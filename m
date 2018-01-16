Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35249 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeAPV0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 16:26:45 -0500
Received: by mail-lf0-f65.google.com with SMTP id a204so10933320lfa.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2018 13:26:44 -0800 (PST)
Subject: Re: [PATCH] lightnvm/pblk-gc: Delete an error message for a failed
 memory allocation in pblk_gc_line_prepare_ws()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-block@vger.kernel.org, Matias Bjorling <mb@lightnvm.io>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <0ef6e852-9c76-ce74-6f21-c0398722c9e5@users.sourceforge.net>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <8d034c60-ce01-f40d-e122-6e1ec2bc145a@bjorling.me>
Date: Tue, 16 Jan 2018 22:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <0ef6e852-9c76-ce74-6f21-c0398722c9e5@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/16/2018 10:10 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 16 Jan 2018 22:00:15 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/lightnvm/pblk-gc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 9c8e114c8a54..54cdb4360366 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -147,10 +147,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>   	int ret;
>   
>   	invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
> -	if (!invalid_bitmap) {
> -		pr_err("pblk: could not allocate GC invalid bitmap\n");
> +	if (!invalid_bitmap)
>   		goto fail_free_ws;
> -	}
>   
>   	emeta_buf = pblk_malloc(lm->emeta_len[0], l_mg->emeta_alloc_type,
>   								GFP_KERNEL);
> 

Thanks Markus. I'll queue it up for 4.17.
