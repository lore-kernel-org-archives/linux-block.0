Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE72FC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9C72086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KoumJPPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9C72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeKQBpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:45:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39589 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:45:49 -0500
Received: by mail-io1-f68.google.com with SMTP id j18-v6so5270520iog.6
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/EElt39lItm0/IED2R3Bixzf+vyKxMLNpuw4CpJaiFY=;
        b=KoumJPPnCBiQ47Gqoa7FBknOlaGBr0qdZ7FZ2hybhEUKyc9sB9/iPONfx1XRQxfEb2
         Lfe7a50TjNbfYcrR6vD6weMSzq6XdDTCnAxqIWVk5J/2ODp3bA4ypTWOrPAAx1XD6zUV
         ceFhqWKAMZ9NuxRSqPQJk3rQ9MMwm7+YQnjOrORY6SeMCGkQhgq0+GKpStmzkLxen6y/
         SX0MVbntWR6OzI9QY2Cwzj5m1tcZ1ydVc0L4V4pgOb1ByXSM50V8StUfQNHf1g0rLk5w
         z6hM82I2eO9ghHVL0oOiZYg2jkYY9JMbPpPaKDdDdaoL2/8HRMc+O5IR+zvjJos5Hf9y
         k+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/EElt39lItm0/IED2R3Bixzf+vyKxMLNpuw4CpJaiFY=;
        b=ahn2oqMAJeTJWsU6nq1/PGxOyQluT69NGdhZFiVzIwCeVeYuN3PQJXmZuXfZcIV2Gy
         tS8bZBa3ZbOR6XCtmAGxgd9VQckUFfeVvB3RqOv3JTy38x6d5/lHjHhmSEFiNcQlx9Cj
         +E2m7aVN0k7HaJDPLgUgJ15K9VxqXIlrVCOYdWB7ehjf6tE4w/dC7UG00+h51JGHiFGf
         J/dcnMD3E1wOA7OO36y/UixpgwpKFd2jzMDKofPCjSmAMyqRLsCI7to4/MjIX8i1QSO6
         aFOrsQXMumPQRw5Xor/Rbgu9MPSiBlr7z/hJiVoitR/kzDZyZjiH4GVguA9kYp/30fQA
         2f7w==
X-Gm-Message-State: AGRZ1gKwHsjwte1OUMWhN6OM5+61V+6IDJx9dZdoCFLwYJpWm1ZZYOT8
        l9WA9r4zv21Bq8zceC58oGpJPbaA8xI=
X-Google-Smtp-Source: AFSGD/XGZKC2alcHfDaD1m8YjqTpQhUqcrfWjrVhRv4XXhDXb3jLPoMGH98KN5OqjgsRIAYv5pfYxA==
X-Received: by 2002:a6b:9204:: with SMTP id u4-v6mr9325217iod.108.1542382377734;
        Fri, 16 Nov 2018 07:32:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y9sm5267293ioj.63.2018.11.16.07.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:32:56 -0800 (PST)
Subject: Re: [PATCH 04/11] block: avoid ordered task state change for polled
 IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-5-axboe@kernel.dk>
 <20181116084134.GF9023@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3054642b-96fa-bc1f-c605-8a49d3b9071a@kernel.dk>
Date:   Fri, 16 Nov 2018 08:32:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116084134.GF9023@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:41 AM, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:51:28PM -0700, Jens Axboe wrote:
>> Ensure that writes to the dio/bio waiter field are ordered
>> correctly. With the smp_rmb() before the READ_ONCE() check,
>> we should be able to use a more relaxed ordering for the
>> task state setting. We don't need a heavier barrier on
>> the wakeup side after writing the waiter field, since we
>> either going to be in the task we care about, or go through
>> wake_up_process() which implies a strong enough barrier.
>>
>> For the core poll helper, the task state setting don't need
>> to imply any atomics, as it's the current task itself that
>> is being modified and we're not going to sleep.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c | 4 ++--
>>  fs/block_dev.c | 9 +++++++--
>>  fs/iomap.c     | 4 +++-
>>  mm/page_io.c   | 4 +++-
>>  4 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 32b246ed44c0..7fc4abb4cc36 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3331,12 +3331,12 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>>  		ret = q->mq_ops->poll(hctx, rq->tag);
>>  		if (ret > 0) {
>>  			hctx->poll_success++;
>> -			set_current_state(TASK_RUNNING);
>> +			__set_current_state(TASK_RUNNING);
>>  			return true;
>>  		}
>>  
>>  		if (signal_pending_state(state, current))
>> -			set_current_state(TASK_RUNNING);
>> +			__set_current_state(TASK_RUNNING);
>>  
>>  		if (current->state == TASK_RUNNING)
>>  			return true;
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index c039abfb2052..5b754f84c814 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -237,9 +237,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  
>>  	qc = submit_bio(&bio);
>>  	for (;;) {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>> +		smp_rmb();
>>  		if (!READ_ONCE(bio.bi_private))
>>  			break;
>> +
>>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>>  		    !blk_poll(bdev_get_queue(bdev), qc))
>>  			io_schedule();
>> @@ -403,7 +406,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  		return -EIOCBQUEUED;
>>  
>>  	for (;;) {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>> +		smp_rmb();
>>  		if (!READ_ONCE(dio->waiter))
>>  			break;
>>  
>> diff --git a/fs/iomap.c b/fs/iomap.c
>> index f61d13dfdf09..3373ea4984d9 100644
>> --- a/fs/iomap.c
>> +++ b/fs/iomap.c
>> @@ -1888,7 +1888,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>  			return -EIOCBQUEUED;
>>  
>>  		for (;;) {
>> -			set_current_state(TASK_UNINTERRUPTIBLE);
>> +			__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>> +			smp_rmb();
>>  			if (!READ_ONCE(dio->submit.waiter))
>>  				break;
>>  
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index d4d1c89bcddd..008f6d00c47c 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -405,7 +405,9 @@ int swap_readpage(struct page *page, bool synchronous)
>>  	bio_get(bio);
>>  	qc = submit_bio(bio);
>>  	while (synchronous) {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>> +		smp_rmb();
>>  		if (!READ_ONCE(bio->bi_private))
> 
> I think any smp_rmb() should have a big fact comment explaining it.
> 
> Also to help stupid people like me that dont understand why we even
> need it here  given the READ_ONCE below.

Thinking about it, I don't think we need it at all. The barrier for
the task check is done on the wakeup side, the READ_ONCE() should
be enough for the read below. I'll update it.

-- 
Jens Axboe

