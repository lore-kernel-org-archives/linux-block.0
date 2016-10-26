Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	hare@suse.de,
	arnd@arndb.de,
	bart.vanassche@sandisk.com,
	grant.likely@secretlab.ca,
	jack@suse.cz,
	James.Bottomley@HansenPartnership.com,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
Date: Wed, 26 Oct 2016 11:27:53 +0200
Message-Id: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi,
this new patch series turns back to the initial approach, i.e., it
adds BFQ as an extra scheduler, instead of replacing CFQ with
BFQ. This patch series also contains all the improvements and bug
fixes recommended by Tejun [5], plus new features of BFQ-v8r5. Details
about old and new features in patch descriptions.

The first version of BFQ was submitted a few years ago [1]. It is
denoted as v0 in this patchset, to distinguish it from the version I
am submitting now, v8r5. In particular, the first two patches
introduce BFQ-v0, whereas the remaining patches turn progressively
BFQ-v0 into BFQ-v8r5.

Some patch generates WARNINGS with checkpatch.pl, but these WARNINGS
seem to be either unavoidable for the involved pieces of code (which
the patch just extends), or false positives.

For your convenience, a slightly updated and extended description of
BFQ follows.

On average CPUs, the current version of BFQ can handle devices
performing at most ~30K IOPS; at most ~50 KIOPS on faster CPUs. These
are about the same limits as CFQ. There may be room for noticeable
improvements regarding these limits, but, given the overall
limitations of blk itself, I thought it was not the case to further
delay this new submission.

Here are some nice features of BFQ-v8r5.

Low latency for interactive applications

Regardless of the actual background workload, BFQ guarantees that, for
interactive tasks, the storage device is virtually as responsive as if
it was idle. For example, even if one or more of the following
background workloads are being executed:
- one or more large files are being read, written or copied,
- a tree of source files is being compiled,
- one or more virtual machines are performing I/O,
- a software update is in progress,
- indexing daemons are scanning filesystems and updating their
  databases,
starting an application or loading a file from within an application
takes about the same time as if the storage device was idle. As a
comparison, with CFQ, NOOP or DEADLINE, and in the same conditions,
applications experience high latencies, or even become unresponsive
until the background workload terminates (also on SSDs).

Low latency for soft real-time applications

Also soft real-time applications, such as audio and video
players/streamers, enjoy a low latency and a low drop rate, regardless
of the background I/O workload. As a consequence, these applications
do not suffer from almost any glitch due to the background workload.

Higher speed for code-development tasks

If some additional workload happens to be executed in parallel, then
BFQ executes the I/O-related components of typical code-development
tasks (compilation, checkout, merge, ...) much more quickly than CFQ,
NOOP or DEADLINE.

High throughput

On hard disks, BFQ achieves up to 30% higher throughput than CFQ, and
up to 150% higher throughput than DEADLINE and NOOP, with all the
sequential workloads considered in our tests. With random workloads,
and with all the workloads on flash-based devices, BFQ achieves,
instead, about the same throughput as the other schedulers.

Strong fairness, bandwidth and delay guarantees

BFQ distributes the device throughput, and not just the device time,
among I/O-bound applications in proportion their weights, with any
workload and regardless of the device parameters. From these bandwidth
guarantees, it is possible to compute tight per-I/O-request delay
guarantees by a simple formula. If not configured for strict service
guarantees, BFQ switches to time-based resource sharing (only) for
applications that would otherwise cause a throughput loss.


BFQ achieves the above service properties thanks to the combination of
its accurate scheduling engine (patches 1-2), and a set of simple
heuristics and improvements (patches 3-14). Details on how BFQ and
its components work are provided in the descriptions of the
patches. In addition, an organic description of the main BFQ algorithm
and of most of its features can be found in this paper [2].

What BFQ can do in practice is shown, e.g., in this 8-minute demo with
an SSD: [3]. I made this demo with an older version of BFQ (v7r6) and
under Linux 3.17.0, but, for the tests considered in the demo,
performance has remained about the same with more recent BFQ and
kernel versions. More details about this point can be found here [4],
together with graphs showing the performance of BFQ, as compared with
CFQ, DEADLINE and NOOP, and on: a fast and a slow hard disk, a RAID1,
an SSD, a microSDHC Card and an eMMC. As an example, our results on
the SSD are reported also in a table at the end of this email.

