Return-Path: <aherrmann@suse.com>
Date: Tue, 11 Apr 2017 18:31:05 +0200
From: Andreas Herrmann <aherrmann@suse.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: bfq-mq performance comparison to cfq
Message-ID: <20170411163105.GA24393@suselix.suse.de>
References: <20170410090538.GA11473@suselix.suse.de>
 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 10, 2017 at 11:55:43AM +0200, Paolo Valente wrote:
> 
> > Il giorno 10 apr 2017, alle ore 11:05, Andreas Herrmann <aherrmann@suse.com> ha scritto:
> > 
> > Hi Paolo,
> > 
> > I've looked at your WIP branch as of 4.11.0-bfq-mq-rc4-00155-gbce0818
> > and did some fio tests to compare the behavior to CFQ.
> > 
> > My understanding is that bfq-mq is supposed to be merged sooner or
> > later and then it will be the only reasonable I/O scheduler with
> > blk-mq for rotational devices. Hence I think it is interesting to see
> > what to expect performance-wise in comparison to CFQ which is usually
> > used for such devices with the legacy block layer.
> > 
> > I've just done simple tests iterating over number of jobs (1-8 as the
> > test system had 8 CPUs) for all (random/sequential) read/write
> > patterns. Fixed set of fio parameters used were '-size=5G
> > --group_reporting --ioengine=libaio --direct=1 --iodepth=1
> > --runtime=10'.
> > 
> > I've done 10 runs for each such configuration. The device used was an
> > older SAMSUNG HD103SJ 1TB disk, SATA attached. Results that stick out
> > the most are those for sequential reads and sequential writes:
> > 
> > * sequential reads
> >  [0] - cfq, intel_pstate driver, powersave governor
> >  [1] - bfq_mq, intel_pstate driver, powersave governor
> > 
> > jo             [0]               [1]
> > bs       mean     stddev    mean       stddev
> >  1 & 17060.300 &  77.090 & 17657.500 &  69.602
> >  2 & 15318.200 &  28.817 & 10678.000 & 279.070
> >  3 & 15403.200 &  42.762 &  9874.600 &  93.436
> >  4 & 14521.200 & 624.111 &  9918.700 & 226.425
> >  5 & 13893.900 & 144.354 &  9485.000 & 109.291
> >  6 & 13065.300 & 180.608 &  9419.800 &  75.043
> >  7 & 12169.600 &  95.422 &  9863.800 & 227.662
> >  8 & 12422.200 & 215.535 & 15335.300 & 245.764

For the sake of completeness here the corresponding results when
setting low_latency=0 for sequential reads

 [1] - bfq_mq, intel_pstate driver, powersave governor, low_latency=1 (default)
 [2] - bfq_mq, intel_pstate driver, powersave governor, low_latency=0

jo             [2]               [1]
bs       mean     stddev    mean       stddev
 1 & 17959.500 &  62.376 & 17657.500 &  69.602
 2 & 16137.200 & 696.527 & 10678.000 & 279.070
 3 & 16223.600 &  41.291 &  9874.600 &  93.436
 4 & 16012.200 &  88.924 &  9918.700 & 226.425
 5 & 15937.900 &  51.172 &  9485.000 & 109.291
 6 & 15849.300 &  54.021 &  9419.800 &  75.043
 7 & 15794.300 &  98.857 &  9863.800 & 227.662
 8 & 15494.800 & 895.513 & 15335.300 & 245.764

> > * sequential writes
> >  [0] - cfq, intel_pstate driver, powersave governor
> >  [1] - bfq_mq, intel_pstate driver, powersave governor
> > 
> > jo            [0]               [1]
> > bs      mean     stddev    mean       stddev
> >  1 & 14171.300 & 80.796 & 14392.500 & 182.587
> >  2 & 13520.000 & 88.967 &  9565.400 & 119.400
> >  3 & 13396.100 & 44.936 &  9284.000 &  25.122
> >  4 & 13139.800 & 62.325 &  8846.600 &  45.926
> >  5 & 12942.400 & 45.729 &  8568.700 &  35.852
> >  6 & 12650.600 & 41.283 &  8275.500 & 199.273
> >  7 & 12475.900 & 43.565 &  8252.200 &  33.145
> >  8 & 12307.200 & 43.594 & 13617.500 & 127.773

... and for sequential writes

 [1] - bfq_mq, intel_pstate driver, powersave governor, low_latency=1 (default)
 [2] - bfq_mq, intel_pstate driver, powersave governor, low_latency=0

jo             [2]               [1]
bs       mean     stddev    mean       stddev

 1 & 14444.800 & 248.806 & 14392.500 & 182.587
 2 & 13929.300 &  89.137 &  9565.400 & 119.400
 3 & 13875.400 &  83.084 &  9284.000 &  25.122
 4 & 13845.000 & 106.445 &  8846.600 &  45.926
 5 & 13784.800 &  66.304 &  8568.700 &  35.852
 6 & 13774.900 &  51.845 &  8275.500 & 199.273
 7 & 13741.900 &  92.647 &  8252.200 &  33.145
 8 & 13732.400 &  88.575 & 13617.500 & 127.773

> > With performance instead of powersave governor results were
> > (expectedly) higher but the pattern was the same -- bfq-mq shows a
> > "dent" for tests with 2-7 fio jobs. At the moment I have no
> > explanation for this behavior.
> > 
> 
> I have :)
> 
> BFQ, by default, is configured to privilege latency over throughput.
> In this respect, as various people and I happened to discuss a few
> times, even on these mailing lists, the only way to provide strong
> low-latency guarantees, at the moment, is through device idling.  The
> throughput loss you see is very likely to be the consequence of that
> idling.
> 
> Why does the throughput go back up at eight jobs?  Because, if many
> processes are born in a very short time interval, then BFQ understands
> that some multi-job task is being started.  And these parallel tasks
> usually prefer overall high throughput to single-process low latency.
> Then, BFQ does not idle the device for these processes.

Thanks for the explanation!

> That said, if you do always want maximum throughput, even at the
> expense of latency, then just switch off low-latency heuristics, i.e.,
> set low_latency to 0.

That helped a lot. (See above.)

> Depending on the device, setting slice_ilde to 0 may help a lot too
> (as well as with CFQ).  If the throughput is still low also after
> forcing BFQ to an only-throughput mode, then you hit some bug, and
> I'll have a little more work to do ...


Thanks,

Andreas
