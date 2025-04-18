Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C6262A6
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948997; cv=none; b=ScEdlD5n83nLcjtO5eiIuieFcSPlGwAzqEUX4fdzGNSp6KfzdHbitkqjDF6VSi8eY8SZCm8/7ftLO6siBpNXkdvwBzxHcewjZjnkiPb/ytiXwsCUFHtn7T2dJulJk0Nzw8z2y2hMx9BgzVYCC/SNn0bC3iPb/h6706KlVIMIcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948997; c=relaxed/simple;
	bh=NkCJYbh+ZERU/RJaeS4Cx+TzEsthcHrsIKMttYyfkx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5+226hAm0n5JlpysrroR89JNl+ufT+uGA797lkPDy6vtVRcbl2IrlfxQVyxQW/92zefX1jlSlDUIDMe+D9TSWwzH9eXq3Hz1+eyO8Ten6dXdjYfDzYUYI8DP7zvX/UAX0nK7ktJI80PVReZQlF4EqAjPCa3WmMTVSi2TjFhkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf1Ly1jXHz4f3jYl
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A0A561A06D7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 12:03:08 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl_rzgFohhdCJw--.15238S3;
	Fri, 18 Apr 2025 12:03:08 +0800 (CST)
Message-ID: <c100b663-b7bb-4fe1-9867-97e55db3d34f@huaweicloud.com>
Date: Fri, 18 Apr 2025 12:02:51 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/7] blk-throttle: Split the service queue
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, wozizhi@huaweicloud.com, ming.lei@redhat.com,
 tj@kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250417105833.1930283-1-wozizhi@huawei.com>
 <20250417105833.1930283-7-wozizhi@huawei.com>
 <98d732b1-145d-65bd-d9f2-dfc3b386fead@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <98d732b1-145d-65bd-d9f2-dfc3b386fead@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl_rzgFohhdCJw--.15238S3
X-Coremail-Antispam: 1UD129KBjvAXoW3try3Aw1fXFyxGF4ruFy3Arb_yoW8JF4DZo
	W5Kr1rJrn8Wr18Kw45Jw18Jr13Zw1kJr1qyr1DCr13JF18AFy7J348Jry5W3yxXF1Ikr48
	JF1Utry0vFy7Jr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY57AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/4/18 9:37, Yu Kuai 写道:
