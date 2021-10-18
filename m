Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF50C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E4360F9F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJROOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhJROOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:14:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C559C0D9416
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:40:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i11so14880769ila.12
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUN4oRbwhwJXE+o1XZ0/1+bDO9k86N0NAWA3HggalUM=;
        b=KGe/8aBexV/27mV6MO+Dzjth2recx7kbDioXFCXINaJOjRU/YUJXB5JKvKbS8e0tZP
         r3vseFGCNsYh0CpfSHBl6VeFGNHXuo3CRVw0IV0ijsxNS3tDuTkDqNcPHJJpm/4YL6vI
         E/omBZ+ATJYtVDwN53+QLJcBQl4Th18x0pxm8rmpXyWi8XN30QyH3JoECuOgnlDL5+ik
         ySncTmYf/iaUCih3b4rO0k0HAd4Tlr0blpko1M8/xtPa+MKzHFVSt1OuXyNCBWdB+Fe0
         ujmG7g1AVBW3gl7JXd2Z6WmmEm2Dhk4CsL2z4lvTg31o41PzqucPWFz2DKV/4vmHlSHM
         BmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUN4oRbwhwJXE+o1XZ0/1+bDO9k86N0NAWA3HggalUM=;
        b=zbktwuBQWbQnNs183Djnw6repVdvuVWTOTC1GcLsnizL3sSrsjGvuOWlOknewPZS/w
         BJDn4xrCqaEHBvwzt1MViO8gejdRPvU7H9UIY05gPViS2bKmLCgNgedIatO0HKGuk1Bw
         Zy/20YzDAnuBEwUJmhkpEMRtDaQTdV/JxScojAghtzve/gfIRIl8RNXxsKMKmK37fpEx
         VZbVASvTFCu9eekCW/1GxKQJ5hYxIwUlSUC0Q7i1dsP+d2AS/qUeXk7Dr8PlxncDGl+f
         tdGNZkCTZKstfh2Js8Xjz+TGXjWey2ZV+/PbWGzBz7V+yBNYFAd3qDknOotBjVFXLjP7
         +g3w==
X-Gm-Message-State: AOAM531S5GHhFF0TTcCGYJlD0ambm/NTJu5zMoN2D2GBSy9fIKzNYqLQ
        hJksuwQa1vLY6oRMC2RYmUHkbB1wLBu4ZQ==
X-Google-Smtp-Source: ABdhPJz++ckIt+UVlf6JrCIfAyQwd36MAlR19Hjkj0ugRjn+1AQlRFkafIhGuGK+HDRfcFJ3pKv+YA==
X-Received: by 2002:a05:6e02:1a42:: with SMTP id u2mr14460081ilv.81.1634564440533;
        Mon, 18 Oct 2021 06:40:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r17sm6572444ioj.43.2021.10.18.06.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 06:40:40 -0700 (PDT)
Subject: Re: [PATCH 3/6] block: add support for blk_mq_end_request_batch()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-4-axboe@kernel.dk> <YW1J92MfyiNZ/wuI@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52825d47-a474-d3bd-f03e-c379e63d1aaa@kernel.dk>
Date:   Mon, 18 Oct 2021 07:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW1J92MfyiNZ/wuI@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 4:18 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 08:06:20PM -0600, Jens Axboe wrote:
>> Instead of calling blk_mq_end_request() on a single request, add a helper
>> that takes the new struct io_comp_batch and completes any request stored
>> in there.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq-tag.c     |  6 ++++
>>  block/blk-mq-tag.h     |  1 +
>>  block/blk-mq.c         | 81 ++++++++++++++++++++++++++++++++----------
>>  include/linux/blk-mq.h | 29 +++++++++++++++
>>  4 files changed, 98 insertions(+), 19 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index c43b97201161..b94c3e8ef392 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -207,6 +207,12 @@ void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>>  	}
>>  }
>>  
>> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
>> +{
>> +	sbitmap_queue_clear_batch(&tags->bitmap_tags, tags->nr_reserved_tags,
>> +					tag_array, nr_tags);
>> +}
>> +
>>  struct bt_iter_data {
>>  	struct blk_mq_hw_ctx *hctx;
>>  	busy_iter_fn *fn;
>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>> index e617c7220626..df787b5a23bd 100644
>> --- a/block/blk-mq-tag.h
>> +++ b/block/blk-mq-tag.h
>> @@ -19,6 +19,7 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
>>  			      unsigned int *offset);
>>  extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
>>  			   unsigned int tag);
>> +void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
>>  extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>>  					struct blk_mq_tags **tags,
>>  					unsigned int depth, bool can_grow);
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8eb80e70e8ea..58dc0c0c24ac 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -292,15 +292,6 @@ void blk_mq_wake_waiters(struct request_queue *q)
>>  			blk_mq_tag_wakeup_all(hctx->tags, true);
>>  }
>>  
>> -/*
>> - * Only need start/end time stamping if we have iostat or
>> - * blk stats enabled, or using an IO scheduler.
>> - */
>> -static inline bool blk_mq_need_time_stamp(struct request *rq)
>> -{
>> -	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
>> -}
>> -
>>  static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>  		unsigned int tag, u64 alloc_time_ns)
>>  {
>> @@ -754,19 +745,21 @@ bool blk_update_request(struct request *req, blk_status_t error,
>>  }
>>  EXPORT_SYMBOL_GPL(blk_update_request);
>>  
>> -inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>> +static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
>>  {
>> -	if (blk_mq_need_time_stamp(rq)) {
>> -		u64 now = ktime_get_ns();
>> +	if (rq->rq_flags & RQF_STATS) {
>> +		blk_mq_poll_stats_start(rq->q);
>> +		blk_stat_add(rq, now);
>> +	}
>>  
>> +	blk_mq_sched_completed_request(rq, now);
>> +	blk_account_io_done(rq, now);
>> +}
>>  
>> -		blk_mq_sched_completed_request(rq, now);
>> -		blk_account_io_done(rq, now);
>> -	}
>> +inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>> +{
>> +	if (blk_mq_need_time_stamp(rq))
>> +		__blk_mq_end_request_acct(rq, ktime_get_ns());
>>  
>>  	if (rq->end_io) {
>>  		rq_qos_done(rq->q, rq);
>> @@ -785,6 +778,56 @@ void blk_mq_end_request(struct request *rq, blk_status_t error)
>>  }
>>  EXPORT_SYMBOL(blk_mq_end_request);
>>  
>> +#define TAG_COMP_BATCH		32
>> +
>> +static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
>> +					  int *tag_array, int nr_tags)
>> +{
>> +	struct request_queue *q = hctx->queue;
>> +
>> +	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
>> +	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
>> +}
>> +
>> +void blk_mq_end_request_batch(struct io_comp_batch *iob)
>> +{
>> +	int tags[TAG_COMP_BATCH], nr_tags = 0;
>> +	struct blk_mq_hw_ctx *last_hctx = NULL;
>> +	struct request *rq;
>> +	u64 now = 0;
>> +
>> +	if (iob->need_ts)
>> +		now = ktime_get_ns();
>> +
>> +	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
>> +		prefetch(rq->bio);
>> +		prefetch(rq->rq_next);
>> +
>> +		blk_update_request(rq, BLK_STS_OK, blk_rq_bytes(rq));
>> +		__blk_mq_end_request_acct(rq, now);
> 
> If iob->need_ts is not set we don't need to call
> __blk_mq_end_request_acct, do we?

We don't strictly need to, I'll make that change.

-- 
Jens Axboe

