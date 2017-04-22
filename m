Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32917 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043641AbdDVJCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Apr 2017 05:02:52 -0400
Received: by mail-lf0-f52.google.com with SMTP id 88so54432718lfr.0
        for <linux-block@vger.kernel.org>; Sat, 22 Apr 2017 02:02:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] lightnvm: pblk: free metadata on line alloc failure
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-5-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2a5ff589-850b-5416-cd92-2f8918c48eb3@lightnvm.io>
Date: Sat, 22 Apr 2017 11:02:49 +0200
MIME-Version: 1.0
In-Reply-To: <1492817569-13532-5-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/22/2017 01:32 AM, Javier González wrote:
> When a line allocation fails, for example, due to having too many bad
> blocks, free its metadata correctly.
>
> Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 7eb62ec..ac3742b 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1127,6 +1127,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>  	spin_lock(&l_mg->free_lock);
>  	retry_line = pblk_line_get(pblk);
>  	if (!retry_line) {
> +		l_mg->data_line = NULL;
>  		spin_unlock(&l_mg->free_lock);
>  		return NULL;
>  	}
> @@ -1134,18 +1135,17 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>  	retry_line->smeta = line->smeta;
>  	retry_line->emeta = line->emeta;
>  	retry_line->meta_line = line->meta_line;
> -	retry_line->map_bitmap = line->map_bitmap;
> -	retry_line->invalid_bitmap = line->invalid_bitmap;
>
> -	line->map_bitmap = NULL;
> -	line->invalid_bitmap = NULL;
> -	line->smeta = NULL;
> -	line->emeta = NULL;
> +	pblk_line_free(pblk, line);
>  	l_mg->data_line = retry_line;
>  	spin_unlock(&l_mg->free_lock);
>
> -	if (pblk_line_erase(pblk, retry_line))
> +	if (pblk_line_erase(pblk, retry_line)) {
> +		spin_lock(&l_mg->free_lock);
> +		l_mg->data_line = NULL;
> +		spin_unlock(&l_mg->free_lock);
>  		return NULL;
> +	}
>
>  	pblk_rl_free_lines_dec(&pblk->rl, retry_line);
>
> @@ -1299,6 +1299,8 @@ void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
>
>  	line->map_bitmap = NULL;
>  	line->invalid_bitmap = NULL;
> +	line->smeta = NULL;
> +	line->emeta = NULL;
>  }
>
>  void pblk_line_put(struct kref *ref)
>

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>
