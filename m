Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03AAC04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E523208CA
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 11:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE0LjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 07:39:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfE0LjJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 07:39:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD193906200EE29045C6;
        Mon, 27 May 2019 19:39:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 19:39:05 +0800
Subject: Re: [PATCH 1/2] block: make rq sector size accessible for block stats
To:     Pavel Begunkov <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <osandov@fb.com>, <ming.lei@redhat.com>
References: <20190521075904.135060-1-houtao1@huawei.com>
 <20190521075904.135060-2-houtao1@huawei.com>
 <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <1a525ec8-3197-7cb4-bec7-bdd8b345cc84@huawei.com>
Date:   Mon, 27 May 2019 19:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <76a679b4-cd55-8bca-0020-fb320914f491@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2019/5/25 19:46, Pavel Begunkov wrote:
> That's the same bug I posted a patch about 3+ weeks ago. No answer yet,
> however.
> https://www.spinics.net/lists/linux-block/msg40049.html
> 
Sorry for missing that.

> I think putting time sampling at __blk_mq_end_request() won't give
> sufficient precision for more sophisticated hybrid polling, because path
> __blk_mq_complete_request() -> __blk_mq_end_request() adds a lot of
> overhead (redirect rq to another cpu, dma unmap, etc). That's the case
> for mentioned patchset
> https://www.spinics.net/lists/linux-block/msg40044.html
> 
> It works OK for 50-80us requests (e.g. SSD read), but is not good enough
> for 20us and less (e.g. SSD write). I think it would be better to save
> the time in advance, and use it later.
> 
Yes, getting the end time from blk_mq_complete_request() will be more accurate.

> By the way, it seems, that __blk_mq_end_request() is really better place
> to record stats, as not all drivers use __blk_mq_complete_request(),
> even though they don't implement blk_poll().
> 
And __blk_mq_complete_request() may be invoked multiple times (although no possible
for nvme device), but __blk_mq_end_request() is only invoked once.

Regards,
Tao

> 
> On 21/05/2019 10:59, Hou Tao wrote:
>> Currently rq->data_len will be decreased by partial completion or
>> zeroed by completion, so when blk_stat_add() is invoked, data_len
>> will be zero and there will never be samples in poll_cb because
>> blk_mq_poll_stats_bkt() will return -1 if data_len is zero.
>>
>> We could move blk_stat_add() back to __blk_mq_complete_request(),
>> but that would make the effort of trying to call ktime_get_ns()
>> once in vain. Instead we can reuse throtl_size field, and use
>> it for both block stats and block throttle, and adjust the
>> logic in blk_mq_poll_stats_bkt() accordingly.
>>
>> Fixes: 4bc6339a583c ("block: move blk_stat_add() to __blk_mq_end_request()")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  block/blk-mq.c         | 11 +++++------
>>  block/blk-throttle.c   |  3 ++-
>>  include/linux/blkdev.h | 15 ++++++++++++---
>>  3 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 08a6248d8536..4d1462172f0f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -44,12 +44,12 @@ static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>>  
>>  static int blk_mq_poll_stats_bkt(const struct request *rq)
>>  {
>> -	int ddir, bytes, bucket;
>> +	int ddir, sectors, bucket;
>>  
>>  	ddir = rq_data_dir(rq);
>> -	bytes = blk_rq_bytes(rq);
>> +	sectors = blk_rq_stats_sectors(rq);
>>  
>> -	bucket = ddir + 2*(ilog2(bytes) - 9);
>> +	bucket = ddir + 2 * ilog2(sectors);
>>  
>>  	if (bucket < 0)
>>  		return -1;
>> @@ -329,6 +329,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>  	else
>>  		rq->start_time_ns = 0;
>>  	rq->io_start_time_ns = 0;
>> +	rq->stats_sectors = 0;
>>  	rq->nr_phys_segments = 0;
>>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>>  	rq->nr_integrity_segments = 0;
>> @@ -678,9 +679,7 @@ void blk_mq_start_request(struct request *rq)
>>  
>>  	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>>  		rq->io_start_time_ns = ktime_get_ns();
>> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>> -		rq->throtl_size = blk_rq_sectors(rq);
>> -#endif
>> +		rq->stats_sectors = blk_rq_sectors(rq);
>>  		rq->rq_flags |= RQF_STATS;
>>  		rq_qos_issue(q, rq);
>>  	}
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 1b97a73d2fb1..88459a4ac704 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -2249,7 +2249,8 @@ void blk_throtl_stat_add(struct request *rq, u64 time_ns)
>>  	struct request_queue *q = rq->q;
>>  	struct throtl_data *td = q->td;
>>  
>> -	throtl_track_latency(td, rq->throtl_size, req_op(rq), time_ns >> 10);
>> +	throtl_track_latency(td, blk_rq_stats_sectors(rq), req_op(rq),
>> +			     time_ns >> 10);
>>  }
>>  
>>  void blk_throtl_bio_endio(struct bio *bio)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 1aafeb923e7b..68a0841d3554 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -202,9 +202,12 @@ struct request {
>>  #ifdef CONFIG_BLK_WBT
>>  	unsigned short wbt_flags;
>>  #endif
>> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>> -	unsigned short throtl_size;
>> -#endif
>> +	/*
>> +	 * rq sectors used for blk stats. It has the same value
>> +	 * with blk_rq_sectors(rq), except that it never be zeroed
>> +	 * by completion.
>> +	 */
>> +	unsigned short stats_sectors;
>>  
>>  	/*
>>  	 * Number of scatter-gather DMA addr+len pairs after
>> @@ -892,6 +895,7 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>>   * blk_rq_err_bytes()		: bytes left till the next error boundary
>>   * blk_rq_sectors()		: sectors left in the entire request
>>   * blk_rq_cur_sectors()		: sectors left in the current segment
>> + * blk_rq_stats_sectors()	: sectors of the entire request used for stats
>>   */
>>  static inline sector_t blk_rq_pos(const struct request *rq)
>>  {
>> @@ -920,6 +924,11 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
>>  	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
>>  }
>>  
>> +static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
>> +{
>> +	return rq->stats_sectors;
>> +}
>> +
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  static inline unsigned int blk_rq_zone_no(struct request *rq)
>>  {
>>
> 

