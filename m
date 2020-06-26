Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96099C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C312076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="wjlyKHfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFZGBx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZGBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:01:53 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A943C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:01:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so6003216edb.3
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=liOwZzMMqZUggalO/Lz6IGxFUJ8BgySWL76nB2HtWX0=;
        b=wjlyKHfPYvQPJeLkTSWgrYeCxZU/Qq8z9rrL22++KnyShAXc2KZnR+pxj/DSVNVjjE
         DOzOCimisJCmisN4R4ffVvYMr7Hbt9WTC28y51Po+g4XqxrXb0uukDMitBe25OviipPQ
         pRbsRh/vqcOs0rOiUn9+d9tXFMEsOQTXh6gA1RtbviR6MuZ0Wd6zShtsHMUtCNWXWgsU
         byszuso5LOzjh3IHGK8ZEdm9SnK/ggvFcxGlRhUXk+YCNgPUGns3wj7i32RlwH1SEmoG
         u2Wii2NX+mfcAUk3jbRWuksPRyX878ZvnW4/21ICd/TnFvhXU7uaHNy5YT7Uw3fkYUtJ
         kuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=liOwZzMMqZUggalO/Lz6IGxFUJ8BgySWL76nB2HtWX0=;
        b=aKbnwzJOeu5he05uFXUZ00GXVG4O9bPVp0iQsy1dUevGMNw88T6hzRX7LyQSJdlCdu
         ZFq4tFUa3yaRSgZeJ9pymtUPiGga8srozpW+pL77lJkKjqG+Z88qfchzjT/x5VjaCBEF
         SXJrfQkA0Tbzfoh2ElxaxsRfKTWW/PrtWC2DHYRPMcZwkre7HGC2CbffMvi3HYkiAWRb
         LqZdx51QlOZjSFe1kylhacFtq0ZSaJ31MvkJoUh3ULgETSZK9+I2i/WO2g4um74XBgGo
         igL59fgc+FX7UW1Zxdf3Z1Vq88gqK7NR7ElAIyVgm/twXjZa71RI7AY1YuImYtZxLoN0
         o3nA==
X-Gm-Message-State: AOAM533HPs2Bs/xxBjVeR0nFbjAo6z/V6j3A+cI4KGiguxtcE6K/flna
        Z9eLtlFSuGdc//skTOf/8BqW/A==
