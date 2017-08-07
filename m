Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
Date: Mon, 7 Aug 2017 20:42:18 +0200
Cc: Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Message-Id: <5E507CD1-C88A-4261-8043-75ABD5620054@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <1B2E3D98-1152-413F-84A9-B3DAC5A528E8@linaro.org> <20170803110144.vvadm3cc5oetf7up@techsingularity.net> <4B181ED1-8605-4156-9BBF-B61A165BE7F5@linaro.org> <20170804110103.oljdzsy7bds6qylo@techsingularity.net> <34B4C2EB-18B2-4EAB-9BBC-8095603D733D@linaro.org> <70979B37-6F91-49C3-9C77-CB3364035DDF@linaro.org>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 ago 2017, alle ore 19:32, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 05 ago 2017, alle ore 00:05, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>>>=20
>>> Il giorno 04 ago 2017, alle ore 13:01, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>>>=20
>>> On Fri, Aug 04, 2017 at 09:26:20AM +0200, Paolo Valente wrote:
>>>>> I took that into account BFQ with low-latency was also tested and =
the
>>>>> impact was not a universal improvement although it can be a =
noticable
>>>>> improvement. =46rom the same machine;
>>>>>=20
>>>>> dbench4 Loadfile Execution Time
>>>>>                          4.12.0                 4.12.0             =
    4.12.0
