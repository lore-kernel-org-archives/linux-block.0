Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBABC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 01:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiFUBKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 21:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiFUBK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 21:10:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7AF12AC7
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 18:10:27 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRpJQ17mLzSgv7;
        Tue, 21 Jun 2022 09:07:02 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 09:10:15 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 09:10:14 +0800
Subject: Re: Races in sbitmap batched wakeups
To:     Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        <linux-block@vger.kernel.org>, Laibin Qiu <qiulaibin@huawei.com>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
 <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
 <20220617113112.rlmx7npkavwkhcxx@quack3>
 <65beb6c4-6780-1f48-866b-63d4c4625c31@huawei.com>
 <20220620115740.dnj56do2egfzrebo@quack3.lan>
 <26f88ff1-5e01-7f2d-798b-4b96e46f46ec@huawei.com>
 <20220620165740.x4sbau7b5olwc65q@quack3.lan>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <6fc9fb43-18a9-494b-bcf3-eb3566d3ab3e@huawei.com>
Date:   Tue, 21 Jun 2022 09:10:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220620165740.x4sbau7b5olwc65q@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/06/21 0:57, Jan Kara 写道:
> On Mon 20-06-22 21:11:25, Yu Kuai wrote:
>> 在 2022/06/20 19:57, Jan Kara 写道:
>>> Hello!
>>>
>>> On Fri 17-06-22 20:50:17, Yu Kuai wrote:
>>>> 在 2022/06/17 19:31, Jan Kara 写道:
>>>>> On Fri 17-06-22 09:40:11, Yu Kuai wrote:
>>>>>> 在 2022/06/17 1:21, Jan Kara 写道:
>>>>>>> I've been debugging some customer reports of tasks hanging (forever)
>>>>>>> waiting for free tags when in fact all tags are free. After looking into it
>>>>>>> for some time I think I know what it happening. First, keep in mind that
>>>>>>> it concerns a device which uses shared tags. There are 127 tags available
>>>>>>> and the number of active queues using these tags is easily 40 or more. So
>>>>>>> number of tags available for each device is rather small. Now I'm not sure
>>>>>>> how batched wakeups can ever work in such situations, but maybe I'm missing
>>>>>>> something.
>>>>>>>
>>>>>>> So take for example a situation where two tags are available for a device,
>>>>>>> they are both currently used. Now a process comes into blk_mq_get_tag() and
>>>>>>> wants to allocate tag and goes to sleep. Now how can it ever be woken up if
>>>>>>> wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
>>>>>>> that's not enough to trigger the batched wakeup to really wakeup the
>>>>>>> waiter...
>>>>>>>
>>>>>>> Even if we have say 4 tags available so in theory there should be enough
>>>>>>> wakeups to fill the batch, there can be the following problem. So 4 tags
>>>>>>> are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
>>>>>>> queue 0, one on wait queue 1. Now four IOs complete so
>>>>>>> sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
>>>>>>> wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
>>>>>>> waiters is woken up but the other one is still sleeping in wq1 and there
>>>>>>> are not enough wakeups to fill the batch and wake it up? This is
>>>>>>> essentially because we have lost three wakeups on wq0 because it didn't
>>>>>>> have enough waiters to wake...
>>>>>>
>>>>>>    From what I see, if tags are shared for multiple devices, wake_batch
>>>>>> should make sure that all waiter will be woke up:
>>>>>>
>>>>>> For example:
>>>>>> there are total 64 tags shared for two devices, then wake_batch is 4(if
>>>>>> both devices are active).  If there are waiters, which means at least 32
>>>>>> tags are grabed, thus 8 queues will ensure to wake up at least once
>>>>>> after 32 tags are freed.
>>>>>
>>>>> Well, yes, wake_batch is updated but as my example above shows it is not
>>>>> enough to fix "wasted" wakeups.
>>>>
>>>> Tags can be preempted, which means new thread can be added to waitqueue
>>>> only if there are no free tags.
>>>
>>> Yes.
>>>
>>>> With the above condition, I can't think of any possibility how the
>>>> following scenario can be existed(dispite the wake ups can be missed):
>>>>
>>>> Only wake_batch tags are still in use, while multiple waitqueues are
>>>> still active.
>>>>
>>>> If you think this is possible, can you share the initial conditions and
>>>> how does it end up to the problematic scenario?
>>>
>>> Very easily AFAICT. I've described the scenario in my original email but
>>> let me maybe write it here with more detail. Let's assume we have 4 tags
>>> available for our device, wake_batch is 4, wait_index is 0, wait_cnt is 4
>>> for all waitqueues. All four tags are currently in use.
>>>
>>> Now task T1 comes, wants a new tag:
>>> blk_mq_get_tag()
>>>     bt_wait_ptr() -> gets ws 0, wait_index incremented to 1
>>>     goes to sleep on ws 0
>>>
>>> Now task T2 comes, wants a new tag:
>>> blk_mq_get_tag()
>>>     bt_wait_ptr() -> gets ws 1, wait_index incremented to 2
>>>     goes to sleep on ws 1
>>>
>>> Now all four requests complete, this generates 4 calls to
>>> sbitmap_queue_wake_up() for ws 0, which decrements wait_cnt on ws 0 to 0
>>> and we do wake_up_nr(&ws->wait, 4). This wakes T1.
>>>
>>> T1 allocates a tag, does IO, IO completes. sbitmap_queue_wake_up() is
>>> called for ws 1. wait_cnt is decremented to 3.
>>>
>>> Now there's no IO in flight but we still have task sleeping in ws 1.
>>> Everything is stuck until someone submits more IO (which may never happen
>>> because everything ends up waiting on completion of IO T2 does).
>>
>> I assum that there should be at least 32 total tags, and at least 8
>> device are issuing io, so that there are only 4 tags available for
>> the devcie? (due to fair share).
>>
>> If so, io from other devcies should trigger new wakeup.
> 
> Well, there isn't necessarily any IO going on on other devices, there may
> be 4 tags used on our device, the rest is free but we are not allowed to
> use them. Sure eventually we should detect other devices are idle and
> decrease tags->active_queues but that can take 30s or more...
> 
It's right queue can be active while there is no io, blk_mq_tag_idle()
will not be called untill such queue doesn't issue any io for a period
time, thus I do think io will not hung eventually, however, it can be
improved that io will rely on other devices to woke up.

BTW, I tried to improve that tags can be wasted for share tags long time
ago:

https://lore.kernel.org/all/20201226102808.2534966-1-yukuai3@huawei.com/

Thanks,
Kuai
> 								Honza
> 
