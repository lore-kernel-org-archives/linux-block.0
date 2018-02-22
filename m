Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46018 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeBVHoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:44:02 -0500
Received: by mail-lf0-f68.google.com with SMTP id x196so6025103lfd.12
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:44:01 -0800 (PST)
Subject: Re: [PATCH 07/20] lightnvm: rename sect_* to sec_*
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-8-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7dc355a2-b3a2-28f3-a595-42822129f456@lightnvm.io>
Date: Thu, 22 Feb 2018 08:43:59 +0100
MIME-Version: 1.0
In-Reply-To: <1519205218-26994-8-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2018 10:26 AM, Javier González wrote:
> Rename abbreviations for sector from sect_* to sec_* as most of the code
> uses this format and it is confusing when using the different
> structures.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c  | 8 ++++----
>   drivers/lightnvm/pblk-sysfs.c | 4 ++--
>   drivers/lightnvm/pblk.h       | 8 ++++----
>   drivers/nvme/host/lightnvm.c  | 8 ++++----
>   include/linux/lightnvm.h      | 8 ++++----
>   5 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 455fc63a9409..6bf51ef8f516 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -179,16 +179,16 @@ static int pblk_set_addrf_12(struct nvm_geo *geo,
>   	dst->blk_len = src->blk_len;
>   	dst->pg_len = src->pg_len;
>   	dst->pln_len = src->pln_len;
> -	dst->sect_len = src->sect_len;
> +	dst->sec_len = src->sec_len;
>   
> -	dst->sect_offset = 0;
> -	dst->pln_offset = dst->sect_len;
> +	dst->sec_offset = 0;
> +	dst->pln_offset = dst->sec_len;
>   	dst->ch_offset = dst->pln_offset + dst->pln_len;
>   	dst->lun_offset = dst->ch_offset + dst->ch_len;
>   	dst->pg_offset = dst->lun_offset + dst->lun_len;
>   	dst->blk_offset = dst->pg_offset + dst->pg_len;
>   
> -	dst->sec_mask = ((1ULL << dst->sect_len) - 1) << dst->sect_offset;
> +	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
>   	dst->pln_mask = ((1ULL << dst->pln_len) - 1) << dst->pln_offset;
>   	dst->ch_mask = ((1ULL << dst->ch_len) - 1) << dst->ch_offset;
>   	dst->lun_mask = ((1ULL << dst->lun_len) - 1) << dst->lun_offset;
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index 5eb21a279361..81288aa9162a 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -128,7 +128,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
>   			ppaf->blk_offset, ppaf->blk_len,
>   			ppaf->pg_offset, ppaf->pg_len,
>   			ppaf->pln_offset, ppaf->pln_len,
> -			ppaf->sect_offset, ppaf->sect_len);
> +			ppaf->sec_offset, ppaf->sec_len);
>   
>   	sz += snprintf(page + sz, PAGE_SIZE - sz,
>   		"device:ch:%d/%d,lun:%d/%d,blk:%d/%d,pg:%d/%d,pl:%d/%d,sec:%d/%d\n",
> @@ -137,7 +137,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
>   			geo_ppaf->blk_offset, geo_ppaf->blk_len,
>   			geo_ppaf->pg_offset, geo_ppaf->pg_len,
>   			geo_ppaf->pln_offset, geo_ppaf->pln_len,
> -			geo_ppaf->sect_offset, geo_ppaf->sect_len);
> +			geo_ppaf->sec_offset, geo_ppaf->sec_len);
>   
>   	return sz;
>   }
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 1f32284b0aec..4f7a365436f1 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -957,7 +957,7 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>   	ppa.g.lun = (paddr & ppaf->lun_mask) >> ppaf->lun_offset;
>   	ppa.g.ch = (paddr & ppaf->ch_mask) >> ppaf->ch_offset;
>   	ppa.g.pl = (paddr & ppaf->pln_mask) >> ppaf->pln_offset;
> -	ppa.g.sec = (paddr & ppaf->sec_mask) >> ppaf->sect_offset;
> +	ppa.g.sec = (paddr & ppaf->sec_mask) >> ppaf->sec_offset;
>   
>   	return ppa;
>   }
> @@ -973,7 +973,7 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>   	paddr |= (u64)p.g.lun << ppaf->lun_offset;
>   	paddr |= (u64)p.g.pg << ppaf->pg_offset;
>   	paddr |= (u64)p.g.pl << ppaf->pln_offset;
> -	paddr |= (u64)p.g.sec << ppaf->sect_offset;
> +	paddr |= (u64)p.g.sec << ppaf->sec_offset;
>   
>   	return paddr;
>   }
> @@ -998,7 +998,7 @@ static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
>   		ppa64.g.blk = (ppa32 & ppaf->blk_mask) >> ppaf->blk_offset;
>   		ppa64.g.pg = (ppa32 & ppaf->pg_mask) >> ppaf->pg_offset;
>   		ppa64.g.pl = (ppa32 & ppaf->pln_mask) >> ppaf->pln_offset;
> -		ppa64.g.sec = (ppa32 & ppaf->sec_mask) >> ppaf->sect_offset;
> +		ppa64.g.sec = (ppa32 & ppaf->sec_mask) >> ppaf->sec_offset;
>   	}
>   
>   	return ppa64;
> @@ -1022,7 +1022,7 @@ static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
>   		ppa32 |= ppa64.g.blk << ppaf->blk_offset;
>   		ppa32 |= ppa64.g.pg << ppaf->pg_offset;
>   		ppa32 |= ppa64.g.pl << ppaf->pln_offset;
> -		ppa32 |= ppa64.g.sec << ppaf->sect_offset;
> +		ppa32 |= ppa64.g.sec << ppaf->sec_offset;
>   	}
>   
>   	return ppa32;
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index bd97672e0b4f..cca32da05316 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -262,21 +262,21 @@ static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
>   	dst->blk_len = src->blk_len;
>   	dst->pg_len = src->pg_len;
>   	dst->pln_len = src->pln_len;
> -	dst->sect_len = src->sec_len;
> +	dst->sec_len = src->sec_len;
>   
>   	dst->ch_offset = src->ch_offset;
>   	dst->lun_offset = src->lun_offset;
>   	dst->blk_offset = src->blk_offset;
>   	dst->pg_offset = src->pg_offset;
>   	dst->pln_offset = src->pln_offset;
> -	dst->sect_offset = src->sec_offset;
> +	dst->sec_offset = src->sec_offset;
>   
>   	dst->ch_mask = ((1ULL << dst->ch_len) - 1) << dst->ch_offset;
>   	dst->lun_mask = ((1ULL << dst->lun_len) - 1) << dst->lun_offset;
>   	dst->blk_mask = ((1ULL << dst->blk_len) - 1) << dst->blk_offset;
>   	dst->pg_mask = ((1ULL << dst->pg_len) - 1) << dst->pg_offset;
>   	dst->pln_mask = ((1ULL << dst->pln_len) - 1) << dst->pln_offset;
> -	dst->sec_mask = ((1ULL << dst->sect_len) - 1) << dst->sect_offset;
> +	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
>   }
>   
>   static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
> @@ -956,7 +956,7 @@ static ssize_t nvm_dev_attr_show_ppaf(struct nvm_addr_format_12 *ppaf,
>   				ppaf->pln_offset, ppaf->pln_len,
>   				ppaf->blk_offset, ppaf->blk_len,
>   				ppaf->pg_offset, ppaf->pg_len,
> -				ppaf->sect_offset, ppaf->sect_len);
> +				ppaf->sec_offset, ppaf->sec_len);
>   }
>   
>   static ssize_t nvm_dev_attr_show_12(struct device *dev,
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 02f1fd617781..ccc5faa63cb7 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -163,14 +163,14 @@ struct nvm_addr_format_12 {
>   	u8	blk_len;
>   	u8	pg_len;
>   	u8	pln_len;
> -	u8	sect_len;
> +	u8	sec_len;
>   
>   	u8	ch_offset;
>   	u8	lun_offset;
>   	u8	blk_offset;
>   	u8	pg_offset;
>   	u8	pln_offset;
> -	u8	sect_offset;
> +	u8	sec_offset;
>   
>   	u64	ch_mask;
>   	u64	lun_mask;
> @@ -399,7 +399,7 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
>   	l.ppa |= ((u64)r.g.blk) << ppaf->blk_offset;
>   	l.ppa |= ((u64)r.g.pg) << ppaf->pg_offset;
>   	l.ppa |= ((u64)r.g.pl) << ppaf->pln_offset;
> -	l.ppa |= ((u64)r.g.sec) << ppaf->sect_offset;
> +	l.ppa |= ((u64)r.g.sec) << ppaf->sec_offset;
>   
>   	return l;
>   }
> @@ -419,7 +419,7 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
>   	l.g.blk = (r.ppa & ppaf->blk_mask) >> ppaf->blk_offset;
>   	l.g.pg = (r.ppa & ppaf->pg_mask) >> ppaf->pg_offset;
>   	l.g.pl = (r.ppa & ppaf->pln_mask) >> ppaf->pln_offset;
> -	l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sect_offset;
> +	l.g.sec = (r.ppa & ppaf->sec_mask) >> ppaf->sec_offset;
>   
>   	return l;
>   }
> 

Looks good, I'll pick up when rebased. This could properly be part of 
another patch set with cleanups, as it is not 2.0 specific.
