Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3679AC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059F820775
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cQ11bMkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgFZGwo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:52:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D89C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:52:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so6072369edr.9
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ddXcAMBJvSM3ecaTj9X80/nb/IWt2EiQ9OJyOSnERbk=;
        b=cQ11bMkmw1huw/T4Wqcuqq5K/hDTvk9EuZZQm6gdgAHqKPh7bPdzm/N7dxAoQhcPDE
         9EHyZ0TPkW8iMbLsyfY6ToVx/Cv75IWD9oz93nwLQHoY3+Hy4rS4ZcejyfiIZtoDeWYw
         boxQgf/aRq4FUQNDLlcRuaLqAhPvl/q65lkOQJuFBqJeHKk/SGP11PhTKs2COWjvOW7k
         fyAhGykm+DcXT5oXJ/4kqW7gxwFsII2OuNtnHaUW3yQe9PJO/Mm5Jd0C3lVOVoLGy+6n
         aTS4tcWBStcmPmetvHVdvqkjACVBJ4lnyL9Xr//MStJxBPfM82amNYjNV3E78m6MkZ6s
         UJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ddXcAMBJvSM3ecaTj9X80/nb/IWt2EiQ9OJyOSnERbk=;
        b=RPh0UIv7oQ9bxpDf/9Fl4QgHERYFHw4g2y+b3ekLG0+Y2g10obI7FfNgCnNZpPxrsE
         Zff/MHGb6uNRAoj8jAGnYc8ALl7H3yXpXaIuKHfH9HxiV8g2tJ3pEnOou+t04ep4qVQ1
         VWjNE+5lGTvpsjMeL+e29ITN4MGxr/wRbQ4Oqh/2mUw6iA5wliMkQpUpuP7nO7jTHcNj
         q0vNdiYb54Zv9VaAIM+v+CJN52Fx0bbXb6Qj1u7/UnFYKubsUllFog1TI8ZGVIgXYLcM
         tCe7c7zqJ4BAfCAlIfRfu9XYfrfZQ9/NXacZCGySRmhkHtRpKgCYR/YH9uxWIXMnc2Dr
         q3oA==
X-Gm-Message-State: AOAM531VYD4ptM/S2kHTMU8MlHSsWTX6dln9+pQB+G/BkZ/T9HREXSIR
        t1bVNYuy5rBciwUucqJ9psFBIg==
X-Google-Smtp-Source: ABdhPJyIBmXJTXL+VPBJYD5vpG7jKRPFc2ybxSCMDzeRny2UoOBk2Q8uf/PFB9tAwPip/KOsmm6wlw==
X-Received: by 2002:a50:e387:: with SMTP id b7mr1852356edm.190.1593154362314;
        Thu, 25 Jun 2020 23:52:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id z8sm11008152eju.106.2020.06.25.23.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:52:41 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:52:41 +0200
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
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Message-ID: <20200626065241.u4fd3m7624kdsonw@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
 <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 06:35, Damien Le Moal wrote:
>On 2020/06/26 14:58, Javier González wrote:
>> On 26.06.2020 01:27, Damien Le Moal wrote:
>>> On 2020/06/25 21:22, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> Add flag to allow selecting all zones on a single zone management
>>>> operation
>>>>
>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>> ---
>>>>  block/blk-zoned.c             | 3 +++
>>>>  include/linux/blk_types.h     | 3 ++-
>>>>  include/uapi/linux/blkzoned.h | 9 +++++++++
>>>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>> index e87c60004dc5..29194388a1bb 100644
>>>> --- a/block/blk-zoned.c
>>>> +++ b/block/blk-zoned.c
>>>> @@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>>>  		return -ENOTTY;
>>>>  	}
>>>>
>>>> +	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)
>>>> +		op |= REQ_ZONE_ALL;
>>>> +
>>>>  	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>>>  				GFP_KERNEL);
>>>>  }
>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>>> index ccb895f911b1..16b57fb2b99c 100644
>>>> --- a/include/linux/blk_types.h
>>>> +++ b/include/linux/blk_types.h
>>>> @@ -351,6 +351,7 @@ enum req_flag_bits {
>>>>  	 * work item to avoid such priority inversions.
>>>>  	 */
>>>>  	__REQ_CGROUP_PUNT,
>>>> +	__REQ_ZONE_ALL,		/* apply zone operation to all zones */
>>>>
>>>>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
>>>>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
>>>> @@ -378,7 +379,7 @@ enum req_flag_bits {
>>>>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
>>>>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
>>>>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>>>> -
>>>> +#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)
>>>>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>>>>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
>>>>
>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>>> index 07b5fde21d9f..a8c89fe58f97 100644
>>>> --- a/include/uapi/linux/blkzoned.h
>>>> +++ b/include/uapi/linux/blkzoned.h
>>>> @@ -157,6 +157,15 @@ enum blk_zone_action {
>>>>  	BLK_ZONE_MGMT_RESET	= 0x4,
>>>>  };
>>>>
>>>> +/**
>>>> + * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt
>>>> + *
>>>> + * BLK_ZONE_SELECT_ALL: Select all zones for current zone action
>>>> + */
>>>> +enum blk_zone_mgmt_flags {
>>>> +	BLK_ZONE_SELECT_ALL	= 1 << 0,
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct blk_zone_mgmt - Extended zoned management
>>>>   *
>>>>
>>>
>>> NACK.
>>>
>>> Details:
>>> 1) REQ_OP_ZONE_RESET together with REQ_ZONE_ALL is the same as
>>> REQ_OP_ZONE_RESET_ALL, isn't it ? You are duplicating a functionality that
>>> already exists.
>>> 2) The patch introduces REQ_ZONE_ALL at the block layer only without defining
>>> how it ties into SCSI and NVMe driver use of it. Is REQ_ZONE_ALL indicating that
>>> the zone management commands are to be executed with the ALL bit set ? If yes,
>>> that will break device-mapper. See the special code for handling
>>> REQ_OP_ZONE_RESET_ALL. That code is in place for a reason: the target block
>>> device may not be an entire physical device. In that case, applying a zone
>>> management command to all zones of the physical drive is wrong.
>>> 3) REQ_ZONE_ALL seems completely equivalent to specifying a sector range of [0
>>> .. drive capacity]. So what is the point ? The current interface handles that.
>>> That is how we chose between REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL right now.
>>> 4) Without any in-kernel user, I do not see the point. And for applications, I
>>> do not see any good use case for doing open all, close all, offline all or
>>> finish all. If you have any such good use case, please elaborate.
>>>
>>
>> The main use if reset all, but without having to look through all zones,
>> as it imposes an overhead when we have a large number of zones. Having
>> the possibility to offload it to HW is more efficient.
>>
>> I had not thought about the device mapper use case. Would it be an
>> option to translate this into REQ_OP_ZONE_RESET_ALL when we have a
>> device mapper (or any other case where this might break) and then leave
>> the bit go to the driver if it applies to the whole device?
>
>But REQ_OP_ZONE_RESET_ALL is already implemented and supported and will reset
>all zones of a drive using a single command if the ioctl is called for the
>entire sector range of a physical drive. For device mapper with a partial
>mapping, the per zone reset loop will be used. If you have no other use case for
>the REQ_ZONE_ALL flag, what is the point here ? Reset is already optimized for
>the all zones case

OK. I might have missed this. I thought we were sending several commands
instead of a single reset with the bit. I will check again. Thanks for
pointing at this.

Javier
