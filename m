Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp1.sms.unimo.it ([155.185.44.147]:33829 "EHLO
        smtp1.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbcJFHWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 03:22:18 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161005203623.GA1754@anikkar-mbp.local.dhcp.thefacebook.com>
Date: Thu, 6 Oct 2016 09:22:05 +0200
Cc: Tejun Heo <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <5F716FD2-2027-434E-BC7F-8B0385722E05@unimore.it>
References: <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <257945FA-6789-4D80-8DA3-AC75640C71AE@unimore.it> <20161005144946.GA26977@htj.duckdns.org> <20161005183052.GA97491@anikkar-mbp.local.dhcp.thefacebook.com> <20161005190832.GA99272@anikkar-mbp.local.dhcp.thefacebook.com> <98C2E984-2CF4-41F7-8A7D-6569C45A627A@unimore.it> <20161005203623.GA1754@anikkar-mbp.local.dhcp.thefacebook.com>
To: Shaohua Li <shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 05 ott 2016, alle ore 22:36, Shaohua Li <shli@fb.com> ha scritto:
> 
> On Wed, Oct 05, 2016 at 09:57:22PM +0200, Paolo Valente wrote:
>> 
>>> Il giorno 05 ott 2016, alle ore 21:08, Shaohua Li <shli@fb.com> ha scritto:
>>> 
>>> On Wed, Oct 05, 2016 at 11:30:53AM -0700, Shaohua Li wrote:
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
>>>> I had a test of BFQ. I'm using BFQ found at
>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__algogroup.unimore.it_people_paolo_disk-5Fsched_sources.php&d=DQIFAg&c=5VD0RTtNlTh3ycd41b3MUw&r=X13hAPkxmvBro1Ug8vcKHw&m=zB09S7v2QifXXTa6f2_r6YLjiXq3AwAi7sqO4o2UfBQ&s=oMKpjQMXfWmMwHmANB-Qnrm2EdERzz9Oef7jcLkbyFg&e= . version is
>>>> 4.7.0-v8r3. It's a LSI SSD, queue depth 32. I use default setting. fio script
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
>>> 
>>> More tests:
>>> 
>>> iodepth=8 numjobs=1 prio 2:6, group A has 50M/s limit
>>> CFQ:51:207  BFQ: 51:45  deadline: 51:216
>>> 
>>> iodepth=1 numjobs=1 prio 2:6, group A bs=4k, group B bs=64k
>>> CFQ:25:249  BFQ: 23:42  deadline: 26:251
>>> 
>> 
>> A true proportional share scheduler like BFQ works under the
>> assumption to be the only limiter of the bandwidth of its clients.
>> And the availability of such a scheduler should apparently make
>> bandwidth limiting useless: once you have a mechanism that allows you
>> to give each group the desired fraction of the bandwidth, and to
>> redistribute excess bandwidth seamlessly when needed, what do you need
>> additional limiting for?
>> 
>> But I'm not expert of any possible system configuration or
>> requirement.  So, if you have practical examples, I would really
>> appreciate them.  And I don't think it will be difficult to see what
>> goes wrong in BFQ with external bw limitation, and to fix the
>> problem.
> 
> I think the test emulates a very common configuration. We assign more IO
> resources to high priority workload. But such workload doesn't always dispatch
> enough io. That's why I set a rate limit. When this happend, we hope low
> priority workload uses the disk bandwidth. That's the whole point of disk
> sharing.
> 

But that's exactly the configuration for which a proportional-share
scheduler is designed: systematically and seamlessly redistribute
excess bw, with no configuration needed.  Or is there something else
in the scenario you have in mind?

Thanks,
Paolo

> Thanks,
> Shaohua
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





