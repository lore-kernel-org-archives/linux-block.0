Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA05C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 04:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbiBHENY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 23:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbiBHENX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 23:13:23 -0500
X-Greylist: delayed 984 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 20:13:18 PST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E39C0401E9
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 20:13:18 -0800 (PST)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jt8Gx0ks6z1FCsG;
        Tue,  8 Feb 2022 11:52:41 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:56:51 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:56:51 +0800
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
 <20220124140224.275sdju6temjgjdu@quack3.lan>
 <75bfe59d-c570-8c1c-5a3c-576791ea84ec@huawei.com>
 <20220202190210.xppvatep47duofbq@quack3.lan>
 <20220202215356.iomsjb57jmbfglt4@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4e33befb-20c0-809c-15e5-bdf3fe300c97@huawei.com>
Date:   Tue, 8 Feb 2022 11:56:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220202215356.iomsjb57jmbfglt4@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/02/03 5:53, Jan Kara 写道:
> [sending once again as I forgot to snip debug log at the end and mail got
> bounced by vger mail server]
> 
> On Tue 25-01-22 16:23:28, yukuai (C) wrote:
>> 在 2022/01/24 22:02, Jan Kara 写道:
>>> On Fri 21-01-22 19:42:11, yukuai (C) wrote:
>>>> 在 2022/01/21 18:56, Jan Kara 写道:
>>>>> Hello,
>>>>>
>>>>> here is the fifth version of my patches to fix use-after-free issues in BFQ
>>>>> when processes with merged queues get moved to different cgroups. The patches
>>>>> have survived some beating in my test VM, but so far I fail to reproduce the
>>>>> original KASAN reports so testing from people who can reproduce them is most
>>>>> welcome. Kuai, can you please give these patches a run in your setup? Thanks
>>>>> a lot for your help with fixing this!
>>>>>
>>>>> Changes since v4:
>>>>> * Even more aggressive splitting of merged bfq queues to avoid problems with
>>>>>      long merge chains.
>>>>>
>>>>> Changes since v3:
>>>>> * Changed handling of bfq group move to handle the case when target of the
>>>>>      merge has moved.
>>>>>
>>>>> Changes since v2:
>>>>> * Improved handling of bfq queue splitting on move between cgroups
>>>>> * Removed broken change to bfq_put_cooperator()
>>>>>
>>>>> Changes since v1:
>>>>> * Added fix for bfq_put_cooperator()
>>>>> * Added fix to handle move between cgroups in bfq_merge_bio()
>>>>>
>>>>> 								Honza
>>>>> Previous versions:
>>>>> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
>>>>> Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
>>>>> Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
>>>>> Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
>>>>> .
>>>>>
>>>> Hi, Jan
>>>>
>>>> I add a new BUG_ON() in bfq_setup_merge() while iterating new_bfqq, and
>>>> this time this BUG_ON() is triggered:
>>>
>>> Thanks for testing!
>>>
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 07be51bc229b..6d4e243c9a1e 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -2753,6 +2753,14 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
>>>> bfq_queue *new_bfqq)
>>>>           while ((__bfqq = new_bfqq->new_bfqq)) {
>>>>                   if (__bfqq == bfqq)
>>>>                           return NULL;
>>>> +               if (new_bfqq->entity.parent != __bfqq->entity.parent &&
>>>> +                   bfqq_group(__bfqq) != __bfqq->bfqd->root_group) {
>>>> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n",
>>>> __func__,
>>>> +                               new_bfqq, bfqq_group(new_bfqq), __bfqq,
>>>> +                               bfqq_group(__bfqq));
>>>> +                       BUG_ON(1);
>>>
>>> This seems to be too early to check and BUG_ON(). Yes, we can walk through
>>> and even end up with a bfqq with a different parent however in that case we
>>> refuse to setup merge a few lines below and so there is no problem.
>>>
>>> Are you still able to reproduce the use-after-free issue with this version
>>> of my patches?
>>>
>>> 								Honza
>>>
>> Hi, Jan
>>
>> I add following additional debug info:
>>
>> @ -926,6 +935,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
>>          if (!entity) /* root group */
>>                  goto put_async_queues;
>>
>> +       printk("%s: bfqg %px offlined\n", __func__, bfqg);
>>          /*
>>           * Empty all service_trees belonging to this group before
>>           * deactivating the group itself.
>> @@ -965,6 +975,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
>>
>>   put_async_queues:
>>          bfq_put_async_queues(bfqd, bfqg);
>> +       pd->plid = BLKCG_MAX_POLS;
>>
>>          spin_unlock_irqrestore(&bfqd->lock, flags);
>>          /*
>>
>> @@ -6039,6 +6050,13 @@ static bool __bfq_insert_request(struct bfq_data
>> *bfqd, struct request *rq)
>>                  *new_bfqq = bfq_setup_cooperator(bfqd, bfqq, rq, true,
>>                                                   RQ_BIC(rq));
>>          bool waiting, idle_timer_disabled = false;
>> +       if (new_bfqq) {
>> +               printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n", __func__,
>> +                       bfqq, bfqq_group(bfqq), new_bfqq,
>> bfqq_group(new_bfqq));
>> +       } else {
>> +               printk("%s: bfqq %px(%px) new_bfqq null \n", __func__,
>> +                       bfqq, bfqq_group(bfqq));
>> +       }
>>
>> @@ -1696,6 +1696,11 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq)
>>
>>          bfq_activate_bfqq(bfqd, bfqq);
>>
>> +       if (bfqq->entity.parent && bfqq_group(bfqq)->pd.plid >=
>> BLKCG_MAX_POLS) {
>> +               printk("%s: bfqq %px(%px) with parent offlined\n", __func__,
>> +                               bfqq, bfqq_group(bfqq));
>> +               BUG_ON(1);
>> +       }
>>
>> And found that the uaf is triggered when bfq_setup_cooperator return
>> NULL, that's why the BUG_ON() in bfq_setup_cooperator() is not
>> triggered:
>>
>> [   51.833290] __bfq_insert_request: bfqq ffff888106913700(ffff888107d67000)
>> new_bfqq null
>> [   51.834762] bfq_add_bfqq_busy: bfqq ffff888106913700(ffff888107d67000)
>> with parent offlined
>>
>> The new_bfqq chain relate to bfqq ffff888106913700:
>>
>> t1: ffff8881114e9600 ------> t4: ffff888106913700 ------> t5:
>> ffff88810719e3c0
>>                          |
>> t2: ffff888106913440 ----
>>                          |
>> t3: ffff8881114e98c0 ----
>>
>> I'm still not sure about the root cause, hope these debuginfo
>> can be helpful
> 
> Thanks for debugging! I was looking into this but I also do not understand
> how what your tracing shows can happen. In particular I don't see why there
> is no __bfq_bic_change_cgroup() call from bfq_insert_request() ->
> bfq_init_rq() for the problematic __bfq_insert_request() into
> ffff888106913700. I have two possible explanations. Either bio is submitted
> to the offlined cgroup ffff888107d67000 or bic->blkcg_serial_nr is pointing
> to different cgroup than bic_to_bfqq(bic, 1)->entity.parent.
> 
> So can you extented the debugging a bit like:
> 1) Add current->pid to all debug messages so that we can distinguish
> different processes and see which already detached from the bfqq and which
> not.
> 
> 2) Print bic->blkcg_serial_nr and __bio_blkcg(bio)->css.serial_nr before
> crashing in bfq_add_bfqq_busy().
> 
> 3) Add BUG_ON to bic_set_bfqq() like:
> 	if (bfqq_group(bfqq)->css.serial_nr != bic->blkcg_serial_nr) {
> 		printk("%s: bfqq %px(%px) serial %d bic serial %d\n", bfqq,
> 			bfqq_group(bfqq), bfqq_group(bfqq)->css.serial_nr,
> 			bic->blkcg_serial_nr);
> 		BUG_ON(1);
> 	}
> 
> and perhaps this scheds more light on the problem... Thanks!
> 
> 								Honza
> 

Hi, Jan

Sorry about the delay, I'm on vacation for the Spring Festival.

I'll try the debugging soon.

Thanks,
Kuai
