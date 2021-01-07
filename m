Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBBC433DB
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05A222E00
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 06:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhAGGU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbhAGGU6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jan 2021 01:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610000372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNabXbxIK6pdckbdV7DLN3sBeM4CJpbGHDvW/cCcUWM=;
        b=Ze97alUbN2GamsyvDKUxgA5v10C2v00pZbhgz+EdU3mzpGwGv2HIw5saDdWO0XcQphlooP
        s3WSeuB1LJCk6FpQXhoXtnTR/otQK8YBN7iGyjaPd3lMyO+ei6f0xj13zoJeiwdtfiAl/r
        qiC11UOOc2iDA8Gkn/r0xNVJurX8tTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ExT4F3y2MG6yXe2nQpIc9A-1; Thu, 07 Jan 2021 01:19:30 -0500
X-MC-Unique: ExT4F3y2MG6yXe2nQpIc9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265D2800D62;
        Thu,  7 Jan 2021 06:19:29 +0000 (UTC)
Received: from T590 (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 557E519C66;
        Thu,  7 Jan 2021 06:19:22 +0000 (UTC)
Date:   Thu, 7 Jan 2021 14:19:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers
 with multiple HW queues
Message-ID: <20210107061918.GA3897511@T590>
References: <20210106102428.551-1-jack@suse.cz>
 <20210106102428.551-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106102428.551-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 06, 2021 at 11:24:28AM +0100, Jan Kara wrote:
> Currently when non-mq aware IO scheduler (BFQ, mq-deadline) is used for
> a queue with multiple HW queues, the performance it rather bad. The
> problem is that these IO schedulers use queue-wide locking and their
> dispatch function does not respect the hctx it is passed in and returns
> any request it finds appropriate. Thus locality of request access is
> broken and dispatch from multiple CPUs just contends on IO scheduler
> locks. For these IO schedulers there's little point in dispatching from
> multiple CPUs. Instead dispatch always only from a single CPU to limit
> contention.
> 
> Below is a comparison of dbench runs on XFS filesystem where the storage
> is a raid card with 64 HW queues and to it attached a single rotating
> disk. BFQ is used as IO scheduler:
> 
>       clients           MQ                     SQ             MQ-Patched
> Amean 1      39.12 (0.00%)       43.29 * -10.67%*       36.09 *   7.74%*
> Amean 2     128.58 (0.00%)      101.30 *  21.22%*       96.14 *  25.23%*
> Amean 4     577.42 (0.00%)      494.47 *  14.37%*      508.49 *  11.94%*
> Amean 8     610.95 (0.00%)      363.86 *  40.44%*      362.12 *  40.73%*
> Amean 16    391.78 (0.00%)      261.49 *  33.25%*      282.94 *  27.78%*
> Amean 32    324.64 (0.00%)      267.71 *  17.54%*      233.00 *  28.23%*
> Amean 64    295.04 (0.00%)      253.02 *  14.24%*      242.37 *  17.85%*
> Amean 512 10281.61 (0.00%)    10211.16 *   0.69%*    10447.53 *  -1.61%*
> 
> Numbers are times so lower is better. MQ is stock 5.10-rc6 kernel. SQ is
> the same kernel with megaraid_sas.host_tagset_enable=0 so that the card
> advertises just a single HW queue. MQ-Patched is a kernel with this
> patch applied.
> 
> You can see multiple hardware queues heavily hurt performance in
> combination with BFQ. The patch restores the performance.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq.c           | 62 ++++++++++++++++++++++++++++++++++------
>  block/kyber-iosched.c    |  1 +
>  include/linux/elevator.h |  2 ++
>  3 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 57f3482b2c26..26e0f6e64a3a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -63,15 +63,20 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
>  	return bucket;
>  }
>  
> +/* Check if there are requests queued in hctx lists. */
> +static bool blk_mq_hctx_has_queued_rq(struct blk_mq_hw_ctx *hctx)
> +{
> +	return !list_empty_careful(&hctx->dispatch) ||
> +		sbitmap_any_bit_set(&hctx->ctx_map);
> +}
> +

blk_mq_hctx_mark_pending() is only called in case of none scheduler, so
looks not necessary to check hctx->ctx_map in blk_mq_hctx_has_queued_rq()
which is supposed to be used when real io scheduler is attached to MQ queue.


Thanks, 
Ming

