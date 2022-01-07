Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D0C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 09:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbiAGJaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 04:30:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34882 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiAGJa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 04:30:29 -0500
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JVdGm41YZzccBX;
        Fri,  7 Jan 2022 17:29:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 17:30:27 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 17:30:27 +0800
Subject: Re: [PATCH 0/3] bfq: Avoid use-after-free when moving processes
 between cgroups
To:     Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20211223171425.3551-1-jack@suse.cz>
 <a9a22745-6fc4-22c0-ddbc-be0e82f07876@huawei.com>
 <20220103203705.airqbsyiar4u6fy4@quack3>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <44c00323-e929-fc4b-e55a-d0f4b03a98fe@huawei.com>
Date:   Fri, 7 Jan 2022 17:30:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220103203705.airqbsyiar4u6fy4@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/01/04 4:37, Jan Kara 写道:
> On Fri 24-12-21 09:30:04, yukuai (C) wrote:
>> 在 2021/12/24 1:31, Jan Kara 写道:
>>> Hello,
>>>
>>> these three patches fix use-after-free issues in BFQ when processes with merged
>>> queues get moved to different cgroups. The patches have survived some beating
>>> in my test VM but so far I fail to reproduce the original KASAN reports so
>>> testing from people who can reproduce them is most welcome. Thanks!
>>
>> Hi,
>>
>> Unfortunately, this patchset can't fix the UAF, just to mark
>> split_coop in patch 3 seems not enough.
> 
> Thanks for testing!
> 
>> Here is the result:
>>
>> [  548.440184]
>> ==============================================================
>> [  548.441680] BUG: KASAN: use-after-free in
>> __bfq_deactivate_entity+0x21/0x290
>> [  548.443155] Read of size 1 at addr ffff8881723e00b0 by task rmmod/13984
>> [  548.444109]
>> [  548.444321] CPU: 30 PID: 13984 Comm: rmmod Tainted: G        W
>> 5.16.0-rc5-next-2026
>> [  548.445549] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> ?-20190727_073836-4
>> [  548.447348] Call Trace:
>> [  548.447682]  <TASK>
>> [  548.447967]  dump_stack_lvl+0x34/0x44
>> [  548.448470]  print_address_description.constprop.0.cold+0xab/0x36b
>> [  548.449303]  ? __bfq_deactivate_entity+0x21/0x290
>> [  548.449929]  ? __bfq_deactivate_entity+0x21/0x290
>> [  548.450565]  kasan_report.cold+0x83/0xdf
>> [  548.451114]  ? _raw_read_lock_bh+0x20/0x40
>> [  548.451658]  ? __bfq_deactivate_entity+0x21/0x290
>> [  548.452296]  __bfq_deactivate_entity+0x21/0x290
>> [  548.452917]  bfq_pd_offline+0xc1/0x110
> 
> Can you pass the trace through addr2line please? I'm curious whether this
> is a call in bfq_flush_idle_tree() or directly from bfq_pd_offline(). Also
> whether the crash in __bfq_deactivate_entity() is indeed inside
> bfq_entity_service_tree() as I expect.
> 
>> [  548.453436]  blkcg_deactivate_policy+0x14b/0x210
>> [  548.454058]  bfq_exit_queue+0xe5/0x100
>> [  548.454573]  blk_mq_exit_sched+0x113/0x140
>> [  548.455162]  elevator_exit+0x30/0x50
>> [  548.455645]  blk_release_queue+0xa8/0x160
> 
> So I'm not convinced this is the same problem as before. I'll be able to
> tell more when I see the addr2line output.
> 
>> How do you think about this:
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 1ce1a99a7160..14c1d1c3811e 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2626,6 +2626,11 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct
>> bfq_queue *new_bfqq)
>>          while ((__bfqq = new_bfqq->new_bfqq)) {
>>                  if (__bfqq == bfqq)
>>                          return NULL;
>> +               if (__bfqq->entity.parent != bfqq->entity.parent) {
>> +                       if (bfq_bfqq_coop(__bfqq))
>> +                               bfq_mark_bfqq_split_coop(__bfqq);
>> +                       return NULL;
>> +               }
> 
> So why is this needed? In my patches we do check in bfq_setup_merge() that
> the bfqq we merge to is in the same cgroup. If some intermediate bfqq
> happens to move to a different cgroup between the detection and merge, well
> that's a bad luck but practically I don't think that is a real problem and
> it should not cause the use-after-free issues. Or am I missing something?

Hi,

I'm sure that in my repoducer bfq_setup_merge() nerver merge two
bfqq from diferent group(I added some debuginfo before), and somehow
later bfqq and bfqq->new_bfqq end up from different bfqg.

I haven't thought of merge bfqqs from diferent group yet. My reporducer
probably can't cover this case...

This modification is just a lazy detection for the problem. It's right
that fix the problem in the first scene is better.

Thanks,
Kuai

> 
>>                  new_bfqq = __bfqq;
>>          }
>>
>> @@ -2825,8 +2830,16 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq,
>>          if (bfq_too_late_for_merging(bfqq))
>>                  return NULL;
>>
>> -       if (bfqq->new_bfqq)
>> -               return bfqq->new_bfqq;
>> +       if (bfqq->new_bfqq) {
>> +               struct bfq_queue *new_bfqq = bfqq->new_bfqq;
>> +
>> +               if(bfqq->entity.parent == new_bfqq->entity.parent)
>> +                       return new_bfqq;
>> +
>> +               if(bfq_bfqq_coop(new_bfqq))
>> +                       bfq_mark_bfqq_split_coop(new_bfqq);
>> +               return NULL;
>> +       }
> 
> So I wanted to say that this should be already handled by the change to
> __bfq_bic_change_cgroup() in my series. But bfq_setup_cooperator() can also
> be called from bfq_allow_bio_merge() and on that path we don't call
> bfq_bic_update_cgroup() so indeed we can merge bfqq to a bfqq in a
> different (or dead) cgroup through that path. I actually think we should
> call bfq_bic_update_cgroup() in bfq_allow_bio_merge() so that we reparent /
> split bfqq when new IO arrives for a different cgroup.
> 
> Also I have realized that my change to __bfq_bic_change_cgroup() may not be
> enough and we should also clear sync_bfqq->new_bfqq if it is set.
> 
> 								Honza
> 
