Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44997 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeHaSZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 14:25:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so10214682ljq.11
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 07:18:15 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: pblk: fix mapping issue on failed writes
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
Date: Fri, 31 Aug 2018 16:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/31/2018 11:59 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> On 1.2-devices, the mapping-out of remaning sectors in the
> failed-write's block can result in an infinite loop,
> stalling the write pipeline, fix this.
> 
> Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> Changes in V2:
> 	Moved the helper function pblk_next_ppa_in_blk to lightnvm core
> 	Renamed variable done->last in the helper function
> 	
> 
>   drivers/lightnvm/pblk-write.c | 10 +---------
>   include/linux/lightnvm.h      | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 5e6df65d392c..922506d2d0a6 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -125,15 +125,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   		if (!test_and_set_bit(paddr, line->invalid_bitmap))
>   			le32_add_cpu(line->vsc, -1);
>   
> -		if (geo->version == NVM_OCSSD_SPEC_12) {
> -			map_ppa.ppa++;
> -			if (map_ppa.g.pg == geo->num_pg)
> -				done = 1;
> -		} else {
> -			map_ppa.m.sec++;
> -			if (map_ppa.m.sec == geo->clba)
> -				done = 1;
> -		}
> +		done = nvm_next_ppa_in_blk(geo, &map_ppa);
>   	}
>   
>   	line->w_err_gc->has_write_err = 1;
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 09f65c6c6676..2a6cbfe1d1b4 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -593,6 +593,40 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
>   	return ppa32;
>   }
>   
> +static inline int nvm_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)

You can pass nvm_tgt_dev here. Then the two unfoldings in 
pblk_map_remaining are not needed.

The naming sounds very 1.2ish, how about nvm_get_next_lba_in_chk?

> +{
> +	int last = 0;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		int sec = ppa->g.sec;
> +
> +		sec++;
> +		if (sec == geo->ws_min) {
> +			int pg = ppa->g.pg;
> +
> +			sec = 0;
> +			pg++;
> +			if (pg == geo->num_pg) {
> +				int pl = ppa->g.pl;
> +
> +				pg = 0;
> +				pl++;
> +				if (pl == geo->num_pln)
> +					last = 1;
> +
> +				ppa->g.pl = pl;
> +			}
> +			ppa->g.pg = pg;
> +		}
> +		ppa->g.sec = sec;
> +	} else {
> +		ppa->m.sec++;
> +		if (ppa->m.sec == geo->clba)
> +			last = 1;
> +	}
> +
> +	return last;
> +}
>   
>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
> 
