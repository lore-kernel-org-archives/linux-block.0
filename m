Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01210C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D1B2075A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbgE0SR2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:17:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388827AbgE0SR2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFBB5AEB9;
        Wed, 27 May 2020 18:17:28 +0000 (UTC)
Subject: Re: [PATCH 4/8] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <491050c7-0ef8-9bd7-90ad-6ed152487d1d@suse.de>
Date:   Wed, 27 May 2020 20:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> To prepare for wider use of this constant give it a more applicable name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-tag.c | 4 ++--
>   block/blk-mq-tag.h | 4 ++--
>   block/blk-mq.c     | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 586c9d6e904ab..c76ba4f90fa09 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -111,7 +111,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   	if (data->flags & BLK_MQ_REQ_RESERVED) {
>   		if (unlikely(!tags->nr_reserved_tags)) {
>   			WARN_ON_ONCE(1);
> -			return BLK_MQ_TAG_FAIL;
> +			return BLK_MQ_NO_TAG;
>   		}
>   		bt = &tags->breserved_tags;
>   		tag_offset = 0;
> @@ -125,7 +125,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   		goto found_tag;
>   
>   	if (data->flags & BLK_MQ_REQ_NOWAIT)
> -		return BLK_MQ_TAG_FAIL;
> +		return BLK_MQ_NO_TAG;
>   
>   	ws = bt_wait_ptr(bt, data->hctx);
>   	do {
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 2b8321efb6820..8a741752af8b9 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -44,9 +44,9 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>   }
>   
>   enum {
> -	BLK_MQ_TAG_FAIL		= -1U,
> +	BLK_MQ_NO_TAG		= -1U,
>   	BLK_MQ_TAG_MIN		= 1,
> -	BLK_MQ_TAG_MAX		= BLK_MQ_TAG_FAIL - 1,
> +	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
>   };
>   
>   extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1ffbc5d9e7cfe..826ff8f97489c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -386,7 +386,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>   	}
>   
>   	tag = blk_mq_get_tag(data);
> -	if (tag == BLK_MQ_TAG_FAIL) {
> +	if (tag == BLK_MQ_NO_TAG) {
>   		if (clear_ctx_on_error)
>   			data->ctx = NULL;
>   		return NULL;
> 
Hehe.
Thanks.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
