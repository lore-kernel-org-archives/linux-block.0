Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeHQNkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 09:40:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so3342878pfn.8
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 03:37:07 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix race condition on metadata I/O
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <fbe93d3b-31d5-608c-e9fc-c77510763462@lightnvm.io>
Date: Fri, 17 Aug 2018 12:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/17/2018 12:22 PM, Javier González wrote:
> In pblk, when a new line is allocated, metadata for the previously
> written line is scheduled. This is done through a fixed memory region
> that is shared through time and contexts across different lines and
> therefore protected by a lock. Unfortunately, this lock is not properly
> covering all the metadata used for sharing this memory regions,
> resulting on a race condition.
> 
> This patch fixes this race condition by protecting this metadata
> properly.
> 
> Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-write.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 508c63701eda..df99c45778d4 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
>   			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
>   	}
>   
> +	spin_lock(&l_mg->close_lock);
>   	emeta->mem += rq_len;
> -	if (emeta->mem >= lm->emeta_len[0]) {
> -		spin_lock(&l_mg->close_lock);
> +	if (emeta->mem >= lm->emeta_len[0])
>   		list_del(&meta_line->list);
> -		spin_unlock(&l_mg->close_lock);
> -	}
> +	spin_unlock(&l_mg->close_lock);
>   
>   	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>   
> @@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
>   	struct pblk_line *meta_line;
>   
>   	spin_lock(&l_mg->close_lock);
> -retry:
>   	if (list_empty(&l_mg->emeta_list)) {
>   		spin_unlock(&l_mg->close_lock);
>   		return NULL;
>   	}
>   	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
> -	if (meta_line->emeta->mem >= lm->emeta_len[0])
> -		goto retry;
> +	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
> +		spin_unlock(&l_mg->close_lock);
> +		return NULL;
> +	} >   	spin_unlock(&l_mg->close_lock);
>   
>   	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
> 

Thanks. Applied for 4.20.
