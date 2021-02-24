Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BEBC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B12664EDD
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBXQT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhBXQSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 11:18:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7084C06174A
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 08:18:01 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o63so1763468pgo.6
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 08:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6SMl7YNZsmvK/aF/c7nlIU3CbdvEkELxTZD1sUqprao=;
        b=Icer9pgQL32zGARA/IPysACm8QgmuZsVE1RS1z7z7e60fTmNv2a11V+FP31+K3D7Of
         8f53la3BDuq4QQ6YdfGlYZtIIsAlVo4ivtIQORssmE7Bcf0u66fWb0wrUNSQduvWHKDJ
         Jjs+8KA/Qh5YqPFP8Vl7WdqLIfclDMer72PN6NRFcEsRE0grMnYo0tx2VBmwFmGxHWey
         JX0c+FnQdtNPBOgcHNccDXmEt9Ir5PryN0EEgfEoIsIMO9ihScfxJE2LmwiYXnxxm21B
         KLMywvvG4E2KmcrMkOWX9G65F9ydiB05Wbi5Q5knQjiK6XxCeorYYAw+DKPVHtsq10XJ
         KTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SMl7YNZsmvK/aF/c7nlIU3CbdvEkELxTZD1sUqprao=;
        b=mfvVyoaTcgryDcKQZ71s+N47K4aIDMoin9MxyaACzv8q3rX2LDTOWwbJPjZWjKzIS7
         Y+yzIG5MFhj47ZBJL/5Yr3bS6Uk1mEGKMMj5MdeLF+PvHKJsvHgZ+QLgzkJrqcTJ2q0F
         skuHJHMd7kKjumKM8EmEM+aIQEuNOiWgqwlCw3MpxwE15ZMfoAKp60mXyDFTFXaI88L7
         OJBnh/nU1PkeHnKbErxjJbTK8dtEGKsGFdpw4/jy9YLEArKbt1RVmmPUfkVmQudab4op
         rGSEl3gyPvJiIpt+31Swo94CGcYfLJFZWYLai7SR/6hcl1C6IvvZZSIlS4Mj6X86Cwrc
         jCjA==
X-Gm-Message-State: AOAM533OugxcYVepBCrDyKaUGeeKWbcykHsttl2zgnjIOMImLeNe03yd
        lfK00h/NPCl2S/jqXNdDqYi/YQ==
X-Google-Smtp-Source: ABdhPJynkz2gQwEvusUSHTcDUm0j9vwCQXrNpP6duSaCKet7GMe/Vzisc6UkroGA6hjlB/15t4jyXg==
X-Received: by 2002:a63:c901:: with SMTP id o1mr5707856pgg.232.1614183481269;
        Wed, 24 Feb 2021 08:18:01 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id s62sm3474838pfb.148.2021.02.24.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:18:00 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:17:57 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block-crypto-fallback: use a bio_set for splitting
 bios
Message-ID: <YDZ8NbfYf2wDSg5T@google.com>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224072407.46363-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 08:24:04AM +0100, Christoph Hellwig wrote:
> bio_split with a NULL bs argumen used to fall back to kmalloc the
> bio, which does not guarantee forward progress and could to deadlocks.
> Now that the overloading of the NULL bs argument to bio_alloc_bioset
> has been removed it crashes instead.  Fix all that by using a special
> crafted bioset.
> 
> Fixes: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---
>  block/blk-crypto-fallback.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index e8327c50d7c9f4..c176b7af56a7a5 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -80,6 +80,7 @@ static struct blk_crypto_keyslot {
>  static struct blk_keyslot_manager blk_crypto_ksm;
>  static struct workqueue_struct *blk_crypto_wq;
>  static mempool_t *blk_crypto_bounce_page_pool;
> +static struct bio_set crypto_bio_split;
>  
>  /*
>   * This is the key we set when evicting a keyslot. This *should* be the all 0's
> @@ -224,7 +225,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
>  	if (num_sectors < bio_sectors(bio)) {
>  		struct bio *split_bio;
>  
> -		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
> +		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
> +				      &crypto_bio_split);
>  		if (!split_bio) {
>  			bio->bi_status = BLK_STS_RESOURCE;
>  			return false;
> @@ -538,9 +540,13 @@ static int blk_crypto_fallback_init(void)
>  
>  	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
>  
> -	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
> +	err = bioset_init(&crypto_bio_split, 64, 0, 0);
>  	if (err)
>  		goto out;
> +
> +	err = blk_ksm_init(&blk_crypto_ksm, blk_crypto_num_keyslots);
> +	if (err)
> +		goto fail_free_bioset;
>  	err = -ENOMEM;
>  
>  	blk_crypto_ksm.ksm_ll_ops = blk_crypto_ksm_ll_ops;
> @@ -591,6 +597,8 @@ static int blk_crypto_fallback_init(void)
>  	destroy_workqueue(blk_crypto_wq);
>  fail_free_ksm:
>  	blk_ksm_destroy(&blk_crypto_ksm);
> +fail_free_bioset:
> +	bioset_exit(&crypto_bio_split);
>  out:
>  	return err;
>  }
> -- 
> 2.29.2
> 
Thanks for fixing this! If needed, feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
