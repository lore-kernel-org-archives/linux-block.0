Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.gydle.com ([64.18.173.180]:51398 "EHLO mail.gydle.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeKFAvn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Nov 2018 19:51:43 -0500
Subject: Re: [PATCH v2 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
 <20181105122610.1555-8-hans.ml.holmberg@owltronix.com>
From: Sebastien Boisvert <sboisvert@gydle.com>
Message-ID: <844bd112-b9be-f63d-dfb1-42763fa83f0d@gydle.com>
Date: Mon, 5 Nov 2018 10:31:27 -0500
MIME-Version: 1.0
In-Reply-To: <20181105122610.1555-8-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2018-11-05 7:26 a.m., Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Remove the call to pblk_line_replace_data as it returns
> directly as we have not set l_mg->data_next yet.

You have the word "as" twice. Replace the second with "because".

> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-recovery.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 0fbd30e0a587..416d9840544b 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -805,7 +805,6 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>  		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>  							&l_mg->meta_bitmap));
>  		spin_unlock(&l_mg->free_lock);
> -		pblk_line_replace_data(pblk);
>  	} else {
>  		spin_lock(&l_mg->free_lock);
>  		/* Allocate next line for preparation */
> 
