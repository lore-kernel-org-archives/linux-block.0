Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
Date: Sat, 5 Aug 2017 00:05:00 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net> <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org> <20170804110103.oljdzsy7bds6qylo@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 04 ago 2017, alle ore 13:01, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> On Fri, Aug 04, 2017 at 09:26:20AM +0200, Paolo Valente wrote:
>>> I took that into account BFQ with low-latency was also tested and =
the
>>> impact was not a universal improvement although it can be a =
noticable
>>> improvement. =46rom the same machine;
>>>=20
>>> dbench4 Loadfile Execution Time
>>>                            4.12.0                 4.12.0             =
    4.12.0
>>>                        legacy-cfq                 mq-bfq            =
mq-bfq-tput
>>> Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)       =
84.70 (  -5.00%)
>>> Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)       =
88.74 (   4.45%)
>>> Amean     4       102.72 (   0.00%)      474.33 (-361.77%)      =
113.97 ( -10.95%)
>>> Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)     =
2038.74 (  19.86%)
>>>=20
>>=20
>> Thanks for trying with low_latency disabled.  If I read numbers
>> correctly, we move from a worst case of 361% higher execution time to
>> a worst case of 11%.  With a best case of 20% of lower execution =
time.
>>=20
>=20
> Yes.
>=20
>> I asked you about none and mq-deadline in a previous email, because
>> actually we have a double change here: change of the I/O stack, and
>> change of the scheduler, with the first change probably not =
irrelevant
>> with respect to the second one.
>>=20
>=20
> True. However, the difference between legacy-deadline mq-deadline is
> roughly around the 5-10% mark across workloads for SSD. It's not
> universally true but the impact is not as severe. While this is not
> proof that the stack change is the sole root cause, it makes it less
> likely.
>=20

I'm getting a little lost here.  If I'm not mistaken, you are saying,
since the difference between two virtually identical schedulers
(legacy-deadline and mq-deadline) is only around 5-10%, while the
difference between cfq and mq-bfq-tput is higher, then in the latter
case it is not the stack's fault.  Yet the loss of mq-bfq-tput in the
above test is exactly in the 5-10% range?  What am I missing?  Other
tests with mq-bfq-tput not yet reported?

>> By chance, according to what you have measured so far, is there any
>> test where, instead, you expect or have seen bfq-mq-tput to always
>> lose?  I could start from there.
>>=20
>=20
> global-dhp__io-fio-randread-async-randwrite-xfs but marginal enough =
that
> it could be the stack change.
>=20
> global-dhp__io-dbench4-fsync-ext4 was a universal loss across any
> machine tested. This is global-dhp__io-dbench4-fsync from mmtests =
using
> ext4 as a filesystem. The same is not true for XFS so the filesystem
> matters.
>=20

Ok, then I will try to repeat global-dhp__io-dbench4-fsync-ext4 as
soon as I can, thanks.


>>> However, it's not a universal gain and there are also fairness =
issues.
>>> For example, this is a fio configuration with a single random reader =
and
>>> a single random writer on the same machine
>>>=20
>>> fio Throughput
>>>                                             4.12.0                 =
4.12.0                 4.12.0
>>>                                         legacy-cfq                 =
mq-bfq            mq-bfq-tput
>>> Hmean     kb/sec-writer-write      398.15 (   0.00%)     4659.18 =
(1070.21%)     4934.52 (1139.37%)
>>> Hmean     kb/sec-reader-read       507.00 (   0.00%)       66.36 ( =
-86.91%)       14.68 ( -97.10%)
>>>=20
>>> With CFQ, there is some fairness between the readers and writers and
>>> with BFQ, there is a strong preference to writers. Again, this is =
not
>>> universal. It'll be a mix and sometimes it'll be classed as a gain =
and
>>> sometimes a regression.
>>>=20
>>=20
>> Yes, that's why I didn't pay too much attention so far to such an
>> issue.  I preferred to tune for maximum responsiveness and minimal
>> latency for soft real-time applications, w.r.t.  to reducing a kind =
of
>> unfairness for which no user happened to complain (so far).  Do you
>> have some real application (or benchmark simulating a real
>> application) in which we can see actual problems because of this form
>> of unfairness?=20
>=20
> I don't have data on that. This was a preliminary study only to see if
> a switch was safe running workloads that would appear in internal bug
> reports related to benchmarking.
>=20
>> I was thinking of, e.g., two virtual machines, one
>> doing heavy writes and the other heavy reads.  But in that case,
>> cgroups have to be used, and I'm not sure we would still see this
>> problem.  Any suggestion is welcome.
>>=20
>=20
> I haven't spent time designing such a thing. Even if I did, I know I =
would
> get hit within weeks of a switch during distro development with =
reports
> related to fio, dbench and other basic IO benchmarks.
>=20

I see.

