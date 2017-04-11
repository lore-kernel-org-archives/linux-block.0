Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38554 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbdDKKvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 06:51:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id t189so58028207wmt.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 03:51:36 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: make nvm_free static
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
 <1491850297-18235-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1b0565ff-61d8-7a88-ccde-11c915252d55@lightnvm.io>
Date: Tue, 11 Apr 2017 12:51:34 +0200
MIME-Version: 1.0
In-Reply-To: <1491850297-18235-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/10/2017 08:51 PM, Javier González wrote:
> Prefix the nvm_free static function with a missing static keyword.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index bdbb333..3e51a05 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -999,7 +999,7 @@ static int nvm_core_init(struct nvm_dev *dev)
>  	return ret;
>  }
>
> -void nvm_free(struct nvm_dev *dev)
> +static void nvm_free(struct nvm_dev *dev)
>  {
>  	if (!dev)
>  		return;
>

Thanks. Applied for 4.12.
