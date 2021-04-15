Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B4C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9186113D
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhDOT1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234859AbhDOT1m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:27:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B40ED61152;
        Thu, 15 Apr 2021 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618514838;
        bh=HYRrEmi7fOFNPZBkFQIEbPMVA5Mg61imnM16h5jqYeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GilKiLJcAiBC2S3okw3J98LUHvn7cozbOHDn48twsQTmDyWlX3eNEveQv0RkCw/rT
         DuCAEI5W2QZ6bJxLfEBGUWHcBWn+LlaadNzFGKjblVH8MujKQzV/PPl5whoH16hzwz
         my7ie8bWB/34TCUsNzkKNhBMcRaOYxFXqB4eXy5ruDp+Y3bfyg0lw6NgGCsHUlA3ee
         G8nqwUbtocvE1Equpnt7sf1HJ9ugAgG8N/QrBmEXKzvVncGj4jHnLf0gWTUwuXHlPS
         QOiz6Mgy4t7q5DwXwALBJ5NxKboOp9Gwo54S+owbZaRLXCjQK61aIEc/uEDHYfUlNS
         OQQJuVeEMoAqA==
Date:   Thu, 15 Apr 2021 12:27:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/8] dm,mmc,ufshcd: handle error from
 blk_ksm_register()
Message-ID: <YHiTlbhb88zmI0n0@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-3-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:03PM +0000, Satya Tangirala wrote:
> Handle any error from blk_ksm_register() in the callers. Previously,
> the callers ignored the return value because blk_ksm_register() wouldn't
> fail as long as the request_queue didn't have integrity support too, but
> as this is no longer the case, it's safer for the callers to just handle
> the return value appropriately.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm-table.c            | 3 ++-
>  drivers/mmc/core/crypto.c        | 6 ++++--
>  drivers/scsi/ufs/ufshcd-crypto.c | 6 ++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)

This probably should be 3 patches, one for each subsystem.

> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index db18a58adad7..1225b9050f29 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1372,7 +1372,8 @@ static void dm_update_keyslot_manager(struct request_queue *q,
>  
>  	/* Make the ksm less restrictive */
>  	if (!q->ksm) {
> -		blk_ksm_register(t->ksm, q);
> +		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
> +			dm_destroy_keyslot_manager(t->ksm);
>  	} else {
>  		blk_ksm_update_capabilities(q->ksm, t->ksm);
>  		dm_destroy_keyslot_manager(t->ksm);
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index 419a368f8402..616103393557 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -21,8 +21,10 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
>  
>  void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
>  {
> -	if (host->caps2 & MMC_CAP2_CRYPTO)
> -		blk_ksm_register(&host->ksm, q);
> +	if (host->caps2 & MMC_CAP2_CRYPTO) {
> +		if (WARN_ON(!blk_ksm_register(&host->ksm, q)))
> +			host->caps2 &= ~MMC_CAP2_CRYPTO;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
>  
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index d70cdcd35e43..f47a72fefe9e 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -233,6 +233,8 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
>  void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>  					    struct request_queue *q)
>  {
> -	if (hba->caps & UFSHCD_CAP_CRYPTO)
> -		blk_ksm_register(&hba->ksm, q);
> +	if (hba->caps & UFSHCD_CAP_CRYPTO) {
> +		if (WARN_ON(!blk_ksm_register(&hba->ksm, q)))
> +			hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +	}

It would be helpful to add a comment in each case to explain why the WARN_ON
should never trigger.

Also, clearing UFSHCD_CAP_CRYPTO or MMC_CAP2_CRYPTO doesn't really make sense
here because those capabilities apply to the whole UFS or MMC host controller,
not just to the individual request_queue which failed.  (A host controller can
control multiple devices, each of which has its own request_queue.)  Isn't
blk_ksm_register() failing already enough to ensure that the inline crypto
support isn't used on that particular request_queue?  What is the benefit of
clearing UFSHCD_CAP_CRYPTO and MMC_CAP2_CRYPTO too?

- Eric
