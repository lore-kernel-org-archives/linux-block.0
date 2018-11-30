Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A5C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB142146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="OaFf64Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB142146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeK3Tpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:45:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44839 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeK3Tpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:45:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so3474952lfe.11
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 00:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CAvqsZpS6OQFISdgtji9uWxaRAmXcs1JEW/cE337ioI=;
        b=OaFf64Izcs+UQzM0z0XNhEHMIqeApTIN1pnYavupbyp/HbzFZ3ZrP4gdevB9tCVIM3
         yVnLjDgEuTKpkm6iZoFpBE+Mq5MqfNjDD5tzuwWuKvdR7o+m2T5CH8jnz3gYJFg+L3uz
         7zJ9Wdm98ssgmMvlSwhYklWkE2k0D11YKSgrLgcdcWkVlUCiu+4kaUPCx0qlZwiUhV/h
         uilE6OaZE48jer58Q84lyDBlY1A/HhuonI7U7A6+g/ELrkYqRd6Ae8q5/dvhPyNFtX7g
         7QWRUk0PwZna1DWMuZb3+a3Qb5p/VgSb6MyJUCifIZhJatkihlPNlSTmIxFZDmOa9mX5
         5Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAvqsZpS6OQFISdgtji9uWxaRAmXcs1JEW/cE337ioI=;
        b=nnyvv85WGczkRtxCYWRrjJdiWgLYvLkQEUbrQezYl6uiOF9cosIR+Hmb606D8v/8EY
         t2iuQm33E9yycmdoDA8upryUZSGenJmo0VnNYq/E6Dj/7M+WYYchHuFjlDutcZcWMogt
         blHVlGprgC5oUPJK/c24UOz3yhzc1utuK06u5SVrAxNuA/Y4QkWEekFENRHuO9xEUhGU
         XJZVExldnn4WG7FCpIn1gvAaNE4xnbyWdcUf8tt4ZqEKVobdatsrAia6nmAy0hNgS9AX
         b6vHWqTwST3AUJiL81HNvxaVaJShl7B9mxM5kZEWa7bwyylqFKWBYBkXuJ7CpLj226LE
         gxLA==
X-Gm-Message-State: AA+aEWaZ4DXkVLjsU1m1dGvi5x1uXr5zlFHfQSoSJnOlMg8xGeWH+1v8
        IS3fYd/Qi9VSAhLm9MC37YGReQ==
X-Google-Smtp-Source: AFSGD/U1nzNTvGBm6p6dGGu8Ne0yHDg/aKnL2TCEXVhqaNUNCOVoac7mpG1U5lcgZL2JUoZz83mJqg==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr3025468lfg.13.1543567026063;
        Fri, 30 Nov 2018 00:37:06 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id q67sm697828lfe.19.2018.11.30.00.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:37:05 -0800 (PST)
Subject: Re: [PATCH] lightnvm: simplify geometry enumeration
To:     Javier Gonzalez <javier@cnexlabs.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20181129142738.9567-1-mb@lightnvm.io>
 <6FEED0D7-5064-464A-B522-412CEE2A1C7A@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e27cef79-efde-fd08-f85a-be7226f66757@lightnvm.io>
