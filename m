Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44670 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeDQMEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 08:04:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id l12so2676098pgp.11
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 05:04:12 -0700 (PDT)
Subject: Re: [PATCH 03/11] lightnvm: pblk: check read lba on gc path
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-4-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f41f6858-77d1-5856-0719-a765251f5679@lightnvm.io>
Date: Tue, 17 Apr 2018 14:03:52 +0200
MIME-Version: 1.0
In-Reply-To: <1523874332-6272-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 4/16/18 12:25 PM, Javier González wrote:
> Check that the lba stored in the LBA metadata is correct in the GC path
> too. This requires a new helper function to check random reads in the
> vector read.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-read.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 9eee10f69df0..0d45d4ffc370 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -113,15 +113,14 @@ static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
>   	return NVM_IO_OK;
>   }
>   
> -static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
> -			   sector_t blba)
> +static void pblk_read_check_seq(struct pblk *pblk, void *meta_list,
> +				sector_t blba, int nr_lbas)
>   {
> -	struct pblk_sec_meta *meta_list = rqd->meta_list;
> -	int nr_lbas = rqd->nr_ppas;
> +	struct pblk_sec_meta *meta_lba_list = meta_list;
>   	int i;
>   
>   	for (i = 0; i < nr_lbas; i++) {
> -		u64 lba = le64_to_cpu(meta_list[i].lba);
> +		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
>   
>   		if (lba == ADDR_EMPTY)
>   			continue;
> @@ -130,6 +129,32 @@ static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
>   	}
>   }
>   
> +/*
> + * There can be wholes in the lba list.
> + */

holes

> +static void pblk_read_check_rand(struct pblk *pblk, void *meta_list,
> +				u64 *lba_list, int nr_lbas)
> +{
> +	struct pblk_sec_meta *meta_lba_list = meta_list;
> +	int i, j;
> +
> +	for (i = 0, j = 0; i < nr_lbas; i++) {
> +		u64 lba = lba_list[i];
> +		u64 meta_lba;
> +
> +		if (lba == ADDR_EMPTY)
> +			continue;
> +
> +		meta_lba = le64_to_cpu(meta_lba_list[j++].lba);

You can move the j++ into the for loop. Although, why not use just the i 
iterator?

> +
> +		if (lba != meta_lba) {
> +			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
> +								lba, meta_lba);
> +			WARN_ON(1);

I don't understand this, if a corrupted LBA is found here, how is it 
communicated back to pblk and the LBA can be recovered from elsewhere. 
If the data is wrong, this should have been communicated by the drive on 
the completion path. The drive is defect if this happens.


> +		}
> +	}
> +}
> +
>   static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
>   {
>   	struct ppa_addr *ppa_list;
> @@ -172,7 +197,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
>   		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
>   #endif
>   
> -	pblk_read_check(pblk, rqd, r_ctx->lba);
> +	pblk_read_check_seq(pblk, rqd->meta_list, r_ctx->lba, rqd->nr_ppas);
>   
>   	bio_put(bio);
>   	if (r_ctx->private)
> @@ -585,6 +610,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   		goto err_free_bio;
>   	}
>   
> +	pblk_read_check_rand(pblk, rqd.meta_list, gc_rq->lba_list, rqd.nr_ppas);
> +
>   	atomic_dec(&pblk->inflight_io);
>   
>   	if (rqd.error) {
> 
