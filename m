Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC V8 00/22] Replace the CFQ I/O Scheduler with BFQ
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
References: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
 <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Paolo <paolo.valente@linaro.org>
Message-ID: <eff8f327-5b45-5d4e-b107-d2e30c61bac9@linaro.org>
Date: Thu, 28 Jul 2016 18:50:13 +0200
MIME-Version: 1.0
In-Reply-To: <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Out of sync with HEAD (at the date of posting), sorry. Rebasing.

Thanks,
Paolo

Il 27/07/2016 18:13, Paolo Valente ha scritto:
> Hi,
> this new version of the patchset contains all the improvements and bug
> fixes recommended by Tejun [7], plus new features of BFQ-v8. Details
> about old and new features in patch descriptions. For your
> convenience, here is the usual description of the overall patchset.
>
> This patchset replaces CFQ with the last version of BFQ (which is a
> proportional-share I/O scheduler). To make a smooth transition, this
> patchset first brings CFQ back to its state at the time when BFQ was
> forked from CFQ. Basically, this reduces CFQ to its engine, by
> removing every heuristic and improvement that has nothing to do with
> any heuristic or improvement in BFQ, and every heuristic and
> improvement whose goal is achieved in a different way in BFQ. Then,
> the second part of the patchset starts by replacing CFQ's engine with
> BFQ's engine, and goes on by adding current BFQ improvements and extra
> heuristics. Here is the thread in which we agreed on both this first
> step, and the second and last step: [1]. Moreover, here is a direct
> link to the email describing both steps: [2].
>
> Some patch generates WARNINGS with checkpatch.pl, but these WARNINGS
> seem to be either unavoidable for the involved pieces of code (which
> the patch just extends), or false positives.
>
> Turning back to BFQ, its first version was submitted a few years ago
> [3]. It is denoted as v0 in this patchset, to distinguish it from the
> version I am submitting now, v8. In particular, the first two
> patches concerned with BFQ introduce BFQ-v0, whereas the remaining
> patches turn progressively BFQ-v0 into BFQ-v8. Here are some nice
> features of BFQ-v8.
>
> Low latency for interactive applications
>
> According to our results, and regardless of the actual background
> workload, for interactive tasks the storage device is virtually as
> responsive as if it was idle. For example, even if one or more of the
> following background workloads are being executed:
> - one or more large files are being read or written,
> - a tree of source files is being compiled,
> - one or more virtual machines are performing I/O,
> - a software update is in progress,
> - indexing daemons are scanning filesystems and updating their
>   databases,
> starting an application or loading a file from within an application
> takes about the same time as if the storage device was idle. As a
> comparison, with CFQ, NOOP or DEADLINE, and in the same conditions,
> applications experience high latencies, or even become unresponsive
> until the background workload terminates (also on SSDs).
>
> Low latency for soft real-time applications
>
> Also soft real-time applications, such as audio and video
> players/streamers, enjoy a low latency and a low drop rate, regardless
> of the background I/O workload. As a consequence, these applications
> do not suffer from almost any glitch due to the background workload.
>
> High throughput
>
> On hard disks, BFQ achieves up to 30% higher throughput than CFQ, and
> up to 150% higher throughput than DEADLINE and NOOP, with half of the
> parallel workloads considered in our tests. With the rest of the
> workloads, and with all the workloads on flash-based devices, BFQ
> achieves instead about the same throughput as the other schedulers.
>
> Strong fairness guarantees (already provided by BFQ-v0)
>
> As for long-term guarantees, BFQ distributes the device throughput
> (and not just the device time) as desired among I/O-bound
> applications, with any workload and regardless of the device
> parameters.
>
>
> BFQ achieves the above service properties thanks to the combination of
> its accurate scheduling engine (patches 9-10), and a set of simple
> heuristics and improvements (patches 11-22). Details on how BFQ and
> its components work are provided in the descriptions of the
> patches. In addition, an organic description of the main BFQ algorithm
> and of most of its features can be found in this paper [4].
>
> What BFQ can do in practice is shown, e.g., in this 8-minute demo with
> an SSD: [5]. I made this demo with an older version of BFQ (v7r6) and
> under Linux 3.17.0, but, for the tests considered in the demo,
> performance has remained about the same with more recent BFQ and
> kernel versions. More details about this point can be found here [6],
> together with graphs showing the performance of BFQ, as compared with
> CFQ, DEADLINE and NOOP, and on: a fast and a slow hard disk, a RAID1,
> an SSD, a microSDHC Card and an eMMC. As an example, our results on
> the SSD are reported also in a table at the end of this email.
>
> Finally, as for testing in everyday use, BFQ is the default I/O
> scheduler in, e.g., Manjaro, Sabayon, OpenMandriva and Arch Linux ARM,
> plus several kernel forks for PCs and smartphones. In addition, BFQ is
> optionally available in, e.g., Arch, PCLinuxOS and Gentoo, and we
> record several downloads a day from people using other
> distributions. The feedback received so far basically confirms the
> expected latency drop and throughput boost.
>
> Paolo
>
> Results on a Plextor PX-256M5S SSD
>
> The first two rows of the next table report the aggregate throughput
> achieved by BFQ, CFQ, DEADLINE and NOOP, while ten parallel processes
> read, either sequentially or randomly, a separate portion of the
> memory blocks each. These processes read directly from the device, and
> no process performs writes, to avoid writing large files repeatedly
> and wearing out the device during the many tests done. As can be seen,
> all schedulers achieve about the same throughput with sequential
> readers, whereas, with random readers, the throughput slightly grows
> as the complexity, and hence the execution time, of the schedulers
> decreases. In fact, with random readers, the number of IOPS is
> extremely higher, and all CPUs spend all the time either executing
> instructions or waiting for I/O (the total idle percentage is
> 0). Therefore, the processing time of I/O requests influences the
> maximum throughput achievable.
>
> The remaining rows report the cold-cache start-up time experienced by
> various applications while one of the above two workloads is being
> executed in parallel. In particular, "Start-up time 10 seq/rand"
> stands for "Start-up time of the application at hand while 10
> sequential/random readers are running". A timeout fires, and the test
> is aborted, if the application does not start within 60 seconds; so,
> in the table, '>60' means that the application did not start before
> the timeout fired.
>
> With sequential readers, the performance gap between BFQ and the other
> schedulers is remarkable. Background workloads are intentionally very
> heavy, to show the performance of the schedulers in somewhat extreme
> conditions. Differences are however still significant also with
> lighter workloads, as shown, e.g., here [6] for slower devices.
>
> -----------------------------------------------------------------------------
> |                      SCHEDULER                    |        Test           |
> -----------------------------------------------------------------------------
> |    BFQ     |    CFQ     |  DEADLINE  |    NOOP    |                       |
> -----------------------------------------------------------------------------
> |            |            |            |            | Aggregate Throughput  |
> |            |            |            |            |       [MB/s]          |
> |    399     |    400     |    400     |    400     |  10 raw seq. readers  |
> |    191     |    193     |    202     |    203     | 10 raw random readers |
> -----------------------------------------------------------------------------
> |            |            |            |            | Start-up time 10 seq  |
> |            |            |            |            |       [sec]           |
> |    0.21    |    >60     |    1.91    |    1.88    |      xterm            |
> |    0.93    |    >60     |    10.2    |    10.8    |     oowriter          |
> |    0.89    |    >60     |    29.7    |    30.0    |      konsole          |
> -----------------------------------------------------------------------------
> |            |            |            |            | Start-up time 10 rand |
> |            |            |            |            |       [sec]           |
> |    0.20    |    0.30    |    0.21    |    0.21    |      xterm            |
> |    0.81    |    3.28    |    0.80    |    0.81    |     oowriter          |
> |    0.88    |    2.90    |    1.02    |    1.00    |      konsole          |
> -----------------------------------------------------------------------------
>
>
> [1] https://lkml.org/lkml/2014/5/27/314
>
> [2] https://lists.linux-foundation.org/pipermail/containers/2014-June/034704.html
>
> [3] https://lkml.org/lkml/2008/4/1/234
>
> [4] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
>     Scheduler", Proceedings of the First Workshop on Mobile System
>     Technologies (MST-2015), May 2015.
>     http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
>
> [5] https://youtu.be/1cjZeaCXIyM
>
> [6] http://algogroup.unimore.it/people/paolo/disk_sched/results.php
>
> [7] https://lkml.org/lkml/2016/2/1/818
>
> Arianna Avanzini (11):
>   block, cfq: remove queue merging for close cooperators
>   block, cfq: remove close-based preemption
>   block, cfq: remove deep seek queues logic
>   block, cfq: remove SSD-related logic
>   block, cfq: get rid of hierarchical support
>   block, cfq: get rid of queue preemption
>   block, cfq: get rid of workload type
>   block, bfq: add full hierarchical scheduling and cgroups support
>   block, bfq: add Early Queue Merge (EQM)
>   block, bfq: reduce idling only in symmetric scenarios
>   block, bfq: handle bursts of queue activations
>
> Fabio Checconi (1):
>   block, cfq: replace CFQ with the BFQ-v0 I/O scheduler
>
> Paolo Valente (10):
>   block, cfq: get rid of latency tunables
>   block, bfq: improve throughput boosting
>   block, bfq: modify the peak-rate estimator
>   block, bfq: add more fairness with writes and slow processes
>   block, bfq: improve responsiveness
>   block, bfq: reduce I/O latency for soft real-time applications
>   block, bfq: preserve a low latency also with NCQ-capable drives
>   block, bfq: reduce latency during request-pool saturation
>   block, bfq: boost the throughput on NCQ-capable flash-based devices
>   block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
>
>  block/Kconfig.iosched |    19 +-
>  block/cfq-iosched.c   | 10173 +++++++++++++++++++++++++++++++-----------------
>  2 files changed, 6610 insertions(+), 3582 deletions(-)
>
