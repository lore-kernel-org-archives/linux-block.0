Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC8FC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A21320863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="taeczmGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeK3BmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:42:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34793 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbeK3BgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so1934553ljd.1
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5wWcUPde3mi9mvB5SEd1AolSSbv5LE/YQZvO7hyyvMw=;
        b=taeczmGGD3YdHgwiPEytVwLRU/k6sPhy2lY0MS1jsdq2Z4nDy0ydvxEUObK4CkNkQ2
         WioRiuPph3WJ4m8CIR+oz2ZYFyoU2CeD5UQkqtJHpWNKdtrZvHNuPfHBkA/Lwyfw0wOI
         jPGxTNUh/aPVdQ/Yxzo8MhZPRsVYTkly1ZF5Vhr4jk6N5iOzLlw/KRQRRAoAyaqZs+hB
         FeuANAonjykK8iKzNSvZj0n2Es3RBUsIrbPB2u9o6VbYBofaLFDJJbm4QzWmgC9ISFtu
         zecjMt37gQc/XnosanYnjpzAqTnhMyWGQ5XPy+LECXnWooZNqVP9txPBb9QAKdKt2mqO
         Q4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wWcUPde3mi9mvB5SEd1AolSSbv5LE/YQZvO7hyyvMw=;
        b=JbhicWwF+2LlkTETvJxdlpCAW8ywSnADbuqjxOyGnSlYz9AurVoEGHC513b95fqkCf
         /gIJ71+PcpeTh0kI6pjll4//MmWUA17L92ff2dbJfrVuKMmk2UI0BMTahU3Rqrdx/hlz
         pmfxHDbAWYJLbGVZwXfOvsutNStnIs6XWdP5CU9Lo/8K8pwVKRD9NRSGVjLdmlNBU4c6
         Gunoz8N76lOtdgKjbpApcv9PoBa0CW2nXkf1aXBQGzRyNc/05yyeTGNQmmNwiF21uSE6
         fEN+QB4FYZxZsVI+14T4fX03lwoe529fwhSrpFsBxLmcwgdgRB7IyR66WdWTFhZSzSbl
         KlfQ==
X-Gm-Message-State: AA+aEWaV01Irk2LK8/ZOrmrTfBnS+Ph5JKgByHm+YI7TpnlvLCqe5QQY
        oUIRX5Gpbc4jCtW811Vi0xxbnXwYgr8=
X-Google-Smtp-Source: AFSGD/UIPRrKZiKHPVg2EuzJM1xB4h6qw9NKVEmq9n0mGgZoXlZDTYFYQHCwTNBPAABwYZIcV8Y//A==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr1105953ljg.71.1543501838127;
        Thu, 29 Nov 2018 06:30:38 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id c2-v6sm311773ljj.41.2018.11.29.06.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:30:37 -0800 (PST)
Subject: Re: [PATCH v4 3/5] lightnvm: Flexible DMA pool entry size
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com
References: <20181129071606.56942-1-igor.j.konopko@intel.com>
 <20181129071606.56942-4-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9ef38ff9-141e-532e-5148-cb356f165bdc@lightnvm.io>