> Hi,
> 
> 在 2025/04/17 18:58, Zizhi Wo 写道:
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
>>   block/blk-throttle.c | 75 +++++++++++++++++++++++++++-----------------
>>   block/blk-throttle.h |  3 +-
>>   2 files changed, 48 insertions(+), 30 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 1cfd226c3b39..6f9f08d7e5fe 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -152,22 +152,27 @@ static void throtl_qnode_init(struct 
>> throtl_qnode *qn, struct throtl_grp *tg)
>>    * throtl_qnode_add_bio - add a bio to a throtl_qnode and activate it
>>    * @bio: bio being added
>>    * @qn: qnode to add bio to
>> - * @queued: the service_queue->queued[] list @qn belongs to
>> + * @sq: the service_queue @qn belongs to
>>    *
>> - * Add @bio to @qn and put @qn on @queued if it's not already on.
>> + * Add @bio to @qn and put @qn on @sq->queued if it's not already on.
>>    * @qn->tg's reference count is bumped when @qn is activated.  See the
>>    * comment on top of throtl_qnode definition for details.
>>    */
>>   static void throtl_qnode_add_bio(struct bio *bio, struct 
>> throtl_qnode *qn,
>> -                 struct list_head *queued)
>> +                 struct throtl_service_queue *sq)
>>   {
>> -    if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
>> +    bool rw = bio_data_dir(bio);
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
>> -        list_add_tail(&qn->node, queued);
>> +        list_add_tail(&qn->node, &sq->queued[rw]);
>>           blkg_get(tg_to_blkg(qn->tg));
>>       }
>>   }
>> @@ -198,22 +203,24 @@ static struct bio *throtl_peek_queued(struct 
>> list_head *queued)
>>   /**
>>    * throtl_pop_queued - pop the first bio form a qnode list
>> - * @queued: the qnode list to pop a bio from
>> + * @sq: the service_queue to pop a bio from
>>    * @tg_to_put: optional out argument for throtl_grp to put
>> + * @rw: read/write
>>    *
>> - * Pop the first bio from the qnode list @queued. Note that we firstly
>> + * Pop the first bio from the qnode list @sq->queued. Note that we 
>> firstly
>>    * focus on the iops list because bios are ultimately dispatched 
>> from it.
>> - * After popping, the first qnode is removed from @queued if empty or 
>> moved to
>> - * the end of @queued so that the popping order is round-robin.
>> + * After popping, the first qnode is removed from @sq->queued if 
>> empty or
>> + * moved to the end of @queued so that the popping order is round-robin.
>>    *
>>    * When the first qnode is removed, its associated throtl_grp should 
>> be put
>>    * too.  If @tg_to_put is NULL, this function automatically puts it;
>>    * otherwise, *@tg_to_put is set to the throtl_grp to put and the 
>> caller is
>>    * responsible for putting it.
>>    */
>> -static struct bio *throtl_pop_queued(struct list_head *queued,
>> -                     struct throtl_grp **tg_to_put)
>> +static struct bio *throtl_pop_queued(struct throtl_service_queue *sq,
>> +                     struct throtl_grp **tg_to_put, bool rw)
>>   {
>> +    struct list_head *queued = &sq->queued[rw];
>>       struct throtl_qnode *qn;
>>       struct bio *bio;
>> @@ -222,8 +229,12 @@ static struct bio *throtl_pop_queued(struct 
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
> 
> The code is broken if bio is NULL. Perhaps:
> 
> bio = bio_list_pop(&qn->bios_iops);
> if (bio) {
>      sq->nr_queued_iops[rw]--;
> } else {
>      bio = bio_list_pop(&qn->bios_bps);
>      if (bio)
>          sq->nr_queued_bps[rw]--;
> }
> 
> WARN_ON_ONCE(!bio);
> 

Although this situation is unexpected, the code should indeed avoid the
problem of null pointer dereference. I will revise it quickly.

Thanks,
Zizhi Wo


> Otherwise, this patch LGTM.
> 
> Thanks,
> Kuai
>>       if (bio_list_empty(&qn->bios_bps) && 
>> bio_list_empty(&qn->bios_iops)) {
>> @@ -553,6 +564,11 @@ static bool throtl_slice_used(struct throtl_grp 
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
>> @@ -682,9 +698,9 @@ static void tg_update_carryover(struct throtl_grp 
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
>> @@ -776,7 +792,8 @@ static void throtl_charge_iops_bio(struct 
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
>> @@ -832,7 +849,7 @@ static unsigned long tg_dispatch_time(struct 
>> throtl_grp *tg, struct bio *bio)
>>        * this function with a different bio if there are other bios
>>        * queued.
>>        */
>> -    BUG_ON(tg->service_queue.nr_queued[rw] &&
>> +    BUG_ON(sq_queued(&tg->service_queue, rw) &&
>>              bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>>       wait = tg_dispatch_bps_time(tg, bio);
>> @@ -872,12 +889,11 @@ static void throtl_add_bio_tg(struct bio *bio, 
>> struct throtl_qnode *qn,
>>        * dispatched.  Mark that @tg was empty.  This is automatically
>>        * cleared on the next tg_update_disptime().
>>        */
>> -    if (!sq->nr_queued[rw])
>> +    if (sq_queued(sq, rw) == 0)
>>           tg->flags |= THROTL_TG_WAS_EMPTY;
>> -    throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
>> +    throtl_qnode_add_bio(bio, qn, sq);
>> -    sq->nr_queued[rw]++;
>>       throtl_enqueue_tg(tg);
>>   }
>> @@ -931,8 +947,7 @@ static void tg_dispatch_one_bio(struct throtl_grp 
>> *tg, bool rw)
>>        * getting released prematurely.  Remember the tg to put and put it
>>        * after @bio is transferred to @parent_sq.
>>        */
>> -    bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
>> -    sq->nr_queued[rw]--;
>> +    bio = throtl_pop_queued(sq, &tg_to_put, rw);
>>       throtl_charge_iops_bio(tg, bio);
>> @@ -949,7 +964,7 @@ static void tg_dispatch_one_bio(struct throtl_grp 
>> *tg, bool rw)
>>       } else {
>>           bio_set_flag(bio, BIO_BPS_THROTTLED);
>>           throtl_qnode_add_bio(bio, &tg->qnode_on_parent[rw],
>> -                     &parent_sq->queued[rw]);
>> +                     parent_sq);
>>           BUG_ON(tg->td->nr_queued[rw] <= 0);
>>           tg->td->nr_queued[rw]--;
>>       }
>> @@ -1014,7 +1029,7 @@ static int throtl_select_dispatch(struct 
>> throtl_service_queue *parent_sq)
>>           nr_disp += throtl_dispatch_tg(tg);
>>           sq = &tg->service_queue;
>> -        if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
>> +        if (sq_queued(sq, READ) || sq_queued(sq, WRITE))
>>               tg_update_disptime(tg);
>>           else
>>               throtl_dequeue_tg(tg);
>> @@ -1067,9 +1082,11 @@ static void throtl_pending_timer_fn(struct 
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
>> @@ -1131,7 +1148,7 @@ static void blk_throtl_dispatch_work_fn(struct 
>> work_struct *work)
>>       spin_lock_irq(&q->queue_lock);
>>       for (rw = READ; rw <= WRITE; rw++)
>> -        while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
>> +        while ((bio = throtl_pop_queued(td_sq, NULL, rw)))
>>               bio_list_add(&bio_list_on_stack, bio);
>>       spin_unlock_irq(&q->queue_lock);
>> @@ -1637,7 +1654,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, 
>> bool rw)
>>   {
>>       /* throtl is FIFO - if bios are already queued, should queue */
>> -    if (tg->service_queue.nr_queued[rw])
>> +    if (sq_queued(&tg->service_queue, rw))
>>           return false;
>>       return tg_dispatch_time(tg, bio) == 0;
>> @@ -1711,7 +1728,7 @@ bool __blk_throtl_bio(struct bio *bio)
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

