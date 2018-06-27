Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15093 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965026AbeF0WSM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 18:18:12 -0400
Subject: Re: [PATCH] lightnvm: pblk: fix read_bitmap for 32bit archs
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        marcin.dziegielewski@intel.com, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180627194206.30384-1-mb@lightnvm.io>
From: Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <c46fb234-a985-02e8-2122-c85e54f97b39@intel.com>
Date: Wed, 27 Jun 2018 15:18:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180627194206.30384-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 27.06.2018 12:42, Matias Bjørling wrote:
> If using pblk on a 32bit architecture, and there is a need to
> perform a partial read, the partial read bitmap will only have
> allocated 32 entries, where as 64 are needed.
> 
> Make sure that the read_bitmap is initialized to 64bits on 32bit
> architectures as well.
> 
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> ---
>   drivers/lightnvm/pblk-read.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 6e93c489ce57..671635275d56 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -401,7 +401,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   	struct pblk_g_ctx *r_ctx;
>   	struct nvm_rq *rqd;
>   	unsigned int bio_init_idx;
> -	unsigned long read_bitmap; /* Max 64 ppas per request */
> +	DECLARE_BITMAP(read_bitmap, 64); /* Max 64 ppas per request */

Probably it would be nicer to use NVM_MAX_VLBA define instead of 
explicit 64.

>   	int ret = NVM_IO_ERR;
>   
>   	/* logic error: lba out-of-bounds. Ignore read request */
> @@ -413,7 +413,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   
>   	generic_start_io_acct(q, READ, bio_sectors(bio), &pblk->disk->part0);
>   
> -	bitmap_zero(&read_bitmap, nr_secs);
> +	bitmap_zero(read_bitmap, nr_secs);
>   
>   	rqd = pblk_alloc_rqd(pblk, PBLK_READ);
>   
> @@ -444,19 +444,19 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>   		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>   
> -		pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
> +		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap >   	} else {
> -		pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
> +		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>   	}
>   
> -	if (bitmap_full(&read_bitmap, nr_secs)) {
> +	if (bitmap_full(read_bitmap, nr_secs)) {
>   		atomic_inc(&pblk->inflight_io);
>   		__pblk_end_io_read(pblk, rqd, false);
>   		return NVM_IO_DONE;
>   	}
>   
>   	/* All sectors are to be read from the device */
> -	if (bitmap_empty(&read_bitmap, rqd->nr_ppas)) {
> +	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>   		struct bio *int_bio = NULL;
>   
>   		/* Clone read bio to deal with read errors internally */
> @@ -480,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   	/* The read bio request could be partially filled by the write buffer,
>   	 * but there are some holes that need to be read from the drive.
>   	 */
> -	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, &read_bitmap);
> +	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitmap);
>   
>   fail_rqd_free:
>   	pblk_free_rqd(pblk, rqd, PBLK_READ);
> 

Otherwise looks good.

Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
