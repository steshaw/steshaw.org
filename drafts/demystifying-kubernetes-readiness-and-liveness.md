---
title: Demystifying Kubernetes "readiness" and "liveness"
date: 2017-03-15 08:25:25+10:00
tags: Kubernetes
---
# Demystifying Kubernetes "readiness" and "liveness"

You may have heard phrases like:

  - "health and readiness"
  - "liveness and readiness"

As you can see "health" corresponds to "liveness" in Kubernetes.

- "readiness probe" or "readiness check"
- "liveness probe" or "readiness check"

### Readiness

Technical definition:

  "ready" = ready to serve traffic

If a container is not "ready" it will be removed (or not added if starting up) to load balancers so that traffic will not be directed to it.

### Liveness

Technical definition:

  "live" = container is alive

Hmm, not that helpful. It's alive! (insert Frankenstein picture here).

You might more familiarly know this as a health check.

If a liveness probe fails multiple times then the container will be restarted.

Q. Is it the container only or the entire pod that is restarted?

Q. But shouldn't there but some relationship between "readiness" and "liveness"?

  Q. Can you be ready but not alive?
  Q. Can you be live but not ready?

Q. Should there be a relationship between initial-delay and period of your checks? Since you can tweak the initial-delay and the period of the checks, it's quite possible to have a situation where your container is ready but not alive or alive but not ready.

## Pods

So far, we've talked in terms of containers but pods are Kubernetes unit of distribution. All containers in a pod must be ready for the pod to be considered ready. Similiarly for liveness.

Q. Does Kubernetes restart individual containers or only whole pods? i.e. can live containers be killed when the pod is considered unhealthy. Yes?

## HTTP response codes

Liveness and readiness checks are usually accomplished via HTTP GET. It's interesting to note that your container is considered to be alive if it responses with codes in the range 200-400. Now a 200 (OK) makes perfect sense but 300 (redirects) and 400 (client errors) less so. Something to be careful about when you implement your liveness/readiness checks. i.e. Just return 200 or 500.

## Dependencies / Boot order

These probes allow your container to be less concerned about the order in which it's dependencies are started/booted.

Image your typical monolithic web app. It's packaged in a container image and needs to talk to a database. Simples (cue picture of Meerkat)! When deploying your application for the first time, neither the database nor your application exist. If your web app is started first, without readiness/liveness checks (XXX: which?), it might start up, start receiving traffic and keep giving the user error messages about database connection issues. With readiness checks, your app will not receive traffic until the database is reachable from your app. Nice. No need to worry about boot order either.

As a bonus, well more than a bonus, if the database goes down, then your app becomes unready and will stop receiving traffic.

Q: How to does a "fail whale" in this situation?

### Warning: avoid cycles.

If you have cycles in your readiness/dependency graph then your system will not boot (i.e. become ready as a whole). You can see this in the simplest system where A depends on B and B depends on A:

  - A -> B
  - B -> A

You start container A. It begins waiting to see B before it's "ready".

You start container B. It begins waiting to see A before it's "ready".

Yikes! Neither will ever become ready.

This could be much hard to detect in a larger system. It would be nice to have a system in which these dependencies are declared and analysed for cycles. This would give a heads-up in development/integration stages.

Kubernetes pod configurations do not explicitly declare dependencies. Neither do deployment configurations. That's ok, these dependencies could be declared in a system at a higher level of abstraction.

Q. Does Terraform do this?

Note the similarity from programming languages: modules are often not allowed to have cycles. If a module system does feature cycles, they are often called ["recursive modules"](https://caml.inria.fr/pub/docs/manual-ocaml/extn.html#sec219).

Q. Does purity make a difference here?
