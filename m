Return-Path: <mgorman@techsingularity.net>
Date: Thu, 3 Aug 2017 09:51:16 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Switching to MQ by default may generate some bug reports
Message-ID: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-block@vger.kernel.org>

Hi Christoph,

I know the reasons for switching to MQ by default but just be aware that it's
not without hazards albeit it the biggest issues I've seen are switching
CFQ to BFQ. On my home grid, there is some experimental automatic testing
running every few weeks searching for regressions. Yesterday, it noticed
that creating some work files for a postgres simulator called pgioperf
was 38.33% slower and it auto-bisected to the switch to MQ. This is just
linearly writing two files for testing on another benchmark and is not
remarkable. The relevant part of the report is

Last good/First bad commit
==========================
Last good commit: 6d311fa7d2c18659d040b9beba5e41fe24c2a6f5
First bad commit: 5c279bd9e40624f4ab6e688671026d6005b066fa
>From 5c279bd9e40624f4ab6e688671026d6005b066fa Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 16 Jun 2017 10:27:55 +0200
Subject: [PATCH] scsi: default to scsi-mq
Remove the SCSI_MQ_DEFAULT config option and default to the blk-mq I/O
path now that we had plenty of testing, and have I/O schedulers for
blk-mq.  The module option to disable the blk-mq path is kept around for
now.
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
 drivers/scsi/Kconfig | 11 -----------
 drivers/scsi/scsi.c  |  4 ----
 2 files changed, 15 deletions(-)

Comparison
==========
                                initial                initial                   last                  penup                  first
                             good-v4.12       bad-16f73eb02d7e          good-6d311fa7          good-d06c587d           bad-5c279bd9
User    min             0.06 (   0.00%)        0.14 (-133.33%)        0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
User    mean            0.06 (   0.00%)        0.14 (-133.33%)        0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
User    stddev          0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
User    coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
User    max             0.06 (   0.00%)        0.14 (-133.33%)        0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
System  min            10.04 (   0.00%)       10.75 (  -7.07%)       10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
System  mean           10.04 (   0.00%)       10.75 (  -7.07%)       10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
System  stddev          0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
System  coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
System  max            10.04 (   0.00%)       10.75 (  -7.07%)       10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
Elapsed min           251.53 (   0.00%)      351.05 ( -39.57%)      252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
Elapsed mean          251.53 (   0.00%)      351.05 ( -39.57%)      252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
Elapsed stddev          0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Elapsed coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Elapsed max           251.53 (   0.00%)      351.05 ( -39.57%)      252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
CPU     min             4.00 (   0.00%)        3.00 (  25.00%)        4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)
CPU     mean            4.00 (   0.00%)        3.00 (  25.00%)        4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)
CPU     stddev          0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
CPU     coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
CPU     max             4.00 (   0.00%)        3.00 (  25.00%)        4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)

The "Elapsed mean" line is what the testing and auto-bisection was paying
attention to. Commit 16f73eb02d7e is simply the head commit at the time
the continuous testing started. The first "bad commit" is the last column.

It's not the only slowdown that has been observed from other testing when
examining whether it's ok to switch to MQ by default. The biggest slowdown
observed was with a modified version of dbench4 -- the modifications use
shorter, but representative, load files to avoid timing artifacts and
reports time to complete a load file instead of throughput as throughput
is kind of meaningless for dbench4

dbench4 Loadfile Execution Time
                             4.12.0                 4.12.0
                         legacy-cfq                 mq-bfq
Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)
Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)
Amean     4       102.72 (   0.00%)      474.33 (-361.77%)
Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)

The units are "milliseconds to complete a load file" so as thread count
increased, there were some fairly bad slowdowns. The most dramatic
slowdown was observed on a machine with a controller with on-board cache

                              4.12.0                 4.12.0
                          legacy-cfq                 mq-bfq
Amean     1        289.09 (   0.00%)      128.43 (  55.57%)
Amean     2        491.32 (   0.00%)      794.04 ( -61.61%)
Amean     4        875.26 (   0.00%)     9331.79 (-966.17%)
Amean     8       2074.30 (   0.00%)      317.79 (  84.68%)
Amean     16      3380.47 (   0.00%)      669.51 (  80.19%)
Amean     32      7427.25 (   0.00%)     8821.75 ( -18.78%)
Amean     256    53376.81 (   0.00%)    69006.94 ( -29.28%)

The slowdown wasn't universal but at 4 threads, it was severe. There
are other examples but it'd just be a lot of noise and not change the
central point.

The major problems were all observed switching from CFQ to BFQ on single disk
rotary storage. It's not machine specific as 5 separate machines noticed
problems with dbench and fio when switching to MQ on kernel 4.12. Weirdly,
I've seen cases of read starvation in the presence of heavy writers
using fio to generate the workload which was surprising to me. Jan Kara
suggested that it may be because the read workload is not being identified
as "interactive" but I didn't dig into the details myself and have zero
understanding of BFQ. I was only interested in answering the question "is
it safe to switch the default and will the performance be similar enough
to avoid bug reports?" and concluded that the answer is "no".

For what it's worth, I've noticed on SSDs that switching from legacy-mq
to deadline-mq also slowed down but in many cases the slowdown was small
enough that it may be tolerable and not generate many bug reports. Also,
mq-deadline appears to receive more attention so issues there are probably
going to be noticed faster.

I'm not suggesting for a second that you fix this or switch back to legacy
by default because it's BFQ, Paulo is cc'd and it'll have to be fixed
eventually but you might see "workload foo is slower on 4.13" reports that
bisect to this commit. What filesystem is used changes the results but at
least btrfs, ext3, ext4 and xfs experience slowdowns.

For Paulo, if you want to try preemptively dealing with regression reports
before 4.13 releases then all the tests in question can be reproduced with
https://github.com/gormanm/mmtests . The most relevant test configurations
I've seen so far are

configs/config-global-dhp__io-dbench4-async
configs/config-global-dhp__io-fio-randread-async-randwrite
configs/config-global-dhp__io-fio-randread-async-seqwrite
configs/config-global-dhp__io-fio-randread-sync-heavywrite
configs/config-global-dhp__io-fio-randread-sync-randwrite
configs/config-global-dhp__pgioperf

-- 
Mel Gorman
SUSE Labs
