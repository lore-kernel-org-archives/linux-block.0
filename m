Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bfq-mq performance comparison to cfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170410090538.GA11473@suselix.suse.de>
Date: Mon, 10 Apr 2017 11:55:43 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
References: <20170410090538.GA11473@suselix.suse.de>
To: Andreas Herrmann <aherrmann@suse.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 apr 2017, alle ore 11:05, Andreas Herrmann =
<aherrmann@suse.com> ha scritto:
>=20
> Hi Paolo,
>=20
> I've looked at your WIP branch as of 4.11.0-bfq-mq-rc4-00155-gbce0818
> and did some fio tests to compare the behavior to CFQ.
>=20
> My understanding is that bfq-mq is supposed to be merged sooner or
> later and then it will be the only reasonable I/O scheduler with
> blk-mq for rotational devices. Hence I think it is interesting to see
> what to expect performance-wise in comparison to CFQ which is usually
> used for such devices with the legacy block layer.
>=20
> I've just done simple tests iterating over number of jobs (1-8 as the
> test system had 8 CPUs) for all (random/sequential) read/write
> patterns. Fixed set of fio parameters used were '-size=3D5G
> --group_reporting --ioengine=3Dlibaio --direct=3D1 --iodepth=3D1
> --runtime=3D10'.
>=20
> I've done 10 runs for each such configuration. The device used was an
> older SAMSUNG HD103SJ 1TB disk, SATA attached. Results that stick out
> the most are those for sequential reads and sequential writes:
>=20
> * sequential reads
>  [0] - cfq, intel_pstate driver, powersave governor
>  [1] - bfq_mq, intel_pstate driver, powersave governor
>=20
> jo             [0]               [1]
> bs       mean     stddev    mean       stddev
>  1 & 17060.300 &  77.090 & 17657.500 &  69.602
>  2 & 15318.200 &  28.817 & 10678.000 & 279.070
>  3 & 15403.200 &  42.762 &  9874.600 &  93.436
>  4 & 14521.200 & 624.111 &  9918.700 & 226.425
>  5 & 13893.900 & 144.354 &  9485.000 & 109.291
>  6 & 13065.300 & 180.608 &  9419.800 &  75.043
>  7 & 12169.600 &  95.422 &  9863.800 & 227.662
>  8 & 12422.200 & 215.535 & 15335.300 & 245.764
>=20
> * sequential writes
>  [0] - cfq, intel_pstate driver, powersave governor
>  [1] - bfq_mq, intel_pstate driver, powersave governor
>=20
> jo            [0]               [1]
> bs      mean     stddev    mean       stddev
>  1 & 14171.300 & 80.796 & 14392.500 & 182.587
>  2 & 13520.000 & 88.967 &  9565.400 & 119.400
>  3 & 13396.100 & 44.936 &  9284.000 &  25.122
>  4 & 13139.800 & 62.325 &  8846.600 &  45.926
>  5 & 12942.400 & 45.729 &  8568.700 &  35.852
>  6 & 12650.600 & 41.283 &  8275.500 & 199.273
>  7 & 12475.900 & 43.565 &  8252.200 &  33.145
>  8 & 12307.200 & 43.594 & 13617.500 & 127.773
>=20
> With performance instead of powersave governor results were
> (expectedly) higher but the pattern was the same -- bfq-mq shows a
> "dent" for tests with 2-7 fio jobs. At the moment I have no
> explanation for this behavior.
>=20

I have :)

BFQ, by default, is configured to privilege latency over throughput.
In this respect, as various people and I happened to discuss a few
times, even on these mailing lists, the only way to provide strong
low-latency guarantees, at the moment, is through device idling.  The
throughput loss you see is very likely to be the consequence of that
idling.

Why does the throughput go back up at eight jobs?  Because, if many
processes are born in a very short time interval, then BFQ understands
that some multi-job task is being started.  And these parallel tasks
usually prefer overall high throughput to single-process low latency.
Then, BFQ does not idle the device for these processes.

That said, if you do always want maximum throughput, even at the
expense of latency, then just switch off low-latency heuristics, i.e.,
set low_latency to 0.  Depending on the device, setting slice_ilde to
0 may help a lot too (as well as with CFQ).  If the throughput is
still low also after forcing BFQ to an only-throughput mode, then you
hit some bug, and I'll have a little more work to do ...

Thanks,
Paolo

> Regards,
> Andreas
