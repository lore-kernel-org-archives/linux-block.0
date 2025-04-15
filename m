Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FA13EFE3
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698189; cv=none; b=SJT4MtRVjTWM2FDZTyl2X2kIxIpQ4pmq6UJRhlHLRCM6xflg4WFJ5CD7bFum304NWbzxuIc0pj9vjzoK99FZv+HrMAU6Gn74Xo/k/vXp/3mgUYnxOYVFbSgOZDZyDX5N4QKwo+WmLAibuRf8Vbcov7bULjJiOZl8ZYdg4ME0VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698189; c=relaxed/simple;
	bh=fos+/dAfaoJvIxfGBS7jL79jSi0FN70gCtsLafr2ViU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D/Lt8mSoicKNlhmPo2npK8sfPCnVyKk0ahsW2CkcxU5fi6K/ZRhStxOliYNoi+smj4uAiwXoBjvZ80CMSzIleOmzqDCQzyJLeKS1qVZVu5Ot/ge9WxbwtJYshpLvNNJBIe6CPetg5YKP8/y8FgMZVWaNTr+k8PZEX7Jtz5ascGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZcDb63vz1z13KsN;
	Tue, 15 Apr 2025 14:22:10 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 010391401F4;
	Tue, 15 Apr 2025 14:22:59 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Apr 2025 14:22:58 +0800
