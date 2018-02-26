Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40887 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeBZSUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 13:20:20 -0500
Received: by mail-lf0-f68.google.com with SMTP id 37so23617704lfs.7
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 10:20:19 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: remove unused variable
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
Date: Mon, 26 Feb 2018 19:20:17 +0100
MIME-Version: 1.0
In-Reply-To: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/26/2018 02:18 PM, Javier González wrote:
> Remove unused variable after a previous cleanup (a8112b631adb)
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index ce6a7cfdba66..e6cb4317bb50 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>   	struct nvm_geo *geo = &dev->geo;
>   	struct pblk_line_meta *lm = &pblk->lm;
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> -	int nr_bb = 0;
>   	u64 off;
>   	int bit = -1;
>   	int emeta_secs;
> @@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
>   		bitmap_or(line->map_bitmap, line->map_bitmap, l_mg->bb_aux,
>   							lm->sec_per_line);
>   		line->sec_in_line -= geo->c.clba;
> -		if (bit >= lm->emeta_bb)
> -			nr_bb++;
>   	}
>   
>   	/* Mark smeta metadata sectors as bad sectors */
> 

Should Fixes be added?