Date:   Thu, 29 Nov 2018 15:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129071606.56942-4-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/2018 08:16 AM, Igor Konopko wrote:
> Currently whole lightnvm and pblk uses single DMA pool,
> for which entry size is always equal to PAGE_SIZE.
> PPA list always needs 8B*64, so there is only 56B*64
> space for OOB meta. Since NVMe OOB meta can be bigger,
> such as 128B, this solution is not robustness.
> 
> This patch add the possiblity to support OOB meta above
> 56b by changing DMA pool size based on OOB meta size.
> 
> It also allows pblk to use OOB metadata >=16B.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/core.c          | 30 ++++++++++++++++++++----------
>   drivers/lightnvm/pblk-core.c     |  8 ++++----
>   drivers/lightnvm/pblk-init.c     |  2 +-
>   drivers/lightnvm/pblk-recovery.c |  4 ++--
>   drivers/lightnvm/pblk.h          |  6 +++++-
>   drivers/nvme/host/lightnvm.c     | 15 +++++++++------
>   include/linux/lightnvm.h         |  7 ++++++-
>   7 files changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 73ab3cf26868..e3a83e506458 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1145,15 +1145,9 @@ int nvm_register(struct nvm_dev *dev)
>   	if (!dev->q || !dev->ops)
>   		return -EINVAL;
>   
> -	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
> -	if (!dev->dma_pool) {
> -		pr_err("nvm: could not create dma pool\n");
> -		return -ENOMEM;
> -	}
> -
>   	ret = nvm_init(dev);
>   	if (ret)
> -		goto err_init;
> +		return ret;
>   
>   	/* register device with a supported media manager */
>   	down_write(&nvm_lock);
> @@ -1161,9 +1155,6 @@ int nvm_register(struct nvm_dev *dev)
>   	up_write(&nvm_lock);
>   
>   	return 0;
> -err_init:
> -	dev->ops->destroy_dma_pool(dev->dma_pool);
> -	return ret;
>   }
>   EXPORT_SYMBOL(nvm_register);
>   
> @@ -1187,6 +1178,25 @@ void nvm_unregister(struct nvm_dev *dev)
>   }
>   EXPORT_SYMBOL(nvm_unregister);
>   
> +int nvm_create_dma_pool(struct nvm_dev *dev)
> +{
> +	int exp_pool_size;
> +
> +	exp_pool_size = max_t(int, PAGE_SIZE,
> +			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
> +	exp_pool_size = round_up(exp_pool_size, PAGE_SIZE);
> +
> +	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
> +						  exp_pool_size);
> +	if (!dev->dma_pool) {
> +		pr_err("nvm: could not create dma pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(nvm_create_dma_pool);
> +
>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   {
>   	struct nvm_dev *dev;
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index aeb10bd78c62..1347d1a93dd0 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -250,8 +250,8 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
>   	if (rqd->nr_ppas == 1)
>   		return 0;
>   
> -	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> -	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size(pblk);
> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	return 0;
>   }
> @@ -846,8 +846,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>   	if (!meta_list)
>   		return -ENOMEM;
>   
> -	ppa_list = meta_list + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> +	ppa_list = meta_list + pblk_dma_meta_size(pblk);
> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   next_rq:
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 6e7a0c6c6655..b67bca810eb7 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -410,7 +410,7 @@ static int pblk_core_init(struct pblk *pblk)
>   	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
>   
>   	pblk->oob_meta_size = geo->sos;
> -	if (pblk->oob_meta_size != sizeof(struct pblk_sec_meta)) {
> +	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
>   		pblk_err(pblk, "Unsupported metadata size\n");
>   		return -EINVAL;
>   	}
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 6a30b9971283..52cbe06e3ebc 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -478,8 +478,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>   	if (!meta_list)
>   		return -ENOMEM;
>   
> -	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
> -	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> +	ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
> +	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
>   
>   	data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
>   	if (!data) {
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 80f356688803..9087d53d5c25 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -104,7 +104,6 @@ enum {
>   	PBLK_RL_LOW = 4
>   };
>   
> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
>   #define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
>   
>   /* write buffer completion context */
> @@ -1388,4 +1387,9 @@ static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
>   {
>   	return meta + pblk->oob_meta_size * index;
>   }
> +
> +static inline int pblk_dma_meta_size(struct pblk *pblk)
> +{
> +	return pblk->oob_meta_size * NVM_MAX_VLBA;
> +}
>   #endif /* PBLK_H_ */
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index d64805dc8efb..60ac32b03fb6 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -732,11 +732,12 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
>   	return ret;
>   }
>   
> -static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
> +static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
> +					int size)
>   {
>   	struct nvme_ns *ns = nvmdev->q->queuedata;
>   
> -	return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, PAGE_SIZE, 0);
> +	return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
>   }
>   
>   static void nvme_nvm_destroy_dma_pool(void *pool)
> @@ -978,11 +979,13 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>   	struct nvm_dev *ndev = ns->ndev;
>   	struct nvm_geo *geo = &ndev->geo;
>   
> -	if (geo->version == NVM_OCSSD_SPEC_12)
> -		return;
> +	if (geo->version != NVM_OCSSD_SPEC_12) {
> +		geo->csecs = 1 << ns->lba_shift;
> +		geo->sos = ns->ms;
> +	}
>   
> -	geo->csecs = 1 << ns->lba_shift;
> -	geo->sos = ns->ms;
> +	if (nvm_create_dma_pool(ndev))
> +		nvm_unregister(ndev);
>   }

This breaks when the drive is invalidated and reread. Each time it 
allocates new memory.

I propose to fix the two step enumeration of the geometry, such that we 
can do the proper allocated from nvm_register(), instead of punting it 
to nvme_nvm_update_info.

Please review the patch I sent, and let me know if we can use that to 
simplify this patch.
