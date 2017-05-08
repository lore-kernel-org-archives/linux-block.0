Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33481 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdEHG4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2017 02:56:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so13278744wmh.0
        for <linux-block@vger.kernel.org>; Sun, 07 May 2017 23:56:20 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: fix error return code of memdup_user
To: Geliang Tang <geliangtang@gmail.com>,
        Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@fb.com>
References: <f0f70c9326edab0cc56731f24244e86f8ba84ef4.1493727412.git.geliangtang@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <879c9631-5d56-d3ad-6b7e-7b16ba1cdbde@bjorling.me>
Date: Mon, 8 May 2017 08:56:18 +0200
MIME-Version: 1.0
In-Reply-To: <f0f70c9326edab0cc56731f24244e86f8ba84ef4.1493727412.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 05/06/2017 05:34 PM, Geliang Tang wrote:
> The error return code of memdup_user() should be -ENOMEM or -EFAULT.
> So this patch changed it to PTR_ERR(info).
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/lightnvm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 54a06c3..e8b5edd 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1164,7 +1164,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
>
>  	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
>  	if (IS_ERR(info))
> -		return -EFAULT;
> +		return PTR_ERR(info);
>
>  	info->version[0] = NVM_VERSION_MAJOR;
>  	info->version[1] = NVM_VERSION_MINOR;
>

Thanks Geliang. Jens, would you pick this beauty up? :)

Reviewed-by: Matias Bj�rling <matias@cnexlabs.com>
