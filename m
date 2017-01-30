Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35650 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdA3KQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 05:16:18 -0500
Received: by mail-wm0-f47.google.com with SMTP id b65so25618210wmf.0
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 02:16:18 -0800 (PST)
Subject: Re: [PATCH 3/3] lightnvm: Add CRC read error
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1485431260-20268-1-git-send-email-javier@cnexlabs.com>
 <1485431260-20268-3-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <fe372dff-b191-0284-90c7-d93c91fc0620@lightnvm.io>
Date: Mon, 30 Jan 2017 11:16:10 +0100
MIME-Version: 1.0
In-Reply-To: <1485431260-20268-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 12:47 PM, Javier González wrote:
> Let the host differentiate between a read error and a CRC check error on
> the device side.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  include/linux/lightnvm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 11c318e..51cda67 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -108,6 +108,7 @@ enum {
>  	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
>  	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
>  	NVM_RSP_ERR_FAILECC	= 0x4281,
> +	NVM_RSP_ERR_FAILCRC	= 0x4004,
>  	NVM_RSP_WARN_HIGHECC	= 0x4700,
>  
>  	/* Device opcodes */
> 

Thanks. Applied.
