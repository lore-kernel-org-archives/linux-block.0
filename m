Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53BC4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B1D60E98
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGWQc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGWQc5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:32:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6566D60EAF;
        Fri, 23 Jul 2021 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627060410;
        bh=2VYOvdLPz0wCDA2UPL7umAdWrABmYwHgrszriT+XD44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAqCMo3RXdkXXFegmieatPGCUCJWvQzLKS2m2ifIG5NjK8yInV5Y4sA4/nwBAtaWF
         uPbyTCl07V+sSq88bJwhkYeq9eAS8kbzQkgbq980eCqxO45l/4zs3s3DHSFmXoeUJq
         YIbh01H/E/8z53VBaD5YekJlDmF7SEWNoMuugb2M9Zv1CdDD+MFir1dWKugLgFt+Ws
         u3Kzwqn31hrAu89sIo+CEO5a3ZRB5oMWXnXAjQEBl+cMr3kBCBCZJYJyzO9pwcDJC4
         +3ToJfx+KvU89i/QA0sXsLS1mwvAVOV7dMRBenLhmbYDI29dzNXUQorAzbNVMg33EG
         BlQ9xO8Y9mKPg==
Date:   Fri, 23 Jul 2021 10:13:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 5/9] ufshcd: handle error from blk_ksm_register()
Message-ID: <YPr4ubrFPQ1Pd5mE@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-6-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-6-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:39PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> Handle any error from blk_ksm_register() in the callers. Previously,
> the callers ignored the return value because blk_ksm_register() wouldn't
> fail as long as the request_queue didn't have integrity support too, but
> as this is no longer the case, it's safer for the callers to just handle
> the return value appropriately.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index d70cdcd35e43..0fcf9d6752f8 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -233,6 +233,15 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
>  void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>  					    struct request_queue *q)
>  {
> -	if (hba->caps & UFSHCD_CAP_CRYPTO)
> -		blk_ksm_register(&hba->ksm, q);
> +	if (hba->caps & UFSHCD_CAP_CRYPTO) {
> +		/*
> +		 * This WARN_ON should never trigger since &hba->ksm won't be
> +		 * "empty" (i.e. will support at least 1 crypto capability), a
> +		 * UFS device's request queue doesn't support integrity, and
> +		 * it also satisfies all the block layer constraints (i.e.
> +		 * supports SG gaps, doesn't have chunk sectors, has a
> +		 * sufficiently large supported max_segments per bio)
> +		 */
> +		WARN_ON(!blk_ksm_register(&hba->ksm, q));
> +	}

I guess this looks okay, but I think the comment should be a bit more concise
and not so tied to the current implementation details, like:

                /*
                 * This WARN_ON should never trigger since at least one of the
                 * declared crypto capabilities should be compatible with the
                 * UFS device, otherwise the UFS host driver shouldn't have
                 * declared crypto support at all.
                 */

Likewise for the similar MMC crypto patch.

- Eric
