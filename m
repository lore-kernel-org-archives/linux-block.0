Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36919 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeBVHsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:48:31 -0500
Received: by mail-lf0-f68.google.com with SMTP id y19so6068065lfd.4
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:48:30 -0800 (PST)
Subject: Re: [PATCH 11/20] lightnvm: pblk: check for supported version
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-12-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b1cc74a-5f7a-2f43-e1ff-5f31445ad709@lightnvm.io>
Date: Thu, 22 Feb 2018 08:48:28 +0100
MIME-Version: 1.0
In-Reply-To: <1519205218-26994-12-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2018 10:26 AM, Javier González wrote:
> At this point, only 1.2 spec is supported, thus check for it. Also,
> since device-side L2P is only supported in the 1.2 spec, make sure to
> only check its value under 1.2.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 56b4afc27add..ec39800eea42 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -990,9 +990,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   	struct pblk *pblk;
>   	int ret;
>   
> -	if (dev->geo.c.dom & NVM_RSP_L2P) {
> +	if (geo->c.version != NVM_OCSSD_SPEC_12) {
> +		pr_err("pblk: OCSSD version not supported (%u)\n",
> +							geo->c.version);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (geo->c.version == NVM_OCSSD_SPEC_12 && geo->c.dom & NVM_RSP_L2P) {
>   		pr_err("pblk: host-side L2P table not supported. (%x)\n",
> -							dev->geo.c.dom);
> +							geo->c.dom);
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> 

Looks good to me. I'll pick up when rebased.
