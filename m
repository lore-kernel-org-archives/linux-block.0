Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3EC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B47206B7
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B47206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeK3UAa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:00:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:22359 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeK3UAa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 15:00:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="117421785"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.255.132.242]) ([10.255.132.242])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2018 00:51:50 -0800
Subject: Re: [PATCH] lightnvm: simplify geometry enumeration
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        marcin.dziegielewski@intel.com, javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, linux-nvme@lists.infradead.org
References: <20181129142738.9567-1-mb@lightnvm.io>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <b8e97f61-51b4-d60c-c37e-21b5471b9f30@intel.com>
Date:   Fri, 30 Nov 2018 09:51:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129142738.9567-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 29.11.2018 15:27, Matias Bjørling wrote:
> Currently the geometry of an OCSSD is enumerated using a two step
> approach:
> 
> First, nvm_register is called, the OCSSD identify command is issued,
> and second the geometry sos and csecs values are read either from the
> OCSSD identify if it is a 1.2 drive, or from the NVMe namespace data
> structure if it is a 2.0 device.
> 
> This patch recombines it into a single step, such that nvm_register can
> use the csecs and sos fields independent of which version is used. This
> enables one to dynamically size the lightnvm subsystem dma pool.
> 
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> ---
>   drivers/lightnvm/core.c      | 12 +++++-------
>   drivers/nvme/host/core.c     | 18 +++++++++---------
>   drivers/nvme/host/lightnvm.c | 18 ++++++------------
>   drivers/nvme/host/nvme.h     |  2 --
>   4 files changed, 20 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 73ab3cf26868..a1d52e934ce4 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1145,25 +1145,23 @@ int nvm_register(struct nvm_dev *dev)
>   	if (!dev->q || !dev->ops)
>   		return -EINVAL;
>   
> +	ret = nvm_init(dev);
> +	if (ret)
> +		return ret;
> +
>   	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
>   	if (!dev->dma_pool) {
>   		pr_err("nvm: could not create dma pool\n");
> +		nvm_free(dev);
>   		return -ENOMEM;
>   	}
>   
> -	ret = nvm_init(dev);
> -	if (ret)
> -		goto err_init;
> -
>   	/* register device with a supported media manager */
>   	down_write(&nvm_lock);
>   	list_add(&dev->devices, &nvm_devices);
>   	up_write(&nvm_lock);
>   
>   	return 0;
> -err_init:
> -	dev->ops->destroy_dma_pool(dev->dma_pool);
> -	return ret;
>   }
>   EXPORT_SYMBOL(nvm_register);
>   
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 65c42448e904..387833b37e38 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1516,8 +1516,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>   	if (ns->noiob)
>   		nvme_set_chunk_size(ns);
>   	nvme_update_disk_info(disk, ns, id);
> -	if (ns->ndev)
> -		nvme_nvm_update_nvm_info(ns);
>   #ifdef CONFIG_NVME_MULTIPATH
>   	if (ns->head->disk)
>   		nvme_update_disk_info(ns->head->disk, ns, id);
> @@ -3086,13 +3084,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	nvme_setup_streams_ns(ctrl, ns);
>   	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
>   
> -	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
> -		if (nvme_nvm_register(ns, disk_name, node)) {
> -			dev_warn(ctrl->device, "LightNVM init failure\n");
> -			goto out_unlink_ns;
> -		}
> -	}
> -
>   	disk = alloc_disk_node(0, node);
>   	if (!disk)
>   		goto out_unlink_ns;
> @@ -3106,6 +3097,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   
>   	__nvme_revalidate_disk(disk, id);
>   
> +	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
> +		if (nvme_nvm_register(ns, disk_name, node)) {
> +			dev_warn(ctrl->device, "LightNVM init failure\n");
> +			goto out_put_disk;
> +		}
> +	}
> +
>   	down_write(&ctrl->namespaces_rwsem);
>   	list_add_tail(&ns->list, &ctrl->namespaces);
>   	up_write(&ctrl->namespaces_rwsem);
> @@ -3119,6 +3117,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	kfree(id);
>   
>   	return;
> + out_put_disk:
> +	put_disk(ns->disk);
>    out_unlink_ns:
>   	mutex_lock(&ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index d64805dc8efb..51d957ccf328 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -973,22 +973,11 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
>   	}
>   }
>   
> -void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
> -{
> -	struct nvm_dev *ndev = ns->ndev;
> -	struct nvm_geo *geo = &ndev->geo;
> -
> -	if (geo->version == NVM_OCSSD_SPEC_12)
> -		return;
> -
> -	geo->csecs = 1 << ns->lba_shift;
> -	geo->sos = ns->ms;
> -}
> -
>   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>   {
>   	struct request_queue *q = ns->queue;
>   	struct nvm_dev *dev;
> +	struct nvm_geo *geo;
>   
>   	_nvme_nvm_check_size();
>   
> @@ -996,6 +985,11 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>   	if (!dev)
>   		return -ENOMEM;
>   
> +	/* Note that csecs and sos will be overridden if it is a 1.2 drive. */
> +	geo = &dev->geo;
> +	geo->csecs = 1 << ns->lba_shift;
> +	geo->sos = ns->ms;
> +
>   	dev->q = q;
>   	memcpy(dev->name, disk_name, DISK_NAME_LEN);
>   	dev->ops = &nvme_nvm_dev_ops;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9fefba039d1e..4f5399c8808b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -541,13 +541,11 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>   #endif /* CONFIG_NVME_MULTIPATH */
>   
>   #ifdef CONFIG_NVM
> -void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
>   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
>   void nvme_nvm_unregister(struct nvme_ns *ns);
>   extern const struct attribute_group nvme_nvm_attr_group;
>   int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
>   #else
> -static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
>   static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
>   				    int node)
>   {
> 

Looks good to me - I will rebase my changes on top of this patch and resend.

Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
