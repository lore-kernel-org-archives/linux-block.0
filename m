Return-Path: <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: SMP affinity and the blk-mq I/O submission path
Message-ID: <576CE200.2040306@suse.de>
Date: Fri, 24 Jun 2016 09:32:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

I've taken a pick at your mpt3sas branch, trying to make the mpt3sas
multiqueue aware. Sadly I've encountered some issues on the way, which
make me think we _might_ run into a locking issue.
Which also might be attributed to my imperfect knowledge of multiqueue
submission and SMP affinity in general, hence my question:

>From my understanding blk-mq works due to the fact that I/O submission
is local to the CPU, and hence we won't need (most) locks.
However, looking at the code I find that indeed the software queues are
CPU-local, but the hardware context is not.
Plus I haven't really seen any provisions for ensure the hardware
context (and hence the actual I/O submission) is running on any given CPU.
So if I have a device with just one MSI-X vector (bloody mpt2sas
firmware restriction) I would assign this vector to a specific CPU.
But then I have the problem that I/O submission can in principle happen
on _any_ CPU, whereas I/O completion will only happen on a specific CPU.
Which consequently means that we might run into locking issue if the I/O
submission happens on another CPU than the I/O completion.
Is this intended?
Plus, wouldn't we have a cacheline bouncing between those CPUs?
Shouldn't rather run the I/O submission in the same CPU than the I/O
completion?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
