Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07656C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D3320780
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jcXYO2C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGBKSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgGBKSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 06:18:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF4C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 03:18:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so28674938ejb.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xbWDHuFi/asrt9wfewvCpHAZIXQkTs3SNUDtcY1u8hU=;
        b=jcXYO2C3KpOvz2vxbAF9UuZbvbe1p7N9wWO46hx2xV5iYz+16cf2tv5D0tdiFN35av
         cNjIfrHtOFD05lCWRB2p/K2kh968Jzhy4e3ttjGUPMABoxAUfIQH23QS7hhnogrQgfbv
         RxxPdsJmync1TQe6wv3YNdlkbFvhEV3XFR3xSGtv2wstx+aDlw5f5etM9ZBAjs2e6cl+
         KFkBE/uy8iAoFYXqqGSvRf2eGpBoLYvpSHM/L9HJptaSrhBBxiShXAO1zPqnAgiggRUn
         X13epM/lUnJTra/507kFIU9IZFLFJsRTDLMjJwxKcCFkR73REtWtyAa7i+5O/G4PVFtt
         oi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xbWDHuFi/asrt9wfewvCpHAZIXQkTs3SNUDtcY1u8hU=;
        b=WHDWCsTG5b7/X3FwayWl3WQqg2SnFR8J1W1RIIPA74YNMYUhXS4DfP7uoIpZ1dMkks
         dj3Q14O0dOufvwMOxdICyhGZRsLIvoqxf9gd3S7XxUIRT1iMVMg1wQEaucKUo+AGGhXH
         Kt/OYjuDT0BJh7FuS2s0wpT/63NhngfcJsXffC1fhFNZSdwb/TaHh6XsGhqSZCI3AGKB
         MoO/oYsrvuqXU8mNEb9BUVfXRWREyY73gpL6VcACecgPnXOHELxiRVihRr8lRno/yYQk
         B1NOes+ZcsACjiTypACKHK6l2ivxCV+aIR9P0LgX+VtN+Z/fjQP4F+8aC5fgC90ikSz/
         /7+w==
X-Gm-Message-State: AOAM531Ge4qsfQlPahpt1oVd2Hs4bw4GcELFuwxmjiVlootePCHvkIa7
        cj599hpQuUXQkvTNqOQ181VFyg==
X-Google-Smtp-Source: ABdhPJyT2g6O3CfkBUhFCbbksffwPXhxQC9QzTc0kfnvqAD2Rt0+u2BvJlNloBVXAkXCrroe0BR2zw==
X-Received: by 2002:a17:907:7244:: with SMTP id ds4mr17235363ejc.509.1593685100092;
        Thu, 02 Jul 2020 03:18:20 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id a37sm9289788edf.86.2020.07.02.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:18:19 -0700 (PDT)
Date:   Thu, 2 Jul 2020 12:18:18 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 1/4] block: Add zone flags to queue zone prop.
Message-ID: <20200702101818.letttarzs4pwi7os@mpHalley.local>
References: <20200702092438.63717-1-javier@javigon.com>
 <20200702092438.63717-2-javier@javigon.com>
 <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB37519E324412FC96FDE6BFC1E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 09:46, Damien Le Moal wrote:
>On 2020/07/02 18:25, Javier González wrote:
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
>*all* zoned devices support capacity. So why changing this ?
>You are only forcing adding setting the queue flags for all device drivers. That
>is more code.
>
>> +
>
>White line change
>
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
>
>White line change
>
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>>
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index c08f6281b614..afe62dc27ff7 100644
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
>
>White line change
>
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
>And you are still breaking device mapper targets report zones with this patch.

Yes. I mentioned in the version changes that I only fixed a bad commit
with debug code. I'll address this in a new version when the use of the
feature bit is clarified (i.e., keep it this way or move to sysfs).

Javier
