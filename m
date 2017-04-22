Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33500 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043642AbdDVIwI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Apr 2017 04:52:08 -0400
Received: by mail-lf0-f41.google.com with SMTP id 88so54372782lfr.0
        for <linux-block@vger.kernel.org>; Sat, 22 Apr 2017 01:52:07 -0700 (PDT)
Subject: Re: [PATCH 2/5] lightnvm: pblk: fix bad error check
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-3-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9a06a21c-d2cb-4283-3386-1132a46f8b4a@lightnvm.io>
Date: Sat, 22 Apr 2017 10:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <1492817569-13532-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:32 AM, Javier González wrote:
> Fix bad error check
>
> Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 7065658..7eb62ec 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1273,7 +1273,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
>  retry_setup:
>  	if (!pblk_line_set_metadata(pblk, new, cur)) {
>  		new = pblk_line_retry(pblk, new);
> -		if (new)
> +		if (!new)
>  			return NULL;
>
>  		goto retry_setup;
>

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>
