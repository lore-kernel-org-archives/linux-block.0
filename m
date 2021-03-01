Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A673C433E9
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 06:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3E964E3F
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 06:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhCAGwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 01:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232152AbhCAGwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Mar 2021 01:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614581440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49QSumwav2iW/xdgtQu1miKSHvtVHTnlz4uRBIv8XYQ=;
        b=I/23bbUBcK1NjGc+0qrL/lkaypbsTBU9g9Nq4K1bsFm0k2qGcCIsCIhjIFNnk8TgaE7rb4
        nBMnu9pGf2vzoB3S5ehm60Z/dCy2WlDDMF+jWCWzBrBqeY/ZLrUl+JA1Q17lQRK25e7yog
        egBa57bz/Y0i5bF+GCL4cltIAEFc3Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-aUu96j9mOLy9TLUq2GnwVQ-1; Mon, 01 Mar 2021 01:50:32 -0500
X-MC-Unique: aUu96j9mOLy9TLUq2GnwVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D7C801965;
        Mon,  1 Mar 2021 06:50:31 +0000 (UTC)
Received: from T590 (ovpn-13-234.pek2.redhat.com [10.72.13.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E59360C43;
        Mon,  1 Mar 2021 06:50:23 +0000 (UTC)
Date:   Mon, 1 Mar 2021 14:50:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, josef@toxicpanda.com,
        hch@lst.de, bvanassche@acm.org
Subject: Re: [RFC PATCH 2/2] blk-mq: blk_mq_tag_to_rq() always return null
 for sched_tags
Message-ID: <YDyOq0eVr35h0GNK@T590>
References: <20210301021444.4134047-1-yuyufen@huawei.com>
 <20210301021444.4134047-3-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301021444.4134047-3-yuyufen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 28, 2021 at 09:14:44PM -0500, Yufen Yu wrote:
> We just set hctx->tags->rqs[tag] when get driver tag, but will
> not set hctx->sched_tags->rqs[tag] when get sched tag.
> So, blk_mq_tag_to_rq() always return NULL for sched_tags.

True, also blk_mq_tag_to_rq() seems an awkward API, and it needs
'struct blk_mq_tags *', but which is a block layer internal definition.

> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/blk-mq.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5362a7958b74..424afe112b58 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -846,6 +846,7 @@ static int blk_mq_test_tag_bit(struct blk_mq_tags *tags, unsigned int tag)
>  
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>  {
> +	/* if tags is hctx->sched_tags, it always return NULL */
>  	if (tag < tags->nr_tags && blk_mq_test_tag_bit(tags, tag)) {
>  		prefetch(tags->rqs[tag]);
>  		return tags->rqs[tag];
> @@ -3845,17 +3846,8 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>  
>  	if (!blk_qc_t_is_internal(cookie))
>  		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
> -	else {
> -		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
> -		/*
> -		 * With scheduling, if the request has completed, we'll
> -		 * get a NULL return here, as we clear the sched tag when
> -		 * that happens. The request still remains valid, like always,
> -		 * so we should be safe with just the NULL check.
> -		 */
> -		if (!rq)
> -			return false;
> -	}
> +	else
> +		return false;
>  

I think the correct fix is to retrieve the request via:

	hctx->sched_tags->static_rqs[blk_qc_t_to_tag(cookie)]

since it is nice to run blk_mq_poll_hybrid_sleep() for one
non-started request in case of real scheduler.

-- 
Ming

