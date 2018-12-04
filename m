Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5A9C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585582081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585582081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeLDOtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:49:22 -0500
Received: from verein.lst.de ([213.95.11.211]:44200 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeLDOtW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 09:49:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4FF1668BDB; Tue,  4 Dec 2018 15:49:21 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:49:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 10/27] aio: don't zero entire aio_kiocb aio_get_req()
Message-ID: <20181204144921.GE3180@lst.de>
References: <20181130165646.27341-1-axboe@kernel.dk> <20181130165646.27341-11-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130165646.27341-11-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
> -	if (unlikely(!req))
> -		return NULL;
> +	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
> +	if (req) {
> +		percpu_ref_get(&ctx->reqs);
> +		req->ki_ctx = ctx;
> +		INIT_LIST_HEAD(&req->ki_list);
> +		refcount_set(&req->ki_refcnt, 0);
> +		req->ki_eventfd = NULL;
> +	}
>  
> -	percpu_ref_get(&ctx->reqs);
> -	INIT_LIST_HEAD(&req->ki_list);
> -	refcount_set(&req->ki_refcnt, 0);
> -	req->ki_ctx = ctx;
>  	return req;

Why the reformatting?  Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
