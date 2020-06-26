Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C26C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD80520775
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Q6u1kihS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFZGSP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFZGSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:18:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F9C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:18:14 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so6018438edy.7
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5bdfdKzWLVA53LirfO3NM/QJjRa/YkbkW1YF8mVU55o=;
        b=Q6u1kihSoDVoBEEPpZKJP/rpXiR3k8qhWSpcWVvn9GgMEkFD3wwc7gbQ9soYwTnDMX
         wk9LRmxYs6yARSN/nhaT2BStlw6ze7EwJ+Is1pkNplS53HXSpAhjQtR4AiyTvW+iY8xt
         1UES+uiYMDqiqpq9X2RYUJc5M6BXU9Dnx0/nLmQlEAoyOEEt6mk+Af4b5OcYySeyptcH
         Ofw6bRt02rDUtyV9TQWg4mGC5HkoC2zyI0ji6AcS+l8wmbsPtjkCGXoSTBuE2toEuCx1
         fWSY1MILeNyxIaxLtAmffl9MhyIB1YfUv/mRJDaD3R3ZjKHfTQLNDP9Ux4fMPZ8a3iza
         +oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5bdfdKzWLVA53LirfO3NM/QJjRa/YkbkW1YF8mVU55o=;
        b=L3jrYQeLeqjuhyRVsf+40tuJNijeZKZ2JudcFfuivtAYFdRss+Qv3p3s1E4eAxG6Wf
         grwuBPnwC8mczSQMxc9LJoxrUJ89wnns7QVnlP0VWStvftTcTWMFjRYEkoSuNz0Aph6o
         E+kuyTc+GMDcyNYfDv4PgaPJxcR4DlMDmq5I6prUfzYgBIR95TQSefsNIf2Gz6q199qF
         tImxGgJTEqfEEsPMYt2JuMyfhjyUYCxyh+g7cvPKYM/tVJeAxigFEMIfTjnFV8MdgwdZ
         29iuXQZdQ2dWiVYsTyiqju/Ih6S/OTwgzEQr2RxgG5h+KBnbIjzJneQoDKL5V6qYp8BV
         bTEA==
X-Gm-Message-State: AOAM532qaglV9DBC6XedLhnbZnqFvI+HF0/yiZDwfP8X6/rCsqURmsO+
        ZnBB6dQ4u41urBWd873EqXaGFA==
X-Google-Smtp-Source: ABdhPJxW60V/9PYPbVQcPRb7jbihPjVWjLI6w0C+nRD85ZGyMEZatr9mwY+UEXq+MQfYM+S+Vvq/UQ==
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr1762531edr.164.1593152293018;
        Thu, 25 Jun 2020 23:18:13 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id p4sm20704652edj.64.2020.06.25.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:18:12 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:18:11 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626061811.nygifelt4x66fpx3@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 01:14, Damien Le Moal wrote:
