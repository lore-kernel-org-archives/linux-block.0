Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB1C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A420989
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 14:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="wJe6gJKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeK1BQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:16:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41122 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeK1BQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 20:16:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so20198708ljb.8
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0+SxtsjGOH0CdTdvR+beqGNlyImHfEH3beEvc7ef2E=;
        b=wJe6gJKOUSMW2SQgFDsRaMaG/D0Ow0Cumg43s7RAsrTP+awbOrife2FDOpUc1JIxz5
         MdR5sb+71VIiQOFHpW5HFZXKmw2PrlrvRtIRsr+teetNqPjU0yHhZ9IpqGj2LnKzyEtW
         Nj4NK6NhmB6pj/zlanY/nNEkwei0xQ8ExoOZ3e7CJc3GHrT0ytbNibaBocmIYHTMmUEd
         +CIsdQFsD2HmrNRPh0jfXH/dZe2Hdly/85FZ1p+LlI8iiHlaiMrtDoCmw0Nvh1s84ppD
         2PVeIyBm50lKliutdgOvoNWiOjatqipAoRobh4Jr6MBntk58mAJpxJ2aOa5RMdmF5/wg
         lyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0+SxtsjGOH0CdTdvR+beqGNlyImHfEH3beEvc7ef2E=;
        b=e3A6Xyjps3WHczPBKmszRF5cMxixZAuwImeByXulqE/C5dW3Ml5jKToV3HBXXp9BrH
         UqNYHqcGrDD+tuFmEcC0YRFxbMCz25XNgolyxzk8A5ALmbbx0X7yAbNLybX1oGhgSMq1
         JZ9nZNOtuFzj+zUhWaJxaQ5eQYoFBnUnmoT+NPQ3wOxUnWmISy7baYJpB+J/ErpL1KCs
         /3gZ350xLYhpDjoWcIK1R591qsi4luZvRXu6UFoYSrfzcDTi5CMgEbKIGYkyMEb17PjV
         oRx39cwbHStmCX5jEItnpY+hjOF+osfcbydUDLSNaDccGIu11pWBLH98qUnx06x7YNJP
         SO1A==
X-Gm-Message-State: AA+aEWYUyyrengf6hqyMdnpU2hAei45r+8ibHcujnVwux4pNaXktdC/T
        yGHo3Z7IfAth3TQsHqp6+mjMyw==
X-Google-Smtp-Source: AJdET5f57CHoTzJ6n9kWwuBVVqOsmnZWGfaONV/fZZDC4xQ6D/QqNybXI5JtYgzLRAHHPGdxjPZ9zQ==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr22204257ljk.80.1543328331840;
        Tue, 27 Nov 2018 06:18:51 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x204sm614553lfa.5.2018.11.27.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 06:18:50 -0800 (PST)
Subject: Re: [PATCH] lightnvm: remove dma alloc/free helpers
To:     javier@javigon.com
Cc:     igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1543325972-15136-1-git-send-email-javier@cnexlabs.com>
 <1543325972-15136-2-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ccb9584d-a262-366b-fe2d-605311c2b593@lightnvm.io>
