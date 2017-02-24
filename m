Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34918 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdBXRIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 12:08:15 -0500
Received: by mail-wm0-f46.google.com with SMTP id v186so19485221wmd.0
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2017 09:08:14 -0800 (PST)
Subject: Re: [PATCH 2/3] lightnvm: rename scrambler controller hint
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1487952846-29476-1-git-send-email-javier@cnexlabs.com>
 <1487952846-29476-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d414955a-60cb-2d09-6731-2f42b792f3eb@lightnvm.io>
Date: Fri, 24 Feb 2017 18:08:12 +0100
MIME-Version: 1.0
In-Reply-To: <1487952846-29476-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/24/2017 05:14 PM, Javier González wrote:
> According to the OCSSD 1.2 specification, the 0x200 hint enables the
> media scrambler for the read/write opcode, providing that the controller
> has been correctly configured by the firmware. Rename the macro to
> represent this meaning.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
> ---
>  include/linux/lightnvm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 6a3534b..bebea80 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -123,7 +123,7 @@ enum {
>  	/* NAND Access Modes */
>  	NVM_IO_SUSPEND		= 0x80,
>  	NVM_IO_SLC_MODE		= 0x100,
> -	NVM_IO_SCRAMBLE_DISABLE	= 0x200,
> +	NVM_IO_SCRAMBLE_ENABLE	= 0x200,
>
>  	/* Block Types */
>  	NVM_BLK_T_FREE		= 0x0,
>

Thanks, applied for 4.12.
