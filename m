Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CEC433E2
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91EE2073E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="O/woc96R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGBK1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgGBK1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 06:27:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F64C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 03:27:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d18so17402418edv.6
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RKtpCLKD8JFl0ONPvNNuzySImdGGwxONv81jtJordPA=;
        b=O/woc96RFrhRk8kRZrJLfTC5SRSXG8vRiknu/V5+eXZK3by6Bjk9L3N9KbG2fDih2K
         D1weFlA7O5EKDkVJPDxOHVP5GqqsMzud9JQ5gFQWeYjZ6zC1mYUQCDumoDlcNk8AkkBA
         S/97EHwpHDvP1ectKWIOhDalmfcoYrkDUzH4u/E6WEjgL8z//GHkhjlKsFphLdJCOekr
         /cgq+7gxrlPXyNu0WIlR36VOFKyZ+IwM/3D7xKOJ+BvnxOXzmwciKEVM6XRv4GsbadTT
         cHZHq2mvnAJhR7LcKEz1clIVf7NuJxK+Gw7KB3Vb+fbjz/edrISTkFn1aCeM0n+NQhfx
         cM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RKtpCLKD8JFl0ONPvNNuzySImdGGwxONv81jtJordPA=;
        b=bDYhNk1f1c6Ashe8SEoxnNBefcgANKqc3wy2/Qmr4Un5qYMbi8AKOLPbMIucIoUL+1
         I+FVjVQvvGdxZf/0DCp5UeBqGf0CaqYPKjJ4H7hvpZZ5KcUjKgh70Qrbg1Va5imyQoT7
         NlzI3yu2+pOXz7wt3UOuzMydldeHFpZWJY60eZIblqsB2RG4FMI9Bk23S4iVaVnM5EJ2
         t7toUmdeF31ROAkPfo/EROp5GxX3+HT55JyGZNhj1MCSBiRLViz8GSoTPh0F73E5QVBB
         FC1Dv8PgR55PWe/V8gLNlQEd+EiM4wMf8qs5iZpBzx925c5O9MlmZwpEMTZ/W1RJYub/
         BPbQ==
X-Gm-Message-State: AOAM5303o3DpeuwIzRh5e2k6cOWFa2HTTXUWa9AkCb6iOU5A0KlR0+y+
        dF4R/ZxamNnjB1tKYysxefaC4Q==
X-Google-Smtp-Source: ABdhPJwT+S3etbkG7eq79LAUMOhccTkHrjopFrr5Ntz9unrrvJjhBQj4aQBHw6hPiXowL/7AiZYkdA==
X-Received: by 2002:aa7:d802:: with SMTP id v2mr26685708edq.77.1593685635824;
        Thu, 02 Jul 2020 03:27:15 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id bm21sm6385616ejb.13.2020.07.02.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:27:15 -0700 (PDT)
Date:   Thu, 2 Jul 2020 12:27:14 +0200
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
Message-ID: <20200702102714.d5igoqcvcavlunmv@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
 <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 08:49, Damien Le Moal wrote:
>On 2020/07/02 17:34, Javier González wrote:
>> On 02.07.2020 07:54, Damien Le Moal wrote:
>>> On 2020/07/02 15:55, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> As the zoned block device will have to deal with features that are
>>>> optional for the backend device, add a flag field to inform the block
>>>> layer about supported features. This builds on top of
>>>> blk_zone_report_flags and extendes to the zone report code.
>>>>
>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>> ---
>>>>  block/blk-zoned.c              | 3 ++-
>>>>  drivers/block/null_blk_zoned.c | 2 ++
>>>>  drivers/nvme/host/zns.c        | 1 +
>>>>  drivers/scsi/sd.c              | 2 ++
>>>>  include/linux/blkdev.h         | 3 +++
>>>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>> index 81152a260354..0f156e96e48f 100644
>>>> --- a/block/blk-zoned.c
>>>> +++ b/block/blk-zoned.c
>>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>>>  		return ret;
>>>>
>>>>  	rep.nr_zones = ret;
>>>> -	rep.flags = BLK_ZONE_REP_CAPACITY;
>>>> +	rep.flags = q->zone_flags;
>>>
>>> zone_flags seem to be a fairly generic flags field while rep.flags is only about
>>> the reported descriptors structure. So you may want to define a
>>> BLK_ZONE_REP_FLAGS_MASK and have:
>>>
>>> 	rep.flags = q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;
>>>
>>> to avoid flags meaningless for the user being set.
>>>
>>> In any case, since *all* zoned block devices now report capacity, I do not
>>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, especially
>>> considering that you set the flag for all zoned device types, including scsi
>>> which does not have zone capacity. This makes q->zone_flags rather confusing
>>> instead of clearly defining the device features as you mentioned in the commit
>>> message.
>>>
>>> I think it may be better to just drop this patch, and if needed, introduce the
>>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl support).
>>
>> I am using this as a way to pass the OFFLINE support flag to the block
>> layer. I used this too for the attributes. Are you thinking of a
>> different way to send this?
>>
>> I believe this fits too for capacity, but we can just pass it in
>> all report as before if you prefer.
>
>The point is that this patch as is does nothing and is needed as a preparatory
>patch if we want to have the offline flag set in the report. But:
>1) As commented in the offline ioctl patch, I am not sure the flag makes a lot
>of sense. sysfs or nothing at all may be OK as well. When we introduced the new
>open/close/finish ioctls, we did not add flags to signal that the device
>supports them. Granted, it was for nullblk and scsi, and both had the support.
>But running an application using these on an old kernel, and you will get
>-ENOTTY, meaning, not supported. So simply introducing the offline ioctl without
>any flag would be OK I think.

