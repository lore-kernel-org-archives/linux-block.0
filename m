Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
Date: Fri, 4 Aug 2017 09:26:20 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 03 ago 2017, alle ore 13:01, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> On Thu, Aug 03, 2017 at 11:21:59AM +0200, Paolo Valente wrote:
>>> For Paulo, if you want to try preemptively dealing with regression =
reports
>>> before 4.13 releases then all the tests in question can be =
reproduced with
>>> https://github.com/gormanm/mmtests . The most relevant test =
configurations
>>> I've seen so far are
>>>=20
>>> configs/config-global-dhp__io-dbench4-async
>>> configs/config-global-dhp__io-fio-randread-async-randwrite
>>> configs/config-global-dhp__io-fio-randread-async-seqwrite
>>> configs/config-global-dhp__io-fio-randread-sync-heavywrite
>>> configs/config-global-dhp__io-fio-randread-sync-randwrite
>>> configs/config-global-dhp__pgioperf
>>>=20
>>=20
>> Hi Mel,
>> as it already happened with the latest Phoronix benchmark article =
(and
>> with other test results reported several months ago on this list), =
bad
>> results may be caused (also) by the fact that the low-latency, =
default
>> configuration of BFQ is being used.=20
>=20
> I took that into account BFQ with low-latency was also tested and the
> impact was not a universal improvement although it can be a noticable
> improvement. =46rom the same machine;
>=20
> dbench4 Loadfile Execution Time
>                             4.12.0                 4.12.0              =
   4.12.0
>                         legacy-cfq                 mq-bfq            =
mq-bfq-tput
> Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)       84.70 =
(  -5.00%)
> Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)       88.74 =
(   4.45%)
> Amean     4       102.72 (   0.00%)      474.33 (-361.77%)      113.97 =
( -10.95%)
> Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)     2038.74 =
(  19.86%)
>=20

Thanks for trying with low_latency disabled.  If I read numbers
correctly, we move from a worst case of 361% higher execution time to
a worst case of 11%.  With a best case of 20% of lower execution time.

I asked you about none and mq-deadline in a previous email, because
actually we have a double change here: change of the I/O stack, and
change of the scheduler, with the first change probably not irrelevant
with respect to the second one.

Are we sure that part of the small losses and gains with bfq-mq-tput
aren't due to the change of I/O stack?  My problem is that it may be
hard to find issues or anomalies in BFQ that justify a 5% or 11% loss
in two cases, while the same scheduler has a 4% and a 20% gain in the
other two cases.

By chance, according to what you have measured so far, is there any
test where, instead, you expect or have seen bfq-mq-tput to always
lose?  I could start from there.

> However, it's not a universal gain and there are also fairness issues.
> For example, this is a fio configuration with a single random reader =
and
> a single random writer on the same machine
>=20
> fio Throughput
>                                              4.12.0                 =
4.12.0                 4.12.0
>                                          legacy-cfq                 =
mq-bfq            mq-bfq-tput
> Hmean     kb/sec-writer-write      398.15 (   0.00%)     4659.18 =
(1070.21%)     4934.52 (1139.37%)
> Hmean     kb/sec-reader-read       507.00 (   0.00%)       66.36 ( =
-86.91%)       14.68 ( -97.10%)
>=20
> With CFQ, there is some fairness between the readers and writers and
> with BFQ, there is a strong preference to writers. Again, this is not
> universal. It'll be a mix and sometimes it'll be classed as a gain and
> sometimes a regression.
>=20

Yes, that's why I didn't pay too much attention so far to such an
issue.  I preferred to tune for maximum responsiveness and minimal
latency for soft real-time applications, w.r.t.  to reducing a kind of
unfairness for which no user happened to complain (so far).  Do you
have some real application (or benchmark simulating a real
application) in which we can see actual problems because of this form
of unfairness?  I was thinking of, e.g., two virtual machines, one
doing heavy writes and the other heavy reads.  But in that case,
cgroups have to be used, and I'm not sure we would still see this
problem.  Any suggestion is welcome.

In any case, if needed, changing read/write throughput ratio should
not be a problem.

> While I accept that BFQ can be tuned, tuning IO schedulers is not =
something
> that normal users get right and they'll only look at "out of box" =
performance
> which, right now, will trigger bug reports. This is neither good nor =
bad,
> it simply is.
>=20
>> This configuration is the default
>> one because the motivation for yet-another-scheduler as BFQ is that =
it
>> drastically reduces latency for interactive and soft real-time tasks
>> (e.g., opening an app or playing/streaming a video), when there is
>> some background I/O.  Low-latency heuristics are willing to sacrifice
>> throughput when this provides a large benefit in terms of the above
>> latency.
>>=20
>=20
> I had seen this assertion so one of the fio configurations had =
multiple
> heavy writers in the background and a random reader of small files to
> simulate that scenario. The intent was to simulate heavy IO in the =
presence
> of application startup
>=20
>                                              4.12.0                 =
4.12.0                 4.12.0
>                                          legacy-cfq                 =
mq-bfq            mq-bfq-tput
> Hmean     kb/sec-writer-write     1997.75 (   0.00%)     2035.65 (   =
1.90%)     2014.50 (   0.84%)
> Hmean     kb/sec-reader-read       128.50 (   0.00%)       79.46 ( =
-38.16%)       12.78 ( -90.06%)
>=20
> Write throughput is steady-ish across each IO scheduler but readers =
get
> starved badly which I expect would slow application startup and =
disabling
> low_latency makes it much worse.

A greedy random reader that goes on steadily mimics an application =
startup
only for the first handful of seconds.

Where can I find the exact script/configuration you used, to check
more precisely what is going on and whether BFQ is actually behaving =
very
badly for some reason?

> The mmtests configuration in question
> is global-dhp__io-fio-randread-sync-heavywrite albeit editted to =
create
> a fresh XFS filesystem on a test partition.
>=20
> This is not exactly equivalent to real application startup but that =
can
> be difficult to quantify properly.
>=20

If you do want to check application startup, then just 1) start some
background workload, 2) drop caches, 3) start the app, 4) measure how
long it takes to start.  Otherwise, the comm_startup_lat test in the
S suite [1] does all of this for you.

[1] https://github.com/Algodev-github/S

>> Of course, BFQ may not be optimal for every workload, even if
>> low-latency mode is switched off.  In addition, there may still be
>> some bug.  I'll repeat your tests on a machine of mine ASAP.
>>=20
>=20
> The intent here is not to rag on BFQ because I know it's going to have =
some
> wins and some losses and will take time to fix up. The primary intent =
was
> to flag that 4.13 might have some "blah blah blah is slower on 4.13" =
reports
> due to the switching of defaults that will bisect to a misleading =
commit.
>=20

I see, and being ready in advance is extremely helpful for me.

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
