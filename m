Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834BC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59CD20768
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="lMoipcHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFZHIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:08:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79051C08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:08:24 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so8330969ejc.8
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YJzyOSLNcwG7HiP7VCvP0ZO8fHWZlEGAzeYmZP3hzEA=;
        b=lMoipcHcrkt9gz3wfrvmEiiYCw6GFtd+k/p5uWVwRroXcK0lGpTgzd7bDpR7eEFyOj
         RxVZ6UNlUXZvdHBigMlUKp6LdqH+PtXxC0KzRsV6/wGxZGzFZFbdwZfNGo7894FF37Tx
         Qosaj2ryl4wVQ6QT3PrmlDGqxYnjLN55rcRL+zBoY+9msTHfeU0Ma8bIcQ1hQw48i2ma
         HEIs5y6Wwzc9yMv1qv85/Fe8XIjSU/SH7Zp7jNpbihwY3YvyQJEKZkE/65ZVFUpfEdxN
         En1RXmwzIRzlnU7peBjTBw3JrII0W7ecB/kzydIG4VxRGxIRlAbSJaMQABtxddICA6w6
         If3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YJzyOSLNcwG7HiP7VCvP0ZO8fHWZlEGAzeYmZP3hzEA=;
        b=ogn/b6osZLdNBR/eIpKA9rfnm897duNMr+vofidlyDAL6KTTNs5HuJxbMkuZbrW8xU
         hr3BgYsfcbLh7cTGkfqZk+K0RyCA8vcVl81KYlLnh9FxkPDXlMf9OdqrmnNGw996pyIw
         qGojy6eofidcndBSrRiosbQ/veO1ijuRuYNy2vwCbvvH6P5urTMpifm11mWoJb1psfHq
         8IGpsXqxlb53fQYwauu8G+YTTQph6JMQ+9herPc2syPjcde5wDStIZOp6H0otiBO7wYG
         0IWQ7Pt7PTOOwmguj54Xr121OReInfg/hu5MTEl8vfx1HYmPsJ2KaMftQDvHBxHF79JN
         oaqw==
X-Gm-Message-State: AOAM530qoF/bmm+pB+serLa8PhSjHHQJRv1IgyJSy8Y3ohhKmo7mQIZ9
        fziG/hcZAo/L9XwFlVzmsyz4yw==
X-Google-Smtp-Source: ABdhPJwUVyUPBLhoVOp2/qQgZWi77IBcUBh3km6/X8PUso/pImHAxvQxr08bJ9k+qeQ9xcD4N+hfVw==
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr1398559ejj.155.1593155303171;
        Fri, 26 Jun 2020 00:08:23 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id i33sm2283491edi.21.2020.06.26.00.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:08:22 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:08:21 +0200
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
Message-ID: <20200626070821.3ubhs5ovwzdwws2t@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
 <CY4PR04MB37514A1058726B8681AE2501E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065128.6x2csy5mjunjbr3t@mpHalley.localdomain>
 <CY4PR04MB3751C477970B556483800A1BE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751C477970B556483800A1BE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 07:03, Damien Le Moal wrote:
