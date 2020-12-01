Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B28C63777
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DBA20857
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adLgcxmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgLACLa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgLACL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 21:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606788601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9yqkeagiwWUX6i1ZL2g3fEa1Nr+b6dYnQRiS0J8QY4=;
        b=adLgcxmCD0LEnYv2Z42O1Ufglc0c6m5kUvaxcegBVxdwohQ/EBm/mq+aXDLPd2GrVgOp84
        9iAb43Ot9y6CEBahK4dpQJg/LNs0F0Hry2S4Bo46434tBIT3/U+abx6KQm1Shon/IbQ8VX
        YHDLbLj+UlDJ/XuQPaw2xvVMVkZddPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-mHdQwyL4OICAMBU4Q-OgNg-1; Mon, 30 Nov 2020 21:09:59 -0500
X-MC-Unique: mHdQwyL4OICAMBU4Q-OgNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0194A1823E41;
        Tue,  1 Dec 2020 02:09:58 +0000 (UTC)
Received: from T590 (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE4260873;
        Tue,  1 Dec 2020 02:09:48 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:09:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
Message-ID: <20201201020944.GA257374@T590>
References: <20201130101921.52754-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130101921.52754-1-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 30, 2020 at 11:19:21AM +0100, Daniel Wagner wrote:
> It's guaranteed that no request is in flight when a hctx is going
> offline. This warning is only triggered when the wq's CPU is hot
> plugged and the blk-mq is not synced up yet.
> 
> As this state is temporary and the request is still processed
> correctly, better remove the warning as this is the fast path.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> v2:
>   - remove the warning as suggested by Ming
> v1:
>   - initial version
>     https://lore.kernel.org/linux-block/20201126095152.19151-1-dwagner@suse.de/
> 
>  block/blk-mq.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..7e6761804f86 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1495,31 +1495,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
>  	int srcu_idx;
>  
> -	/*
> -	 * We should be running this queue from one of the CPUs that
> -	 * are mapped to it.
> -	 *
> -	 * There are at least two related races now between setting
> -	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
> -	 * __blk_mq_run_hw_queue():
> -	 *
> -	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes online, then this warning is harmless
> -	 *   at all
> -	 *
> -	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes offline, then the warning can't be
> -	 *   triggered, and we depend on blk-mq timeout handler to
> -	 *   handle dispatched requests to this hctx
> -	 */
> -	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> -		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> -		dump_stack();
> -	}
> -
>  	/*
>  	 * We can't run the queue inline with ints disabled. Ensure that
>  	 * we catch bad users of this early.
> -- 
> 2.16.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