>>>>>                      legacy-cfq                 mq-bfq            =
mq-bfq-tput
>>>>> Amean     1        80.67 (   0.00%)       83.68 (  -3.74%)       =
84.70 (  -5.00%)
>>>>> Amean     2        92.87 (   0.00%)      121.63 ( -30.96%)       =
88.74 (   4.45%)
>>>>> Amean     4       102.72 (   0.00%)      474.33 (-361.77%)      =
113.97 ( -10.95%)
>>>>> Amean     32     2543.93 (   0.00%)     1927.65 (  24.23%)     =
2038.74 (  19.86%)
>>>>>=20
>>>>=20
>>>> Thanks for trying with low_latency disabled.  If I read numbers
>>>> correctly, we move from a worst case of 361% higher execution time =
to
>>>> a worst case of 11%.  With a best case of 20% of lower execution =
time.
>>>>=20
>>>=20
>>> Yes.
>>>=20
>>>> I asked you about none and mq-deadline in a previous email, because
>>>> actually we have a double change here: change of the I/O stack, and
>>>> change of the scheduler, with the first change probably not =
irrelevant
>>>> with respect to the second one.
>>>>=20
>>>=20
>>> True. However, the difference between legacy-deadline mq-deadline is
>>> roughly around the 5-10% mark across workloads for SSD. It's not
>>> universally true but the impact is not as severe. While this is not
>>> proof that the stack change is the sole root cause, it makes it less
>>> likely.
>>>=20
>>=20
>> I'm getting a little lost here.  If I'm not mistaken, you are saying,
>> since the difference between two virtually identical schedulers
>> (legacy-deadline and mq-deadline) is only around 5-10%, while the
>> difference between cfq and mq-bfq-tput is higher, then in the latter
>> case it is not the stack's fault.  Yet the loss of mq-bfq-tput in the
>> above test is exactly in the 5-10% range?  What am I missing?  Other
>> tests with mq-bfq-tput not yet reported?
>>=20
>>>> By chance, according to what you have measured so far, is there any
>>>> test where, instead, you expect or have seen bfq-mq-tput to always
>>>> lose?  I could start from there.
>>>>=20
>>>=20
>>> global-dhp__io-fio-randread-async-randwrite-xfs but marginal enough =
that
>>> it could be the stack change.
>>>=20
>>> global-dhp__io-dbench4-fsync-ext4 was a universal loss across any
>>> machine tested. This is global-dhp__io-dbench4-fsync from mmtests =
using
>>> ext4 as a filesystem. The same is not true for XFS so the filesystem
>>> matters.
>>>=20
>>=20
>> Ok, then I will try to repeat global-dhp__io-dbench4-fsync-ext4 as
>> soon as I can, thanks.
>>=20
>>=20
>=20
> I've run this test and tried to further investigate this regression.
> For the moment, the gist seems to be that blk-mq plays an important
> role, not only with bfq (unless I'm considering the wrong numbers).
> Even if your main purpose in this thread was just to give a heads-up,
> I guess it may be useful to share what I have found out.  In addition,
> I want to ask for some help, to try to get closer to the possible
> causes of at least this regression.  If you think it would be better
> to open a new thread on this stuff, I'll do it.
>=20
> First, I got mixed results on my system.  I'll focus only on the the
> case where mq-bfq-tput achieves its worst relative performance w.r.t.
> to cfq, which happens with 64 clients.  Still, also in this case
> mq-bfq is better than cfq in all average values, but Flush.  I don't
> know which are the best/right values to look at, so, here's the final
> report for both schedulers:
>=20
> CFQ
>=20
> Operation                Count    AvgLat    MaxLat
> --------------------------------------------------
> Flush                    13120    20.069   348.594
> Close                   133696     0.008    14.642
> LockX                      512     0.009     0.059
> Rename                    7552     1.857   415.418
> ReadX                   270720     0.141   535.632
> WriteX                   89591   421.961  6363.271
> Unlink                   34048     1.281   662.467
> UnlockX                    512     0.007     0.057
> FIND_FIRST               62016     0.086    25.060
> SET_FILE_INFORMATION     15616     0.995   176.621
> QUERY_FILE_INFORMATION   28734     0.004     1.372
> QUERY_PATH_INFORMATION  170240     0.163   820.292
> QUERY_FS_INFORMATION     28736     0.017     4.110
> NTCreateX               178688     0.437   905.567
>=20
> MQ-BFQ-TPUT
>=20
> Operation                Count    AvgLat    MaxLat
> --------------------------------------------------
> Flush                    13504    75.828 11196.035
> Close                   136896     0.004     3.855
> LockX                      640     0.005     0.031
> Rename                    8064     1.020   288.989
> ReadX                   297600     0.081   685.850
> WriteX                   93515   391.637 12681.517
> Unlink                   34880     0.500   146.928
> UnlockX                    640     0.004     0.032
> FIND_FIRST               63680     0.045   222.491
> SET_FILE_INFORMATION     16000     0.436   686.115
> QUERY_FILE_INFORMATION   30464     0.003     0.773
> QUERY_PATH_INFORMATION  175552     0.044   148.449
> QUERY_FS_INFORMATION     29888     0.009     1.984
> NTCreateX               183152     0.289   300.867
>=20
> Are these results in line with yours for this test?
>=20
> Anyway, to investigate this regression more in depth, I took two
> further steps.  First, I repeated the same test with bfq-sq, my
> out-of-tree version of bfq for legacy block (identical to mq-bfq apart
> from the changes needed for bfq to live in blk-mq).  I got:
>=20
> BFQ-SQ-TPUT
>=20
> Operation                Count    AvgLat    MaxLat
> --------------------------------------------------
> Flush                    12618    30.212   484.099
> Close                   123884     0.008    10.477
> LockX                      512     0.010     0.170
> Rename                    7296     2.032   426.409
> ReadX                   262179     0.251   985.478
> WriteX                   84072   461.398  7283.003
> Unlink                   33076     1.685   848.734
> UnlockX                    512     0.007     0.036
> FIND_FIRST               58690     0.096   220.720
> SET_FILE_INFORMATION     14976     1.792   466.435
> QUERY_FILE_INFORMATION   26575     0.004     2.194
> QUERY_PATH_INFORMATION  158125     0.112   614.063
> QUERY_FS_INFORMATION     28224     0.017     1.385
> NTCreateX               167877     0.827   945.644
>=20
> So, the worst-case regression is now around 15%.  This made me suspect
> that blk-mq influences results a lot for this test.  To crosscheck, I
> compared legacy-deadline and mq-deadline too.
>=20

Ok, found the problem for the 15% loss in bfq-sq.  bfq-sq gets
occasionally confused by the workload, and grants device idling to
processes that, for this specific workload, would be better to
de-schedule immediately.  If we set slice_idle to 0, then bfq-sq
becomes more or less equivalent to cfq (for some operations apparently
even much better):

bfq-sq-tput-0idle

 Operation                Count    AvgLat    MaxLat
 --------------------------------------------------
 Flush                    13013    17.888   280.517
 Close                   133004     0.008    20.698
 LockX                      512     0.008     0.088
 Rename                    7427     2.041   193.232
 ReadX                   270534     0.138   408.534
 WriteX                   88598   429.615  6272.212
 Unlink                   33734     1.205   559.152
 UnlockX                    512     0.011     1.808
 FIND_FIRST               61762     0.087    23.012
 SET_FILE_INFORMATION     15337     1.322   220.155
 QUERY_FILE_INFORMATION   28415     0.004     0.559
 QUERY_PATH_INFORMATION  169423     0.150   580.570
 QUERY_FS_INFORMATION     28547     0.019    24.466
 NTCreateX               177618     0.544   681.795

I'll try soon with mq-bfq too, for which I expect however a deeper
investigation to be needed.

Thanks,
Paolo

> LEGACY-DEADLINE
>=20
> Operation                Count    AvgLat    MaxLat
> --------------------------------------------------
> Flush                    13267     9.622   298.206
> Close                   135692     0.007    10.627
> LockX                      640     0.008     0.066
> Rename                    7827     0.544   481.123
> ReadX                   285929     0.220  2698.442
> WriteX                   92309   430.867  5191.608
> Unlink                   34534     1.133   619.235
> UnlockX                    640     0.008     0.724
> FIND_FIRST               63289     0.086    56.851
> SET_FILE_INFORMATION     16000     1.254   844.065
> QUERY_FILE_INFORMATION   29883     0.004     0.618
> QUERY_PATH_INFORMATION  173232     0.089  1295.651
> QUERY_FS_INFORMATION     29632     0.017     4.813
> NTCreateX               181464     0.479  2214.343
>=20
>=20
> MQ-DEADLINE
>=20
> Operation                Count    AvgLat    MaxLat
> --------------------------------------------------
> Flush                    13760    90.542 13221.495
> Close                   137654     0.008    27.133
> LockX                      640     0.009     0.115
> Rename                    8064     1.062   246.759
> ReadX                   297956     0.051   347.018
> WriteX                   94698   425.636 15090.020
> Unlink                   35077     0.580   208.462
> UnlockX                    640     0.007     0.291
> FIND_FIRST               66630     0.566   530.339
> SET_FILE_INFORMATION     16000     1.419   811.494
> QUERY_FILE_INFORMATION   30717     0.004     1.108
> QUERY_PATH_INFORMATION  176153     0.182   517.419
> QUERY_FS_INFORMATION     30857     0.018    18.562
> NTCreateX               184145     0.281   582.076
>=20
> So, with both bfq and deadline there seems to be a serious regression,
> especially on MaxLat, when moving from legacy block to blk-mq.  The
> regression is much worse with deadline, as legacy-deadline has the
> lowest max latency among all the schedulers, whereas mq-deadline has
> the highest one.
>=20
> Regardless of the actual culprit of this regression, I would like to
> investigate further this issue.  In this respect, I would like to ask
> for a little help.  I would like to isolate the workloads generating
> the highest latencies.  To this purpose, I had a look at the loadfile
> client-tiny.txt, and I still have a doubt: is every item in the
> loadfile executed somehow several times (for each value of the number
> of clients), or is it executed only once?  More precisely, IIUC, for
> each operation reported in the above results, there are several items
> (lines) in the loadfile.  So, is each of these items executed only
> once?
>=20
> I'm asking because, if it is executed only once, then I guess I can
> find the critical tasks ore easily.  Finally, if it is actually
> executed only once, is it expected that the latency for such a task is
> one order of magnitude higher than that of the average latency for
> that group of tasks?  I mean, is such a task intrinsically much
> heavier, and then expectedly much longer, or is the fact that latency
> is much higher for this task a sign that something in the kernel
> misbehaves for that task?
>=20
> While waiting for some feedback, I'm going to execute your test
> showing great unfairness between writes and reads, and to also check
> whether responsiveness does worsen if the write workload for that test
> is being executed in the background.
>=20
> Thanks,
> Paolo
>=20
>> ...
>>> --=20
>>> Mel Gorman
>>> SUSE Labs
