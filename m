Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0185C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E54207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="GnBd3UrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFZH0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFZH0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:26:23 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49AC08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:26:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so6126386eds.13
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6FLT1rEZDQ7AK3nSmTqm6yAfDkrzVqRj9stTw7PfeN4=;
        b=GnBd3UrPWNpJ6i2503DTN2VJHgDozqKRREQMY8HzgrJzw2CZD8BDpqU5Hl3fNVz6f6
         /4ulBWBOB3a+iO0MRTI7Q2Hx/ehWXmXoibqe3Fw1w9nwlfDUtKdk9Phr0mU9PvHqmt5Q
         kS7eO0vUwOTU1Dgih96++IQXtBHhQ1FyKUoTJCqLpHR/TnhQxB1rBemzn86APfTucbd5
         tqiDpr1PljqhH2PM3MBgQsbQSE2Ky/w6fwYVIn2YkFVzERlbzhgiwmEKQdbleyJQqHkv
         TluQ3qsKsjaqqG08IvZgBDMoRL6DgqCNbX6Zf7zxwiey8RLRRPcdVBwJZ3wPqvHVcK+T
         5h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6FLT1rEZDQ7AK3nSmTqm6yAfDkrzVqRj9stTw7PfeN4=;
        b=T0vE2GObhiXkHtlWEds/VYMc88vnsosbGyXfdQek8NtAk4ZBfcZdI19/2V3DjN/Wcl
         0en+3P1nqtd62rhJ3VEE+x17V+QkmCkMK0fahMiKNAcRYVCO4RMz6xhTN0kHIaCqL6Dv
         rNq+bmAU81MkOLnyd+413u+BQqm8q8l5ioTH/YWtsEhi0oR7QNoCtgK3WLze26AzDO42
         QmplWEdVftTZlGswoWT1xqzDMYMJHlYuRF7AOB8vaZ7tvQ/tZn9YVr5s3YbH/yNGsIza
         svEAPEKGFFZNPVHFR0h9p/bNlNlrbxYwyGv/fhuBtWV0JIU0I5Z+NIaw9oisS4qL1oGs
         VLBQ==
X-Gm-Message-State: AOAM533sRcWVdS2G7M4ScALLEeCQPzZsfzeOpt1cMTAxv/h6dFDvFMGC
        K+bMm/eATQQhOhd1xacNxuFSgw==
X-Google-Smtp-Source: ABdhPJyEe6b1vs8g49vANMRHs5e6EHKJgNPYlMfk1+lzdwdD3HmT9eMT5G6bC6HSGpK3hLDoWekgew==
X-Received: by 2002:a50:f05d:: with SMTP id u29mr2067693edl.137.1593156381837;
        Fri, 26 Jun 2020 00:26:21 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id w15sm6165899ejk.103.2020.06.26.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:26:21 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:26:20 +0200
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
Message-ID: <20200626072620.mxve5i3tiq4o4coo@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
 <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065822.6psy3tp6vqmjwppa@mpHalley.localdomain>
 <CY4PR04MB3751D6B0FFCA3A8C0278A194E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751D6B0FFCA3A8C0278A194E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 07:17, Damien Le Moal wrote:
