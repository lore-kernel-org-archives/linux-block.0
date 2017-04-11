Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37165 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbdDKOfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 10:35:19 -0400
Received: by mail-wm0-f45.google.com with SMTP id u2so2419438wmu.0
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2017 07:35:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] lightnvm: clean unused variable
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1491920338-2348-1-git-send-email-javier@cnexlabs.com>
 <1491920338-2348-2-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d0c6c6f5-3d95-1860-595b-9a08a0625396@lightnvm.io>
Date: Tue, 11 Apr 2017 16:35:15 +0200
MIME-Version: 1.0
In-Reply-To: <1491920338-2348-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/11/2017 04:18 PM, Javier González wrote:
> Clean unused variable on lightnvm core.
>
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index eb9ab1a..258007a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -501,7 +501,6 @@ void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
>  		int *lun_roffs;
>  		struct ppa_addr gaddr;
>  		u64 pba = le64_to_cpu(entries[i]);
> -		int off;
>  		u64 diff;
>
>  		if (!pba)
> @@ -511,8 +510,6 @@ void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
>  		ch_rmap = &dev_rmap->chnls[gaddr.g.ch];
>  		lun_roffs = ch_rmap->lun_offs;
>
> -		off = gaddr.g.ch * geo->luns_per_chnl + gaddr.g.lun;
> -
>  		diff = ((ch_rmap->ch_off * geo->luns_per_chnl) +
>  				(lun_roffs[gaddr.g.lun])) * geo->sec_per_lun;
>
>
Thanks. Applied for 4.12.
