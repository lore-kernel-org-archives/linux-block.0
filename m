Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeH2SNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 14:13:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so2375098pga.13
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 07:16:25 -0700 (PDT)
Subject: Re: [V2 PATCH] lightnvm: pblk: add helpers for chunk addresses
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d9e4f836-1ad0-526b-241e-e934d767ab77@lightnvm.io>
Date: Wed, 29 Aug 2018 16:16:20 +0200
MIME-Version: 1.0
In-Reply-To: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 03:12 PM, Javier González wrote:
> # Changes since V1:
>   - Move 1.2 / 2.0 specific code to core (form Matias)
> 
> Implement helpers to go from ppas to a chunk within a line and an
> address within a chunk.
> 
> These helpers will be used on the patches adding trace support in pblk,
> which will be sent in this window.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk.h  | 19 +++++++++++++++++++
>   include/linux/lightnvm.h | 19 +++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index be67bbfa3d0a..f95fe75fef6e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1034,6 +1034,25 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>   	return ppa;
>   }
>   
> +static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
> +							struct ppa_addr p)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
> +	int pos = pblk_ppa_to_pos(geo, p);
> +
> +	return &line->chks[pos];
> +}
> +
> +static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
> +							struct ppa_addr p)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +
> +	return dev_to_chunk_addr(dev->parent, &pblk->addrf, p);
> +}
> +
>   static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>   							struct ppa_addr p)
>   {
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 0106984400bc..77743a02ec0d 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -487,6 +487,25 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
>   	return l;
>   }
>   
> +static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
> +				    struct ppa_addr p)
> +{
> +	struct nvm_geo *geo = &dev->geo;
> +	u64 caddr;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)addrf;
> +
> +		caddr = (u64)p.g.pg << ppaf->pg_offset;
> +		caddr |= (u64)p.g.pl << ppaf->pln_offset;
> +		caddr |= (u64)p.g.sec << ppaf->sec_offset;
> +	} else {
> +		caddr = p.m.sec;
> +	}
> +
> +	return caddr;
> +}
> +
>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
>   typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
> 

Thanks. Applied for 4.20.
