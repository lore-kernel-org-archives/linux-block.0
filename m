Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAABC67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF6320811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF6320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLMJSm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727980AbeLMJSm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 04:18:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44086AE38;
        Thu, 13 Dec 2018 09:18:40 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
Date:   Thu, 13 Dec 2018 10:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206164812.30925-5-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> Without this exposure, lsblk will fail as it tries to find out the
> device's dev_t numbers. This causes a real problem for nvme multipath
> devices, as their slaves are hidden.
> 
> Exposing them fixes the problem, even though trying to open the devices
> returns an error in the case of nvme multipath. So, right now, it's the
> driver's responsibility to return a failure to open hidden devices.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>   block/genhd.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 7674fce32fca..65a7fa664188 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -687,6 +687,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>   
>   	disk_alloc_events(disk);
>   
> +	disk_to_dev(disk)->devt = devt;
>   	if (disk->flags & GENHD_FL_HIDDEN) {
>   		/*
>   		 * Don't let hidden disks show up in /proc/partitions,
> @@ -698,13 +699,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>   		int ret;
>   
>   		/* Register BDI before referencing it from bdev */
> -		disk_to_dev(disk)->devt = devt;
>   		ret = bdi_register_owner(disk->queue->backing_dev_info,
>   						disk_to_dev(disk));
>   		WARN_ON(ret);
> -		blk_register_region(disk_devt(disk), disk->minors, NULL,
> -				    exact_match, exact_lock, disk);
>   	}
> +	blk_register_region(disk_devt(disk), disk->minors, NULL,
> +			    exact_match, exact_lock, disk);
>   	register_disk(parent, disk, groups);
>   	if (register_queue)
>   		blk_register_queue(disk);
> @@ -776,8 +776,7 @@ void del_gendisk(struct gendisk *disk)
>   		WARN_ON(1);
>   	}
>   
> -	if (!(disk->flags & GENHD_FL_HIDDEN))
> -		blk_unregister_region(disk_devt(disk), disk->minors);
> +	blk_unregister_region(disk_devt(disk), disk->minors);
>   
>   	kobject_put(disk->part0.holder_dir);
>   	kobject_put(disk->slave_dir);
> 
Welll ... this is not just 'lsblk', but more importantly this will force 
udev to create _block_ device nodes for the hidden devices, essentially 
'unhide' them.

Is this what we want?
Christoph?
I thought the entire _point_ of having hidden devices is that the are 
... well ... hidden ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
