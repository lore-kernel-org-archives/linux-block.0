Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C54C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E684207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="DtaXE94V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFZGJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZGJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:09:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F88C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:09:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a8so4802618edy.1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d31PpSzdyqjKwey15N5IKMpFdG+4vlPQzj0ZE0Mhabk=;
        b=DtaXE94Vz2GriaOfmgfyU24KSTsGYsYhe16nGRkyZ4Vt0Q7NOf7prCJyCX5nTwVho2
         s6MMFbJsaIEi9nMefDZdz76yW9pvGBYygSnr1E3c7AoXh60LuYDBZcLNlhZPw30Hl70d
         DMY+zkZncupMiqsV8tZ9ZxDzst6KRGkKH0bfJgSmhJDsDHFoBiVxSrJjyIt0g2dAJ+OK
         hUqk77PpAminKSPmVUrdVWHfzzVy10IojrUHZpeees/F0DJYgOL5KbJbgqM7uhgI6KyB
         POZ92YEOvf9TcKie8zOk80xyVgyk4DgXXzCgeb7D3nSc2lWLXy9gCBQYFi10iG/65CpK
         8h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d31PpSzdyqjKwey15N5IKMpFdG+4vlPQzj0ZE0Mhabk=;
        b=pv86PZ2BtKsBSlsIkg99pBY6sgJy2V4jnoTD/gr30sdWu1QaC2sqxW+bZDJexEGvu4
         EAZRebPWna1woodZR5ncdSTJ/FeJWyJ5aVmpspfG0cOe4XhqvclKT3fJjvoLuyq+9DVe
         HTypSqblzN7R2MUUx3G+Y7eTXNUpFHC07u2BvOO5mLZ6GY4Hb+nnClwq8loWr/RSDe6z
         TncZiMGtnahTMaJqBwCRf9bQMq6j+4Byxotd5qKODf6g+bGDkMFIQ24M/Ewt7i73q+U8
         TcogcysM7qm8W8Ciqq5752OiW/d8vTr1TASL5lck3HrtHBXqDdYMg/AO5Sb/Ojv5UFuG
         lnXw==
X-Gm-Message-State: AOAM533ofuLHmFLk+4eioo3ycsi3CdW3eE2W8P3ED1VSQNhQX0yuiVBf
        ZO7ogEvmc2vXyO20bo1FOX/E6w==
X-Google-Smtp-Source: ABdhPJx59lWENb/DyYuQHrZ3utvTYPC5G6bwIGS0eCgcvkCNm2mTPfpStObKCCaApZEWJfbF2ziT/w==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr1727405edr.16.1593151739548;
        Thu, 25 Jun 2020 23:08:59 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id bc23sm2347762edb.90.2020.06.25.23.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:08:58 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:08:58 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 01:34, Damien Le Moal wrote:
>On 2020/06/25 21:22, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Add support for offline transition on the zoned block device using the
>> new zone management IOCTL
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-core.c              | 2 ++
>>  block/blk-zoned.c             | 3 +++
>>  drivers/nvme/host/core.c      | 3 +++
>>  include/linux/blk_types.h     | 3 +++
>>  include/linux/blkdev.h        | 1 -
>>  include/uapi/linux/blkzoned.h | 1 +
>>  6 files changed, 12 insertions(+), 1 deletion(-)
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
>> index 29194388a1bb..704fc15813d1 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  	case BLK_ZONE_MGMT_RESET:
>>  		op = REQ_OP_ZONE_RESET;
>>  		break;
>> +	case BLK_ZONE_MGMT_OFFLINE:
>> +		op = REQ_OP_ZONE_OFFLINE;
>> +		break;
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f1215523792b..5b95c81d2a2d 100644
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
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 16b57fb2b99c..b3921263c3dd 100644
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
>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>  	case REQ_OP_ZONE_OPEN:
>>  	case REQ_OP_ZONE_CLOSE:
>>  	case REQ_OP_ZONE_FINISH:
>> +	case REQ_OP_ZONE_OFFLINE:
>>  		return true;
>>  	default:
>>  		return false;
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index bd8521f94dc4..8308d8a3720b 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>> -
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>
>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>> index a8c89fe58f97..d0978ee10fc7 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>  	BLK_ZONE_MGMT_FINISH	= 0x2,
>>  	BLK_ZONE_MGMT_OPEN	= 0x3,
>>  	BLK_ZONE_MGMT_RESET	= 0x4,
>> +	BLK_ZONE_MGMT_OFFLINE	= 0x5,
>>  };
>>
>>  /**
>>
>
>As mentioned in previous email, the usefulness of this is dubious. Please
>elaborate in the commit message. Sure NVMe ZNS defines this and we can support
>it. But without a good use case, what is the point ?

Use case is to transition zones in read-only state to offline when we
are done moving valid data. It is easier to explicitly managing zones
that are not usable by having all under the offline state.

>
>scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to a
>ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sectors" or
>the like to indicate support by the device or not would be nicer.

We can do that.

>
>Does offling ALL zones make any sense ? Because this patch does not prevent the
>use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good idea to
>allow offlining all zones, no ?

AFAIK the transition to offline is only valid when coming from a
read-only state. I did think of adding a check, but I can see that other
transitions go directly to the driver and then the device, so I decided
to follow the same model. If you think it is better, we can add the
check.

Javier
