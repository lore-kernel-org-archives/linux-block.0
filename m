Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35294 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754041AbdGJWP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2017 18:15:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id c73so56544548pfk.2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2017 15:15:57 -0700 (PDT)
Date: Mon, 10 Jul 2017 15:15:54 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Kyber benchmarks
Message-ID: <20170710221554.GA18621@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, everyone,

I did some benchmarks of Kyber on 4.12 that I wanted to share. If anyone
else has done any testing, I'd love to see the results.

== Latency

Kyber's basic function is controlling latency, so the first benchmark I
did was to measure latency of a mixed workload. When idle, the NVMe
device I tested on has a p99.99 of 150 microseconds for 4k reads and 30
microseconds for 4k writes. I ran the following fio job, where
/dev/nvme0np{1,2} are 16 GB partitions compeletely overwritten before
running the test:

[global]
direct=1
runtime=10s
time_based

[writers]
filename=/dev/nvme0n1p1
rw=randwrite
numjobs=100
group_reporting=1

[reader]
filename=/dev/nvme0n1p2
ioengine=sync
rw=randread
io_submit_mode=offload

This test simulates a single latency-sensitive reader contending with
many writers, so I tweaked the scheduler settings to favor reads over
writes: for Kyber, I used a 1 ms read target latency instead of the
default 2 ms, and for deadline I used a 1 ms read expiry.

read latency percentiles | 1   | 5   | 10  | 20  | 30  | 40  | 50  | 60   | 70   | 80   | 90   | 95   | 99   | 99.5 | 99.9 | 99.95 | 99.99
-------------------------+-----+-----+-----+-----+-----+-----+-----+------+------+------+------+------+------+------+------+-------+------
none                     | 99  | 161 | 223 | 338 | 438 | 572 | 764 | 1012 | 1384 | 1992 | 2640 | 2960 | 3344 | 3504 | 4960 | 5792  | 6816
kyber                    | 75  | 83  | 85  | 87  | 92  | 101 | 103 | 107  | 181  | 270  | 948  | 1928 | 2800 | 2928 | 3120 | 3216  | 5664
mq-deadline              | 169 | 215 | 266 | 358 | 446 | 596 | 796 | 1048 | 1448 | 2024 | 2704 | 3024 | 3376 | 3504 | 5472 | 6496  | 7712

As you can see, Kyber is more effective at managing read latencies. With
this configuration, of course, Kyber optimizes reads at the expense of
writes: the write p99 goes from around 3 ms to 6 ms, since we're using
the default 10 ms write latency target here.

The highest percentiles still don't look great, but we are at the mercy
of flash here. To iron these out, we'll need help from the hardware,
like the NVMe read determinism work.

== Scalability

On CPU scalability, Kyber is a clear win over mq-deadline. To test that,
I used my blk_scale.py script [1]. That basically runs the following fio
job with an increasing numjobs and measures total IOPS:

[scale]
filename=$DEV
direct=1
numjobs=$N
cpus_allowed_policy=split
runtime=10
time_based
ioengine=libaio
iodepth=64
rw=randread
unified_rw_reporting=1

I ran this with iostats disabled on an NVMe drive after running
blkdiscard on the whole thing. Kyber easily hits the limit of the
device, whereas mq-deadline falls over with just 2 jobs.

NVMe numjobs vs. IOPS | 1      | 2      | 4      | 8      | 16     | 32     | 56
----------------------+--------+--------+--------+--------+--------+--------+-------
none                  | 329986 | 642121 | 807191 | 807105 | 806531 | 806875 | 803813
kyber                 | 314097 | 588791 | 807213 | 807057 | 806551 | 807753 | 803833
mq-deadline           | 326959 | 375369 | 352587 | 347723 | 350743 | 336972 | 313795

With null-blk (submit_queues=56 queue_mode=2 hw_queue_depth=1024,
iostats disabled), we can see that Kyber does have some overhead, but it
can still easily keep up with real hardware.

null-blk numjobs vs. IOPS | 1      | 2      | 4       | 8       | 16      | 32       | 56
--------------------------+--------+--------+---------+---------+---------+----------+-------
none                      | 496817 | 965295 | 1946658 | 3847158 | 7698758 | 13424482 | 15151692
kyber                     | 441907 | 832978 | 1598153 | 3202248 | 6137827 | 8931286  | 10725823
mq-deadline               | 462503 | 524586 | 378026  | 372034  | 380879  | 360153   | 337560

1: https://github.com/osandov/osandov-linux/blob/master/scripts/blk_scale.py

== Future Work

The results here are promising, but one thing I haven't tested yet is
how well Kyber reacts to changing workloads. The code hard-codes the
time it gathers statistics for, which for shorter latency targets might
mean we miss our target for a while before Kyber throttles requests.

I'm happy with the scalability results, because it means we still have
some headroom to add fancier features.

Thanks!
