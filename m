Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF2F2072E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMZfExZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbgFXGuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389354AbgFXGuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:23 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90CC061573
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RHjSpVYGdZjD+HIkmzVyTxtaW+4lB3qT+uwXBXWUER0=; b=cMZfExZ+xh6/162KNUg0gBoWWe
        UxbmBeN66+nlimqOoz1ZGDfe0AJXxTywTev/uK17LcWAq9/89bJafDOd6bfzJmSg/tnE92EVGqzIJ
        RUhHans5Y01BzPvAqAUrSam4m8mTU4VHpNlxlqJ3uVCqlKqd/jPXbOHNYephQjFeGcAMqGJJCTsWg
        /YV7u+mb9jwwOkcyO5WMyBpy60iDOEeUHIdEhIsUEo0KduCX5ywzr/5kg80UDazGwDl6ybB3UWTOh
        B5nhZ+gLC1AS1tzIpM2fTb7BV2pt0xiTPIpg95eujFBmZtCur7zx/pvcYEJclexvVN1dPVunJON/e
        O5Vc3sBA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnzER-0004UD-Dh; Wed, 24 Jun 2020 06:50:03 +0000
Date:   Wed, 24 Jun 2020 07:50:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block; release bip in a right way in error path
Message-ID: <20200624065003.GA15905@infradead.org>
References: <20200623140653.4226-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623140653.4226-1-cgxu519@mykernel.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 10:06:53PM +0800, Chengguang Xu wrote:
> Release bip using kfree() in error path when that was allocated
> by kmalloc().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  block/bio-integrity.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 23632a33ed39..538c8dc8840a 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -78,7 +78,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>  
>  	return bip;
>  err:
> -	mempool_free(bip, &bs->bio_integrity_pool);
> +	if (bs && mempool_initialized(&bs->bio_integrity_pool))
> +		mempool_free(bip, &bs->bio_integrity_pool);
> +	else
> +		kfree(bip);
> +
>  	return ERR_PTR(-ENOMEM);

How about factoring out a __bio_integrity_free helper to not duplicate
this logic?
