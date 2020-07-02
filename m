Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CEC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CD320720
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QMaVtQUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGBIeg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgGBIeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:34:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D3C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:34:36 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so13698895edr.5
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qi9qGF+SqQYuKRudvW84peIMSp1FDuyHvZ3I82vYQjg=;
        b=QMaVtQUw67TOY8AIWVh5B/jTHwhYg/McW4YY3DLJr4nE2LTcEgxHyqm6BB+xkN2sxS
         e5yDTfynX2vrT7S/vmx4xp/bECLjs++MjdCvldaQbv6R2v+phwdYiZwBxvPkSrzo4ELU
         MEqyEVSCkE4sDy9ra8jHwrz8zIIBJ4tfYmw5W9Xckc6spGHwg3H5a2s3dzuLIpLdlT1u
         uwsr/P0i7eWnel0BTxgX+y5ZY8czC+NDrovMfImI/LgN/k77SjAH6dHCH9Tu1OvRUgv1
         MghwDW+4JkXAOFivNSkLYwRUQz5LbSgZcLZlLBJtpOoE9+UQ+udP0XVfyruSTN7InDiV
         2Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qi9qGF+SqQYuKRudvW84peIMSp1FDuyHvZ3I82vYQjg=;
        b=ulJpOtxEGCTWr64SHlVpyxrcFE3zfD1CnQKRkIvTiqXp2QA8yLm+Y6VbNRoBbQWlTw
         iS9CvDxOggczI69LVoIf1WG/GoX6rDkyuMIfLKf6byt0jDvwMjd3JXnz14Z1fGPg1f0Y
         AtBB50VbMWnyb+9WoZFLHPGYJYYYAWN93hMrAM0NyWuV7qhZXME0MkRhp4pXo1I1EHCk
         4u7IC1vXeS7Kl5CONxAtfI7Mvdg4W0UgoxZPS0zCEDH2EgsNpWtoHceeRO4+DkCEHac4
         3LM1dipdNbLyPnTKGd+KCBMjyTffyrWM7e1dXfhRQjyrnSCKRk2E3Wd/8OzSotEvinDo
         HgIg==
X-Gm-Message-State: AOAM5303fjYsPtFM34ncHeIrK5sOZeQtjX5tCl5RhAE6hjHVh4DlM5gz
        Qo5ZADMYVWvbU5nmVMSVEgIP7A==
X-Google-Smtp-Source: ABdhPJxyKxm9ZA5zyOrNFXILHYk1ydemwjcqycIrZHrUPV+z5kl1jj+rAQi3+BMRu5PEERrCEZCJjA==
X-Received: by 2002:aa7:c1d8:: with SMTP id d24mr34060818edp.178.1593678874803;
        Thu, 02 Jul 2020 01:34:34 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b14sm4996168ejg.18.2020.07.02.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:34:34 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:34:30 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 1/4] block: Add zone flags to queue zone prop.
Message-ID: <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 07:54, Damien Le Moal wrote:
>On 2020/07/02 15:55, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> As the zoned block device will have to deal with features that are
>> optional for the backend device, add a flag field to inform the block
>> layer about supported features. This builds on top of
>> blk_zone_report_flags and extendes to the zone report code.
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-zoned.c              | 3 ++-
>>  drivers/block/null_blk_zoned.c | 2 ++
>>  drivers/nvme/host/zns.c        | 1 +
>>  drivers/scsi/sd.c              | 2 ++
>>  include/linux/blkdev.h         | 3 +++
>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 81152a260354..0f156e96e48f 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>  		return ret;
>>
>>  	rep.nr_zones = ret;
>> -	rep.flags = BLK_ZONE_REP_CAPACITY;
>> +	rep.flags = q->zone_flags;
>
>zone_flags seem to be a fairly generic flags field while rep.flags is only about
>the reported descriptors structure. So you may want to define a
>BLK_ZONE_REP_FLAGS_MASK and have:
>
>	rep.flags = q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;
>
>to avoid flags meaningless for the user being set.
>
>In any case, since *all* zoned block devices now report capacity, I do not
>really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, especially
>considering that you set the flag for all zoned device types, including scsi
>which does not have zone capacity. This makes q->zone_flags rather confusing
>instead of clearly defining the device features as you mentioned in the commit
>message.
>
>I think it may be better to just drop this patch, and if needed, introduce the
>zone_flags field where it may be needed (e.g. OFFLINE zone ioctl support).

I am using this as a way to pass the OFFLINE support flag to the block
layer. I used this too for the attributes. Are you thinking of a
different way to send this?

I believe this fits too for capacity, but we can just pass it in
all report as before if you prefer.

>
>> +
>>  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
>>  		return -EFAULT;
>>  	return 0;
>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
>> index b05832eb21b2..957c2103f240 100644
>> --- a/drivers/block/null_blk_zoned.c
>> +++ b/drivers/block/null_blk_zoned.c
>> @@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>>  	}
>>
>>  	q->limits.zoned = BLK_ZONED_HM;
>> +	q->zone_flags = BLK_ZONE_REP_CAPACITY;
>> +
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>>
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index 0642d3c54e8f..888264261ba3 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  	}
>>
>>  	q->limits.zoned = BLK_ZONED_HM;
>> +	q->zone_flags = BLK_ZONE_REP_CAPACITY;
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  free_data:
>>  	kfree(id);
>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>> index d90fefffe31b..b9c920bace28 100644
>> --- a/drivers/scsi/sd.c
>> +++ b/drivers/scsi/sd.c
>> @@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>>  	if (sdkp->device->type == TYPE_ZBC) {
>>  		/* Host-managed */
>>  		q->limits.zoned = BLK_ZONED_HM;
>> +		q->zone_flags = BLK_ZONE_REP_CAPACITY;
>>  	} else {
>>  		sdkp->zoned = (buffer[8] >> 4) & 3;
>>  		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
>> @@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>>  					  "Drive-managed SMR disk\n");
>>  		}
>>  	}
>> +
>>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)
>>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
>>  		      q->limits.zoned == BLK_ZONED_HM ? "managed" : "aware");
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 8fd900998b4e..3f2e3425fa53 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -512,12 +512,15 @@ struct request_queue {
>>  	 * Stacking drivers (device mappers) may or may not initialize
>>  	 * these fields.
>>  	 *
>> +	 * Flags represent features as described by blk_zone_report_flags in blkzoned.h
>> +	 *
>>  	 * Reads of this information must be protected with blk_queue_enter() /
>>  	 * blk_queue_exit(). Modifying this information is only allowed while
>>  	 * no requests are being processed. See also blk_mq_freeze_queue() and
>>  	 * blk_mq_unfreeze_queue().
>>  	 */
>>  	unsigned int		nr_zones;
>> +	unsigned int		zone_flags;
>>  	unsigned long		*conv_zones_bitmap;
>>  	unsigned long		*seq_zones_wlock;
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>
>
>And you are missing device-mapper support. DM target devices have a request
>queue that would need to set the zone_flags too.

Ok. I looked at it and I thought that this would be inherited by the
underlying device. I will add it in V3.

Javier

