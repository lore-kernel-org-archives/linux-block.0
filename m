Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170808103023.2b2tks5y5lniuq2k@techsingularity.net>
Date: Tue, 8 Aug 2017 19:16:21 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <A4BDDC67-E22E-49BF-83F6-2A1135607BE7@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net> <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org> <20170804110103.oljdzsy7bds6qylo@techsingularity.net> <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org> <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org> <20170808103023.2b2tks5y5lniuq2k@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 08 ago 2017, alle ore 12:30, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> On Mon, Aug 07, 2017 at 07:32:41PM +0200, Paolo Valente wrote:
>>>> global-dhp__io-dbench4-fsync-ext4 was a universal loss across any
>>>> machine tested. This is global-dhp__io-dbench4-fsync from mmtests =
using
>>>> ext4 as a filesystem. The same is not true for XFS so the =
filesystem
>>>> matters.
>>>>=20
>>>=20
>>> Ok, then I will try to repeat global-dhp__io-dbench4-fsync-ext4 as
>>> soon as I can, thanks.
>>>=20
>>>=20
>>=20
>> I've run this test and tried to further investigate this regression.
>> For the moment, the gist seems to be that blk-mq plays an important
>> role, not only with bfq (unless I'm considering the wrong numbers).
>> Even if your main purpose in this thread was just to give a heads-up,
>> I guess it may be useful to share what I have found out.  In =
addition,
>> I want to ask for some help, to try to get closer to the possible
>> causes of at least this regression.  If you think it would be better
>> to open a new thread on this stuff, I'll do it.
>>=20
>=20
> I don't think it's necessary unless Christoph or Jens object and I =
doubt
> they will.
>=20
>> First, I got mixed results on my system.=20
>=20
> For what it's worth, this is standard. In my experience, IO benchmarks
> are always multi-modal, particularly on rotary storage. Cases of =
universal
> win or universal loss for a scheduler or set of tuning are rare.
>=20
>> I'll focus only on the the
>> case where mq-bfq-tput achieves its worst relative performance w.r.t.
>> to cfq, which happens with 64 clients.  Still, also in this case
>> mq-bfq is better than cfq in all average values, but Flush.  I don't
>> know which are the best/right values to look at, so, here's the final
>> report for both schedulers:
>>=20
>=20
> For what it's worth, it has often been observed that dbench overall
> performance was dominated by flush costs. This is also true for the
> standard reported throughput figures rather than the modified load =
file
> elapsed time that mmtests reports. In dbench3 it was even worse where =
the
> "performance" was dominated by whether the temporary files were =
deleted
> before writeback started.
>=20
>> CFQ
>>=20
>> Operation                Count    AvgLat    MaxLat
>> --------------------------------------------------
>> Flush                    13120    20.069   348.594
>> Close                   133696     0.008    14.642
>> LockX                      512     0.009     0.059
>> Rename                    7552     1.857   415.418
>> ReadX                   270720     0.141   535.632
>> WriteX                   89591   421.961  6363.271
>> Unlink                   34048     1.281   662.467
>> UnlockX                    512     0.007     0.057
>> FIND_FIRST               62016     0.086    25.060
>> SET_FILE_INFORMATION     15616     0.995   176.621
>> QUERY_FILE_INFORMATION   28734     0.004     1.372
>> QUERY_PATH_INFORMATION  170240     0.163   820.292
>> QUERY_FS_INFORMATION     28736     0.017     4.110
>> NTCreateX               178688     0.437   905.567
>>=20
>> MQ-BFQ-TPUT
>>=20
>> Operation                Count    AvgLat    MaxLat
>> --------------------------------------------------
>> Flush                    13504    75.828 11196.035
>> Close                   136896     0.004     3.855
>> LockX                      640     0.005     0.031
>> Rename                    8064     1.020   288.989
>> ReadX                   297600     0.081   685.850
>> WriteX                   93515   391.637 12681.517
>> Unlink                   34880     0.500   146.928
>> UnlockX                    640     0.004     0.032
>> FIND_FIRST               63680     0.045   222.491
>> SET_FILE_INFORMATION     16000     0.436   686.115
>> QUERY_FILE_INFORMATION   30464     0.003     0.773
>> QUERY_PATH_INFORMATION  175552     0.044   148.449
>> QUERY_FS_INFORMATION     29888     0.009     1.984
>> NTCreateX               183152     0.289   300.867
>>=20
>> Are these results in line with yours for this test?
>>=20
>=20
> Very broadly speaking yes, but it varies. On a small machine, the =
differences
> in flush latency are visible but not as dramatic. It only has a few
> CPUs. On a machine that tops out with 32 CPUs, it is more noticable. =
On
> the one machine I have that topped out with CFQ/BFQ at 64 threads, the
> latency of flush is vaguely similar
>=20
> 			CFQ			BFQ			=
BFQ-TPUT
> latency	avg-Flush-64 	287.05	( 0.00%)	389.14	( =
-35.57%)	349.90	( -21.90%)
> latency	avg-Close-64 	0.00	( 0.00%)	0.00	( =
-33.33%)	0.00	( 0.00%)
> latency	avg-LockX-64 	0.01	( 0.00%)	0.01	( =
-16.67%)	0.01	( 0.00%)
> latency	avg-Rename-64 	0.18	( 0.00%)	0.21	( =
-16.39%)	0.18	( 3.28%)
> latency	avg-ReadX-64 	0.10	( 0.00%)	0.15	( =
-40.95%)	0.15	( -40.95%)
> latency	avg-WriteX-64 	0.86	( 0.00%)	0.81	( 6.18%)	=
0.74	( 13.75%)
> latency	avg-Unlink-64 	1.49	( 0.00%)	1.52	( =
-2.28%)	1.14	( 23.69%)
> latency	avg-UnlockX-64 	0.00	( 0.00%)	0.00	( 0.00%)	=
0.00	( 0.00%)
> latency	avg-NTCreateX-64 	0.26	( 0.00%)	0.30	=
( -16.15%)	0.21	( 19.62%)
>=20
> So, different figures to yours but the general observation that flush
> latency is higher holds.
>=20
>> Anyway, to investigate this regression more in depth, I took two
>> further steps.  First, I repeated the same test with bfq-sq, my
>> out-of-tree version of bfq for legacy block (identical to mq-bfq =
apart
>> from the changes needed for bfq to live in blk-mq).  I got:
>>=20
>> <SNIP>
>>=20
>> So, with both bfq and deadline there seems to be a serious =
regression,
>> especially on MaxLat, when moving from legacy block to blk-mq.  The
>> regression is much worse with deadline, as legacy-deadline has the
>> lowest max latency among all the schedulers, whereas mq-deadline has
>> the highest one.
>>=20
>=20
> I wouldn't worry too much about max latency simply because a large
> outliier can be due to multiple factors and it will be variable.
> However, I accept that deadline is not necessarily great either.
>=20
>> Regardless of the actual culprit of this regression, I would like to
>> investigate further this issue.  In this respect, I would like to ask
>> for a little help.  I would like to isolate the workloads generating
>> the highest latencies.  To this purpose, I had a look at the loadfile
>> client-tiny.txt, and I still have a doubt: is every item in the
>> loadfile executed somehow several times (for each value of the number
>> of clients), or is it executed only once?  More precisely, IIUC, for
>> each operation reported in the above results, there are several items
>> (lines) in the loadfile.  So, is each of these items executed only
>> once?
>>=20
>=20
> The load file is executed multiple times. The normal loadfile was
> basically just the same commands, or very similar commands, run =
multiple
> times within a single load file. This made the workload too sensitive =
to
> the exact time the workload finished and too coarse.
>=20
>> I'm asking because, if it is executed only once, then I guess I can
>> find the critical tasks ore easily.  Finally, if it is actually
>> executed only once, is it expected that the latency for such a task =
is
>> one order of magnitude higher than that of the average latency for
>> that group of tasks?  I mean, is such a task intrinsically much
>> heavier, and then expectedly much longer, or is the fact that latency
>> is much higher for this task a sign that something in the kernel
>> misbehaves for that task?
>>=20
>=20
> I don't think it's quite as easily isolated. It's all the operations =
in
> combination that replicate the behaviour. If it was just a single =
operation
> like "fsync" then it would be fairly straight-forward but the full mix
> is relevant as it matters when writeback kicks off, when merges =
happen,
> how much dirty data was outstanding when writeback or sync started =
etc.
>=20
> I see you've made other responses to the thread so rather than respond
> individually=20
>=20
> o I've queued a subset of tests with Ming's v3 patchset as that was =
the
>  latest branch at the time I looked. It'll take quite some time to =
execute
>  as the grid I use to collect data is backlogged with other work
>=20
> o I've included pgioperf this time because it is good at demonstrate
>  oddities related to fsync. Granted it's mostly simulating a database
>  workload that is typically recommended to use deadline scheduler but =
I
>  think it's still a useful demonstration=20
>=20
> o If you want a patch set queued that may improve workload pattern
>  detection for dbench then I can add that to the grid with the caveat =
that
>  results take time. It'll be a blind test as I'm not actively =
debugging
>  IO-related problems right now.
>=20
> o I'll keep an eye out for other workloads that demonstrate =
empirically
>  better performance given that a stopwatch and desktop performance is
>  tough to quantify even though I'm typically working in other areas. =
While
>  I don't spend a lot of time on IO-related problems, it would still
>  be preferred if switching to MQ by default was a safe option so I'm
>  interested enough to keep it in mind.
>=20

Hi Mel,
thanks for your thorough responses (I'm about to write something about
the read-write unfairness issue, with, again, some surprise).

I want to reply only to your last point above.  With our
responsiveness benchmark of course you don't need a stopwatch, but,
yes, to get some minimally comprehensive results you need a machine
with at least a desktop application like a terminal installed.

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
