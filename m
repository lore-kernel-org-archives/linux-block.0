Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C1C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFB42087F
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFB42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLDAuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:50:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39763 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDAuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:50:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so12760116oia.6
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0YAT2SXVxQ1iJ7lUUu5S5sONIuNDd1ovz0YxUcP+xs=;
        b=Dtf8c4v7Pyj5KL5o5rJ08GxHXBSTKKJRN/sQpy8HoIysUqRW5zTgAgPCZ0dbfbVVlM
         udkir01H6XYcqubcIS7c4fffT7MS8FyRHpVfAaAkSkeq7ZagRcAhBMDvXjK3rz8HWqaT
         aWbU4CoWpcfuXo2OwvsNWD9/wWBO90BOfpTb91g5PFGqeuN4vlG59w6/6TOhZSUzoPmo
         pj+J4TRBaAXpT2WRDPe9JnZGXeyNRR6q4oL26irrYY81udHrjsu+p3F23PsOicqHL6aG
         PeBn/GrV3kWjrSmQCdoZFQfmHvDS2GgwqQnv6S1pI4dO32ORJ67gKn3BSe4qRzso3VNk
         wIXw==
X-Gm-Message-State: AA+aEWYMLRIczRLHi/7AFUlEbbkAC50/UBfS3ASghxz2XgUPup7X835e
        51TxTr15dlUj13yeBpI2WtemXqfU
X-Google-Smtp-Source: AFSGD/XdmOnShS0owBO+B4yvXCeSyA1WX6LR6cyNmABCu6pd40lZhevo+lyZPG1XlOP/tvsC5lyhJQ==
X-Received: by 2002:aca:2807:: with SMTP id 7mr11522681oix.7.1543884599170;
        Mon, 03 Dec 2018 16:49:59 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p129sm5932758oif.17.2018.12.03.16.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:49:58 -0800 (PST)
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
Date:   Mon, 3 Dec 2018 16:49:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/18 8:46 AM, Christoph Hellwig wrote:
> Having another indirect all in the fast path doesn't really help
> in our post-spectre world.  Also having too many queue type is just
> going to create confusion, so I'd rather manage them centrally.
> 
> Note that the queue type naming and ordering changes a bit - the
> first index now is the default queue for everything not explicitly
> marked, the optional ones are read and poll queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-sysfs.c    |  9 +++++-
>   block/blk-mq.h          | 21 +++++++------
>   drivers/nvme/host/pci.c | 68 +++++++++++++++--------------------------
>   include/linux/blk-mq.h  | 15 ++++-----
>   4 files changed, 51 insertions(+), 62 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 6efef1f679f0..9c2df137256a 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -173,9 +173,16 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
>   	return ret;
>   }
>   
> +static const char *const hctx_types[] = {
> +	[HCTX_TYPE_DEFAULT]	= "default",
> +	[HCTX_TYPE_READ]	= "read",
> +	[HCTX_TYPE_POLL]	= "poll",
> +};
> +
>   static ssize_t blk_mq_hw_sysfs_type_show(struct blk_mq_hw_ctx *hctx, char *page)
>   {
> -	return sprintf(page, "%u\n", hctx->type);
> +	BUILD_BUG_ON(ARRAY_SIZE(hctx_types) != HCTX_MAX_TYPES);
> +	return sprintf(page, "%s\n", hctx_types[hctx->type]);
>   }
>   
>   static struct attribute *default_ctx_attrs[] = {
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 7291e5379358..a664ea44ffd4 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -81,16 +81,14 @@ extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
>   /*
>    * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
>    * @q: request queue
> - * @hctx_type: the hctx type index
> + * @type: the hctx type index
>    * @cpu: CPU
>    */
>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> -							  unsigned int hctx_type,
> +							  enum hctx_type type,
>   							  unsigned int cpu)
>   {
> -	struct blk_mq_tag_set *set = q->tag_set;
> -
> -	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
> +	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
>   }
>   
>   /*
> @@ -103,12 +101,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>   						     unsigned int flags,
>   						     unsigned int cpu)
>   {
> -	int hctx_type = 0;
> +	enum hctx_type type = HCTX_TYPE_DEFAULT;
> +
> +	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
> +	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
> +		type = HCTX_TYPE_POLL;
>   
> -	if (q->mq_ops->rq_flags_to_type)
> -		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
> +	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
> +		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
> +		type = HCTX_TYPE_READ;

Nit, there seems to be an extra newline that can be omitted here before
the else if statement (if I'm reading this correctly)...

Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
