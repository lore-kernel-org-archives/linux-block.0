Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
Date: Thu, 3 Aug 2017 11:21:59 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 03 ago 2017, alle ore 10:51, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> Hi Christoph,
>=20
> I know the reasons for switching to MQ by default but just be aware =
that it's
> not without hazards albeit it the biggest issues I've seen are =
switching
> CFQ to BFQ. On my home grid, there is some experimental automatic =
testing
> running every few weeks searching for regressions. Yesterday, it =
noticed
> that creating some work files for a postgres simulator called pgioperf
> was 38.33% slower and it auto-bisected to the switch to MQ. This is =
just
> linearly writing two files for testing on another benchmark and is not
> remarkable. The relevant part of the report is
>=20
> Last good/First bad commit
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Last good commit: 6d311fa7d2c18659d040b9beba5e41fe24c2a6f5
> First bad commit: 5c279bd9e40624f4ab6e688671026d6005b066fa
> =46rom 5c279bd9e40624f4ab6e688671026d6005b066fa Mon Sep 17 00:00:00 =
2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 16 Jun 2017 10:27:55 +0200
> Subject: [PATCH] scsi: default to scsi-mq
> Remove the SCSI_MQ_DEFAULT config option and default to the blk-mq I/O
> path now that we had plenty of testing, and have I/O schedulers for
> blk-mq.  The module option to disable the blk-mq path is kept around =
for
> now.
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> drivers/scsi/Kconfig | 11 -----------
> drivers/scsi/scsi.c  |  4 ----
> 2 files changed, 15 deletions(-)
>=20
> Comparison
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                                initial                initial          =
         last                  penup                  first
