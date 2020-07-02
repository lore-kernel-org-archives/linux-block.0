Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2736AC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A1D2084C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="2G+5hg19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgGBIkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBIkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:40:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3409C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:40:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lx13so9645598ejb.4
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CY1+xXeM98A+4ORvwrMrgQ9HrN1UK/F/dXmhdXBR9Q8=;
        b=2G+5hg19z8zKRrhF6e9qYJrqb9QevMu7duG3B47GG3zmgOnY8QY1fD0z/P23IPx07k
         gBCCEJW4iT12nsuTeiKO0LNuZ/NNHe7elGJP9yerFAkkDlfgk4k0kElJOTHM3IxAABJz
         GqOXYn0kQuqM1xCLq9kHB17Wg2UJPEvCPtsIi/nb3n5CE3DBlqPXUtXYnwlIdTTd+zZy
         31tJVZmZeKpGv6x0wtEI72hl/EQ2kmpQraoUnNls58Zc/sEfFBvkFIkq09gcvcAdRSME
         cEivk/dMnqdUy/FdXcWQIX9pioIkvS11VtFMZQlW+RUK6ITk+oyM8B5txaMzoAOUq8mj
         mwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CY1+xXeM98A+4ORvwrMrgQ9HrN1UK/F/dXmhdXBR9Q8=;
        b=RApZPj9taUjHVygKnZMX+c57i8QOFTJ4nrSM7a5qvncUPytrkWor2VJ5Ba3n1f+TQR
         AQY8kuPxiEMu/Nckw1NekT7nn5ZQrmJ89dr8GbOZGvJfLb0aB3CwuXGwO37f6f+UvjX1
         DhtfbQEHAf6AootX7eTei4loJGKMu1oigOTPnkZEUvkxK5L0mMxTQl3/jm834ijkJZd2
         NAXyO7aqb8ubs9sLUglBPlqlENJvC+7t+dWaxcBpE5gQ/4QeqpgH3+jDf9y0I7dTOa0H
         1WQI0IkIXic250ZjctDOsZG0jGkKMO1HRuzXTlRCa5SML5bZz5pDWNS69b84afytG8/j
         9WIQ==
X-Gm-Message-State: AOAM530eTjIOZFCVOAR9q/0VEYUKcdpsOMvN+VhlxeaSd1B3HIy7mfIb
        AC6MOb7dhCgYdUz9ZbTMc9HbEA==
X-Google-Smtp-Source: ABdhPJxobGY9yFW8oPSZk92kT6B6MKt1vmHt8jcVvdaNT58s95f3ggU08VHZZOMFxiSzlBcLG/d4QA==
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr24636676eja.346.1593679202338;
        Thu, 02 Jul 2020 01:40:02 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id s2sm8677638edu.39.2020.07.02.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:40:01 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:39:56 +0200
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
Subject: Re: [PATCH 2/4] block: add support for zone offline transition
Message-ID: <20200702083956.rwlewfgyc6ycs4ys@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-3-javier@javigon.com>
 <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751F9F6BBBAD8CAC7E15431E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 08:10, Damien Le Moal wrote:
>On 2020/07/02 15:55, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Add support for offline transition on the zoned block device. Use the
>> existing feature flags for the underlying driver to report support for
>> the feature, as currently this transition is only supported in ZNS and
>> not in ZAC/ZBC
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-core.c              | 2 ++
>>  block/blk-zoned.c             | 8 +++++++-
>>  drivers/nvme/host/core.c      | 3 +++
>>  drivers/nvme/host/zns.c       | 2 +-
>>  include/linux/blk_types.h     | 3 +++
>>  include/linux/blkdev.h        | 1 -
>>  include/uapi/linux/blkzoned.h | 3 +++
>>  7 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 03252af8c82c..589cbdacc5ec 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
>>  	REQ_OP_NAME(ZONE_CLOSE),
>>  	REQ_OP_NAME(ZONE_FINISH),
>>  	REQ_OP_NAME(ZONE_APPEND),
>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>  	REQ_OP_NAME(WRITE_SAME),
>>  	REQ_OP_NAME(WRITE_ZEROES),
>>  	REQ_OP_NAME(SCSI_IN),
>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>  	case REQ_OP_ZONE_OPEN:
>>  	case REQ_OP_ZONE_CLOSE:
>>  	case REQ_OP_ZONE_FINISH:
>> +	case REQ_OP_ZONE_OFFLINE:
>>  		if (!blk_queue_is_zoned(q))
>>  			goto not_supported;
>>  		break;
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 0f156e96e48f..b97f67f462b4 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>  }
>>
>>  /*
>> - * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
>> + * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLINEZONE
>> + * ioctl processing.
>>   * Called from blkdev_ioctl.
>>   */
>>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>> @@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  	case BLKFINISHZONE:
>>  		op = REQ_OP_ZONE_FINISH;
>>  		break;
>> +	case BLKOFFLINEZONE:
>> +		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))
>> +			return -EINVAL;
>
>return -ENOTTY here.
>
>That is the error returned for regular block devices when a zone ioctl is
>received, indicating the lack of support for these ioctls. Since this is also a
>lack  of support by the device here too, we may as well keep the same error
>code. Returning -EINVAL should be reserved for cases where the device can accept
>the ioctl but start sector or number of sectors is invalid.