>>> I had seen this assertion so one of the fio configurations had =
multiple
>>> heavy writers in the background and a random reader of small files =
to
>>> simulate that scenario. The intent was to simulate heavy IO in the =
presence
>>> of application startup
>>>=20
>>>                                             4.12.0                 =
4.12.0                 4.12.0
>>>                                         legacy-cfq                 =
mq-bfq            mq-bfq-tput
>>> Hmean     kb/sec-writer-write     1997.75 (   0.00%)     2035.65 (   =
1.90%)     2014.50 (   0.84%)
>>> Hmean     kb/sec-reader-read       128.50 (   0.00%)       79.46 ( =
-38.16%)       12.78 ( -90.06%)
>>>=20
>>> Write throughput is steady-ish across each IO scheduler but readers =
get
>>> starved badly which I expect would slow application startup and =
disabling
>>> low_latency makes it much worse.
>>=20
>> A greedy random reader that goes on steadily mimics an application =
startup
>> only for the first handful of seconds.
>>=20
>=20
> Sure, but if during those handful of seconds the throughput is 10% of
> what is used to be, it'll still be noticeable.
>=20

I did not have the time yet to repeat this test (I will try soon), but
I had the time think about it a little bit.  And I soon realized that
actually this is not a responsiveness test against background
workload, or, it is at most an extreme corner case for it.  Both the
write and the read thread start at the same time.  So, we are
mimicking a user starting, e.g., a file copy, and, exactly at the same
time, an app(in addition, the file copy starts to cause heavy writes
immediately).

BFQ uses time patterns to guess which processes to privilege, and the
time patterns of the writer and reader are indistinguishable here.
Only tagging processes with extra information would help, but that is
a different story.  And in this case tagging would help for a
not-so-frequent use case.

In addition, a greedy random reader may mimick the start-up of only
very simple applications.  Even a simple terminal such as xterm does
some I/O (not completely random, but I guess we don't need to be
overpicky), then it stops doing I/O and passes the ball to the X
server, which does some I/O, stops and passes the ball back to xterm
for its final start-up phase.  More and more processes are involved,
and more and more complex I/O patterns are issued as applications
become more complex.  This is the reason why we strived to benchmark
application start-up by truly starting real applications and measuring
their start-up time (see below).

>> Where can I find the exact script/configuration you used, to check
>> more precisely what is going on and whether BFQ is actually behaving =
very
>> badly for some reason?
>>=20
>=20
> https://github.com/gormanm/mmtests
>=20
> All the configuration files are in configs/ so
> global-dhp__io-dbench4-fsync-ext4 maps to global-dhp__io-dbench4-fsync =
but
> it has to be editted if you want to format a test partition.  =
Otherwise,
> you'd just need to make sure the current directory was ext4 and ignore
> any filesystem aging artifacts.
>=20

Thank you, I'll do it ASAP.

>>> The mmtests configuration in question
>>> is global-dhp__io-fio-randread-sync-heavywrite albeit editted to =
create
>>> a fresh XFS filesystem on a test partition.
>>>=20
>>> This is not exactly equivalent to real application startup but that =
can
>>> be difficult to quantify properly.
>>>=20
>>=20
>> If you do want to check application startup, then just 1) start some
>> background workload, 2) drop caches, 3) start the app, 4) measure how
>> long it takes to start.  Otherwise, the comm_startup_lat test in the
>> S suite [1] does all of this for you.
>>=20
>=20
> I did have something like this before but found it unreliable because =
it
> couldn't tell the difference between when an application has a window
> and when it's ready for use. Evolution for example may start up and
> start displaing but then clicking on a mail may stall for a few =
seconds.
> It's difficult to quantify meaningfully which is why I eventually gave
> up and relied instead on proxy measures.
>=20

Right, that's why we looked for other applications that were as
popular, but for which we could get reliable and precise measures.
One such application is a terminal, another one a shell.  On the
opposite end of the size spectrum, another other such applications are
libreoffice/openoffice.

For, e.g, gnome-terminal, it is enough to invoke "time gnome-terminal
-e /bin/true".  By the stopwatch, such a command measures very
precisely the time that elapses from when you start the terminal, to
when you can start typing a command in its window.  Similarly, "xterm
/bin/true", "ssh localhost exit", "bash -c exit", "lowriter
--terminate-after-init".  Of course, these tricks certainly cause a
few more block reads than the real, bare application start-up, but,
even if the difference were noticeable in terms of time, what matters
is to measure the execution time of these commands without background
workload, and then compare it against their execution time with some
background workload.  If it takes, say, 5 seconds without background
workload, and still about 5 seconds with background workload and a
given scheduler, but, with another scheduler, it takes 40 seconds with
background workload (all real numbers, actually), then you can draw
some sound conclusion on responsiveness for the each of the two
schedulers.

In addition, as for coverage, we made the empiric assumption that
start-up time measured with each of the above easy-to-benchmark
applications gives an idea of the time that it would take with any
application of the same size and complexity.  User feedback confirmed
this assumptions so far.  Of course there may well be exceptions.

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