Message-ID: <afea77d4-42a9-432f-870d-c48413a40299@huawei.com>
Date: Tue, 15 Apr 2025 14:22:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] blk-throttle: Split the service queue
To: Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <ming.lei@redhat.com>, <tj@kernel.org>, "yukuai
 (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-7-wozizhi@huawei.com>
 <46268858-3300-caf1-4e9a-f731ebf812d5@huaweicloud.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <46268858-3300-caf1-4e9a-f731ebf812d5@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/15 10:34, Yu Kuai 写道:
> Hi,
> 
> 在 2025/04/14 21:27, Zizhi Wo 写道:
>> This patch splits throtl_service_queue->nr_queued into "nr_queued_bps" 
>> and
>> "nr_queued_iops", allowing separate accounting of BPS and IOPS queued 
>> bios.
>> This prepares for future changes that need to check whether the BPS or 
>> IOPS
>> queues are empty.
>>
>> To facilitate updating the number of IOs in the BPS and IOPS queues, the
>> addition logic will be moved from throtl_add_bio_tg() to
>> throtl_qnode_add_bio(), and similarly, the removal logic will be moved 
>> from
>> tg_dispatch_one_bio() to throtl_pop_queued().
>>
>> And introduce sq_queued() to calculate the total sum of sq->nr_queued.
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   block/blk-throttle.c | 56 ++++++++++++++++++++++++++++++--------------
>>   block/blk-throttle.h |  3 ++-
>>   2 files changed, 40 insertions(+), 19 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 542db54f995c..faae10e2e6e3 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -161,10 +161,17 @@ static void throtl_qnode_init(struct 
>> throtl_qnode *qn, struct throtl_grp *tg)
>>   static void throtl_qnode_add_bio(struct bio *bio, struct 
>> throtl_qnode *qn,
>>                    struct list_head *queued)
>>   {
>> -    if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
>> +    bool rw = bio_data_dir(bio);
>> +    struct throtl_service_queue *sq = container_of(queued,
>> +                struct throtl_service_queue, queued[rw]);
> 
> Instead of container_of(), I think directly pass in sq is better, the
> queued list can be get by sq->queued[rw];
> 
> Otherwise LGTM.
> 
> Thanks,
> Kuai

Okay, I originally thought we could reduce the amount of changes, but
passing sq directly does seem more straightforward. I will modify it.

Thanks,
Zizhi Wo

> 
>> +
>> +    if (bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
>>           bio_list_add(&qn->bios_iops, bio);
>> -    else
>> +        sq->nr_queued_iops[rw]++;
>> +    } else {
>>           bio_list_add(&qn->bios_bps, bio);
>> +        sq->nr_queued_bps[rw]++;
>> +    }
>>       if (list_empty(&qn->node)) {
>>           list_add_tail(&qn->node, queued);
>> @@ -200,6 +207,7 @@ static struct bio *throtl_peek_queued(struct 
>> list_head *queued)
>>    * throtl_pop_queued - pop the first bio form a qnode list
>>    * @queued: the qnode list to pop a bio from
>>    * @tg_to_put: optional out argument for throtl_grp to put
>> + * @rw: read/write
>>    *
>>    * Pop the first bio from the qnode list @queued.  Note that we 
>> firstly focus
>>    * on the iops list here because bios are ultimately dispatched from 
>> it.
>> @@ -212,8 +220,10 @@ static struct bio *throtl_peek_queued(struct 
>> list_head *queued)
>>    * responsible for putting it.
>>    */
>>   static struct bio *throtl_pop_queued(struct list_head *queued,
>> -                     struct throtl_grp **tg_to_put)
>> +                     struct throtl_grp **tg_to_put, bool rw)
>>   {
>> +    struct throtl_service_queue *sq = container_of(queued,
>> +                struct throtl_service_queue, queued[rw]);
>>       struct throtl_qnode *qn;
>>       struct bio *bio;
>> @@ -222,8 +232,12 @@ static struct bio *throtl_pop_queued(struct 
>> list_head *queued,
>>       qn = list_first_entry(queued, struct throtl_qnode, node);
>>       bio = bio_list_pop(&qn->bios_iops);
>> -    if (!bio)
>> +    if (!bio) {
>>           bio = bio_list_pop(&qn->bios_bps);
>> +        sq->nr_queued_bps[rw]--;
>> +    } else {
>> +        sq->nr_queued_iops[rw]--;
>> +    }
>>       WARN_ON_ONCE(!bio);
>>       if (bio_list_empty(&qn->bios_bps) && 
>> bio_list_empty(&qn->bios_iops)) {
>> @@ -553,6 +567,11 @@ static bool throtl_slice_used(struct throtl_grp 
>> *tg, bool rw)
>>       return true;
>>   }
>> +static unsigned int sq_queued(struct throtl_service_queue *sq, int type)
>> +{
>> +    return sq->nr_queued_bps[type] + sq->nr_queued_iops[type];
>> +}
>> +
>>   static unsigned int calculate_io_allowed(u32 iops_limit,
>>                        unsigned long jiffy_elapsed)
>>   {
>> @@ -682,9 +701,9 @@ static void tg_update_carryover(struct throtl_grp 
>> *tg)
>>       long long bytes[2] = {0};
>>       int ios[2] = {0};
>> -    if (tg->service_queue.nr_queued[READ])
>> +    if (sq_queued(&tg->service_queue, READ))
>>           __tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
>> -    if (tg->service_queue.nr_queued[WRITE])
>> +    if (sq_queued(&tg->service_queue, WRITE))
>>           __tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>>       /* see comments in struct throtl_grp for meaning of these 
>> fields. */
>> @@ -776,7 +795,8 @@ static void throtl_charge_iops_bio(struct 
>> throtl_grp *tg, struct bio *bio)
>>    */
>>   static void tg_update_slice(struct throtl_grp *tg, bool rw)
>>   {
>> -    if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>> +    if (throtl_slice_used(tg, rw) &&
>> +        sq_queued(&tg->service_queue, rw) == 0)
>>           throtl_start_new_slice(tg, rw, true);
>>       else
>>           throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
>> @@ -832,7 +852,7 @@ static unsigned long tg_dispatch_time(struct 
>> throtl_grp *tg, struct bio *bio)
>>        * this function with a different bio if there are other bios
>>        * queued.
>>        */
>> -    BUG_ON(tg->service_queue.nr_queued[rw] &&
>> +    BUG_ON(sq_queued(&tg->service_queue, rw) &&
>>              bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>>       wait = tg_dispatch_bps_time(tg, bio);
>> @@ -872,12 +892,11 @@ static void throtl_add_bio_tg(struct bio *bio, 
>> struct throtl_qnode *qn,
>>        * dispatched.  Mark that @tg was empty.  This is automatically
>>        * cleared on the next tg_update_disptime().
>>        */
>> -    if (!sq->nr_queued[rw])
>> +    if (sq_queued(sq, rw) == 0)
>>           tg->flags |= THROTL_TG_WAS_EMPTY;
>>       throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
>> -    sq->nr_queued[rw]++;
>>       throtl_enqueue_tg(tg);
>>   }
>> @@ -931,8 +950,7 @@ static void tg_dispatch_one_bio(struct throtl_grp 
>> *tg, bool rw)
>>        * getting released prematurely.  Remember the tg to put and put it
>>        * after @bio is transferred to @parent_sq.
>>        */
>> -    bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
>> -    sq->nr_queued[rw]--;
>> +    bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put, rw);
>>       throtl_charge_iops_bio(tg, bio);
>> @@ -1014,7 +1032,7 @@ static int throtl_select_dispatch(struct 
>> throtl_service_queue *parent_sq)
>>           nr_disp += throtl_dispatch_tg(tg);
>>           sq = &tg->service_queue;
>> -        if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
>> +        if (sq_queued(sq, READ) || sq_queued(sq, WRITE))
>>               tg_update_disptime(tg);
>>           else
>>               throtl_dequeue_tg(tg);
>> @@ -1067,9 +1085,11 @@ static void throtl_pending_timer_fn(struct 
>> timer_list *t)
>>       dispatched = false;
>>       while (true) {
>> +        unsigned int bio_cnt_r = sq_queued(sq, READ);
>> +        unsigned int bio_cnt_w = sq_queued(sq, WRITE);
>> +
>>           throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
>> -               sq->nr_queued[READ] + sq->nr_queued[WRITE],
>> -               sq->nr_queued[READ], sq->nr_queued[WRITE]);
>> +               bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
>>           ret = throtl_select_dispatch(sq);
>>           if (ret) {
>> @@ -1131,7 +1151,7 @@ static void blk_throtl_dispatch_work_fn(struct 
>> work_struct *work)
>>       spin_lock_irq(&q->queue_lock);
>>       for (rw = READ; rw <= WRITE; rw++)
>> -        while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
>> +        while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL, rw)))
>>               bio_list_add(&bio_list_on_stack, bio);
>>       spin_unlock_irq(&q->queue_lock);
>> @@ -1637,7 +1657,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, 
>> bool rw)
>>   {
>>       /* throtl is FIFO - if bios are already queued, should queue */
>> -    if (tg->service_queue.nr_queued[rw])
>> +    if (sq_queued(&tg->service_queue, rw))
>>           return false;
>>       return tg_dispatch_time(tg, bio) == 0;
>> @@ -1711,7 +1731,7 @@ bool __blk_throtl_bio(struct bio *bio)
>>              tg->bytes_disp[rw], bio->bi_iter.bi_size,
>>              tg_bps_limit(tg, rw),
>>              tg->io_disp[rw], tg_iops_limit(tg, rw),
>> -           sq->nr_queued[READ], sq->nr_queued[WRITE]);
>> +           sq_queued(sq, READ), sq_queued(sq, WRITE));
>>       td->nr_queued[rw]++;
>>       throtl_add_bio_tg(bio, qn, tg);
>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>> index 5257e5c053e6..04e92cfd0ab1 100644
>> --- a/block/blk-throttle.h
>> +++ b/block/blk-throttle.h
>> @@ -41,7 +41,8 @@ struct throtl_service_queue {
>>        * children throtl_grp's.
>>        */
>>       struct list_head    queued[2];    /* throtl_qnode [READ/WRITE] */
>> -    unsigned int        nr_queued[2];    /* number of queued bios */
>> +    unsigned int        nr_queued_bps[2];    /* number of queued bps 
>> bios */
>> +    unsigned int        nr_queued_iops[2];    /* number of queued 
>> iops bios */
>>       /*
>>        * RB tree of active children throtl_grp's, which are sorted by
>>
> 
