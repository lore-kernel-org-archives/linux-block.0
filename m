Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A519C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiFQMui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiFQMuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 08:50:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BF37A84
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:50:35 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPf240FVxzBrpL;
        Fri, 17 Jun 2022 20:47:08 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 20:50:18 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 20:50:18 +0800
Subject: Re: Races in sbitmap batched wakeups
To:     Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        <linux-block@vger.kernel.org>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
 <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
 <20220617113112.rlmx7npkavwkhcxx@quack3>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <65beb6c4-6780-1f48-866b-63d4c4625c31@huawei.com>
Date:   Fri, 17 Jun 2022 20:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220617113112.rlmx7npkavwkhcxx@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/06/17 19:31, Jan Kara 写道:
> Hi!
> 
> On Fri 17-06-22 09:40:11, Yu Kuai wrote:
>> 在 2022/06/17 1:21, Jan Kara 写道:
>>> I've been debugging some customer reports of tasks hanging (forever)
>>> waiting for free tags when in fact all tags are free. After looking into it
>>> for some time I think I know what it happening. First, keep in mind that
>>> it concerns a device which uses shared tags. There are 127 tags available
>>> and the number of active queues using these tags is easily 40 or more. So
>>> number of tags available for each device is rather small. Now I'm not sure
>>> how batched wakeups can ever work in such situations, but maybe I'm missing
>>> something.
>>>
>>> So take for example a situation where two tags are available for a device,
>>> they are both currently used. Now a process comes into blk_mq_get_tag() and
>>> wants to allocate tag and goes to sleep. Now how can it ever be woken up if
>>> wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
>>> that's not enough to trigger the batched wakeup to really wakeup the
>>> waiter...
>>>
>>> Even if we have say 4 tags available so in theory there should be enough
>>> wakeups to fill the batch, there can be the following problem. So 4 tags
>>> are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
>>> queue 0, one on wait queue 1. Now four IOs complete so
>>> sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
>>> wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
>>> waiters is woken up but the other one is still sleeping in wq1 and there
>>> are not enough wakeups to fill the batch and wake it up? This is
>>> essentially because we have lost three wakeups on wq0 because it didn't
>>> have enough waiters to wake...
>>
>>  From what I see, if tags are shared for multiple devices, wake_batch
>> should make sure that all waiter will be woke up:
>>
>> For example:
>> there are total 64 tags shared for two devices, then wake_batch is 4(if
>> both devices are active).  If there are waiters, which means at least 32
>> tags are grabed, thus 8 queues will ensure to wake up at least once
>> after 32 tags are freed.
> 
> Well, yes, wake_batch is updated but as my example above shows it is not
> enough to fix "wasted" wakeups.

Tags can be preempted, which means new thread can be added to waitqueue
only if there are no free tags.

With the above condition, I can't think of any possibility how the
following scenario can be existed(dispite the wake ups can be missed):

Only wake_batch tags are still in use, while multiple waitqueues are
still active.

If you think this is possible, can you share the initial conditions and
how does it end up to the problematic scenario?

Thanks,
Kuai
> 
>>> Finally, sbitmap_queue_wake_up() is racy and if two of them race together,
>>> they can end up decrementing wait_cnt of wq which does not have any process
>>> queued which again effectively leads to lost wakeups and possibly
>>> indefinitely sleeping tasks.
>>>
>>
>> BTW, I do this implementation have some problems on concurrent
>> scenario, as described in following patch:
>>
>> https://lore.kernel.org/lkml/20220415101053.554495-4-yukuai3@huawei.com/
> 
> Yes, as far as I can see you have identified similar races as I point out
> in this email. But I'm not sure whether your patch fixes all the
> possibilities for lost wakeups...
> 
> 								Honza
> 
