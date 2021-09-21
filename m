Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF40C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A136124A
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhIUDef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:34:35 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:46727 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhIUDbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 23:31:19 -0400
Received: by mail-pj1-f46.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so1504285pjb.5
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 20:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WqzQyM6RfuAIu97MqnwxvxvqUWlDbbQjPtipL0spCr8=;
        b=h9bwwElv18Ix1TJzqaZFD0xOywhqRG+73nyt4x/qZvQbaixAYhRV2HPZiwzRF1I9Yi
         SEys+3tlAjR53TFrWfVr+D/A+9vraQhgXkqgfK2W2MBcC4U0yE0IIDHbZTRcyCHQKG04
         2cXDStV4Ebz/HUKRcMSoERoU60oUsIHkSEnXlHCXIwl/o7+w+XYdPKl3XK5YJF8pLzli
         AmmMLoHVKC2wWVN/97cXW9KL2SzvBqSmRX/LwVzuU9vL1+XbRRuz2d13kCuC1NKzbft/
         w8R1WqlJu/IPwqClmb6Gfq9hednVEpuLkx66cSGNu2UeLYJEVxuMtjYAI2sEKSk+Nfem
         k8hQ==
X-Gm-Message-State: AOAM532xAlDDSDazyigewBw8Mp6qyQMgpipc3V1FhKC4rSrUrMn3BK/U
        g8nhYGj7PNZtcBQr3+VmRQ8G/T5a4N6AEA==
X-Google-Smtp-Source: ABdhPJy2ekgW8yhJhM1hoTvtdDSixgBUPCkeR8D5PqQo1tOgBPxcveMnpmqEGuw6n8vqr1mp/KR5rw==
X-Received: by 2002:a17:903:244e:b0:13c:802d:92c with SMTP id l14-20020a170903244e00b0013c802d092cmr25307344pls.78.1632194991412;
        Mon, 20 Sep 2021 20:29:51 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:2c03:4c32:d511:41a6? ([2601:647:4000:d7:2c03:4c32:d511:41a6])
        by smtp.gmail.com with ESMTPSA id p189sm15517685pfp.167.2021.09.20.20.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 20:29:50 -0700 (PDT)
Message-ID: <cc552293-f203-5d0a-b39b-94502bb1ec16@acm.org>
Date:   Mon, 20 Sep 2021 20:29:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 4/4] block: keep q_usage_counter in atomic mode after
 del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
 <20210920112405.1299667-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20210920112405.1299667-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 04:24, Christoph Hellwig wrote:
> Don't switch back to percpu mode to avoid the double RCU grace period
> when tearing down SCSI devices.  After removing the disk only passthrough
> commands can be send anyway.
                   ^^^^
                   sent?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 108a352051be5..bc026372de439 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -188,9 +188,11 @@ void blk_mq_freeze_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
>   
> -void blk_mq_unfreeze_queue(struct request_queue *q)
> +void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
>   {
>   	mutex_lock(&q->mq_freeze_lock);
> +	if (force_atomic)
> +		q->q_usage_counter.data->force_atomic = true;
>   	q->mq_freeze_depth--;
>   	WARN_ON_ONCE(q->mq_freeze_depth < 0);
>   	if (!q->mq_freeze_depth) {
> @@ -199,6 +201,11 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
>   	}
>   	mutex_unlock(&q->mq_freeze_lock);
>   }
> +
> +void blk_mq_unfreeze_queue(struct request_queue *q)
> +{
> +	__blk_mq_unfreeze_queue(q, false);
> +}
>   EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>   
>   /*
> diff --git a/block/blk.h b/block/blk.h
> index e2ed2257709ae..6c3c00a8fe19d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>   void blk_free_flush_queue(struct blk_flush_queue *q);
>   
>   void blk_freeze_queue(struct request_queue *q);
> +void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
>   void blk_queue_start_drain(struct request_queue *q);
>   
>   #define BIO_INLINE_VECS 4
> diff --git a/block/genhd.c b/block/genhd.c
> index b3c33495d7208..fe23085ddddd6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -596,6 +596,7 @@ void del_gendisk(struct gendisk *disk)
>   	/*
>   	 * Allow using passthrough request again after the queue is torn down.
>   	 */
> +	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
>   	blk_mq_unfreeze_queue(q);
>   
>   	if (!(disk->flags & GENHD_FL_HIDDEN)) {

I don't see any code that passes 'true' as second argument to
__blk_mq_unfreeze_queue()? Did I perhaps overlook something?

Thanks,

Bart.


