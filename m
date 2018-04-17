Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46305 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDQMNC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 08:13:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so11866282plc.13
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 05:13:02 -0700 (PDT)
Subject: Re: [PATCH 08/11] lightnvm: pblk: remove unnecessary argument
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-9-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <feabf6cc-a25b-b3de-3259-c211cb7120f0@lightnvm.io>
Date: Tue, 17 Apr 2018 14:12:48 +0200
MIME-Version: 1.0
In-Reply-To: <1523874332-6272-9-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 4/16/18 12:25 PM, Javier González wrote:
> Remove unnecessary argument on pblk_line_free()
> 

Why was the argument no longer needed?

> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 6 +++---
>   drivers/lightnvm/pblk-init.c | 2 +-
>   drivers/lightnvm/pblk.h      | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 6bc0c7f61aac..1b871441d816 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1337,7 +1337,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>   	retry_line->emeta = line->emeta;
>   	retry_line->meta_line = line->meta_line;
>   
> -	pblk_line_free(pblk, line);
> +	pblk_line_free(line);
>   	l_mg->data_line = retry_line;
>   	spin_unlock(&l_mg->free_lock);
>   
> @@ -1562,7 +1562,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
>   	return new;
>   }
>   
> -void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
> +void pblk_line_free(struct pblk_line *line)
>   {
>   	kfree(line->map_bitmap);
>   	kfree(line->invalid_bitmap);
> @@ -1584,7 +1584,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
>   	WARN_ON(line->state != PBLK_LINESTATE_GC);
>   	line->state = PBLK_LINESTATE_FREE;
>   	line->gc_group = PBLK_LINEGC_NONE;
> -	pblk_line_free(pblk, line);
> +	pblk_line_free(line);
>   	spin_unlock(&line->lock);
>   
>   	atomic_dec(&gc->pipeline_gc);
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 8f8c9abd14fc..b52855f9336b 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -509,7 +509,7 @@ static void pblk_lines_free(struct pblk *pblk)
>   	for (i = 0; i < l_mg->nr_lines; i++) {
>   		line = &pblk->lines[i];
>   
> -		pblk_line_free(pblk, line);
> +		pblk_line_free(line);
>   		pblk_line_meta_free(line);
>   	}
>   	spin_unlock(&l_mg->free_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 856ac41e1201..ff0e5e6421dd 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -766,7 +766,7 @@ struct pblk_line *pblk_line_get_data(struct pblk *pblk);
>   struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
>   int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
>   int pblk_line_is_full(struct pblk_line *line);
> -void pblk_line_free(struct pblk *pblk, struct pblk_line *line);
> +void pblk_line_free(struct pblk_line *line);
>   void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line);
>   void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
>   void pblk_line_close_ws(struct work_struct *work);
> 
