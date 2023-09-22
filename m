Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F4CD4F32
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIVIhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjIVIhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 04:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5B83
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695371792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DE04X5myYMSLSbdgQN2mttrC5Y+H9uzrXqGU6HwjJk=;
        b=YA+Sf8rSqXygbt8P81dvJ9gRXBFmC0d8RU6WpqOGeQfhfaBDH2SUADMSCeoU6HYEj0FyI4
        HbG1I+7IwGCMI5y+MeHUZLiBZe7IK4flc77MtcaW+mdY64mEkXbGRuVBpIVp4kz68iliEo
        4h/8pQ2shrHb13WyooP1KgHZReXQBwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-MI0UDQcpOEeUFOOzE94Bgg-1; Fri, 22 Sep 2023 04:36:28 -0400
X-MC-Unique: MI0UDQcpOEeUFOOzE94Bgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 380EA802C1A;
        Fri, 22 Sep 2023 08:36:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4B7B140E950;
        Fri, 22 Sep 2023 08:36:20 +0000 (UTC)
Date:   Fri, 22 Sep 2023 16:36:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 3/5] blk-mq: support batched queue_rqs() on shared
 tags queue
Message-ID: <ZQ1SANMNrEK80lbN@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-4-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:14PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since active requests have been accounted when allocate driver tags,
> we can remove this limit now.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-mq.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c209a7dddee3..68ce9357463b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2781,13 +2781,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  		 * If we do, we can dispatch the whole plug list in one go. We
>  		 * already know at this point that all requests belong to the
>  		 * same queue, caller must ensure that's the case.
> -		 *
> -		 * Since we pass off the full list to the driver at this point,
> -		 * we do not increment the active request count for the queue.
> -		 * Bypass shared tags for now because of that.
>  		 */
> -		if (q->mq_ops->queue_rqs &&
> -		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> +		if (q->mq_ops->queue_rqs) {
>  			blk_mq_run_dispatch_ops(q,
>  				__blk_mq_flush_plug_list(q, plug));
>  			if (rq_list_empty(plug->mq_list))

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

