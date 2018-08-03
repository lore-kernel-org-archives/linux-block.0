Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41725 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeHCOlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 10:41:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so3951501lfe.8
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 05:45:07 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
Date: Fri, 3 Aug 2018 14:45:05 +0200
MIME-Version: 1.0
In-Reply-To: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/03/2018 02:05 PM, Javier González wrote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..160b54d26bfa 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return nvm_submit_io_sync(dev, rqd);
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +	if (rqd->opcode != NVM_OP_PWRITE)
> +		pblk_submit_io_sync(pblk, rqd);
> +

Why should the write be issued twice?

> +	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +	pblk_submit_io_sync(pblk, rqd);
> +	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +}
> +
>   static void pblk_bio_map_addr_endio(struct bio *bio)
>   {
>   	bio_put(bio);
> @@ -737,7 +747,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
>   		}
>   	}
>   
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> @@ -842,7 +852,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   	 * the write thread is the only one sending write and erase commands,
>   	 * there is no need to take the LUN semaphore.
>   	 */
> -	ret = pblk_submit_io_sync(pblk, &rqd);
> +	ret = pblk_submit_io_sync_sem(pblk, &rqd);
>   	if (ret) {
>   		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4760af7b6499..6ccc6ad8e1ce 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
>   void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>   int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>   struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>   			      unsigned int nr_secs, unsigned int len,
> 
