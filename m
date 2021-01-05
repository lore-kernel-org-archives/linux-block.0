Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AEAC433E6
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2322B4B
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 15:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAEPlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:41:36 -0500
Received: from verein.lst.de ([213.95.11.211]:33582 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbhAEPlf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 10:41:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F3D767373; Tue,  5 Jan 2021 16:40:53 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:40:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/6] block: manage bio slab cache by xarray
Message-ID: <20210105154053.GA21138@lst.de>
References: <20210105124203.3726599-1-ming.lei@redhat.com> <20210105124203.3726599-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105124203.3726599-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	bslab->slab = kmem_cache_create(bslab->name, size,
> +			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
> +	if (!bslab->slab) {
> +		kfree(bslab);
> +		return NULL;
>  	}
>  
> +	bslab->slab_ref = 1;
> +	bslab->slab_size = size;
> +
> +	if (xa_err(xa_store(&bio_slabs, size, bslab, GFP_KERNEL))) {
> +		kmem_cache_destroy(bslab->slab);
> +		kfree(bslab);
> +		return NULL;
>  	}
> +	return bslab;

I'd prefer a label so that the error return and freeing of bslab is
shared between the two error conditions.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
