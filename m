Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38292 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeBVH0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:26:51 -0500
Received: by mail-lf0-f67.google.com with SMTP id g72so5975625lfg.5
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:26:51 -0800 (PST)
Subject: Re: [PATCH 02/20] lightnvm: add controller capabilities to 2.0
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-3-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <bd9509cd-dc47-e0af-2ee1-027eb22af189@lightnvm.io>
Date: Thu, 22 Feb 2018 08:26:49 +0100
MIME-Version: 1.0
In-Reply-To: <1519205218-26994-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2018 10:26 AM, Javier González wrote:
> Assign missing mccap value on 2.0 path
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index c81e64cc20d7..969bb874850c 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -392,6 +392,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>   	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
>   	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
>   
> +	dev_geo->c.mccap = le32_to_cpu(id->mccap);
> +
>   	dev_geo->c.trdt = le32_to_cpu(id->trdt);
>   	dev_geo->c.trdm = le32_to_cpu(id->trdm);
>   	dev_geo->c.tprt = le32_to_cpu(id->twrt);
> 

The mccap field between 1.2 and 2.0 is orthogonal. They represent two 
different capabilities fields. The mccap has to be interpreted if used.
