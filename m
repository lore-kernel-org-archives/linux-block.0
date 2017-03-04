Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Date: Sat,  4 Mar 2017 17:01:17 +0100
Message-Id: <20170304160131.57366-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi,
at last, here is my first patch series meant for merging. It adds BFQ
to blk-mq. Don't worry, in this message I won't bore you again with
the wonderful properties of BFQ :)

A quick update on the status of the code: thanks to Murphy's laws, in
the last handful of days,
1) A kind of rare failure, reported only once by a user, several
months ago, has been reported again. Fortunately, the bug reporter
provided an oops this time.
2) An unexpected bandwidth unbalance between greedy reads and writes
has been noted.
I have chosen however to submit these patches before attacking these
new problems.

Let me also recall the limitations of the current version of BFQ. On
average CPUs, it can handle, without loss of throughput or fairness
guarantees, devices performing at most ~30K IOPS; at most ~50 KIOPS on
faster CPUs. Just to put this into context, these are about the same
limits as CFQ in blk. A second intrinsic problem is the current need
for device idling when differentiated bandwidth distribution must be
guaranteed.  Over the last months, I have seen that, fortunately,
there is room for significant improvements with both these
limitations. I plan to work on these improvements after we are done
(and if everything goes well) with merging BFQ.

Finally, a few details on the patchset.

The first two patches introduce BFQ-v0, which is more or less the
first version of BFQ submitted a few years ago [1].  The remaining
patches turn progressively BFQ-v0 into BFQ-v8r8, the current version
of BFQ.

Some patch generates WARNINGS with checkpatch.pl, but these WARNINGS
seem to be either unavoidable for the involved pieces of code (which
the patch just extends), or false positives.

Thanks,
Paolo

[1] https://lkml.org/lkml/2008/4/1/234

Arianna Avanzini (4):
  block, bfq: add full hierarchical scheduling and cgroups support
  block, bfq: add Early Queue Merge (EQM)
  block, bfq: reduce idling only in symmetric scenarios
  block, bfq: handle bursts of queue activations

Paolo Valente (10):
  block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
  block, bfq: improve throughput boosting
  block, bfq: modify the peak-rate estimator
  block, bfq: add more fairness with writes and slow processes
  block, bfq: improve responsiveness
  block, bfq: reduce I/O latency for soft real-time applications
  block, bfq: preserve a low latency also with NCQ-capable drives
  block, bfq: reduce latency during request-pool saturation
  block, bfq: boost the throughput on NCQ-capable flash-based devices
  block, bfq: boost the throughput with random I/O on NCQ-capable HDDs

 Documentation/block/00-INDEX        |    2 +
 Documentation/block/bfq-iosched.txt |  530 +++
 block/Kconfig.iosched               |   21 +
 block/Makefile                      |    1 +
 block/bfq-iosched.c                 | 8751 +++++++++++++++++++++++++++++++++++
 block/elevator.c                    |   16 +-
 include/linux/blkdev.h              |    2 +-
 7 files changed, 9317 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/block/bfq-iosched.txt
 create mode 100644 block/bfq-iosched.c

--
2.10.0
