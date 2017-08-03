Return-Path: <mgorman@techsingularity.net>
Date: Thu, 3 Aug 2017 12:01:45 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 03, 2017 at 11:21:59AM +0200, Paolo Valente wrote:
> > For Paulo, if you want to try preemptively dealing with regression reports
> > before 4.13 releases then all the tests in question can be reproduced with
> > https://github.com/gormanm/mmtests . The most relevant test configurations
> > I've seen so far are
> > 
> > configs/config-global-dhp__io-dbench4-async
> > configs/config-global-dhp__io-fio-randread-async-randwrite
> > configs/config-global-dhp__io-fio-randread-async-seqwrite
> > configs/config-global-dhp__io-fio-randread-sync-heavywrite
> > configs/config-global-dhp__io-fio-randread-sync-randwrite
> > configs/config-global-dhp__pgioperf
> > 
> 
> Hi Mel,
> as it already happened with the latest Phoronix benchmark article (and
> with other test results reported several months ago on this list), bad
> results may be caused (also) by the fact that the low-latency, default
> configuration of BFQ is being used. 

I took that into account BFQ with low-latency was also tested and the
impact was not a universal improvement although it can be a noticable
improvement. From the same machine;

dbench4 Loadfile Execution Time
                             4.12.0                 4.12.0                 4.12.0
                         legacy-cfq                 mq-bfq            mq-bfq-tput
Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)       84.70 (  -5.00%)
Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)       88.74 (   4.45%)
Amean     4       102.72 (   0.00%)      474.33 (-361.77%)      113.97 ( -10.95%)
Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)     2038.74 (  19.86%)

However, it's not a universal gain and there are also fairness issues.
For example, this is a fio configuration with a single random reader and
a single random writer on the same machine

fio Throughput
                                              4.12.0                 4.12.0                 4.12.0
                                          legacy-cfq                 mq-bfq            mq-bfq-tput
Hmean     kb/sec-writer-write      398.15 (   0.00%)     4659.18 (1070.21%)     4934.52 (1139.37%)
Hmean     kb/sec-reader-read       507.00 (   0.00%)       66.36 ( -86.91%)       14.68 ( -97.10%)

With CFQ, there is some fairness between the readers and writers and
with BFQ, there is a strong preference to writers. Again, this is not
universal. It'll be a mix and sometimes it'll be classed as a gain and
sometimes a regression.

While I accept that BFQ can be tuned, tuning IO schedulers is not something
that normal users get right and they'll only look at "out of box" performance
which, right now, will trigger bug reports. This is neither good nor bad,
it simply is.

> This configuration is the default
> one because the motivation for yet-another-scheduler as BFQ is that it
> drastically reduces latency for interactive and soft real-time tasks
> (e.g., opening an app or playing/streaming a video), when there is
> some background I/O.  Low-latency heuristics are willing to sacrifice
> throughput when this provides a large benefit in terms of the above
> latency.
> 

I had seen this assertion so one of the fio configurations had multiple
heavy writers in the background and a random reader of small files to
simulate that scenario. The intent was to simulate heavy IO in the presence
of application startup

                                              4.12.0                 4.12.0                 4.12.0
                                          legacy-cfq                 mq-bfq            mq-bfq-tput
Hmean     kb/sec-writer-write     1997.75 (   0.00%)     2035.65 (   1.90%)     2014.50 (   0.84%)
Hmean     kb/sec-reader-read       128.50 (   0.00%)       79.46 ( -38.16%)       12.78 ( -90.06%)

Write throughput is steady-ish across each IO scheduler but readers get
starved badly which I expect would slow application startup and disabling
low_latency makes it much worse. The mmtests configuration in question
is global-dhp__io-fio-randread-sync-heavywrite albeit editted to create
a fresh XFS filesystem on a test partition.

This is not exactly equivalent to real application startup but that can
be difficult to quantify properly.

> Of course, BFQ may not be optimal for every workload, even if
> low-latency mode is switched off.  In addition, there may still be
> some bug.  I'll repeat your tests on a machine of mine ASAP.
> 

The intent here is not to rag on BFQ because I know it's going to have some
wins and some losses and will take time to fix up. The primary intent was
to flag that 4.13 might have some "blah blah blah is slower on 4.13" reports
due to the switching of defaults that will bisect to a misleading commit.

-- 
Mel Gorman
SUSE Labs
