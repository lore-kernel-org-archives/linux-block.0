Return-Path: <mgorman@techsingularity.net>
Date: Fri, 4 Aug 2017 12:01:03 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org>
 <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
 <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 04, 2017 at 09:26:20AM +0200, Paolo Valente wrote:
> > I took that into account BFQ with low-latency was also tested and the
> > impact was not a universal improvement although it can be a noticable
> > improvement. From the same machine;
> > 
> > dbench4 Loadfile Execution Time
> >                             4.12.0                 4.12.0                 4.12.0
> >                         legacy-cfq                 mq-bfq            mq-bfq-tput
> > Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)       84.70 (  -5.00%)
> > Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)       88.74 (   4.45%)
> > Amean     4       102.72 (   0.00%)      474.33 (-361.77%)      113.97 ( -10.95%)
> > Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)     2038.74 (  19.86%)
> > 
> 
> Thanks for trying with low_latency disabled.  If I read numbers
> correctly, we move from a worst case of 361% higher execution time to
> a worst case of 11%.  With a best case of 20% of lower execution time.
> 

Yes.

> I asked you about none and mq-deadline in a previous email, because
> actually we have a double change here: change of the I/O stack, and
> change of the scheduler, with the first change probably not irrelevant
> with respect to the second one.
> 

True. However, the difference between legacy-deadline mq-deadline is
roughly around the 5-10% mark across workloads for SSD. It's not
universally true but the impact is not as severe. While this is not
proof that the stack change is the sole root cause, it makes it less
likely.

> By chance, according to what you have measured so far, is there any
> test where, instead, you expect or have seen bfq-mq-tput to always
> lose?  I could start from there.
> 

global-dhp__io-fio-randread-async-randwrite-xfs but marginal enough that
it could be the stack change.

global-dhp__io-dbench4-fsync-ext4 was a universal loss across any
machine tested. This is global-dhp__io-dbench4-fsync from mmtests using
ext4 as a filesystem. The same is not true for XFS so the filesystem
matters.

> > However, it's not a universal gain and there are also fairness issues.
> > For example, this is a fio configuration with a single random reader and
> > a single random writer on the same machine
> > 
> > fio Throughput
> >                                              4.12.0                 4.12.0                 4.12.0
> >                                          legacy-cfq                 mq-bfq            mq-bfq-tput
> > Hmean     kb/sec-writer-write      398.15 (   0.00%)     4659.18 (1070.21%)     4934.52 (1139.37%)
> > Hmean     kb/sec-reader-read       507.00 (   0.00%)       66.36 ( -86.91%)       14.68 ( -97.10%)
> > 
> > With CFQ, there is some fairness between the readers and writers and
> > with BFQ, there is a strong preference to writers. Again, this is not
> > universal. It'll be a mix and sometimes it'll be classed as a gain and
> > sometimes a regression.
> > 
> 
> Yes, that's why I didn't pay too much attention so far to such an
> issue.  I preferred to tune for maximum responsiveness and minimal
> latency for soft real-time applications, w.r.t.  to reducing a kind of
> unfairness for which no user happened to complain (so far).  Do you
> have some real application (or benchmark simulating a real
> application) in which we can see actual problems because of this form
> of unfairness? 

I don't have data on that. This was a preliminary study only to see if
a switch was safe running workloads that would appear in internal bug
reports related to benchmarking.

> I was thinking of, e.g., two virtual machines, one
> doing heavy writes and the other heavy reads.  But in that case,
> cgroups have to be used, and I'm not sure we would still see this
> problem.  Any suggestion is welcome.
> 

I haven't spent time designing such a thing. Even if I did, I know I would
get hit within weeks of a switch during distro development with reports
related to fio, dbench and other basic IO benchmarks.

> > I had seen this assertion so one of the fio configurations had multiple
> > heavy writers in the background and a random reader of small files to
> > simulate that scenario. The intent was to simulate heavy IO in the presence
> > of application startup
> > 
> >                                              4.12.0                 4.12.0                 4.12.0
> >                                          legacy-cfq                 mq-bfq            mq-bfq-tput
> > Hmean     kb/sec-writer-write     1997.75 (   0.00%)     2035.65 (   1.90%)     2014.50 (   0.84%)
> > Hmean     kb/sec-reader-read       128.50 (   0.00%)       79.46 ( -38.16%)       12.78 ( -90.06%)
> > 
> > Write throughput is steady-ish across each IO scheduler but readers get
> > starved badly which I expect would slow application startup and disabling
> > low_latency makes it much worse.
> 
> A greedy random reader that goes on steadily mimics an application startup
> only for the first handful of seconds.
> 

Sure, but if during those handful of seconds the throughput is 10% of
what is used to be, it'll still be noticable.

> Where can I find the exact script/configuration you used, to check
> more precisely what is going on and whether BFQ is actually behaving very
> badly for some reason?
> 

https://github.com/gormanm/mmtests

All the configuration files are in configs/ so
global-dhp__io-dbench4-fsync-ext4 maps to global-dhp__io-dbench4-fsync but
it has to be editted if you want to format a test partition.  Otherwise,
you'd just need to make sure the current directory was ext4 and ignore
any filesystem aging artifacts.

> > The mmtests configuration in question
> > is global-dhp__io-fio-randread-sync-heavywrite albeit editted to create
> > a fresh XFS filesystem on a test partition.
> > 
> > This is not exactly equivalent to real application startup but that can
> > be difficult to quantify properly.
> > 
> 
> If you do want to check application startup, then just 1) start some
> background workload, 2) drop caches, 3) start the app, 4) measure how
> long it takes to start.  Otherwise, the comm_startup_lat test in the
> S suite [1] does all of this for you.
> 

I did have something like this before but found it unreliable because it
couldn't tell the difference between when an application has a window
and when it's ready for use. Evolution for example may start up and
start displaing but then clicking on a mail may stall for a few seconds.
It's difficult to quantify meaningfully which is why I eventually gave
up and relied instead on proxy measures.

-- 
Mel Gorman
SUSE Labs
