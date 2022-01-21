Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 12:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380371AbiAUM2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:28:18 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31110 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380360AbiAUM2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 07:28:16 -0500
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JgJTj5zN5z1FCX3;
        Fri, 21 Jan 2022 20:24:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 20:28:13 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 20:28:13 +0800
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Jan Kara <jack@suse.cz>, <linux-block@vger.kernel.org>
CC:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
Message-ID: <9e9206d6-d806-459f-49f0-710606c0ab3f@huawei.com>
Date:   Fri, 21 Jan 2022 20:28:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/01/21 19:42, yukuai (C) 写道:
> 在 2022/01/21 18:56, Jan Kara 写道:
>> Hello,
>>
>> here is the fifth version of my patches to fix use-after-free issues 
>> in BFQ
>> when processes with merged queues get moved to different cgroups. The 
>> patches
>> have survived some beating in my test VM, but so far I fail to 
>> reproduce the
>> original KASAN reports so testing from people who can reproduce them 
>> is most
>> welcome. Kuai, can you please give these patches a run in your setup? 
>> Thanks
>> a lot for your help with fixing this!
>>
>> Changes since v4:
>> * Even more aggressive splitting of merged bfq queues to avoid 
>> problems with
>>    long merge chains.
>>
>> Changes since v3:
>> * Changed handling of bfq group move to handle the case when target of 
>> the
>>    merge has moved.
>>
>> Changes since v2:
>> * Improved handling of bfq queue splitting on move between cgroups
>> * Removed broken change to bfq_put_cooperator()
>>
>> Changes since v1:
>> * Added fix for bfq_put_cooperator()
>> * Added fix to handle move between cgroups in bfq_merge_bio()
>>
>>                                 Honza
>> Previous versions:
>> Link: http://lore.kernel.org/r/20211223171425.3551-1-jack@suse.cz # v1
>> Link: http://lore.kernel.org/r/20220105143037.20542-1-jack@suse.cz # v2
>> Link: http://lore.kernel.org/r/20220112113529.6355-1-jack@suse.cz # v3
>> Link: http://lore.kernel.org/r/20220114164215.28972-1-jack@suse.cz # v4
>> .
>>
> Hi, Jan
> 
> I add a new BUG_ON() in bfq_setup_merge() while iterating new_bfqq, and
> this time this BUG_ON() is triggered:
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 00184530c644..4b17eb4a29bc 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -731,8 +731,12 @@ static struct bfq_group 
> *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
>          if (sync_bfqq) {
>                  if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
>                          /* We are the only user of this bfqq, just move 
> it */
> -                       if (sync_bfqq->entity.sched_data != 
> &bfqg->sched_data)
> +                       if (sync_bfqq->entity.sched_data != 
> &bfqg->sched_data) {
> +                               printk("%s: bfqq %px move from %px to 
> %px\n",
> +                                      __func__, sync_bfqq,
> +                                      bfqq_group(sync_bfqq), bfqg);
>                                  bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
> +                       }
>                  } else {
>                          struct bfq_queue *bfqq;
> 
> @@ -741,10 +745,13 @@ static struct bfq_group 
> *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
>                           * that the merge chain still belongs to the same
>                           * cgroup.
>                           */
> -                       for (bfqq = sync_bfqq; bfqq; bfqq = bfqq->new_bfqq)
> +                       for (bfqq = sync_bfqq; bfqq; bfqq = 
> bfqq->new_bfqq) {
> +                               printk("%s: bfqq %px(%px) bfqg %px\n", 
> __func__,
> +                                       bfqq, bfqq_group(bfqq), bfqg);
>                                  if (bfqq->entity.sched_data !=
>                                      &bfqg->sched_data)
>                                          break;
> +                       }
>                          if (bfqq) {
>                                  /*
>                                   * Some queue changed cgroup so the 
> merge is
> @@ -878,6 +885,8 @@ static void bfq_reparent_leaf_entity(struct bfq_data 
> *bfqd,
>          }
> 
>          bfqq = bfq_entity_to_bfqq(child_entity);
> +       printk("%s: bfqq %px move from %px to %px\n",  __func__, bfqq,
> +               bfqq_group(bfqq), bfqd->root_group);
>          bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
>   }
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 07be51bc229b..6d4e243c9a1e 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2753,6 +2753,14 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct 
> bfq_queue *new_bfqq)
>          while ((__bfqq = new_bfqq->new_bfqq)) {
>                  if (__bfqq == bfqq)
>                          return NULL;
> +               if (new_bfqq->entity.parent != __bfqq->entity.parent &&
> +                   bfqq_group(__bfqq) != __bfqq->bfqd->root_group) {
> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n", 
> __func__,
> +                               new_bfqq, bfqq_group(new_bfqq), __bfqq,
> +                               bfqq_group(__bfqq));
> +                       BUG_ON(1);
> +               }
> +
>                  new_bfqq = __bfqq;
>          }
> 
> @@ -2797,6 +2805,8 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct 
> bfq_queue *new_bfqq)
>           * are likely to increase the throughput.
>           */
>          bfqq->new_bfqq = new_bfqq;
> +        printk("%s: set bfqq %px(%px) new_bfqq %px(%px)\n", __func__, 
> bfqq,
> +               bfqq_group(bfqq), new_bfqq, bfqq_group(new_bfqq));
>          new_bfqq->ref += process_refs;
>          return new_bfqq;
>   }
> @@ -2963,8 +2973,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, 
> struct bfq_queue *bfqq,
>          if (bfq_too_late_for_merging(bfqq))
>                  return NULL;
> 
> -       if (bfqq->new_bfqq)
> +       if (bfqq->new_bfqq) {
> +               if (bfqq->entity.parent != bfqq->new_bfqq->entity.parent &&
> +                   bfqq_group(bfqq->new_bfqq) != bfqd->root_group) {
> +                       printk("%s: bfqq %px(%px) new_bfqq %px(%px)\n", 
> __func__,
> +                               bfqq, bfqq_group(bfqq), bfqq->new_bfqq,
> +                               bfqq_group(bfqq->new_bfqq));
> +                       BUG_ON(1);
> +               }
>                  return bfqq->new_bfqq;
> +       }
> 
>          if (!io_struct || unlikely(bfqq == &bfqd->oom_bfqq))
>                  return NULL;
> @@ -6928,6 +6946,9 @@ static void __bfq_put_async_bfqq(struct bfq_data 
> *bfqd,
> 
>          bfq_log(bfqd, "put_async_bfqq: %p", bfqq);
>          if (bfqq) {
> +               printk("%s: bfqq %px move from %px to %px\n",  __func__, 
> bfqq,
> +                       bfqq_group(bfqq), bfqd->root_group);
> +
>                  bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
> 
>                  bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
> 
Hi, Jan

It seems to me this problem is related to your orignal patch to move all
bfqqs to root during bfqg offline:

bfqg ffff8881721ee000  offline:
[   51.083018] bfq_reparent_leaf_entity: bfqq ffff8881130898c0 move from 
ffff8881721ee000 to ffff88817cb0f000
[   51.093889] bfq_reparent_leaf_entity: bfqq ffff8881222e2940 move from 
ffff8881721ee000 to ffff88817cb0f000
[   51.094756] bfq_reparent_leaf_entity: bfqq ffff88810e6a58c0 move from 
ffff8881721ee000 to ffff88817cb0f000
[   51.095626] bfq_reparent_leaf_entity: bfqq ffff888136b95600 move from 
ffff8881721ee000 to ffff88817cb0f000

however parent of ffff88817f8d0dc0 is still ffff8881721ee000 :
[   51.224771] bfq_setup_merge: bfqq ffff8881130898c0(ffff88817cb0f000) 
new_bfqq ffff88817f8d0dc0(ffff8881721ee000)
