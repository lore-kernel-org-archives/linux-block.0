Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8165C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D0764EDD
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 23:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhBXXYz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236301AbhBXXYi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 18:24:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F76B64EDD;
        Wed, 24 Feb 2021 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614209037;
        bh=d1HjoFSwALNOCgxoy3Gj0o/rGxI+qCbB7C4aRHFnwXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlLrnA/yz5VbyLmxR+wP4AzUY1QlG2t/pyRS+6D0hLtp2RyQ5R034ykOX8cMUuHeU
         gzGdFRK+b5RaJp7Dnp3EUdrAXz6QlSnEYZBfhpx6KFbewGz9wruJA2JdsYxn8Ai5Dt
         cW0WqEIzudUNTvKCdRnVDKt/Kdy3OM4zzWg85buNA/tAItfgUII9aaxAkc5u6EQXkS
         w/UAWyIKzRy3Oi6P7DdxoANMeaDdR9BwAzwLuGPb5Cxa2ABOJFmFYD0PK4V9izSrS0
         +Jj6B9MerchGSK/bcb2Elj/jsZYHsGiu0XQdMt+PbH2t79iMeqMmyJlYkfR7UFHFkQ
         fcN5y2cKq+ZDg==
Date:   Wed, 24 Feb 2021 15:23:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block-crypto-fallback: use a bio_set for splitting
 bios
Message-ID: <YDbgDCHqUiLxUp1w@sol.localdomain>
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

"argumen" => "argument"
"could to" => "could lead to"

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

Something like "blk_crypto_bioset" might be a better name, since the other
variables above are prefixed with "blk_crypto".

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

Anyway, this works.  Feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
