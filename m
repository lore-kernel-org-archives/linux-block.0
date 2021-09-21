Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E05C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F386561242
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhIUDef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:34:35 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36850 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhIUD1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 23:27:23 -0400
Received: by mail-pj1-f49.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so978923pjn.1
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 20:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tgDfdvtjQjhv7uYckhicTiScn8dqJ78KhExl2MNgM+I=;
        b=j2aoFwXeaa1NshaJMktrxxs0djwYMNSoSK+KO18tQjIwd9eUJ/FGyDcDsoBghjuVGo
         KfPSfem2gHWJkS55gAZB8F1+ociP12U5aNAS2dVj4h24BVYU050UvdNn6FEkIZrdRW7x
         d+yR/oTPXBx6q0KMvsc6j5uGv1kj2cb8LnrxGkFMdrkellUkXaYK5t5raErXleWGtfAt
         DflpA1J32H8qMQ285nZknaHdMQaUbWTlPvCAXtBQ5kV46f9/vbD2oydANIqfw+qJwnc+
         tYYQLhDzRe0qHqH04jq8E4GYupgtU3sywUDRAyEFyOfksfYx8g5b7jtCQDY2JT1r5Lvh
         Gpog==
X-Gm-Message-State: AOAM532Ic1VlzAF2RtX70jzsIPY3EJnt0suevNL8MmnKqzLOpCiFNwxF
        qWi1QZ5A9o5HtwBDtZXVKrI=
X-Google-Smtp-Source: ABdhPJxxBBvsObos0V1CpQsXwnBDYZAVbXeQI9HbDFX67r0MIDDO8v0S/0rp5ZaCDpfs89wJtfDhyw==
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr2696935pji.11.1632194755057;
        Mon, 20 Sep 2021 20:25:55 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:2c03:4c32:d511:41a6? ([2601:647:4000:d7:2c03:4c32:d511:41a6])
        by smtp.gmail.com with ESMTPSA id h24sm16170884pfn.180.2021.09.20.20.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 20:25:54 -0700 (PDT)
Message-ID: <dc7ee301-f3d4-e8dd-3dd5-f0d6c9200048@acm.org>
Date:   Mon, 20 Sep 2021 20:25:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/4] block: split bio_queue_enter from blk_queue_enter
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
 <20210920112405.1299667-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20210920112405.1299667-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 04:24, Christoph Hellwig wrote:
> To prepare for fixing a gendisk shutdown race, open code the
> blk_queue_enter logic in bio_queue_enter.  This also remove the
                                                        ^^^^^^
                                                        removes
> pointless flags translation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4c078681f39b8..be7cd1819b605 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -475,18 +475,32 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>   static inline int bio_queue_enter(struct bio *bio)
>   {
>   	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> -	bool nowait = bio->bi_opf & REQ_NOWAIT;
> -	int ret;
>   
> -	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
> -	if (unlikely(ret)) {
> -		if (nowait && !blk_queue_dying(q))
> +	while (!blk_try_enter_queue(q, false)) {
> +		if (bio->bi_opf & REQ_NOWAIT) {
>   			bio_wouldblock_error(bio);
> -		else
> +			return -EBUSY;
> +		}
> +
> +		/*
> +		 * read pair of barrier in blk_freeze_queue_start(), we need to
> +		 * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
> +		 * reading .mq_freeze_depth or queue dying flag, otherwise the
> +		 * following wait may never return if the two reads are
> +		 * reordered.
> +		 */
> +		smp_rmb();
> +		wait_event(q->mq_freeze_wq,
> +			   (!q->mq_freeze_depth &&
> +			    blk_pm_resume_queue(false, q)) ||
> +			   blk_queue_dying(q));
> +		if (blk_queue_dying(q)) {
>   			bio_io_error(bio);
> +			return -ENODEV;
> +		}
>   	}
>   
> -	return ret;
> +	return 0;

This patch changes the behavior of bio_queue_enter(). I think that
preserving the existing behavior implies testing blk_queue_dying(q)
before checking the REQ_NOWAIT flag.

Thanks,

Bart.
