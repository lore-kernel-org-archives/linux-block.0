Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34102 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0HoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 02:44:11 -0500
Received: by mail-lf0-f67.google.com with SMTP id l191so26092429lfe.1
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 23:44:10 -0800 (PST)
Subject: Re: [PATCH][RESEND] lightnvm: Avoid validation of default op value
To: Heiner Litz <hlitz@ucsc.edu>, linux-block@vger.kernel.org
Cc: javier@cnexlabs.com
References: <20180226202219.2880-1-hlitz@ucsc.edu>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b5edbe73-f8d9-dc23-47ff-7f7d7c6966e5@lightnvm.io>
Date: Tue, 27 Feb 2018 08:44:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180226202219.2880-1-hlitz@ucsc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/26/2018 09:22 PM, Heiner Litz wrote:
> Fixes: 38401d231de65 ("lightnvm: set target over-provision on create ioctl")
> 
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
>   drivers/lightnvm/core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index dcc9e621e651..74b53fc1b813 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -304,11 +304,9 @@ static int __nvm_config_extended(struct nvm_dev *dev,
>   	}
>   
>   	/* op not set falls into target's default */
> -	if (e->op == 0xFFFF)
> +	if (e->op == 0xFFFF) {
>   		e->op = NVM_TARGET_DEFAULT_OP;
> -
> -	if (e->op < NVM_TARGET_MIN_OP ||
> -	    e->op > NVM_TARGET_MAX_OP) {
> +	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
>   		pr_err("nvm: invalid over provisioning value\n");
>   		return -EINVAL;
>   	}
> 

Thanks Heiner. Applied.