Date:   Tue, 27 Nov 2018 15:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543325972-15136-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/2018 02:39 PM, Javier González wrote:
> Time has shown that the LightNVM alloc/free dma helpers are merely
> replacements of the native dma_pool operations. Thus, remove them and
> let targets manage the LightNVM dma pool directly.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c          | 25 +++++++------------------
>   drivers/lightnvm/pblk-core.c     | 10 +++++-----
>   drivers/lightnvm/pblk-read.c     |  3 ++-
>   drivers/lightnvm/pblk-recovery.c |  5 +++--
>   drivers/nvme/host/lightnvm.c     | 16 +---------------
>   include/linux/lightnvm.h         |  8 +-------
>   6 files changed, 19 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c3650b141a30..8b6ee35e4356 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -641,20 +641,6 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>   }
>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
>   
> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
> -							dma_addr_t *dma_handler)
> -{
> -	return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
> -								dma_handler);
> -}
> -EXPORT_SYMBOL(nvm_dev_dma_alloc);
> -
> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
> -{
> -	dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
> -}
> -EXPORT_SYMBOL(nvm_dev_dma_free);
> -
>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>   {
>   	struct nvm_dev *dev;
> @@ -682,7 +668,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>   	}
>   
>   	rqd->nr_ppas = nr_ppas;
> -	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
> +	rqd->ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL,
> +							&rqd->dma_ppa_list);
>   	if (!rqd->ppa_list) {
>   		pr_err("nvm: failed to allocate dma memory\n");
>   		return -ENOMEM;
> @@ -705,10 +692,12 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>   static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>   			struct nvm_rq *rqd)
>   {
> +	struct nvm_dev *dev = tgt_dev->parent;
> +
>   	if (!rqd->ppa_list)
>   		return;
>   
> -	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
> +	dma_pool_free(dev->dma_pool, rqd->ppa_list, rqd->dma_ppa_list);
>   }
>   
>   static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
> @@ -1178,7 +1167,7 @@ void nvm_unregister(struct nvm_dev *dev)
>   }
>   EXPORT_SYMBOL(nvm_unregister);
>   
> -int nvm_alloc_dma_pool(struct nvm_dev *dev)
> +int nvm_create_dma_pool(struct nvm_dev *dev)
>   {
>   	int exp_pool_size;
>   
> @@ -1195,7 +1184,7 @@ int nvm_alloc_dma_pool(struct nvm_dev *dev)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(nvm_alloc_dma_pool);
> +EXPORT_SYMBOL(nvm_create_dma_pool);
>   
>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   {
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 615817bf97e3..61a2a5330ecf 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -242,7 +242,7 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   
> -	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> +	rqd->meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
>   							&rqd->dma_meta_list);
>   	if (!rqd->meta_list)
>   		return -ENOMEM;
> @@ -261,8 +261,8 @@ void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   
>   	if (rqd->meta_list)
> -		nvm_dev_dma_free(dev->parent, rqd->meta_list,
> -				rqd->dma_meta_list);
> +		dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
> +							rqd->dma_meta_list);
>   }
>   
>   /* Caller must guarantee that the request is a valid type */
> @@ -846,7 +846,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>   	int i, j;
>   	int ret;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> +	meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
>   							&dma_meta_list);
>   	if (!meta_list)
>   		return -ENOMEM;
> @@ -925,7 +925,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>   		goto next_rq;
>   
>   free_rqd_dma:
> -	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> +	dma_pool_free(dev->parent->dma_pool, rqd.meta_list, rqd.dma_meta_list);
>   	return ret;
>   }
>   
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 32b285cf5846..1576f357c9af 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -507,7 +507,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>   	return NVM_IO_OK;
>   
>   fail_meta_free:
> -	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
> +	dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
> +							rqd->dma_meta_list);
>   fail_rqd_free:
>   	pblk_free_rqd(pblk, rqd, PBLK_READ);
>   	return ret;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 65abc043e268..80d5b5bd4ab7 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -472,7 +472,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	dma_addr_t dma_ppa_list, dma_meta_list;
>   	int ret = 0;
>   
> -	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
> +	meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
> +								&dma_meta_list);
>   	if (!meta_list)
>   		return -ENOMEM;
>   
> @@ -508,7 +509,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	mempool_free(rqd, &pblk->r_rq_pool);
>   	kfree(data);
>   free_meta_list:
> -	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> +	dma_pool_free(dev->parent->dma_pool, meta_list, dma_meta_list);
>   
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 049425ad8592..dd300ce9983f 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -747,18 +747,6 @@ static void nvme_nvm_destroy_dma_pool(void *pool)
>   	dma_pool_destroy(dma_pool);
>   }
>   
> -static void *nvme_nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
> -				    gfp_t mem_flags, dma_addr_t *dma_handler)
> -{
> -	return dma_pool_alloc(pool, mem_flags, dma_handler);
> -}
> -
> -static void nvme_nvm_dev_dma_free(void *pool, void *addr,
> -							dma_addr_t dma_handler)
> -{
> -	dma_pool_free(pool, addr, dma_handler);
> -}
> -
>   static struct nvm_dev_ops nvme_nvm_dev_ops = {
>   	.identity		= nvme_nvm_identity,
>   
> @@ -772,8 +760,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
>   
>   	.create_dma_pool	= nvme_nvm_create_dma_pool,
>   	.destroy_dma_pool	= nvme_nvm_destroy_dma_pool,
> -	.dev_dma_alloc		= nvme_nvm_dev_dma_alloc,
> -	.dev_dma_free		= nvme_nvm_dev_dma_free,
>   };
>   
>   static int nvme_nvm_submit_user_cmd(struct request_queue *q,
> @@ -985,7 +971,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>   		geo->ext = ns->ext;
>   	}
>   
> -	if (nvm_alloc_dma_pool(ndev))
> +	if (nvm_create_dma_pool(ndev))
>   		nvm_unregister(ndev);
>   }
>   
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index fd7b519f3ad2..7ca38b8bf133 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -94,7 +94,6 @@ typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
>   typedef void (nvm_destroy_dma_pool_fn)(void *);
>   typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
>   								dma_addr_t *);
> -typedef void (nvm_dev_dma_free_fn)(void *, void*, dma_addr_t);
>   
>   struct nvm_dev_ops {
>   	nvm_id_fn		*identity;
> @@ -108,8 +107,6 @@ struct nvm_dev_ops {
>   
>   	nvm_create_dma_pool_fn	*create_dma_pool;
>   	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
> -	nvm_dev_dma_alloc_fn	*dev_dma_alloc;
> -	nvm_dev_dma_free_fn	*dev_dma_free;
>   };
>   
>   #ifdef CONFIG_NVM
> @@ -669,11 +666,8 @@ struct nvm_tgt_type {
>   extern int nvm_register_tgt_type(struct nvm_tgt_type *);
>   extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
>   
> -extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
> -extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
> -
>   extern struct nvm_dev *nvm_alloc_dev(int);
> -extern int nvm_alloc_dma_pool(struct nvm_dev *);
> +extern int nvm_create_dma_pool(struct nvm_dev *);
>   extern int nvm_register(struct nvm_dev *);
>   extern void nvm_unregister(struct nvm_dev *);
>   
> 

I kindly would like to reject this patch. One reason is that target's 
should not have direct access to DMA pools and another reason is that 
the code changes when OCSSD is used over Fabrics. The DMA pool is no 
longer available and data has to be allocated differently. This code 
does not belong inside a target.