X-Google-Smtp-Source: ABdhPJxz3l9GB2Y/unyJL6AYdroyYULWO9zO0Lmp+hMnpt+PTXp5pDzv+4VhOqoUY7poxM6J6EyZLg==
X-Received: by 2002:a50:c90d:: with SMTP id o13mr1761616edh.338.1593151311775;
        Thu, 25 Jun 2020 23:01:51 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id k23sm18360776ejo.120.2020.06.25.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:01:50 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:01:50 +0200
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
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Message-ID: <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 01:17, Damien Le Moal wrote:
>On 2020/06/25 21:22, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> The current IOCTL interface for zone management is limited by struct
>> blk_zone_range, which is unfortunately not extensible. Specially, the
>> lack of flags is problematic for ZNS zoned devices.
>>
>> This new IOCTL is designed to be a superset of the current one, with
>> support for flags and bits for extensibility.
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-
>>  block/ioctl.c                 |  2 ++
>>  include/linux/blkdev.h        |  9 ++++++
>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
>>  4 files changed, 99 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 81152a260354..e87c60004dc5 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
>>   * Called from blkdev_ioctl.
>>   */
>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>  			   unsigned int cmd, unsigned long arg)
>>  {
>>  	void __user *argp = (void __user *)arg;
>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				GFP_KERNEL);
>>  }
>>
>> +/*
>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioctl(), with
>> + * blk_zone_mgmt structure.
>> + *
>> + * Called from blkdev_ioctl.
>> + */
>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>> +			   unsigned int cmd, unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +	struct request_queue *q;
>> +	struct blk_zone_mgmt zmgmt;
>> +	enum req_opf op;
>> +
>> +	if (!argp)
>> +		return -EINVAL;
>> +
>> +	q = bdev_get_queue(bdev);
>> +	if (!q)
>> +		return -ENXIO;
>> +
>> +	if (!blk_queue_is_zoned(q))
>> +		return -ENOTTY;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EACCES;
>> +
>> +	if (!(mode & FMODE_WRITE))
>> +		return -EBADF;
>> +
>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
>> +		return -EFAULT;
>> +
>> +	switch (zmgmt.action) {
>> +	case BLK_ZONE_MGMT_CLOSE:
>> +		op = REQ_OP_ZONE_CLOSE;
>> +		break;
>> +	case BLK_ZONE_MGMT_FINISH:
>> +		op = REQ_OP_ZONE_FINISH;
>> +		break;
>> +	case BLK_ZONE_MGMT_OPEN:
>> +		op = REQ_OP_ZONE_OPEN;
>> +		break;
>> +	case BLK_ZONE_MGMT_RESET:
>> +		op = REQ_OP_ZONE_RESET;
>> +		break;
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +
>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>> +				GFP_KERNEL);
>> +}
>> +
>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>  						   unsigned int nr_zones)
>>  {
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index bdb3bbb253d9..0ea29754e7dd 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>>  	case BLKOPENZONE:
>>  	case BLKCLOSEZONE:
>>  	case BLKFINISHZONE:
>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>> +	case BLKMGMTZONE:
>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>  	case BLKGETZONESZ:
>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 8fd900998b4e..bd8521f94dc4 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>>
>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>  				     unsigned int cmd, unsigned long arg);
>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>> +				  unsigned int cmd, unsigned long arg);
>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>
>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
>>  	return -ENOTTY;
>>  }
>>
>> +
>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>> +					unsigned int cmd, unsigned long arg)
>> +{
>> +	return -ENOTTY;
>> +}
>> +
>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>>  					 fmode_t mode, unsigned int cmd,
>>  					 unsigned long arg)
>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>> index 42c3366cc25f..07b5fde21d9f 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -142,6 +142,38 @@ struct blk_zone_range {
>>  	__u64		nr_sectors;
>>  };
>>
>> +/**
>> + * enum blk_zone_action - Zone state transitions managed from user-space
>> + *
>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state
>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state
>> + */
>> +enum blk_zone_action {
>> +	BLK_ZONE_MGMT_CLOSE	= 0x1,
>> +	BLK_ZONE_MGMT_FINISH	= 0x2,
>> +	BLK_ZONE_MGMT_OPEN	= 0x3,
>> +	BLK_ZONE_MGMT_RESET	= 0x4,
>> +};
>> +
>> +/**
>> + * struct blk_zone_mgmt - Extended zoned management
>> + *
>> + * @action: Zone action as in described in enum blk_zone_action
>> + * @flags: Flags for the action
>> + * @sector: Starting sector of the first zone to operate on
>> + * @nr_sectors: Total number of sectors of all zones to operate on
>> + */
>> +struct blk_zone_mgmt {
>> +	__u8		action;
>> +	__u8		resv3[3];
>> +	__u32		flags;
>> +	__u64		sector;
>> +	__u64		nr_sectors;
>> +	__u64		resv31;
>> +};
>> +
>>  /**
>>   * Zoned block device ioctl's:
>>   *
>> @@ -166,5 +198,6 @@ struct blk_zone_range {
>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>
>>  #endif /* _UAPI_BLKZONED_H */
>>
>
>Without defining what the flags can be, it is hard to judge what will change
>from the current distinct ioctls.
>

The first flag is the one to select all. Down the line we have other
modifiers that make sense, but it is true that it is public yet.

Would you like to wait until then or is it an option to revise the IOCTL
now?

Javier
