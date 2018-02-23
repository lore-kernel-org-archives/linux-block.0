Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42872 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933851AbeBWSpn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 13:45:43 -0500
Received: by mail-lf0-f67.google.com with SMTP id t204so13718020lff.9
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2018 10:45:42 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix bad block initialization
To: Heiner Litz <hlitz@ucsc.edu>, linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, matias@lightnvm.io
References: <20180223174016.6104-1-hlitz@ucsc.edu>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <02770a13-9699-aa8d-bcf2-c7aaefe28623@lightnvm.io>
Date: Fri, 23 Feb 2018 19:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180223174016.6104-1-hlitz@ucsc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/23/2018 06:40 PM, Heiner Litz wrote:
> fix reading bad block device information to correctly setup the per line
> blk_bitmap during lightnvm initialization
> 
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
>   drivers/lightnvm/pblk-init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 86a94a7faa96..e0eba150ac7e 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -461,10 +461,11 @@ static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
>   	int i, bb_cnt = 0;
> +	int blk_per_lun = geo->nr_chks * geo->plane_mode;
>   
>   	for (i = 0; i < blk_per_line; i++) {
>   		struct pblk_lun *rlun = &pblk->luns[i];
> -		u8 *lun_bb_log = bb_log + i * blk_per_line;
> +		u8 *lun_bb_log = bb_log + i * blk_per_lun;
>   
>   		if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
>   			continue;
> 

Thanks Heiner. Applied.
