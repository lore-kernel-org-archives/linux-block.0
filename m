Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B69C43463
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCEE2137B
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwJ7dusR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQW0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQW0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 18:26:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18FC06174A
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:26:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so2124860pfc.7
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q77gUSamNF92wlJ+lR4GPQtw23AEZMyMYEOoR6N4qAA=;
        b=bwJ7dusRdoaGoe73/6PvH1xWcDBr9oe6pV9ceE97DlYZVpQrDnvIVP8VUp9gLRz5xw
         Gowkk+P9HLv5hrDpz+RwygwAKBAV+5ixzvVCMb0ExJBq+LTa1jBnbl7Cgs0EF9PCH7Sq
         1bMOslpKFSXif/oJJehVHIZhX2M5oGeWLUw0k7cusm6FPXqHDRpgbG5iM7PwFTW/XrGE
         tFTH+R70V6sAE/vl8shVNLpFQgUBZeWV40qHcvRaY1AHBXCszdJslS3w2Hg0pe0I4fVW
         yYfvHBFT51ftNXIvAiBaKQ79MmUNVHI6kd9pY1G0TJQCKFRKyed9tMECspszouLpF2dy
         C7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q77gUSamNF92wlJ+lR4GPQtw23AEZMyMYEOoR6N4qAA=;
        b=gAyEm288YDwHAHofM7xojKuW138tAWYSrpMgPebNBjOnmvmDmdW2ElBov4ujA26Wzj
         541jzirFicthsAnuzEc8PNaiUC1ojS1ikJFweI7m8zFiX6HeUelGcpi4yAcESZWo4JpJ
         43QH8Z5M1nuUC0AUQd8fKZYB6F1MuA0erkUoW8GYdekcPnpgGVm1wtHQzouTzYAoHZpw
         A+de/ZD26yKpYOiZNxGxkUvdMVu8MSAQi2LPbEUBWqXDfr0gHvBtz7wEDEj7ETpiP1h4
         l/wdwOCrVQdvch3FGnwq3CKvThqOfXGHa4jNZgJFa8q2Ml4b/000D8AZEsyPjSFuE9l+
         btBQ==
X-Gm-Message-State: AOAM532n+6thJDHEMQjpfxksIq2GXzgCwa3cFQHKwQqKd4x/Q4/UoM1i
        Jrd4zeAWHHk2jIge6axLUeBTiA==
X-Google-Smtp-Source: ABdhPJydTfNwtlMrd82NIkSVsPt/owVM7ehmZAjCmZBjvbBuEggXWuRHybUb74uWQNjYQwGD4UeW5Q==
X-Received: by 2002:a63:5952:: with SMTP id j18mr25156407pgm.317.1600381570500;
        Thu, 17 Sep 2020 15:26:10 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id b10sm616516pgm.64.2020.09.17.15.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:26:10 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:26:06 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v2 3/3] block: warn if !__GFP_DIRECT_RECLAIM in
 bio_crypt_set_ctx()
Message-ID: <20200917222606.GC421296@google.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200916035315.34046-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:15PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> bio_crypt_set_ctx() assumes its gfp_mask argument always includes
> __GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.
> 
> For now this assumption is still fine, since no callers violate it.
> Making bio_crypt_set_ctx() able to fail would add unneeded complexity.
> 
> However, if a caller didn't use __GFP_DIRECT_RECLAIM, it would be very
> hard to notice the bug.  Make it easier by adding a WARN_ON_ONCE().
> 
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-crypto.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index bbe7974fd74f0..5da43f0973b46 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -81,7 +81,15 @@ subsys_initcall(bio_crypt_ctx_init);
>  void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
>  		       const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE], gfp_t gfp_mask)
>  {
> -	struct bio_crypt_ctx *bc = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +	struct bio_crypt_ctx *bc;
> +
> +	/*
> +	 * The caller must use a gfp_mask that contains __GFP_DIRECT_RECLAIM so
> +	 * that the mempool_alloc() can't fail.
> +	 */
> +	WARN_ON_ONCE(!(gfp_mask & __GFP_DIRECT_RECLAIM));
> +
> +	bc = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
>  
>  	bc->bc_key = key;
>  	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
> -- 
Looks good!

Reviewed-by: Satya Tangirala <satyat@google.com>

> 2.28.0
> 
