Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
To: javier@javigon.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f4f8c276-0269-5aa5-39fc-42aecc7bb309@lightnvm.io>
Date: Wed, 29 Aug 2018 15:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/29/2018 10:56 AM, Javier González wrote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> For the metadata I/O that is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metadata scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 767178185f19..1e4dc0c1ed88 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return ret;
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	struct ppa_addr *ppa_list;
> +	int ret;
> +
> +	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +
> +	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);

If the debug stuff is killed inside __pblk_down_page, then ppa_list and 
rqd->nr_ppas does not need to be passed, and this function can be 
inlined in its caller. Can we kill it? I'll make the patch if you like.

> +	ret = pblk_submit_io_sync(pblk, rqd);
> +	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
> +
> +	return ret;
> +}
> +
>   static void pblk_bio_map_addr_endio(struct bio *bio)
>   {
>   	bio_put(bio);
> @@ -788,7 +802,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>   		meta_list[i].lba = lba_list[paddr] = addr_empty;
>   	}
>   
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index c0d9eddd344b..54f937c1fb62 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -793,6 +793,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>   void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
>   struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> 
