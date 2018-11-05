Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.gydle.com ([64.18.173.180]:51115 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeKFAdD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Nov 2018 19:33:03 -0500
Subject: Re: [PATCH v2 1/7] lightnvm: pblk: fix resubmission of overwritten
 write err lbas
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
 <20181105122610.1555-2-hans.ml.holmberg@owltronix.com>
From: Sebastien Boisvert <sboisvert@gydle.com>
Message-ID: <de7235bc-e458-381d-442e-11b42dd20dc9@gydle.com>
Date: Mon, 5 Nov 2018 10:12:51 -0500
MIME-Version: 1.0
In-Reply-To: <20181105122610.1555-2-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2018-11-05 7:26 a.m., Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Make sure we only look up valid lba addresses on the resubmission path.
> 
> If an lba is invalidated in the write buffer, that sector will be
> submitted to disk(as it is already mapped to a ppa), and that write

submitted to disk(as it is already mapped to a ppa), and that write
                 ^
                 add a space

> might fail, resulting in a crash when trying to look up the lba in the
> mapping table (as the lba is marked as invalid).
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index fa8726493b39..3ddd16f47106 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
>  		w_ctx = &entry->w_ctx;
>  
>  		/* Check if the lba has been overwritten */
> -		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> -		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> -			w_ctx->lba = ADDR_EMPTY;
> +		if (w_ctx->lba != ADDR_EMPTY) {
> +			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
> +			if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
> +				w_ctx->lba = ADDR_EMPTY;
> +		}

Was w_ctx->lba set to ADDR_EMPTY in the same kernel I/O thread ?

I wonder if w_ctx->lba could become ADDR_EMPTY after 

		if (w_ctx->lba != ADDR_EMPTY) {

but before

			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);


>  
>  		/* Mark up the entry as submittable again */
>  		flags = READ_ONCE(w_ctx->flags);
> 
