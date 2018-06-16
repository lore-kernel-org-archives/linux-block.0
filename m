Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38036 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFPTir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 15:38:47 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so19198203lfh.5
        for <linux-block@vger.kernel.org>; Sat, 16 Jun 2018 12:38:47 -0700 (PDT)
Subject: Re: [PATCH 5/5] lightnvm: pblk: Disable interleaved metadata in pblk
To: igor.j.konopko@intel.com, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, michal.sorn@intel.com,
        marcin.dziegielewski@intel.com
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-6-igor.j.konopko@intel.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5977e8b8-223b-3d15-76df-82c827d6775a@lightnvm.io>
Date: Sat, 16 Jun 2018 21:38:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180615222706.3801-6-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/16/2018 12:27 AM, Igor Konopko wrote:
> Currently pblk and lightnvm does only check for size
> of OOB metadata and does not care wheather this meta
> is located in separate buffer or is interleaved with
> data in single buffer.
> 
> In reality only the first scenario is supported, where
> second mode will break pblk functionality during any
> IO operation.
> 
> The goal of this patch is to block creation of pblk
> devices in case of interleaved metadata
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-init.c | 6 ++++++
>   drivers/nvme/host/lightnvm.c | 1 +
>   include/linux/lightnvm.h     | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 5eb641da46ed..483a6d479e7d 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1238,6 +1238,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> +	if (geo->ext) {
> +		pr_err("pblk: extended (interleaved) metadata in data buffer"
> +			" not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	pblk = kzalloc(sizeof(struct pblk), GFP_KERNEL);
>   	if (!pblk)
>   		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 670478abc754..872ab854ccf5 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -979,6 +979,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>   
>   	geo->csecs = 1 << ns->lba_shift;
>   	geo->sos = ns->ms;
> +	geo->ext = ns->ext;
>   }
>   
>   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 72a55d71917e..b13e64e2112f 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -350,6 +350,7 @@ struct nvm_geo {
>   	u32	clba;		/* sectors per chunk */
>   	u16	csecs;		/* sector size */
>   	u16	sos;		/* out-of-band area size */
> +	u16	ext;		/* metadata in extended data buffer */
>   
>   	/* device write constrains */
>   	u32	ws_min;		/* minimum write size */
> 

I think bool type would be better here. Can it be placesd a bit down, 
just over the 1.2 stuff?

Also, feel free to fix up the checkpatch stuff in patch 1 & 3 & 5.
