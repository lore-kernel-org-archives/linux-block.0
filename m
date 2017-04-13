Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33274 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdDMToX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 15:44:23 -0400
Received: by mail-lf0-f49.google.com with SMTP id h125so34434684lfe.0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2017 12:44:22 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: fix some WARN() messages
To: Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170413193636.GC591@mwanda>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b241f2f9-e5ab-a8b3-c518-c26477d43b1c@lightnvm.io>
Date: Thu, 13 Apr 2017 21:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170413193636.GC591@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/13/2017 09:36 PM, Dan Carpenter wrote:
> WARN_ON() takes a condition, not an error message.  I slightly tweaked
> some conditions so hopefully it's more clear.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index eff0982c076f..bce7ed5fc73f 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -49,8 +49,8 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>  	int i, j = 0;
>
>  	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (!(blba + nr_secs < pblk->rl.nr_secs)) {
> -		WARN_ON("pblk: read lbas out of bounds\n");
> +	if (blba + nr_secs >= pblk->rl.nr_secs) {
> +		WARN(1, "pblk: read lbas out of bounds\n");
>  		return;
>  	}
>
> @@ -254,8 +254,8 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
>  	sector_t lba = pblk_get_lba(bio);
>
>  	/* logic error: lba out-of-bounds. Ignore read request */
> -	if (!(lba < pblk->rl.nr_secs)) {
> -		WARN_ON("pblk: read lba out of bounds\n");
> +	if (lba >= pblk->rl.nr_secs) {
> +		WARN(1, "pblk: read lba out of bounds\n");
>  		return;
>  	}
>
> @@ -411,8 +411,8 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
>  	int valid_secs = 0;
>
>  	/* logic error: lba out-of-bounds */
> -	if (!(lba < pblk->rl.nr_secs)) {
> -		WARN_ON("pblk: read lba out of bounds\n");
> +	if (lba >= pblk->rl.nr_secs) {
> +		WARN(1, "pblk: read lba out of bounds\n");
>  		goto out;
>  	}
>
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 02c415b957d4..56547ca87926 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -141,7 +141,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
>
>  		/* Logic error */
>  		if (bit > c_ctx->nr_valid) {
> -			WARN_ON_ONCE("pblk: corrupted write request\n");
> +			WARN_ONCE(1, "pblk: corrupted write request\n");
>  			goto out;
>  		}
>
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 0d50f415cfde..f8f85087cd3c 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -167,7 +167,7 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
>  		if (le64_to_cpu(lba_list[i]) == ADDR_EMPTY) {
>  			spin_lock(&line->lock);
>  			if (test_and_set_bit(i, line->invalid_bitmap))
> -				WARN_ON_ONCE("pblk: rec. double invalidate:\n");
> +				WARN_ONCE(1, "pblk: rec. double invalidate:\n");
>  			else
>  				line->vsc--;
>  			spin_unlock(&line->lock);
>

Hehe, yep. That was slightly misused. Thanks for pointing it out. I've 
applied it for 4.12.