>On 2020/06/26 15:58, Javier González wrote:
>> On 26.06.2020 06:42, Damien Le Moal wrote:
>>> On 2020/06/26 15:09, Javier González wrote:
>>>> On 26.06.2020 01:34, Damien Le Moal wrote:
>>>>> On 2020/06/25 21:22, Javier González wrote:
>>>>>> From: Javier González <javier.gonz@samsung.com>
>>>>>>
>>>>>> Add support for offline transition on the zoned block device using the
>>>>>> new zone management IOCTL
>>>>>>
>>>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>> ---
>>>>>>  block/blk-core.c              | 2 ++
>>>>>>  block/blk-zoned.c             | 3 +++
>>>>>>  drivers/nvme/host/core.c      | 3 +++
>>>>>>  include/linux/blk_types.h     | 3 +++
>>>>>>  include/linux/blkdev.h        | 1 -
>>>>>>  include/uapi/linux/blkzoned.h | 1 +
>>>>>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>>> index 03252af8c82c..589cbdacc5ec 100644
>>>>>> --- a/block/blk-core.c
>>>>>> +++ b/block/blk-core.c
>>>>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
>>>>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>>>>  	REQ_OP_NAME(ZONE_APPEND),
>>>>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>>>>  	REQ_OP_NAME(WRITE_SAME),
>>>>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>>>>  	REQ_OP_NAME(SCSI_IN),
>>>>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>>>>  	case REQ_OP_ZONE_OPEN:
>>>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>>>  		if (!blk_queue_is_zoned(q))
>>>>>>  			goto not_supported;
>>>>>>  		break;
>>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>>> index 29194388a1bb..704fc15813d1 100644
>>>>>> --- a/block/blk-zoned.c
>>>>>> +++ b/block/blk-zoned.c
>>>>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  	case BLK_ZONE_MGMT_RESET:
>>>>>>  		op = REQ_OP_ZONE_RESET;
>>>>>>  		break;
>>>>>> +	case BLK_ZONE_MGMT_OFFLINE:
>>>>>> +		op = REQ_OP_ZONE_OFFLINE;
>>>>>> +		break;
>>>>>>  	default:
>>>>>>  		return -ENOTTY;
>>>>>>  	}
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index f1215523792b..5b95c81d2a2d 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>>>  		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>>>>  		break;
>>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>>> +		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>>>>> +		break;
>>>>>>  	case REQ_OP_WRITE_ZEROES:
>>>>>>  		ret = nvme_setup_write_zeroes(ns, req, cmd);
>>>>>>  		break;
>>>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>>>>> index 16b57fb2b99c..b3921263c3dd 100644
>>>>>> --- a/include/linux/blk_types.h
>>>>>> +++ b/include/linux/blk_types.h
>>>>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>>>>  	REQ_OP_ZONE_FINISH	= 12,
>>>>>>  	/* write data at the current zone write pointer */
>>>>>>  	REQ_OP_ZONE_APPEND	= 13,
>>>>>> +	/* Transition a zone to offline */
>>>>>> +	REQ_OP_ZONE_OFFLINE	= 14,
>>>>>>
>>>>>>  	/* SCSI passthrough using struct scsi_request */
>>>>>>  	REQ_OP_SCSI_IN		= 32,
>>>>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>>>>>  	case REQ_OP_ZONE_OPEN:
>>>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>>>  		return true;
>>>>>>  	default:
>>>>>>  		return false;
>>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>>>> index bd8521f94dc4..8308d8a3720b 100644
>>>>>> --- a/include/linux/blkdev.h
>>>>>> +++ b/include/linux/blkdev.h
>>>>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>>> -
>>>>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>>>>
>>>>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>>>>> index a8c89fe58f97..d0978ee10fc7 100644
>>>>>> --- a/include/uapi/linux/blkzoned.h
>>>>>> +++ b/include/uapi/linux/blkzoned.h
>>>>>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>>>>>  	BLK_ZONE_MGMT_FINISH	= 0x2,
>>>>>>  	BLK_ZONE_MGMT_OPEN	= 0x3,
>>>>>>  	BLK_ZONE_MGMT_RESET	= 0x4,
>>>>>> +	BLK_ZONE_MGMT_OFFLINE	= 0x5,
>>>>>>  };
>>>>>>
>>>>>>  /**
>>>>>>
>>>>>
>>>>> As mentioned in previous email, the usefulness of this is dubious. Please
>>>>> elaborate in the commit message. Sure NVMe ZNS defines this and we can support
>>>>> it. But without a good use case, what is the point ?
>>>>
>>>> Use case is to transition zones in read-only state to offline when we
>>>> are done moving valid data. It is easier to explicitly managing zones
>>>> that are not usable by having all under the offline state.
>>>
>>> Then adding a simple BLKZONEOFFLINE ioctl, similar to open, close, finish and
>>> reset, would be enough. No need for all the new zone management ioctl with flags
>>> plumbing.
>>
>> Ok. We can add that then.
>>
>> Note that zone management is not motivated by this use case at all, but
>> it made sense to implement it here instead of as a new BLKZONEOFFLINE
>> IOCTL as ZAC/ZBC users will not be able to use it either way.
>
>Sure, that is fine. We could actually add that to sd_zbc.c since we have zone
>tracking there. A read-only zone can be reported as offline to sync-up with zns.
>The value of it is dubious though as most applications will treat read-only and
>offline zones the same way: as unusable. That is what zonefs does.

Ok.

>
>>
>>>
>>>>
>>>>>
>>>>> scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to a
>>>>> ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sectors" or
>>>>> the like to indicate support by the device or not would be nicer.
>>>>
>>>> We can do that.
>>>>
>>>>>
>>>>> Does offling ALL zones make any sense ? Because this patch does not prevent the
>>>>> use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good idea to
>>>>> allow offlining all zones, no ?
>>>>
>>>> AFAIK the transition to offline is only valid when coming from a
>>>> read-only state. I did think of adding a check, but I can see that other
>>>> transitions go directly to the driver and then the device, so I decided
>>>> to follow the same model. If you think it is better, we can add the
>>>> check.
>>>
>>> My point was that the REQ_ZONE_ALL flag would make no sense for offlining zones
>>> but this patch does not have anything checking that. There is no point in
>>> sending a command that is known to be incorrect to the drive...
>>
>> I will add some extra checks then to fail early. I assume these should
>> be in the NVMe driver as it is NVMe-specific, right?
>
>If it is a simple BLKZONEOFFLINE ioctl, it can be processed exactly like open,
>close and finish, using blkdev_zone_mgmt(). Calling that one for a range of
>sectors of more than one zone will likely not make any sense most of the time,
>but that is allowed for all other ops, so I guess you can keep it as is for
>offline too. blkdev_zone_mgmt() will actually not need any change. You will only
>need to wire the ioctl path and update op_is_zone_mgmt(). That's it. Simple that
>way.

Sounds good.

Javier
