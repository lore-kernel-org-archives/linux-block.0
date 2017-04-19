Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V4 00/16] Introduce the BFQ I/O scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170412162322.11139-1-paolo.valente@linaro.org>
Date: Wed, 19 Apr 2017 11:23:59 +0200
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <62E939C2-CBA8-4D33-AEEF-380616616E52@linaro.org>
References: <20170412162322.11139-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 12 apr 2017, alle ore 18:23, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> new patch series, addressing (both) issues raised by Bart [1], and
> with block/Makefile fixed as suggested by Bart [2].
>=20

Hi Jens,
apparently no complain of any sort on this last series.  Do you think
we could make it for 4.12, or shall we aim at 4.13?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2017/3/31/393
> [2] https://lkml.org/lkml/2017/4/12/502
>=20
> Arianna Avanzini (4):
>  block, bfq: add full hierarchical scheduling and cgroups support
>  block, bfq: add Early Queue Merge (EQM)
>  block, bfq: reduce idling only in symmetric scenarios
>  block, bfq: handle bursts of queue activations
>=20
> Paolo Valente (12):
>  block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
>  block, bfq: improve throughput boosting
>  block, bfq: modify the peak-rate estimator
>  block, bfq: add more fairness with writes and slow processes
>  block, bfq: improve responsiveness
>  block, bfq: reduce I/O latency for soft real-time applications
>  block, bfq: preserve a low latency also with NCQ-capable drives
>  block, bfq: reduce latency during request-pool saturation
>  block, bfq: boost the throughput on NCQ-capable flash-based devices
>  block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
>  block, bfq: remove all get and put of I/O contexts
>  block, bfq: split bfq-iosched.c into multiple source files
>=20
> Documentation/block/00-INDEX        |    2 +
> Documentation/block/bfq-iosched.txt |  531 ++++
> block/Kconfig.iosched               |   21 +
> block/Makefile                      |    2 +
> block/bfq-cgroup.c                  | 1139 ++++++++
> block/bfq-iosched.c                 | 5047 =
+++++++++++++++++++++++++++++++++++
> block/bfq-iosched.h                 |  942 +++++++
> block/bfq-wf2q.c                    | 1616 +++++++++++
> include/linux/blkdev.h              |    2 +-
> 9 files changed, 9301 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/block/bfq-iosched.txt
> create mode 100644 block/bfq-cgroup.c
> create mode 100644 block/bfq-iosched.c
> create mode 100644 block/bfq-iosched.h
> create mode 100644 block/bfq-wf2q.c
>=20
> --
> 2.10.0