>On 2020/06/26 4:48, Javier González wrote:
>> On 25.06.2020 16:12, Matias Bjørling wrote:
>>> On 25/06/2020 14.21, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> Add support for offline transition on the zoned block device using the
>>>> new zone management IOCTL
>>>>
>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>> ---
>>>>  block/blk-core.c              | 2 ++
>>>>  block/blk-zoned.c             | 3 +++
>>>>  drivers/nvme/host/core.c      | 3 +++
>>>>  include/linux/blk_types.h     | 3 +++
>>>>  include/linux/blkdev.h        | 1 -
>>>>  include/uapi/linux/blkzoned.h | 1 +
>>>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index 03252af8c82c..589cbdacc5ec 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
>>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>>  	REQ_OP_NAME(ZONE_APPEND),
>>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>>  	REQ_OP_NAME(WRITE_SAME),
>>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>>  	REQ_OP_NAME(SCSI_IN),
>>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>>  	case REQ_OP_ZONE_OPEN:
>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>  	case REQ_OP_ZONE_FINISH:
>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>  		if (!blk_queue_is_zoned(q))
>>>>  			goto not_supported;
>>>>  		break;
>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>> index 29194388a1bb..704fc15813d1 100644
>>>> --- a/block/blk-zoned.c
>>>> +++ b/block/blk-zoned.c
>>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>  	case BLK_ZONE_MGMT_RESET:
>>>>  		op = REQ_OP_ZONE_RESET;
>>>>  		break;
>>>> +	case BLK_ZONE_MGMT_OFFLINE:
>>>> +		op = REQ_OP_ZONE_OFFLINE;
>>>> +		break;
>>>>  	default:
>>>>  		return -ENOTTY;
>>>>  	}
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index f1215523792b..5b95c81d2a2d 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>>>  	case REQ_OP_ZONE_FINISH:
>>>>  		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>>  		break;
>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>> +		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>>> +		break;
>>>>  	case REQ_OP_WRITE_ZEROES:
>>>>  		ret = nvme_setup_write_zeroes(ns, req, cmd);
>>>>  		break;
>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>>> index 16b57fb2b99c..b3921263c3dd 100644
>>>> --- a/include/linux/blk_types.h
>>>> +++ b/include/linux/blk_types.h
>>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>>  	REQ_OP_ZONE_FINISH	= 12,
>>>>  	/* write data at the current zone write pointer */
>>>>  	REQ_OP_ZONE_APPEND	= 13,
>>>> +	/* Transition a zone to offline */
>>>> +	REQ_OP_ZONE_OFFLINE	= 14,
>>>>  	/* SCSI passthrough using struct scsi_request */
>>>>  	REQ_OP_SCSI_IN		= 32,
>>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>>>  	case REQ_OP_ZONE_OPEN:
>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>  	case REQ_OP_ZONE_FINISH:
>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>  		return true;
>>>>  	default:
>>>>  		return false;
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>> index bd8521f94dc4..8308d8a3720b 100644
>>>> --- a/include/linux/blkdev.h
>>>> +++ b/include/linux/blkdev.h
>>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>>  				  unsigned int cmd, unsigned long arg);
>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>  				  unsigned int cmd, unsigned long arg);
>>>> -
>>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>>> index a8c89fe58f97..d0978ee10fc7 100644
>>>> --- a/include/uapi/linux/blkzoned.h
>>>> +++ b/include/uapi/linux/blkzoned.h
>>>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>>>  	BLK_ZONE_MGMT_FINISH	= 0x2,
>>>>  	BLK_ZONE_MGMT_OPEN	= 0x3,
>>>>  	BLK_ZONE_MGMT_RESET	= 0x4,
>>>> +	BLK_ZONE_MGMT_OFFLINE	= 0x5,
>>>>  };
>>>>  /**
>>>
>>> I am not sure this makes sense to expose through the kernel zone api.
>>> One of the goals of the kernel zone API is to be a layer that provides
>>> an unified zone model across SMR HDDs and ZNS SSDs. The offline zone
>>> operation, as defined in the ZNS specification, does not have an
>>> equivalent in SMR HDDs (ZAC/ZBC).
>>>
>>> This is different from the Zone Capacity change, where the zone
>>> capacity simply was zone size for SMR HDDs. Making it easy to support.
>>> That is not the same for ZAC/ZBC, that does not offer the offline
>>> operation to transition zones in read only state to offline state.
>>
>> I agree that an unified interface is desirable. However, the truth is
>> that ZAC/ZBC are different, and will differ more and more and time goes
>> by. We can deal with the differences at the driver level or with checks
>> at the API level, but limiting ZNS with ZAC/ZBC is a hard constraint.
>
>As long as you keep ZNS namespace report itself as being "host-managed" like
>ZBC/ZAC disks, we need the consistency and common interface. If you break that,
>the meaning of the zoned model queue attribute disappears and an application or
>in-kernel user cannot rely on this model anymore to know how the drive will behave.

I agree. The API should be clean and common, but that should not prevent
extensions to ZAC/ZBC or ZNS specifics. The suggestions you propose in
the other patches make sense to do this properly.

>
>> Note too that I chose to only support this particular transition on the
>> new management IOCTL to avoid confusion for existing ZAC/ZBC users.
>>
>> It would be good to clarify what is the plan for kernel APIs moving
>> forward, as I believe there is a general desire to support new ZNS
>> features, which will not necessarily be replicated in SMR drives.
>
>What the drive is supposed to support and its behavior is determined by the
>zoned model. ZNS standard was written so that most things have an equivalent
>with ZBC/ZAC, e.g. the zone state machine is nearly identical. Differences are
>either emulated (e.g. zone append scsi emulation), or not supported (e.g. zone
>capacity change) so that the kernel follows the same pattern and maintains a
>coherent behavior between device protocols for the host-managed model.

Yes.

>
>Think of a file system, or any other in-kernel user. If they have to change
>their code based on the device type (NVMe vs SCSI), then the zoned block device
>interface is broken. Right now, that is not the case, everything works equally
>well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
>do not define. But that is still consistent with the host-managed model since
>conventional zones are optional.

I think this is a very nice goal, but I do believe we will not be able
to keep a 100% consistent behavior. We will have new features on either
of the specs that do not make sense on the other and we will have to
deal with them. We can deal with this as generic optional features, but
at the end of the day, applications will need to check whether the
feature is selected or not.

This said, I agree that we need a good way to communicate this, and the
suggestions you made with sysfs parameters and flags make sense to me.

>
>For this particular patch, there is currently no in-kernel user, and it is not
>clear how this will be useful to applications. At least please clarify this. And
>most likely, similarly to discard etc operations that are optional, having a
>sysfs attribute and in-kernel API indicating if the drive supports offlining
>zones will be needed. Otherwise, the caller will have to play with error codes
>to understand if the drive does not support the command or if it is supported
>but the command failed. Not nice. Better to know before issuing the command.

Makes sense. See the reply on the patch itself.

Javier
