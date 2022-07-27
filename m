Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99998C00144
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 02:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiG0CMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiG0CMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 22:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84A3515706
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658887934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9ZiWAR4TTbQzye8TX2kwsdQwgz8TyRW3EiTMyG6y74=;
        b=XFj+JBRAI7qVrqm78Kj5+JI13kXwvcu6sMEU2kUKHwILMdWGmwtZ4UjFlgmeDZ1tdWHszu
        h154LZ7XQvzS1dba/kGI04joleuu5386cmzU6Rib7ggCy8J66uEQv6g1bpwdo+BXb3VdB+
        Oiq44evk9TQiTA/hKYSGASDe5UGSvCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-hOiGpDqfOoikqZbBZ_NLnA-1; Tue, 26 Jul 2022 22:12:08 -0400
X-MC-Unique: hOiGpDqfOoikqZbBZ_NLnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBE7D2803028;
        Wed, 27 Jul 2022 02:12:07 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D29A22026D64;
        Wed, 27 Jul 2022 02:12:03 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:11:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3] blk-mq: fix io hung due to missing commit_rqs
Message-ID: <YuCe7e5KapIqzO0S@T590>
References: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726122224.1790882-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 08:22:24PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, in virtio_scsi, if 'bd->last' is not set to true while
> dispatching request, such io will stay in driver's queue, and driver
> will wait for block layer to dispatch more rqs. However, if block
> layer failed to dispatch more rq, it should trigger commit_rqs to
> inform driver.
> 
> There is a problem in blk_mq_try_issue_list_directly() that commit_rqs
> won't be called:
> 
> // assume that queue_depth is set to 1, list contains two rq
> blk_mq_try_issue_list_directly
>  blk_mq_request_issue_directly
>  // dispatch first rq
>  // last is false
>   __blk_mq_try_issue_directly
>    blk_mq_get_dispatch_budget
>    // succeed to get first budget
>    __blk_mq_issue_directly
>     scsi_queue_rq
>      cmd->flags |= SCMD_LAST
>       virtscsi_queuecommand
>        kick = (sc->flags & SCMD_LAST) != 0
>        // kick is false, first rq won't issue to disk
>  queued++
> 
>  blk_mq_request_issue_directly
>  // dispatch second rq
>   __blk_mq_try_issue_directly
>    blk_mq_get_dispatch_budget
>    // failed to get second budget
>  ret == BLK_STS_RESOURCE
>   blk_mq_request_bypass_insert
>  // errors is still 0
> 
>  if (!list_empty(list) || errors && ...)
>   // won't pass, commit_rqs won't be called
> 
> In this situation, first rq relied on second rq to dispatch, while
> second rq relied on first rq to complete, thus they will both hung.
> 
> Fix the problem by also treat 'BLK_STS_*RESOURCE' as 'errors' since
> it means that request is not queued successfully.
> 
> Same problem exists in blk_mq_dispatch_rq_list(), 'BLK_STS_*RESOURCE'
> can't be treated as 'errors' here, fix the problem by calling
> commit_rqs if queue_rq return 'BLK_STS_*RESOURCE'.
> 
> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v3:
>  - as poinited out by Ming, v2 will break return value by treating
>  BLK_STS_*RESOURCE as errors.
> Changes in v2:
>  - suggested by Ming, handle blk_mq_dispatch_rq_list() as well.
>  - change title and modify commit message.
> 
>  block/blk-mq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 70177ee74295..7d26b222cbc9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1931,7 +1931,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  	/* If we didn't flush the entire list, we could have told the driver
>  	 * there was more coming, but that turned out to be a lie.
>  	 */
> -	if ((!list_empty(list) || errors) && q->mq_ops->commit_rqs && queued)
> +	if ((!list_empty(list) || errors || needs_resource ||
> +	     ret == BLK_STS_DEV_RESOURCE) && q->mq_ops->commit_rqs && queued)

'ret == BLK_STS_DEV_RESOURCE' may happen before, but 'ret' could be
overridden later.

Thanks,
Ming