>On 2020/06/26 15:51, Javier González wrote:
>> On 26.06.2020 06:37, Damien Le Moal wrote:
>>> On 2020/06/26 15:01, Javier González wrote:
>>>> On 26.06.2020 01:17, Damien Le Moal wrote:
>>>>> On 2020/06/25 21:22, Javier González wrote:
>>>>>> From: Javier González <javier.gonz@samsung.com>
>>>>>>
>>>>>> The current IOCTL interface for zone management is limited by struct
>>>>>> blk_zone_range, which is unfortunately not extensible. Specially, the
>>>>>> lack of flags is problematic for ZNS zoned devices.
>>>>>>
>>>>>> This new IOCTL is designed to be a superset of the current one, with
>>>>>> support for flags and bits for extensibility.
>>>>>>
>>>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>> ---
>>>>>>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-
>>>>>>  block/ioctl.c                 |  2 ++
>>>>>>  include/linux/blkdev.h        |  9 ++++++
>>>>>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
>>>>>>  4 files changed, 99 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>>> index 81152a260354..e87c60004dc5 100644
>>>>>> --- a/block/blk-zoned.c
>>>>>> +++ b/block/blk-zoned.c
>>>>>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
>>>>>>   * Called from blkdev_ioctl.
>>>>>>   */
>>>>>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  			   unsigned int cmd, unsigned long arg)
>>>>>>  {
>>>>>>  	void __user *argp = (void __user *)arg;
>>>>>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  				GFP_KERNEL);
>>>>>>  }
>>>>>>
>>>>>> +/*
>>>>>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioctl(), with
>>>>>> + * blk_zone_mgmt structure.
>>>>>> + *
>>>>>> + * Called from blkdev_ioctl.
>>>>>> + */
>>>>>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>> +			   unsigned int cmd, unsigned long arg)
>>>>>> +{
>>>>>> +	void __user *argp = (void __user *)arg;
>>>>>> +	struct request_queue *q;
>>>>>> +	struct blk_zone_mgmt zmgmt;
>>>>>> +	enum req_opf op;
>>>>>> +
>>>>>> +	if (!argp)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	q = bdev_get_queue(bdev);
>>>>>> +	if (!q)
>>>>>> +		return -ENXIO;
>>>>>> +
>>>>>> +	if (!blk_queue_is_zoned(q))
>>>>>> +		return -ENOTTY;
>>>>>> +
>>>>>> +	if (!capable(CAP_SYS_ADMIN))
>>>>>> +		return -EACCES;
>>>>>> +
>>>>>> +	if (!(mode & FMODE_WRITE))
>>>>>> +		return -EBADF;
>>>>>> +
>>>>>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
>>>>>> +		return -EFAULT;
>>>>>> +
>>>>>> +	switch (zmgmt.action) {
>>>>>> +	case BLK_ZONE_MGMT_CLOSE:
>>>>>> +		op = REQ_OP_ZONE_CLOSE;
>>>>>> +		break;
>>>>>> +	case BLK_ZONE_MGMT_FINISH:
>>>>>> +		op = REQ_OP_ZONE_FINISH;
>>>>>> +		break;
>>>>>> +	case BLK_ZONE_MGMT_OPEN:
>>>>>> +		op = REQ_OP_ZONE_OPEN;
>>>>>> +		break;
>>>>>> +	case BLK_ZONE_MGMT_RESET:
>>>>>> +		op = REQ_OP_ZONE_RESET;
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		return -ENOTTY;
>>>>>> +	}
>>>>>> +
>>>>>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>>>>> +				GFP_KERNEL);
>>>>>> +}
>>>>>> +
>>>>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>>>>>  						   unsigned int nr_zones)
>>>>>>  {
>>>>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>>>>> index bdb3bbb253d9..0ea29754e7dd 100644
>>>>>> --- a/block/ioctl.c
>>>>>> +++ b/block/ioctl.c
>>>>>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  	case BLKOPENZONE:
>>>>>>  	case BLKCLOSEZONE:
>>>>>>  	case BLKFINISHZONE:
>>>>>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>>>>>> +	case BLKMGMTZONE:
>>>>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>>>>>  	case BLKGETZONESZ:
>>>>>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>>>> index 8fd900998b4e..bd8521f94dc4 100644
>>>>>> --- a/include/linux/blkdev.h
>>>>>> +++ b/include/linux/blkdev.h
>>>>>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>>>>>>
>>>>>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  				     unsigned int cmd, unsigned long arg);
>>>>>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>> +				  unsigned int cmd, unsigned long arg);
>>>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>>>
>>>>>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
>>>>>>  	return -ENOTTY;
>>>>>>  }
>>>>>>
>>>>>> +
>>>>>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>> +					unsigned int cmd, unsigned long arg)
>>>>>> +{
>>>>>> +	return -ENOTTY;
>>>>>> +}
>>>>>> +
>>>>>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>>>>>>  					 fmode_t mode, unsigned int cmd,
>>>>>>  					 unsigned long arg)
>>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>>>>> index 42c3366cc25f..07b5fde21d9f 100644
>>>>>> --- a/include/uapi/linux/blkzoned.h
>>>>>> +++ b/include/uapi/linux/blkzoned.h
>>>>>> @@ -142,6 +142,38 @@ struct blk_zone_range {
>>>>>>  	__u64		nr_sectors;
>>>>>>  };
>>>>>>
>>>>>> +/**
>>>>>> + * enum blk_zone_action - Zone state transitions managed from user-space
>>>>>> + *
>>>>>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
>>>>>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
>>>>>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state
>>>>>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state
>>>>>> + */
>>>>>> +enum blk_zone_action {
>>>>>> +	BLK_ZONE_MGMT_CLOSE	= 0x1,
>>>>>> +	BLK_ZONE_MGMT_FINISH	= 0x2,
>>>>>> +	BLK_ZONE_MGMT_OPEN	= 0x3,
>>>>>> +	BLK_ZONE_MGMT_RESET	= 0x4,
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>> + * struct blk_zone_mgmt - Extended zoned management
>>>>>> + *
>>>>>> + * @action: Zone action as in described in enum blk_zone_action
>>>>>> + * @flags: Flags for the action
>>>>>> + * @sector: Starting sector of the first zone to operate on
>>>>>> + * @nr_sectors: Total number of sectors of all zones to operate on
>>>>>> + */
>>>>>> +struct blk_zone_mgmt {
>>>>>> +	__u8		action;
>>>>>> +	__u8		resv3[3];
>>>>>> +	__u32		flags;
>>>>>> +	__u64		sector;
>>>>>> +	__u64		nr_sectors;
>>>>>> +	__u64		resv31;
>>>>>> +};
>>>>>> +
>>>>>>  /**
>>>>>>   * Zoned block device ioctl's:
>>>>>>   *
>>>>>> @@ -166,5 +198,6 @@ struct blk_zone_range {
>>>>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>>>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>>>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>>>>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>>>>>
>>>>>>  #endif /* _UAPI_BLKZONED_H */
>>>>>>
>>>>>
>>>>> Without defining what the flags can be, it is hard to judge what will change
>>>> >from the current distinct ioctls.
>>>>>
>>>>
>>>> The first flag is the one to select all. Down the line we have other
>>>> modifiers that make sense, but it is true that it is public yet.
>>>
>>> You mean *not* public ?
>>
>> Yes...
>>
>>>
>>>>
>>>> Would you like to wait until then or is it an option to revise the IOCTL
>>>> now?
>>>
>>> Yes. Wait until it is actually needed. Adding code that has no users makes it
>>> impossible to test so not acceptable. As for the "all zones" flag, I already
>>> commented about it.
>>
>> Ok. We will have this in the backlog then.
>>
>> It would be great if you and Matias would like to comment on it if you
>> have some ideas on how to improve it. Happy to set a branch somewhere to
>> keep a patchset with this functionality somewhere.
>
>I sent a much simpler version of this using a REQ_ZONE_ALL flag too, but driven
>by the specified sector range. That allowed to do reset, open, close, finish all
>zones using a single command much more simply than your patch. But as Christoph
>commented, the only real use case interesting for this is reset all (e.g. for FS
>format). open, close and finish all zones have no user...

Yes. The use-case here is format too, which might take some time on very
large drives.
>
>Let's see first what kind of flags may be needed in the future, if at all. We
>can then cook something if needed.

Makes sense.

Thanks Damien!

Javier
