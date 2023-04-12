Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2694C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 09:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDLJOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDLJOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 05:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138D1726
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681290798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CmrZp+McxeCtLepLs2mywEi6XcHgg4EuUSv2GMqNTtA=;
        b=N5atUv66n80tUAAc6BVvJpDpYC8Cb2oWyu8QbAyhGNgV41DGGmeqSWD9XeuDTIKQ/jZwpp
        uwZheG4OW5IVHGBybJ6/uaj6/C8sY7LuDLF57/ycqhdoJ6NQQ37NTjpbqSgnH14RSPNt7f
        MK1WdllvaTfkEGuN6br2IPaZxEWI/aE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-UDlgIgiaO9-k9l-HEEXHHw-1; Wed, 12 Apr 2023 05:13:15 -0400
X-MC-Unique: UDlgIgiaO9-k9l-HEEXHHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06E15811E7C;
        Wed, 12 Apr 2023 09:13:15 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C26F1492C3E;
        Wed, 12 Apr 2023 09:13:10 +0000 (UTC)
Date:   Wed, 12 Apr 2023 17:13:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] blk-mq: call blk_mq_hctx_stopped in
 __blk_mq_run_hw_queue
Message-ID: <ZDZ2Ibe7AtvgrtdE@ovpn-8-21.pek2.redhat.com>
References: <20230412063743.618957-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412063743.618957-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 08:37:42AM +0200, Christoph Hellwig wrote:
> Instead of calling blk_mq_hctx_stopped in both callers, move it right
> next to the dispatching.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 03c6fa4afcdb91..cdf1d5ca04bba2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2150,6 +2150,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	WARN_ON_ONCE(in_interrupt());
>  
> +	if (blk_mq_hctx_stopped(hctx))
> +		return;
>  	blk_mq_run_dispatch_ops(hctx->queue,
>  			blk_mq_sched_dispatch_requests(hctx));

The above new check isn't needed actually, since blk_mq_sched_dispatch_requests()
does check it with rcu read lock held, which should be more reliable.  

Thanks,
Ming