>                             good-v4.12       bad-16f73eb02d7e          =
good-6d311fa7          good-d06c587d           bad-5c279bd9
> User    min             0.06 (   0.00%)        0.14 (-133.33%)        =
0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
> User    mean            0.06 (   0.00%)        0.14 (-133.33%)        =
0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
> User    stddev          0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> User    coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> User    max             0.06 (   0.00%)        0.14 (-133.33%)        =
0.14 (-133.33%)        0.06 (   0.00%)        0.19 (-216.67%)
> System  min            10.04 (   0.00%)       10.75 (  -7.07%)       =
10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
> System  mean           10.04 (   0.00%)       10.75 (  -7.07%)       =
10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
> System  stddev          0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> System  coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> System  max            10.04 (   0.00%)       10.75 (  -7.07%)       =
10.05 (  -0.10%)       10.16 (  -1.20%)       10.73 (  -6.87%)
> Elapsed min           251.53 (   0.00%)      351.05 ( -39.57%)      =
252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
> Elapsed mean          251.53 (   0.00%)      351.05 ( -39.57%)      =
252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
> Elapsed stddev          0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> Elapsed coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> Elapsed max           251.53 (   0.00%)      351.05 ( -39.57%)      =
252.83 (  -0.52%)      252.96 (  -0.57%)      347.93 ( -38.33%)
> CPU     min             4.00 (   0.00%)        3.00 (  25.00%)        =
4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)
> CPU     mean            4.00 (   0.00%)        3.00 (  25.00%)        =
4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)
> CPU     stddev          0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> CPU     coeffvar        0.00 (   0.00%)        0.00 (   0.00%)        =
0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> CPU     max             4.00 (   0.00%)        3.00 (  25.00%)        =
4.00 (   0.00%)        4.00 (   0.00%)        3.00 (  25.00%)
>=20
> The "Elapsed mean" line is what the testing and auto-bisection was =
paying
> attention to. Commit 16f73eb02d7e is simply the head commit at the =
time
> the continuous testing started. The first "bad commit" is the last =
column.
>=20
> It's not the only slowdown that has been observed from other testing =
when
> examining whether it's ok to switch to MQ by default. The biggest =
slowdown
> observed was with a modified version of dbench4 -- the modifications =
use
> shorter, but representative, load files to avoid timing artifacts and
> reports time to complete a load file instead of throughput as =
throughput
> is kind of meaningless for dbench4
>=20
> dbench4 Loadfile Execution Time
>                             4.12.0                 4.12.0
>                         legacy-cfq                 mq-bfq
> Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)
> Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)
> Amean     4       102.72 (   0.00%)      474.33 (-361.77%)
> Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)
>=20
> The units are "milliseconds to complete a load file" so as thread =
count
> increased, there were some fairly bad slowdowns. The most dramatic
> slowdown was observed on a machine with a controller with on-board =
cache
>=20
>                              4.12.0                 4.12.0
>                          legacy-cfq                 mq-bfq
> Amean     1        289.09 (   0.00%)      128.43 (  55.57%)
> Amean     2        491.32 (   0.00%)      794.04 ( -61.61%)
> Amean     4        875.26 (   0.00%)     9331.79 (-966.17%)
> Amean     8       2074.30 (   0.00%)      317.79 (  84.68%)
> Amean     16      3380.47 (   0.00%)      669.51 (  80.19%)
> Amean     32      7427.25 (   0.00%)     8821.75 ( -18.78%)
> Amean     256    53376.81 (   0.00%)    69006.94 ( -29.28%)
>=20
> The slowdown wasn't universal but at 4 threads, it was severe. There
> are other examples but it'd just be a lot of noise and not change the
> central point.
>=20
> The major problems were all observed switching from CFQ to BFQ on =
single disk
> rotary storage. It's not machine specific as 5 separate machines =
noticed
> problems with dbench and fio when switching to MQ on kernel 4.12. =
Weirdly,
> I've seen cases of read starvation in the presence of heavy writers
> using fio to generate the workload which was surprising to me. Jan =
Kara
> suggested that it may be because the read workload is not being =
identified
> as "interactive" but I didn't dig into the details myself and have =
zero
> understanding of BFQ. I was only interested in answering the question =
"is
> it safe to switch the default and will the performance be similar =
enough
> to avoid bug reports?" and concluded that the answer is "no".
>=20
> For what it's worth, I've noticed on SSDs that switching from =
legacy-mq
> to deadline-mq also slowed down but in many cases the slowdown was =
small
> enough that it may be tolerable and not generate many bug reports. =
Also,
> mq-deadline appears to receive more attention so issues there are =
probably
> going to be noticed faster.
>=20
> I'm not suggesting for a second that you fix this or switch back to =
legacy
> by default because it's BFQ, Paulo is cc'd and it'll have to be fixed
> eventually but you might see "workload foo is slower on 4.13" reports =
that
> bisect to this commit. What filesystem is used changes the results but =
at
> least btrfs, ext3, ext4 and xfs experience slowdowns.
>=20
> For Paulo, if you want to try preemptively dealing with regression =
reports
> before 4.13 releases then all the tests in question can be reproduced =
with
> https://github.com/gormanm/mmtests . The most relevant test =
configurations
> I've seen so far are
>=20
> configs/config-global-dhp__io-dbench4-async
> configs/config-global-dhp__io-fio-randread-async-randwrite
> configs/config-global-dhp__io-fio-randread-async-seqwrite
> configs/config-global-dhp__io-fio-randread-sync-heavywrite
> configs/config-global-dhp__io-fio-randread-sync-randwrite
> configs/config-global-dhp__pgioperf
>=20

Hi Mel,
as it already happened with the latest Phoronix benchmark article (and
with other test results reported several months ago on this list), bad
results may be caused (also) by the fact that the low-latency, default
configuration of BFQ is being used.  This configuration is the default
one because the motivation for yet-another-scheduler as BFQ is that it
drastically reduces latency for interactive and soft real-time tasks
(e.g., opening an app or playing/streaming a video), when there is
some background I/O.  Low-latency heuristics are willing to sacrifice
throughput when this provides a large benefit in terms of the above
latency.

Things do change if, instead, one wants to use BFQ for tasks that
don't need this kind of low-latency guarantees, but need only the
highest possible sustained throughput.  This seems to be the case for
all the tests you have listed above.  In this case, it doesn't make
much sense to leave low-latency heuristics on.  Throughput may only
get worse for these tests, and the elapsed time can only increase.

How to switch low-latency heuristics off?
echo 0 > /sys/block/<dev>/queue/iosched/low_latency

Of course, BFQ may not be optimal for every workload, even if
low-latency mode is switched off.  In addition, there may still be
some bug.  I'll repeat your tests on a machine of mine ASAP.

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
