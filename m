Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34238 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964867AbeEXITE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 May 2018 04:19:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id a14-v6so492732pfi.1
        for <linux-block@vger.kernel.org>; Thu, 24 May 2018 01:19:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] lightnvm: pblk: handle case when device expose
 mw_cunits equal to 0
To: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc: linux-block@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>
References: <1527088640-13062-1-git-send-email-marcin.dziegielewski@intel.com>
 <1527088640-13062-3-git-send-email-marcin.dziegielewski@intel.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <add2c8b9-b900-f165-b783-500ca53100be@lightnvm.io>
Date: Thu, 24 May 2018 10:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <1527088640-13062-3-git-send-email-marcin.dziegielewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/23/2018 05:17 PM, Marcin Dziegielewski wrote:
> Some devices can expose mw_cunits equal to 0, it can cause creation of too
> small write buffer and in consecuence performance drop on write workloads.
> 
> To handle that, in such case we are using default value for MLC and
> beacause it covers both 1.2 and 2.0 OC specification, setting up mw_cunits
> in nvme_nvm_setup_12 function isn't longer necessary.
> 
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-init.c | 10 +++++++++-
>   drivers/nvme/host/lightnvm.c |  1 -
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 9a7213e..42190de 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -366,7 +366,15 @@ static int pblk_core_init(struct pblk *pblk)
>   	atomic64_set(&pblk->nr_flush, 0);
>   	pblk->nr_flush_rst = 0;
>   
> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
> +	if (geo->mw_cunits) {
> +		pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
> +	} else {
> +		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo->all_luns;
> +		/*
> +		 * Some devices can expose mw_cunits equal to 0, so let's use
> +		 * here default safe value for MLC.
> +		 */
> +	}
>   
>   	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
>   	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 41279da..c747792 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>   
>   	geo->ws_min = sec_per_pg;
>   	geo->ws_opt = sec_per_pg;
> -	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
>   
>   	/* Do not impose values for maximum number of open blocks as it is
>   	 * unspecified in 1.2. Users of 1.2 must be aware of this and eventually
> 

Thanks Marcin. Applied for 4.18.
