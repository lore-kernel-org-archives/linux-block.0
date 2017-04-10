Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34520 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdDJIC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 04:02:28 -0400
Received: by mail-wm0-f48.google.com with SMTP id w204so7166435wmd.1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2017 01:02:27 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: don't check for failure from mempool_alloc()
To: NeilBrown <neilb@suse.com>
References: <87k26txbfa.fsf@notabene.neil.brown.name>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a6f33ff5-28c7-3c85-f146-c1aeda2540bf@lightnvm.io>
Date: Mon, 10 Apr 2017 10:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <87k26txbfa.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/10/2017 04:07 AM, NeilBrown wrote:
>
> mempool_alloc() cannot fail if the gfp flags allow it to
> sleep, and both GFP_KERNEL and GFP_NOIO allows for sleeping.
>
> So rrpc_move_valid_pages() and rrpc_make_rq() don't need to
> test the return value.
>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/lightnvm/rrpc.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index e00b1d7b976f..34f5f1cc9452 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -318,10 +318,6 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
>  	}
>
>  	page = mempool_alloc(rrpc->page_pool, GFP_NOIO);
> -	if (!page) {
> -		bio_put(bio);
> -		return -ENOMEM;
> -	}
>
>  	while ((slot = find_first_zero_bit(rblk->invalid_pages,
>  					    nr_sec_per_blk)) < nr_sec_per_blk) {
> @@ -1007,11 +1003,6 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q, struct bio *bio)
>  	}
>
>  	rqd = mempool_alloc(rrpc->rq_pool, GFP_KERNEL);
> -	if (!rqd) {
> -		pr_err_ratelimited("rrpc: not able to queue bio.");
> -		bio_io_error(bio);
> -		return BLK_QC_T_NONE;
> -	}
>  	memset(rqd, 0, sizeof(struct nvm_rq));
>
>  	err = rrpc_submit_io(rrpc, bio, rqd, NVM_IOTYPE_NONE);
>

This is great!, Thanks Neil.  Applied for 4.12.
