Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E8CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEFE208B8
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="D0YSXf5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgFRVIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRVIN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 17:08:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEDC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 14:08:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so7134338wmt.4
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ggw+RLzwmpyyEiT1KQdp4dtSLiIkA+8DINb4OML+CJY=;
        b=D0YSXf5cAh2kEScb1AXB59bjqJ7uI7mgrZLNUbTGd2Rx2rbDiRDXwvZOA3BL8dK5oj
         M6i65DHAxqRArcWVE6SVJA/KtmMRvpOhgLebT4B9CdNf3lnvVbiBRfgccuggpX9VOHYK
         CNdl3X73sTzmyY5vr/pED563VRIsrLJikX4+Jx6Ug53kubPHPTxltHJtqQWC9v41J+Cr
         UJf7bQcvZM/RiPzytMnrZfFBWTxBioR+dgCUnQZwMWe5+9wb6O3aewQZ8EB5q95PvhVC
         +voVStamFMmwTYEseCMAdfYTqeJDltHiW0QVPNpttU8XfMphjLxtRwcXqj44Ob9ZVKw2
         5Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ggw+RLzwmpyyEiT1KQdp4dtSLiIkA+8DINb4OML+CJY=;
        b=iqe/zbeMtMmvsir4MjVnYrZzNGGvgET5rTgCA1618A+6MvsPp0plSaRwdkNUA4+MAb
         PiWLKVT6QwXI7gTmx0gC4EcCSnILLXji+S1z/EnfnjhMiS9qq+WDsUgcUKCaF3dbLBsL
         8LwWQ7GXgSFVGkM6aeww+P3sx9lP39ZRnOPBDpF3zAIWEWydq39juNGyabXS4iXCgyh+
         u9aIhLStv/PyuLCy2Q7sn6Sc586DjR++gYe/iAw06WNZ1Qm9xtk363bG/ExcQBf4RhQt
         QxMfM5VxIRxz/X+2LhK6r2XkFt+Tqoa9rwuX1I6sZt9FIJP9/+cl5Qu+9+HWLxzO+LTB
         vTFQ==
X-Gm-Message-State: AOAM530T7mvTsSelZ4NTZCxNW+caNO5JJ9uJnZNEmF7APbMad+LxtUwe
        Z9zmf/9BSoNVTIp1GwTWFTV8i84OAv8=
X-Google-Smtp-Source: ABdhPJzhrk+K//npHPnI+8t1LgOJEZXWWDmcfXap4FUGU2ywhpC77XkVPnYEyTrfWdvyM7sDzOUARQ==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr200343wmg.63.1592514491962;
        Thu, 18 Jun 2020 14:08:11 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id z8sm1702491wrv.80.2020.06.18.14.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:08:11 -0700 (PDT)
Subject: Re: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Aravind Ramesh <aravind.ramesh@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-3-kbusch@kernel.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c99bf481-af99-e6a7-731d-d7cc7dd17455@lightnvm.io>
Date:   Thu, 18 Jun 2020 23:08:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618145354.1139350-3-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 16.53, Keith Busch wrote:
> From: Aravind Ramesh <aravind.ramesh@wdc.com>
>
> Allow emulation of a zoned device with a per zone capacity smaller than
> the zone size as as defined in the Zoned Namespace (ZNS) Command Set
> specification. The zone capacity defaults to the zone size if not
> specified and must be smaller than the zone size otherwise.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> ---
>   drivers/block/null_blk.h       |  1 +
>   drivers/block/null_blk_main.c  | 10 +++++++++-
>   drivers/block/null_blk_zoned.c | 16 ++++++++++++++--
>   3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index 81b311c9d781..daed4a9c3436 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -49,6 +49,7 @@ struct nullb_device {
>   	unsigned long completion_nsec; /* time in ns to complete a request */
>   	unsigned long cache_size; /* disk cache size in MB */
>   	unsigned long zone_size; /* zone size in MB if device is zoned */
> +	unsigned long zone_capacity; /* zone capacity in MB if device is zoned */
>   	unsigned int zone_nr_conv; /* number of conventional zones */
>   	unsigned int submit_queues; /* number of submission queues */
>   	unsigned int home_node; /* home node for the device */
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 87b31f9ca362..a2a0e199215b 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -200,6 +200,10 @@ static unsigned long g_zone_size = 256;
>   module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
>   MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
>   
> +static unsigned long g_zone_capacity;
> +module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
> +MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block device is zoned. Can be less than or equal to zone size. Default: Zone size");
> +
>   static unsigned int g_zone_nr_conv;
>   module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
>   MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
> @@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);
>   NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
>   NULLB_DEVICE_ATTR(zoned, bool, NULL);
>   NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
> +NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>   NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>   
>   static ssize_t nullb_device_power_show(struct config_item *item, char *page)
> @@ -457,6 +462,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>   	&nullb_device_attr_badblocks,
>   	&nullb_device_attr_zoned,
>   	&nullb_device_attr_zone_size,
> +	&nullb_device_attr_zone_capacity,
>   	&nullb_device_attr_zone_nr_conv,
>   	NULL,
>   };
> @@ -510,7 +516,8 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
>   
>   static ssize_t memb_group_features_show(struct config_item *item, char *page)
>   {
> -	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
> +	return snprintf(page, PAGE_SIZE,
> +			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
>   }
>   
>   CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -571,6 +578,7 @@ static struct nullb_device *null_alloc_dev(void)
>   	dev->use_per_node_hctx = g_use_per_node_hctx;
>   	dev->zoned = g_zoned;
>   	dev->zone_size = g_zone_size;
> +	dev->zone_capacity = g_zone_capacity;
>   	dev->zone_nr_conv = g_zone_nr_conv;
>   	return dev;
>   }
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 624aac09b005..3d25c9ad2383 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -28,6 +28,15 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   		return -EINVAL;
>   	}
>   
> +	if (!dev->zone_capacity)
> +		dev->zone_capacity = dev->zone_size;
> +
> +	if (dev->zone_capacity > dev->zone_size) {
> +		pr_err("null_blk: zone capacity (%lu MB) larger than zone size (%lu MB)\n",
> +					dev->zone_capacity, dev->zone_size);
> +		return -EINVAL;
> +	}
> +
>   	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
>   	dev->nr_zones = dev_size >>
>   				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
> @@ -60,7 +69,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   
>   		zone->start = zone->wp = sector;
>   		zone->len = dev->zone_size_sects;
> -		zone->capacity = zone->len;
> +		zone->capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
>   		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
>   		zone->cond = BLK_ZONE_COND_EMPTY;
>   
> @@ -187,6 +196,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>   			return BLK_STS_IOERR;
>   		}
>   
> +		if (zone->wp + nr_sectors > zone->start + zone->capacity)
> +			return BLK_STS_IOERR;
> +
>   		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
>   			zone->cond = BLK_ZONE_COND_IMP_OPEN;
>   
> @@ -195,7 +207,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>   			return ret;
>   
>   		zone->wp += nr_sectors;
> -		if (zone->wp == zone->start + zone->len)
> +		if (zone->wp == zone->start + zone->capacity)
>   			zone->cond = BLK_ZONE_COND_FULL;
>   		return BLK_STS_OK;
>   	default:

Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