Date:   Fri, 30 Nov 2018 09:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6FEED0D7-5064-464A-B522-412CEE2A1C7A@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/2018 08:17 AM, Javier Gonzalez wrote:
>> On 29 Nov 2018, at 15.27, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> Currently the geometry of an OCSSD is enumerated using a two step
>> approach:
>>
>> First, nvm_register is called, the OCSSD identify command is issued,
>> and second the geometry sos and csecs values are read either from the
>> OCSSD identify if it is a 1.2 drive, or from the NVMe namespace data
>> structure if it is a 2.0 device.
>>
>> This patch recombines it into a single step, such that nvm_register can
>> use the csecs and sos fields independent of which version is used. This
>> enables one to dynamically size the lightnvm subsystem dma pool.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/lightnvm/core.c      | 12 +++++-------
>> drivers/nvme/host/core.c     | 18 +++++++++---------
>> drivers/nvme/host/lightnvm.c | 18 ++++++------------
>> drivers/nvme/host/nvme.h     |  2 --
>> 4 files changed, 20 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 73ab3cf26868..a1d52e934ce4 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -1145,25 +1145,23 @@ int nvm_register(struct nvm_dev *dev)
>> 	if (!dev->q || !dev->ops)
>> 		return -EINVAL;
>>
>> +	ret = nvm_init(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> 	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
>> 	if (!dev->dma_pool) {
>> 		pr_err("nvm: could not create dma pool\n");
>> +		nvm_free(dev);
>> 		return -ENOMEM;
>> 	}
>>
>> -	ret = nvm_init(dev);
>> -	if (ret)
>> -		goto err_init;
>> -
>> 	/* register device with a supported media manager */
>> 	down_write(&nvm_lock);
>> 	list_add(&dev->devices, &nvm_devices);
>> 	up_write(&nvm_lock);
>>
>> 	return 0;
>> -err_init:
>> -	dev->ops->destroy_dma_pool(dev->dma_pool);
>> -	return ret;
>> }
>> EXPORT_SYMBOL(nvm_register);
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 65c42448e904..387833b37e38 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1516,8 +1516,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>> 	if (ns->noiob)
>> 		nvme_set_chunk_size(ns);
>> 	nvme_update_disk_info(disk, ns, id);
>> -	if (ns->ndev)
>> -		nvme_nvm_update_nvm_info(ns);
>> #ifdef CONFIG_NVME_MULTIPATH
>> 	if (ns->head->disk)
>> 		nvme_update_disk_info(ns->head->disk, ns, id);
>> @@ -3086,13 +3084,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> 	nvme_setup_streams_ns(ctrl, ns);
>> 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
>>
>> -	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
>> -		if (nvme_nvm_register(ns, disk_name, node)) {
>> -			dev_warn(ctrl->device, "LightNVM init failure\n");
>> -			goto out_unlink_ns;
>> -		}
>> -	}
>> -
>> 	disk = alloc_disk_node(0, node);
>> 	if (!disk)
>> 		goto out_unlink_ns;
>> @@ -3106,6 +3097,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>
>> 	__nvme_revalidate_disk(disk, id);
>>
>> +	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
>> +		if (nvme_nvm_register(ns, disk_name, node)) {
>> +			dev_warn(ctrl->device, "LightNVM init failure\n");
>> +			goto out_put_disk;
>> +		}
>> +	}
>> +
>> 	down_write(&ctrl->namespaces_rwsem);
>> 	list_add_tail(&ns->list, &ctrl->namespaces);
>> 	up_write(&ctrl->namespaces_rwsem);
>> @@ -3119,6 +3117,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> 	kfree(id);
>>
>> 	return;
>> + out_put_disk:
>> +	put_disk(ns->disk);
>>   out_unlink_ns:
>> 	mutex_lock(&ctrl->subsys->lock);
>> 	list_del_rcu(&ns->siblings);
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index d64805dc8efb..51d957ccf328 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -973,22 +973,11 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
>> 	}
>> }
>>
>> -void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>> -{
>> -	struct nvm_dev *ndev = ns->ndev;
>> -	struct nvm_geo *geo = &ndev->geo;
>> -
>> -	if (geo->version == NVM_OCSSD_SPEC_12)
>> -		return;
>> -
>> -	geo->csecs = 1 << ns->lba_shift;
>> -	geo->sos = ns->ms;
>> -}
>> -
>> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>> {
>> 	struct request_queue *q = ns->queue;
>> 	struct nvm_dev *dev;
>> +	struct nvm_geo *geo;
>>
>> 	_nvme_nvm_check_size();
>>
>> @@ -996,6 +985,11 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>> 	if (!dev)
>> 		return -ENOMEM;
>>
>> +	/* Note that csecs and sos will be overridden if it is a 1.2 drive. */
>> +	geo = &dev->geo;
>> +	geo->csecs = 1 << ns->lba_shift;
>> +	geo->sos = ns->ms;
>> +
>> 	dev->q = q;
>> 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
>> 	dev->ops = &nvme_nvm_dev_ops;
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 9fefba039d1e..4f5399c8808b 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -541,13 +541,11 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>> #endif /* CONFIG_NVME_MULTIPATH */
>>
>> #ifdef CONFIG_NVM
>> -void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
>> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
>> void nvme_nvm_unregister(struct nvme_ns *ns);
>> extern const struct attribute_group nvme_nvm_attr_group;
>> int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
>> #else
>> -static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
>> static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
>> 				    int node)
>> {
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> Good refactor; much better to do initialization on a single step.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks. Picked up for 4.21.