Finally, as for testing in everyday use, BFQ is the default I/O
scheduler in, e.g., Mageia, Manjaro, Sabayon, OpenMandriva and Arch
Linux ARM, plus several kernel forks for PCs and smartphones. In
addition, BFQ is optionally available in, e.g., Arch, PCLinuxOS and
Gentoo, and we record several downloads a day from people using other
distributions. The feedback received so far basically confirms the
expected latency drop and throughput boost.

Thanks,
Paolo

Results on a Plextor PX-256M5S SSD

The first two rows of the next table report the aggregate throughput
achieved by BFQ, CFQ, DEADLINE and NOOP, while ten parallel processes
read, either sequentially or randomly, a separate portion of the
memory blocks each. These processes read directly from the device, and
no process performs writes, to avoid writing large files repeatedly
and wearing out the device during the many tests done. As can be seen,
all schedulers achieve about the same throughput with sequential
readers, whereas, with random readers, the throughput slightly grows
as the complexity, and hence the execution time, of the schedulers
decreases. In fact, with random readers, the number of IOPS is
extremely higher, and all CPUs spend all the time either executing
instructions or waiting for I/O (the total idle percentage is
0). Therefore, the processing time of I/O requests influences the
maximum throughput achievable.

The remaining rows report the cold-cache start-up time experienced by
various applications while one of the above two workloads is being
executed in parallel. In particular, "Start-up time 10 seq/rand"
stands for "Start-up time of the application at hand while 10
sequential/random readers are running". A timeout fires, and the test
is aborted, if the application does not start within 60 seconds; so,
in the table, '>60' means that the application did not start before
the timeout fired.

With sequential readers, the performance gap between BFQ and the other
schedulers is remarkable. Background workloads are intentionally very
heavy, to show the performance of the schedulers in somewhat extreme
conditions. Differences are however still significant also with
lighter workloads, as shown, e.g., here [4] for slower devices.

-----------------------------------------------------------------------------
|                      SCHEDULER                    |        Test           |
-----------------------------------------------------------------------------
|    BFQ     |    CFQ     |  DEADLINE  |    NOOP    |                       |
-----------------------------------------------------------------------------
|            |            |            |            | Aggregate Throughput  |
|            |            |            |            |       [MB/s]          |
|    399     |    400     |    400     |    400     |  10 raw seq. readers  |
|    191     |    193     |    202     |    203     | 10 raw random readers |
-----------------------------------------------------------------------------
|            |            |            |            | Start-up time 10 seq  |
|            |            |            |            |       [sec]           |
|    0.21    |    >60     |    1.91    |    1.88    |      xterm            |
|    0.93    |    >60     |    10.2    |    10.8    |     oowriter          |
|    0.89    |    >60     |    29.7    |    30.0    |      konsole          |
-----------------------------------------------------------------------------
|            |            |            |            | Start-up time 10 rand |
|            |            |            |            |       [sec]           |
|    0.20    |    0.30    |    0.21    |    0.21    |      xterm            |
|    0.81    |    3.28    |    0.80    |    0.81    |     oowriter          |
|    0.88    |    2.90    |    1.02    |    1.00    |      konsole          |
-----------------------------------------------------------------------------


[1] https://lkml.org/lkml/2008/4/1/234

[2] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
    Scheduler", Proceedings of the First Workshop on Mobile System
    Technologies (MST-2015), May 2015.
    http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf

[3] https://youtu.be/1cjZeaCXIyM

[4] http://algogroup.unimore.it/people/paolo/disk_sched/results.php

[5] https://lkml.org/lkml/2016/2/1/818

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
 Documentation/block/bfq-iosched.txt |  516 +++
 block/Kconfig.iosched               |   27 +
 block/Makefile                      |    1 +
 block/bfq-iosched.c                 | 8195 +++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h              |    2 +-
 6 files changed, 8742 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/block/bfq-iosched.txt
 create mode 100644 block/bfq-iosched.c

-- 
2.10.0
