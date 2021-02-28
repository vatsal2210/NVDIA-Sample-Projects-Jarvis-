# NVDIA-Sample-Projects

## Requirements

Jarvis Contact is a Node.js application, intended to run in a Linux environment. It requires Jarvis Speech Services to be running with two primary models:

- Streaming ASR
- Named Entity Recognition (NER)

## Installation

1. Download the client sample image from NGC.

```
$ docker pull nvcr.io/nvidia/jarvis-speech-client:1.0.0-b.2-samples`
```

2. Run the service within a Docker container.

```
$ docker run -it --rm -p 8009:8009 -p 9000:9000 nvcr.io/nvidia/jarvis-speech-client:1.0.0-b.2-samples /bin/bash
$ cd samples/jarvis-contact
```
