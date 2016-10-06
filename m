Return-Path: <linux-block-owner@vger.kernel.org>
Received: from spostino.sms.unimo.it ([155.185.44.3]:49409 "EHLO
        spostino.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbcJFNP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 09:15:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it>
Date: Thu, 6 Oct 2016 15:15:50 +0200
Cc: Tejun Heo <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <35D8ECB2-BE20-4A4E-9B93-951B0D5042C9@unimore.it>
References: <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it> <20161005144946.GA26977@htj.duckdns.org> <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com> <E7D744B7-22B1-4D6B-9C42-A43517AA490F@unimore.it> <20161005204601.GB1754@anikkar-mbp.local.dhcp.thefacebook.com> <5699035C-6DC3-497A-9D7A-A4E43D17C3CD@unimore.it>
To: Shaohua Li <shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 06 ott 2016, alle ore 09:58, Paolo Valente <paolo.valente@unimore.it> ha scritto:
> 
>> 
>> Il giorno 05 ott 2016, alle ore 22:46, Shaohua Li <shli@fb.com> ha scritto:
>> 
>> On Wed, Oct 05, 2016 at 09:47:19PM +0200, Paolo Valente wrote:
>>> 
>>>> Il giorno 05 ott 2016, alle ore 20:30, Shaohua Li <shli@fb.com> ha scritto:
>>>> 
>>>> On Wed, Oct 05, 2016 at 10:49:46AM -0400, Tejun Heo wrote:
>>>>> Hello, Paolo.
>>>>> 
>>>>> On Wed, Oct 05, 2016 at 02:37:00PM +0200, Paolo Valente wrote:
>>>>>> In this respect, for your generic, unpredictable scenario to make
>>>>>> sense, there must exist at least one real system that meets the
>>>>>> requirements of such a scenario.  Or, if such a real system does not
>>>>>> yet exist, it must be possible to emulate it.  If it is impossible to
>>>>>> achieve this last goal either, then I miss the usefulness
>>>>>> of looking for solutions for such a scenario.
>>>>>> 
>>>>>> That said, let's define the instance(s) of the scenario that you find
>>>>>> most representative, and let's test BFQ on it/them.  Numbers will give
>>>>>> us the answers.  For example, what about all or part of the following
>>>>>> groups:
>>>>>> . one cyclically doing random I/O for some second and then sequential I/O
>>>>>> for the next seconds
>>>>>> . one doing, say, quasi-sequential I/O in ON/OFF cycles
>>>>>> . one starting an application cyclically
>>>>>> . one playing back or streaming a movie
>>>>>> 
>>>>>> For each group, we could then measure the time needed to complete each
>>>>>> phase of I/O in each cycle, plus the responsiveness in the group
>>>>>> starting an application, plus the frame drop in the group streaming
>>>>>> the movie.  In addition, we can measure the bandwidth/iops enjoyed by
>>>>>> each group, plus, of course, the aggregate throughput of the whole
>>>>>> system.  In particular we could compare results with throttling, BFQ,
>>>>>> and CFQ.
>>>>>> 
>>>>>> Then we could write resulting numbers on the stone, and stick to them
>>>>>> until something proves them wrong.
>>>>>> 
>>>>>> What do you (or others) think about it?
>>>>> 
>>>>> That sounds great and yeah it's lame that we didn't start with that.
>>>>> Shaohua, would it be difficult to compare how bfq performs against
>>>>> blk-throttle?
>>>> 
>>>> I had a test of BFQ.
>>> 
>>> Thank you very much for testing BFQ!
>>> 
>>>> I'm using BFQ found at
>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__algogroup.unimore.it_people_paolo_disk-5Fsched_sources.php&d=DQIFAg&c=5VD0RTtNlTh3ycd41b3MUw&r=i6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=2pG8KEx5tRymExa_K0ddKH_YvhH3qvJxELBd1_lw0-w&s=FZKEAOu2sw95y9jZio2k012cQWoLzlBWDl0NiGPVW78&e= . version is
>>>> 4.7.0-v8r3.
>>> 
>>> That's the latest stable version.  The development version [1] already
>>> contains further improvements for fairness, latency and throughput.
>>> It is however still a release candidate.
>>> 
>>> [1] https://github.com/linusw/linux-bfq/tree/bfq-v8
>>> 
>>>> It's a LSI SSD, queue depth 32. I use default setting. fio script
>>>> is:
>>>> 
>>>> [global]
>>>> ioengine=libaio
>>>> direct=1
>>>> readwrite=randread
>>>> bs=4k
>>>> runtime=60
>>>> time_based=1
>>>> file_service_type=random:36
>>>> overwrite=1
>>>> thread=0
>>>> group_reporting=1
>>>> filename=/dev/sdb
>>>> iodepth=1
>>>> numjobs=8
>>>> 
>>>> [groupA]
>>>> prio=2
>>>> 
>>>> [groupB]
>>>> new_group
>>>> prio=6
>>>> 
>>>> I'll change iodepth, numjobs and prio in different tests. result unit is MB/s.
>>>> 
>>>> iodepth=1 numjobs=1 prio 4:4
>>>> CFQ: 28:28 BFQ: 21:21 deadline: 29:29
>>>> 
>>>> iodepth=8 numjobs=1 prio 4:4
>>>> CFQ: 162:162 BFQ: 102:98 deadline: 205:205
>>>> 
>>>> iodepth=1 numjobs=8 prio 4:4
>>>> CFQ: 157:157 BFQ: 81:92 deadline: 196:197
>>>> 
>>>> iodepth=1 numjobs=1 prio 2:6
>>>> CFQ: 26.7:27.6 BFQ: 20:6 deadline: 29:29
>>>> 
>>>> iodepth=8 numjobs=1 prio 2:6
>>>> CFQ: 166:174 BFQ: 139:72  deadline: 202:202
>>>> 
>>>> iodepth=1 numjobs=8 prio 2:6
>>>> CFQ: 148:150 BFQ: 90:77 deadline: 198:197
>>>> 
>>>> CFQ isn't fair at all. BFQ is very good in this side, but has poor throughput
>>>> even prio is the default value.
>>>> 
>>> 
>>> Throughput is lower with BFQ for two reasons.
>>> 
>>> First, you certainly left the low_latency in its default state, i.e.,
>>> on.  As explained, e.g., here [2], low_latency mode is totally geared
>>> towards maximum responsiveness and minimum latency for soft real-time
>>> applications (e.g., video players).  To achieve this goal, BFQ is
>>> willing to perform more idling, when necessary.  This lowers
>>> throughput (I'll get back on this at the end of the discussion of the
>>> second reason).
>> 
>> changing low_latency to 0 seems not change anything, at least for the test:
>> iodepth=1 numjobs=1 prio 2:6 A bs 4k:64k
>> 
>>> The second, most important reason, is that a minimum of idling is the
>>> *only* way to achieve differentiated bandwidth distribution, as you
>>> requested by setting different ioprios.  I stress that this constraint
>>> is not a technological accident, but a intrinsic, logical necessity.
>>> The proof is simple, and if the following explanation is too boring or
>>> confusing, I can show it to you with any trace of sync I/O.
>>> 
>>> First, to provide differentiated service, you need per-process
>>> scheduling, i.e., schedulers in which there is a separate queue
>>> associated with each process.  Now, let A be the process with higher
>>> weight (ioprio), and B the process with lower weight.  Both processes
>>> are sync, thus, by definition, they issue requests as follows: a few
>>> requests (probably two, or a little bit more with larger iodepth),
>>> then a little break to wait for request completion, then the next
>>> small batch and so on.  For each process, the queue associated with
>>> the process (in the scheduler) is necessarily empty on the break.  As
>>> a consequence, if there is no idling, then every time A reaches its
>>> break, the scheduler has only the option to switch to B (which is
>>> extremely likely to have pending requests).
>>> 
>>> The service pattern of the processes then unavoidably becomes:
>>> 
>>> A B A B A B ...
>>> 
>>> where each letter represents a full small batch served for the
>>> process.  That is, 50% of the bw for each process, and complete loss
>>> of control on the desired bandwidth distribution.
>>> 
>>> So, to sum up, the reason why BFQ achieves a lower total bw is that it
>>> behaves in the only correct way to respect weights with sync I/O,
>>> i.e., it performs a little idling.  If low_latency is on, then BFQ
>>> increases idling further, and this may be have caused further bw loss
>>> in your test (but this varies greatly with devices, so you can
>>> discover it only by trying).
>>> 
>>> The bottom line is that if you do want to achieve differentiation with
>>> sync I/O, you have to pay a price in terms of bw, because of idling.
>>> Actually, the recent preemption mechanism that I have introduced in
>>> BFQ is proving so effective in preserving differentiation, that I'm
>>> tempted to try some almost idleness solution.  A little of accuracy
>>> should however be sacrificed.  Anyway, this is still work in progress.
>> 
>> Yep, I fully understand why idle is required here. As long as workload io depth
>> is lower than queue io depth, idle is the only way to maintain fairness. This
>> is the core of CFQ, I bet the same for BFQ. Unfortunately idle disk harms
>> throughput too much especially for high end SSD.
>> 
> 
> Then I'm afraid I have to give you very bad news: bw limiting causes
> the same throughput loss.  You can see it from your very tests.  Here
> is one of your results with BFQ (one that is likely to have been
> affected less by the fact that you left low_latency on, or by further
> issues that I may have not yet addressed thoroughly):
> 
> iodepth=8 numjobs=1 prio 2:6
> CFQ: 166:174 BFQ: 139:72  deadline: 202:202
> 
> Here is, instead, your test with bw limitation:
> iodepth=8 numjobs=1 prio 2:6, group A has 50M/s limit
> CFQ:51:207  BFQ: 51:45  deadline: 51:216
> 
> From the first test, you see that the total bw achievable by the
> device is at least 404MB/s.  But in the second test you get at most
> 267MB/s, with deadline.  In this respect, the total bw achieved by BFQ
> in the first test is 211MB/s.
> 
> So, both throttling and proportional share need to waste bw, BFQ
> looses about 13% more of the total bw.  In return, it gives you
> incomparably better bw and latency guarantees, while allowing you to
> configure your system with zero or minimal effort.  In contrast, using
> bw limits to properly configure a common system like, e.g., a large
> file server, may become a nightmare for a sysadmin.  For example, if,
> in the simplest case, she/he configures limits for the worst-case,
> then per-client limits will have to be extremely low.  But the system
> is large and dynamic, so the actual number of clients and at the
> actual bw consumed by each client will vary without a break, even in
> the short-medium term.  The bw redistribution heuristic do not give
> any provable guarantees on accuracy of bw redistribution.  The result
> will likely be highly varying client bandwidths, with unlucky clients
> unjustly limited to low limits, and then experiencing high latencies.
> The latter will be further emphasized by the intrinsically bursty
> nature of throttling.
> 
> In addition, the scenario in your tests is the worst case for a
> proportional share solution: in a generic system, such as the the file
> server above, part of the workload is likely to be sequential or
> quasi-sequential (at least in medium-length time intervals), and this
> is enough to get very close to peak bw with a proportional-share
> scheduler.  No configuration needed.  With bw throttling, you must do
> the math very well to get peak bw all the time in a dynamic system.
> 
> To sum up, I do think that bw throttling is the best possible solution
> (and in particular your solution is very good) till blk-mq lacks an
> accurate scheduler.  But, where you do have such a scheduler, it makes
> very little sense to give users a very bad service, for fear of
> wasting at most 13% of the bw in a single worst case.
> 

Shaohua, I have just realized that I have unconsciously defended a
wrong argument.  Although all the facts that I have reported are
evidently true, I have argued as if the question was: "do we need to
throw away throttling because there is proportional, or do we need to
throw away proportional share because there is throttling?".  This
question is simply wrong, as I think consciously (sorry for my
dissociated behavior :) ).

The best goal to achieve is to have both a good throttling mechanism,
and a good proportional share scheduler.  This goal would be valid if
even if there was just one important scenario for each of the two
approaches.  The vulnus here is that you guys are constantly, and
rightly, working on solutions to achieve and consolidate reasonable
QoS guarantees, but an apparently very good proportional-share
scheduler has been kept off for years.  If you (or others) have good
arguments to support this state of affairs, then this would probably
be an important point to discuss.

Thanks,
Paolo

> Thanks,
> Paolo
> 
> 
>> Thanks,
>> Shaohua
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-block" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> Paolo Valente
> Algogroup
> Dipartimento di Scienze Fisiche, Informatiche e Matematiche
> Via Campi 213/B
> 41125 Modena - Italy
> http://algogroup.unimore.it/people/paolo/
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





