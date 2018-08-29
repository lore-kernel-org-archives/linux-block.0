Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33610 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:32:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3-v6so1044093pgv.0
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:36:06 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: add helpers for chunk addresses
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
Date: Wed, 29 Aug 2018 14:36:00 +0200
MIME-Version: 1.0
In-Reply-To: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 10:37 AM, Javier González wrote:
> Implement helpers to go from ppas to a chunk within a line and an
> address within a chunk.
> 
> These helpers will be used on the patches adding trace support in pblk,
> which will be sent in this window.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index be67bbfa3d0a..1bfbd3315598 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1034,6 +1034,37 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
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
> +	struct nvm_geo *geo = &dev->geo;
> +	u64 caddr;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {

Please move this into core.

> +		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)&pblk->addrf;
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
>   static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>   							struct ppa_addr p)
>   {
> 
