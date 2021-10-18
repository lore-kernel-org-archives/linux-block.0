Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361A360FD7
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 16:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhJRQMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJRQMo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 12:12:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C1C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 09:10:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b188so12005945iof.8
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WehA1Of8Dgzn3y68QBKKPIWZI7nmPo6prVLYGTh6Scs=;
        b=K0upSoFhxt8ySNwHKGVj85lxqzWS6XUiOvcopbBSwdLlB7XuLObZUrvFMEkJtrjXng
         2dBrQOA5YX0BkRUWWaqtoCJiWyJyp2udajW95nFeTlaf97O83ZFtjctGKEleN97pkZwJ
         iVOzbxzmcBmXS5cnkadQ705xkvcHvEG6zJg5GwE2Z/Divq/JTdIn8rOEyeZtyZa9ncIn
         uXuYzlAbd+rtgJUUX7ne//eKTcnny0uM3MBbQowsF27NX4Oo1ftcNYkoZRdMLM2qvWLN
         rJWsjTUN0uKzF+p6m1kBjaZExXZ+Mnwe2fNKpDd4cpio5NEou4WlQxgS8ojtY0do37jE
         zZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WehA1Of8Dgzn3y68QBKKPIWZI7nmPo6prVLYGTh6Scs=;
        b=lWMr95Ybk+EEgLiycDQgAM5JfDzw+pEeRFFeCEq2F5dUy6WbIUwraGfMmx0btMalZG
         +/q7L5Anen66mUtNp1oTSR2MbjgNMqz8NFzdQmOixnUMbWkJzr1bzW7pyrhOEM6QsohO
         XpD2eDnYxB9RKSY9lyaMkTPiB4pLgzXley28UzU4nCTZNokMRISduMYZFLGb0bp8oaCE
         v5JCWnJBPHhwaGKMyavbEzxt4n5Yv6aIUnM7CtCZVYDL5kS4sPrX9bPBykJLrC+h0V82
         syUzARUpZCt8YsuSne4MOgguRdMz1R1nG0NtragCGAXgp4pVmkMbad4wCAvdlVO8Vv+b
         +JfA==
X-Gm-Message-State: AOAM532BfMfuKcE0mDFq8Ub0B8kopIQAJ7YuC5MhK24vSrwfnX8KZFYw
        TMTuCNOYcadWTdgbjilYsUw2i/VTLBjgGQ==
X-Google-Smtp-Source: ABdhPJxLRFVCEaHmLeJyHosMqDWS805o9iE+D179fGVLbhqkMhP6G27NykhEmXWlxf/oxrS9R7cQ/A==
X-Received: by 2002:a02:aa96:: with SMTP id u22mr477071jai.95.1634573431914;
        Mon, 18 Oct 2021 09:10:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r11sm7164910ilt.83.2021.10.18.09.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 09:10:31 -0700 (PDT)
Subject: Re: [PATCH 07/14] block: change plugging to use a singly linked list
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-8-axboe@kernel.dk> <YW08EPYhH73m7nUj@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89a1ae23-d8e1-f4c2-a5f1-d988c2709815@kernel.dk>
Date:   Mon, 18 Oct 2021 10:10:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW08EPYhH73m7nUj@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 3:19 AM, Christoph Hellwig wrote:
> On Sat, Oct 16, 2021 at 07:37:41PM -0600, Jens Axboe wrote:
>> Use a singly linked list for the blk_plug. This saves 8 bytes in the
>> blk_plug struct, and makes for faster list manipulations than doubly
>> linked lists. As we don't use the doubly linked lists for anything,
>> singly linked is just fine.
> 
> This patch also does a few other thing, like changing the same_queue_rq
> type and adding a has_elevator flag to the plug.  Can you please split
> this out and document the changes better?

I'll split it, should probably be 3 patches.

> 
>> static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>>  {
>> +	struct blk_mq_hw_ctx *hctx = NULL;
>> +	int queued = 0;
>> +	int errors = 0;
>> +
>> +	while (!rq_list_empty(plug->mq_list)) {
>> +		struct request *rq;
>> +		blk_status_t ret;
>> +
>> +		rq = rq_list_pop(&plug->mq_list);
>>  
>> +		if (!hctx)
>> +			hctx = rq->mq_hctx;
>> +		else if (hctx != rq->mq_hctx && hctx->queue->mq_ops->commit_rqs) {
>> +			trace_block_unplug(hctx->queue, queued, !from_schedule);
>> +			hctx->queue->mq_ops->commit_rqs(hctx);
>> +			queued = 0;
>> +			hctx = rq->mq_hctx;
>> +		}
>> +
>> +		ret = blk_mq_request_issue_directly(rq,
>> +						rq_list_empty(plug->mq_list));
>> +		if (ret != BLK_STS_OK) {
>> +			if (ret == BLK_STS_RESOURCE ||
>> +					ret == BLK_STS_DEV_RESOURCE) {
>> +				blk_mq_request_bypass_insert(rq, false,
>> +						rq_list_empty(plug->mq_list));
>> +				break;
>> +			}
>> +			blk_mq_end_request(rq, ret);
>> +			errors++;
>> +		} else
>> +			queued++;
>> +	}
> 
> This all looks a bit messy to me.  I'd suggest reordering this a bit
> including a new helper:
> 
> static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
> 		bool from_schedule)
> {
> 	if (hctx->queue->mq_ops->commit_rqs) {
> 		trace_block_unplug(hctx->queue, *queued, !from_schedule);
> 		hctx->queue->mq_ops->commit_rqs(hctx);
> 	}
> 	*queued = 0;
> }
> 
> static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
> {
> 	struct blk_mq_hw_ctx *hctx = NULL;
> 	int queued = 0;
> 	int errors = 0;
> 
> 	while ((rq = rq_list_pop(&plug->mq_list))) {
> 		bool last = rq_list_empty(plug->mq_list);
> 		blk_status_t ret;
> 
> 		if (hctx != rq->mq_hctx) {
> 			if (hctx)
> 				blk_mq_commit_rqs(hctx, &queued, from_schedule);
> 			hctx = rq->mq_hctx;
> 		}
> 
> 		ret = blk_mq_request_issue_directly(rq, last);
> 		switch (ret) {
> 		case BLK_STS_OK:
> 			queued++;
> 			break;
> 		case BLK_STS_RESOURCE:
> 		case BLK_STS_DEV_RESOURCE:
> 			blk_mq_request_bypass_insert(rq, false, last);
> 			blk_mq_commit_rqs(hctx, &queued, from_schedule);
> 			return;
> 		default:
> 			blk_mq_end_request(rq, ret);
> 			errors++;
> 			break;
> 		}
> 	}
> 
> 	/*
> 	 * If we didn't flush the entire list, we could have told the driver
> 	 * there was more coming, but that turned out to be a lie.
> 	 */
> 	if (errors)
> 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
> }

Good suggestion!

-- 
Jens Axboe

