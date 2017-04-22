Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33433 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043434AbdDVIvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Apr 2017 04:51:39 -0400
Received: by mail-lf0-f44.google.com with SMTP id 88so54369969lfr.0
        for <linux-block@vger.kernel.org>; Sat, 22 Apr 2017 01:51:38 -0700 (PDT)
Subject: Re: [PATCH 1/5] lightnvm: pblk: fix race condition on line retry
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9781715a-68ea-b677-aff4-155b8a3b59b7@lightnvm.io>
Date: Sat, 22 Apr 2017 10:51:34 +0200
MIME-Version: 1.0
In-Reply-To: <1492817569-13532-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:32 AM, Javier González wrote:
> When a pblk line fails (or is recovered), make sure to take the line
> management lock.
>
> Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index a2bcd09..7065658 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1050,13 +1050,14 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>  	spin_lock(&l_mg->free_lock);
>  	l_mg->data_line = line;
>  	list_del(&line->list);
> -	spin_unlock(&l_mg->free_lock);
>
>  	ret = pblk_line_prepare(pblk, line);
>  	if (ret) {
>  		list_add(&line->list, &l_mg->free_list);
> +		spin_unlock(&l_mg->free_lock);
>  		return ret;
>  	}
> +	spin_unlock(&l_mg->free_lock);
>
>  	pblk_rl_free_lines_dec(&pblk->rl, line);
>
> @@ -1140,6 +1141,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>  	line->invalid_bitmap = NULL;
>  	line->smeta = NULL;
>  	line->emeta = NULL;
> +	l_mg->data_line = retry_line;
>  	spin_unlock(&l_mg->free_lock);
>
>  	if (pblk_line_erase(pblk, retry_line))
> @@ -1147,8 +1149,6 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
>
>  	pblk_rl_free_lines_dec(&pblk->rl, retry_line);
>
> -	l_mg->data_line = retry_line;
> -
>  	return retry_line;
>  }
>
>

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>
