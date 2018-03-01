Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33520 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966437AbeCAKlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Mar 2018 05:41:47 -0500
Received: by mail-lf0-f67.google.com with SMTP id o145so8126336lff.0
        for <linux-block@vger.kernel.org>; Thu, 01 Mar 2018 02:41:47 -0800 (PST)
Subject: Re: [PATCH 12/15] lightnvn: pblk: use generic address format
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
 <1519832975-25432-13-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f1468f08-9412-0243-440a-b79615814b1e@lightnvm.io>
Date: Thu, 1 Mar 2018 11:41:45 +0100
MIME-Version: 1.0
In-Reply-To: <1519832975-25432-13-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/28/2018 04:49 PM, Javier González wrote:
> Use the generic address format on common address manipulations.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c  | 10 +++++-----
>   drivers/lightnvm/pblk-map.c   |  4 ++--
>   drivers/lightnvm/pblk-sysfs.c |  4 ++--
>   drivers/lightnvm/pblk.h       |  4 ++--
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 7d0bd33f11d9..2e10b18b61e3 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -885,7 +885,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
>   		}
>   
>   		ppa = pblk->luns[bit].bppa; /* set ch and lun */
> -		ppa.g.blk = line->id;
> +		ppa.a.blk = line->id;
>   
>   		atomic_dec(&line->left_eblks);
>   		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> @@ -1686,8 +1686,8 @@ static void __pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list,
>   	int i;
>   
>   	for (i = 1; i < nr_ppas; i++)
> -		WARN_ON(ppa_list[0].g.lun != ppa_list[i].g.lun ||
> -				ppa_list[0].g.ch != ppa_list[i].g.ch);
> +		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
> +				ppa_list[0].a.ch != ppa_list[i].a.ch);
>   #endif
>   
>   	ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
> @@ -1731,8 +1731,8 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
>   	int i;
>   
>   	for (i = 1; i < nr_ppas; i++)
> -		WARN_ON(ppa_list[0].g.lun != ppa_list[i].g.lun ||
> -				ppa_list[0].g.ch != ppa_list[i].g.ch);
> +		WARN_ON(ppa_list[0].a.lun != ppa_list[i].a.lun ||
> +				ppa_list[0].a.ch != ppa_list[i].a.ch);
>   #endif
>   
>   	rlun = &pblk->luns[pos];
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 04e08d76ea5f..20dbaa89c9df 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -127,7 +127,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   			atomic_dec(&e_line->left_eblks);
>   
>   			*erase_ppa = rqd->ppa_list[i];
> -			erase_ppa->g.blk = e_line->id;
> +			erase_ppa->a.blk = e_line->id;
>   
>   			spin_unlock(&e_line->lock);
>   
> @@ -168,6 +168,6 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>   		set_bit(bit, e_line->erase_bitmap);
>   		atomic_dec(&e_line->left_eblks);
>   		*erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
> -		erase_ppa->g.blk = e_line->id;
> +		erase_ppa->a.blk = e_line->id;
>   	}
>   }
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index cbb5b6edb7bf..a643dc623731 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -39,8 +39,8 @@ static ssize_t pblk_sysfs_luns_show(struct pblk *pblk, char *page)
>   		sz += snprintf(page + sz, PAGE_SIZE - sz,
>   				"pblk: pos:%d, ch:%d, lun:%d - %d\n",
>   					i,
> -					rlun->bppa.g.ch,
> -					rlun->bppa.g.lun,
> +					rlun->bppa.a.ch,
> +					rlun->bppa.a.lun,
>   					active);
>   	}
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index dd0089fe62b9..6ac64d9eb57e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -936,12 +936,12 @@ static inline int pblk_pad_distance(struct pblk *pblk)
>   
>   static inline int pblk_ppa_to_line(struct ppa_addr p)
>   {
> -	return p.g.blk;
> +	return p.a.blk;
>   }
>   
>   static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
>   {
> -	return p.g.lun * geo->num_ch + p.g.ch;
> +	return p.a.lun * geo->num_ch + p.a.ch;
>   }
>   
>   static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
> 

Would it make sense to merge this with 7/15?