Ok.

>
>
>> +		op = REQ_OP_ZONE_OFFLINE;
>> +		break;
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e5f754889234..1f5c7fc3d2c9 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>  	case REQ_OP_ZONE_FINISH:
>>  		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>  		break;
>> +	case REQ_OP_ZONE_OFFLINE:
>> +		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>> +		break;
>>  	case REQ_OP_WRITE_ZEROES:
>>  		ret = nvme_setup_write_zeroes(ns, req, cmd);
>>  		break;
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index 888264261ba3..b34d2ed13825 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  	}
>>
>>  	q->limits.zoned = BLK_ZONED_HM;
>> -	q->zone_flags = BLK_ZONE_REP_CAPACITY;
>> +	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
>
>The name BLK_ZONE_REP_OFFLINE is not ideal.  This flag is not about if offline
>condition will be reported or not. It is about the drive supporting an explicit
>offlining zone operation.

I wanted to follow the same convention. I can change the name in the
same enum for the report flags.

>
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  free_data:
>>  	kfree(id);
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index ccb895f911b1..c0123c643e2f 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -316,6 +316,8 @@ enum req_opf {
>>  	REQ_OP_ZONE_FINISH	= 12,
>>  	/* write data at the current zone write pointer */
>>  	REQ_OP_ZONE_APPEND	= 13,
>> +	/* Transition a zone to offline */
>> +	REQ_OP_ZONE_OFFLINE	= 14,
>>
>>  	/* SCSI passthrough using struct scsi_request */
>>  	REQ_OP_SCSI_IN		= 32,
>> @@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>  	case REQ_OP_ZONE_OPEN:
>>  	case REQ_OP_ZONE_CLOSE:
>>  	case REQ_OP_ZONE_FINISH:
>> +	case REQ_OP_ZONE_OFFLINE:
>>  		return true;
>>  	default:
>>  		return false;
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 3f2e3425fa53..e489b646486d 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>  				     unsigned int cmd, unsigned long arg);
>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>> -
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>
>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>> index 42c3366cc25f..e5adf4a9f4b0 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -77,9 +77,11 @@ enum blk_zone_cond {
>>   * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>>   *
>>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>> + * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.
>
>The device supports explicit zone offline transition
>
>Since the implicit transition by the device may happen, even on SMR disks.
>
>But I am not sure this flags is very useful. Or rather, isn't it out of place
>here ? Device features are normally reported through sysfs (e.g. discard, etc).
>It is certainly confusing and not matching the user doc for rep.flag which
>states that the flags are about the zone descriptors, not what the device can
>do. So at the very least, the comments need to change.
>
>The other thing is that the implementation does not consider device mapper case
>again: if a DM target is built on one or more ZNS drives all supporting zone
>offline, then the target should be allowed to report zone offline support too,
>no ? dm-linear and dm-flakey certainly should be allowed to do that. Exporting a
>"zone_offline" (or something like named that) sysfs limit would allow that to be
>supported easily through limit stacking and avoid the need for the report flag.

I can add that too. I left it out as I did not add any implementation on
top of it for the device mapper itself. If this is the way that it makes
sense, then we can add it to the different device mappers later on.

>
>Happy to here others opinion about this one though.
>
>>   */
>>  enum blk_zone_report_flags {
>>  	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>> +	BLK_ZONE_REP_OFFLINE	= (1 << 1),
>>  };
>>
>>  /**
>> @@ -166,5 +168,6 @@ struct blk_zone_range {
>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>> +#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
>>
>>  #endif /* _UAPI_BLKZONED_H */
>>
>

