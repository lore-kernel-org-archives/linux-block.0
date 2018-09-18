Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34864 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeIROEK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 10:04:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so1200089edq.2
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:32:36 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix race on sysfs line state
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5d780512-f36f-77a6-09ae-c6ad001ef401@lightnvm.io>
Date: Tue, 18 Sep 2018 10:32:33 +0200
MIME-Version: 1.0
In-Reply-To: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/18/2018 09:40 AM, Javier González wrote:
> pblk exposes a sysfs interface that represents its internal state. Part
> of this state is the map bitmap for the current open line, which should
> be protected by the line lock to avoid a race when freeing the line
> metadata. Currently, it is not.
> 
> This patch makes sure that the line state is consistent and NULL
> bitmap pointers are not dereferenced.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c  | 5 +++--
>   drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index a23e965d32fc..fec0ad68dcd6 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1662,13 +1662,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
>   	struct pblk_line *cur, *new = NULL;
>   	unsigned int left_seblks;
>   
> -	cur = l_mg->data_line;
>   	new = l_mg->data_next;
>   	if (!new)
>   		goto out;
> +
> +	spin_lock(&l_mg->free_lock);
> +	cur = l_mg->data_line;
>   	l_mg->data_line = new;
>   
> -	spin_lock(&l_mg->free_lock);
>   	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
>   	spin_unlock(&l_mg->free_lock);
>   
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index cba83ac43e62..2d2818155aa8 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -263,8 +263,14 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
>   		sec_in_line = l_mg->data_line->sec_in_line;
>   		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
>   							PBLK_DATA_LINES);
> -		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
> +
> +		spin_lock(&l_mg->data_line->lock);
> +		if (l_mg->data_line->map_bitmap)
> +			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
>   							lm->sec_per_line);
> +		else
> +			map_weight = 0;
> +		spin_unlock(&l_mg->data_line->lock);
>   	}
>   	spin_unlock(&l_mg->free_lock);
>   
> 

Applied for 4.20. Thanks.