I see. My understanding after some comments from Christoph was that we
should use these bits to signal any optional features / capabilities
that would depend on the underlying driver, just as it is done with the
capacity flag today.

If not for the offline transition, for the attributes, I see it exactly
as the same use case as capacity, where we signal that a new field is
reported in the report structure.

Am I missing something here?

>
>Since DM support for this would be nice too and we now are in a situation where
>not all devices support the  ioctl, instead of a report flag (a little out of
>place), a queue limit exported through sysfs may be a cleaner way to both
>support DM correctly (stacked limits) and signal the support to the user. If you
>choose this approach, then this patch is not needed. The zoned_flags, or a
>regular queue flag like for RESET_ALL can be added in the offline ioctl patch.

I see. If we can reach an agreement that the above is a bad
understanding on my side, I will be happy to translate this into a sysfs
entry. If it is OK, I'll give it this week in the mailing list and send
a V4 next week.

>
>>
>>>
>>>> +
>>>>  	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
>>>>  		return -EFAULT;
>>>>  	return 0;
>>>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
>>>> index b05832eb21b2..957c2103f240 100644
>>>> --- a/drivers/block/null_blk_zoned.c
>>>> +++ b/drivers/block/null_blk_zoned.c
>>>> @@ -78,6 +78,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>>>>  	}
>>>>
>>>>  	q->limits.zoned = BLK_ZONED_HM;
>>>> +	q->zone_flags = BLK_ZONE_REP_CAPACITY;
>>>> +
>>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>>>>
>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>>> index 0642d3c54e8f..888264261ba3 100644
>>>> --- a/drivers/nvme/host/zns.c
>>>> +++ b/drivers/nvme/host/zns.c
>>>> @@ -81,6 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>>>  	}
>>>>
>>>>  	q->limits.zoned = BLK_ZONED_HM;
>>>> +	q->zone_flags = BLK_ZONE_REP_CAPACITY;
>>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>>  free_data:
>>>>  	kfree(id);
>>>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>>>> index d90fefffe31b..b9c920bace28 100644
>>>> --- a/drivers/scsi/sd.c
>>>> +++ b/drivers/scsi/sd.c
>>>> @@ -2967,6 +2967,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>>>>  	if (sdkp->device->type == TYPE_ZBC) {
>>>>  		/* Host-managed */
>>>>  		q->limits.zoned = BLK_ZONED_HM;
>>>> +		q->zone_flags = BLK_ZONE_REP_CAPACITY;
>>>>  	} else {
>>>>  		sdkp->zoned = (buffer[8] >> 4) & 3;
>>>>  		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
>>>> @@ -2983,6 +2984,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>>>>  					  "Drive-managed SMR disk\n");
>>>>  		}
>>>>  	}
>>>> +
>>>>  	if (blk_queue_is_zoned(q) && sdkp->first_scan)
>>>>  		sd_printk(KERN_NOTICE, sdkp, "Host-%s zoned block device\n",
>>>>  		      q->limits.zoned == BLK_ZONED_HM ? "managed" : "aware");
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>> index 8fd900998b4e..3f2e3425fa53 100644
>>>> --- a/include/linux/blkdev.h
>>>> +++ b/include/linux/blkdev.h
>>>> @@ -512,12 +512,15 @@ struct request_queue {
>>>>  	 * Stacking drivers (device mappers) may or may not initialize
>>>>  	 * these fields.
>>>>  	 *
>>>> +	 * Flags represent features as described by blk_zone_report_flags in blkzoned.h
>>>> +	 *
>>>>  	 * Reads of this information must be protected with blk_queue_enter() /
>>>>  	 * blk_queue_exit(). Modifying this information is only allowed while
>>>>  	 * no requests are being processed. See also blk_mq_freeze_queue() and
>>>>  	 * blk_mq_unfreeze_queue().
>>>>  	 */
>>>>  	unsigned int		nr_zones;
>>>> +	unsigned int		zone_flags;
>>>>  	unsigned long		*conv_zones_bitmap;
>>>>  	unsigned long		*seq_zones_wlock;
>>>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>>>
>>>
>>> And you are missing device-mapper support. DM target devices have a request
>>> queue that would need to set the zone_flags too.

Yes. As mentioned, I did not want to introduce more changes to this
series, just fix the mistake I made with some added debug code.

>>
>> Ok. I looked at it and I thought that this would be inherited by the
>> underlying device. I will add it in V3.
>>
>> Javier
>>
>>
