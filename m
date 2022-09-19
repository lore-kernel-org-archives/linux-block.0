Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A578CECAAD3
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiISJMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiISJM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 05:12:28 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779F2497C;
        Mon, 19 Sep 2022 02:12:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQA11kj_1663578742;
Received: from 30.97.56.99(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQA11kj_1663578742)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 17:12:23 +0800
Message-ID: <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
Date:   Mon, 19 Sep 2022 17:12:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
 <YyfoQuw18kOynxcC@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YyfoQuw18kOynxcC@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/19 11:55, Ming Lei wrote:
> On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
>> With recovery feature enabled, in ublk_queue_rq or task work
>> (in exit_task_work or fallback wq), we requeue rqs instead of
>> ending(aborting) them. Besides, No matter recovery feature is enabled
>> or disabled, we schedule monitor_work immediately.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 23337bd7c105..b067f33a1913 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>>  
>>  #define UBLK_REQUEUE_DELAY_MS	3
>>  
>> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
>> +		struct request *rq)
>> +{
>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
>> +	/* We cannot process this rq so just requeue it. */
>> +	if (ublk_queue_can_use_recovery(ubq)) {
>> +		blk_mq_requeue_request(rq, false);
>> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
> 
> Here you needn't to kick requeue list since we know it can't make
> progress. And you can do that once before deleting gendisk
> or the queue is recovered.

No, kicking rq here is necessary.

Consider USER_RECOVERY is enabled and everything goes well.
User sends STOP_DEV, and we have kicked requeue list in
ublk_stop_dev() and are going to call del_gendisk().
However, a crash happens now. Then rqs may be still requeued
by ublk_queue_rq() because ublk_queue_rq() sees a dying
ubq_daemon. So del_gendisk() will hang because there are
rqs leaving in requeue list and no one kicks them.

BTW, kicking requeue list after requeue rqs is really harmless
since we schedule quiesce_work immediately after finding a
dying ubq_daemon. So few rqs have chance to be re-dispatched.

> 
>> +	} else {
>> +		blk_mq_end_request(rq, BLK_STS_IOERR);
>> +	}
>> +}
>> +
>>  static inline void __ublk_rq_task_work(struct request *req)
>>  {
>>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>> @@ -704,7 +719,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>>  	 * (2) current->flags & PF_EXITING.
>>  	 */
>>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
>> -		blk_mq_end_request(req, BLK_STS_IOERR);
>> +		__ublk_abort_rq_in_task_work(ubq, req);
>>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>>  		return;
>>  	}
>> @@ -779,6 +794,21 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>>  	__ublk_rq_task_work(req);
>>  }
>>  
>> +static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
>> +		struct request *rq)
>> +{
>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
>> +	/* We cannot process this rq so just requeue it. */
>> +	if (ublk_queue_can_use_recovery(ubq)) {
>> +		blk_mq_requeue_request(rq, false);
>> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
> 
> Same with above.
> 
> 
> Thanks,
> Ming
