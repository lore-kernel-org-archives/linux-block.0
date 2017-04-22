Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33216 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043567AbdDVI5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Apr 2017 04:57:50 -0400
Received: by mail-lf0-f50.google.com with SMTP id 88so54402822lfr.0
        for <linux-block@vger.kernel.org>; Sat, 22 Apr 2017 01:57:50 -0700 (PDT)
Subject: Re: [PATCH 3/5] lightnvm: pblk: fix memory leak on error path
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-4-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <60b7abb8-6c99-5844-56c6-41dce14e8297@lightnvm.io>
Date: Sat, 22 Apr 2017 10:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <1492817569-13532-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/22/2017 01:32 AM, Javier González wrote:
> When write recovery fails, Free memory for the recovery structure.
>
> Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-write.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 74f7413..a896190 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -142,6 +142,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
>  		/* Logic error */
>  		if (bit > c_ctx->nr_valid) {
>  			WARN_ONCE(1, "pblk: corrupted write request\n");
> +			mempool_free(recovery, pblk->rec_pool);
>  			goto out;
>  		}
>
> @@ -149,6 +150,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
>  		entry = pblk_rb_sync_scan_entry(&pblk->rwb, &ppa);
>  		if (!entry) {
>  			pr_err("pblk: could not scan entry on write failure\n");
> +			mempool_free(recovery, pblk->rec_pool);
>  			goto out;
>  		}
>
> @@ -162,6 +164,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
>  	ret = pblk_recov_setup_rq(pblk, c_ctx, recovery, comp_bits, c_entries);
>  	if (ret) {
>  		pr_err("pblk: could not recover from write failure\n");
> +		mempool_free(recovery, pblk->rec_pool);
>  		goto out;
>  	}
>
>
Reviewed-by: Matias Bjørling <matias@cnexlabs.com>
