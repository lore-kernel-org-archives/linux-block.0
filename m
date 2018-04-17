Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42058 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeDQLs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 07:48:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id t20-v6so11845058ply.9
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 04:48:27 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: take bitmap alloc. out of critical
 section
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1523874066-4459-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <76bed955-2e70-7540-0836-f93fbd677d7e@lightnvm.io>
Date: Tue, 17 Apr 2018 13:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <1523874066-4459-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 4/16/18 12:21 PM, Javier González wrote:
> Allocate line bitmaps outside of the line lock on line preparation.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>


The patch description tells what the patch does, it should tell why the 
change the done.

> ---
>   drivers/lightnvm/pblk-core.c | 96 +++++++++++++++++++++++++-------------------
>   1 file changed, 55 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 5f960a6609c8..7762e89984ee 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1058,6 +1058,25 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>   	return 1;
>   }
>   
> +static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm = &pblk->lm;
> +
> +	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
> +	if (!line->map_bitmap)
> +		return -ENOMEM;
> +
> +	/* will be initialized using bb info from map_bitmap */
> +	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
> +	if (!line->invalid_bitmap) {
> +		kfree(line->map_bitmap);
> +		line->map_bitmap = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>   /* For now lines are always assumed full lines. Thus, smeta former and current
>    * lun bitmaps are omitted.
>    */
> @@ -1162,18 +1181,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   {
>   	struct pblk_line_meta *lm = &pblk->lm;
>   	int blk_in_line = atomic_read(&line->blk_in_line);
> -	int blk_to_erase, ret;
> -
> -	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_ATOMIC);
> -	if (!line->map_bitmap)
> -		return -ENOMEM;
> -
> -	/* will be initialized using bb info from map_bitmap */
> -	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_ATOMIC);
> -	if (!line->invalid_bitmap) {
> -		ret = -ENOMEM;
> -		goto fail_free_map_bitmap;
> -	}
> +	int blk_to_erase;
>   
>   	/* Bad blocks do not need to be erased */
>   	bitmap_copy(line->erase_bitmap, line->blk_bitmap, lm->blk_per_line);
> @@ -1191,15 +1199,15 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   	}
>   
>   	if (blk_in_line < lm->min_blk_line) {
> -		ret = -EAGAIN;
> -		goto fail_free_invalid_bitmap;
> +		spin_unlock(&line->lock);
> +		return -EAGAIN;
>   	}
>   
>   	if (line->state != PBLK_LINESTATE_FREE) {
>   		WARN(1, "pblk: corrupted line %d, state %d\n",
>   							line->id, line->state);
> -		ret = -EINTR;
> -		goto fail_free_invalid_bitmap;
> +		spin_unlock(&line->lock);
> +		return -EINTR;
>   	}
>   
>   	line->state = PBLK_LINESTATE_OPEN;
> @@ -1213,16 +1221,6 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   	kref_init(&line->ref);
>   
>   	return 0;
> -
> -fail_free_invalid_bitmap:
> -	spin_unlock(&line->lock);
> -	kfree(line->invalid_bitmap);
> -	line->invalid_bitmap = NULL;
> -fail_free_map_bitmap:
> -	kfree(line->map_bitmap);
> -	line->map_bitmap = NULL;
> -
> -	return ret;
>   }
>   
>   int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
> @@ -1242,13 +1240,15 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>   	}
>   	spin_unlock(&l_mg->free_lock);
>   
> -	pblk_rl_free_lines_dec(&pblk->rl, line, true);
> +	if (pblk_line_alloc_bitmaps(pblk, line))
> +		return -EINTR;

Why return -EINTR, instead of the return value from (0, -ENOMEM) from 
pblk_line_alloc_bitmap?


>   
>   	if (!pblk_line_init_bb(pblk, line, 0)) {
>   		list_add(&line->list, &l_mg->free_list);
>   		return -EINTR;
>   	}
>   
> +	pblk_rl_free_lines_dec(&pblk->rl, line, true);
>   	return 0;
>   }
>   
> @@ -1260,6 +1260,24 @@ void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
>   	line->emeta = NULL;
>   }
>   
> +static void pblk_line_clear(struct pblk_line *line)
> +{
> +	*line->vsc = cpu_to_le32(EMPTY_ENTRY);
> +
> +	line->map_bitmap = NULL;
> +	line->invalid_bitmap = NULL;
> +	line->smeta = NULL;
> +	line->emeta = NULL;
> +}

Instead of pblk_line_clear, how about pblk_line_reinit?
