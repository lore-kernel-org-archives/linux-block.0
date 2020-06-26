Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A216BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792892076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FhAvyIgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgFZH3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZH3C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:29:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B0C08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:29:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so8409042ejb.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eMRZSEPILJ/VgixGAVUR+OM7H5tl0QETRHZF7IXIBss=;
        b=FhAvyIgFjRuPlJkiK3zynyy98TyIiLkieNPIzKLj6sVRVCaIkK1GqSqNL4ONLMUyjW
         IYl5UNBe0qk4FT/pPZzopEy9FlUBS52cNShrn3piFyYmXfW3nqhHRm32D/RGvR7lweCj
         xBafkwtXaCVSfrEviUap6gjET/WgHp7aHJbNK+uGuMFQ5jAoo1bVpcZ7EK/0WOd8RU11
         WLuqb5af44g5sR8d/A64GcvxD4T9Vr6GCEV+Nnri8AGSkDs3HfLR4WLNRVH14h28zDKD
         C59IJ0/2H3xccbSrDTAYUydoXOe5jjl15FS39Hymo/UDDgcOXURsOwGpW3dfvMyu13P6
         g/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eMRZSEPILJ/VgixGAVUR+OM7H5tl0QETRHZF7IXIBss=;
        b=X6nSM6CzyVJUWcXGC3KDgPJhtlq1Vej5TPm9cUTaxZ9qBJaqQAe9x5WsqlrRkplNhT
         Ljg0hbN2GBbwb9i9kqMF1uJB9C+7p4uNdjY/HGSzdlmdiqO5ZLZiFw9jfW10wlkmTA6l
         LMtrPT2zFYBUI3bTUf0morinfsgRQM54AxKsHflAQw+VPxJbH8bifm9dbArwriiROckd
         U7fxuvYUKPejqzvrOPK/8qpEOcJEz1A+W2qShW/9WZyvXwe4PSuY2k4kA5gWDDZdZSgM
         HeE6c64/BuSaRu1egpwbhzC3T1rHEoEQ2A1WYNZ1L8fEb6SnrgrSZe78a+D6BvQ/KA2Z
         uyig==
X-Gm-Message-State: AOAM5309S4+1weks0juzzNj0qgq4kbBUZMlcZsJ4E6SDjwB+v8JjDyp3
        TxBfbH4ZGjNZcm+x4//MWOWbuQ==
X-Google-Smtp-Source: ABdhPJy3fzGC9HvPjjRE+CSI1d1tpFMlrZVKYRIKUdR5Rb9H0Uv7AiDxCUL1l9DjRsN3Hw1Yn8lyaQ==
X-Received: by 2002:a17:906:6d15:: with SMTP id m21mr1344598ejr.209.1593156541214;
        Fri, 26 Jun 2020 00:29:01 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id gu15sm2074049ejb.111.2020.06.26.00.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:29:00 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:29:00 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626072900.rjigm3wiya4sdufv@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
 <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
 <CY4PR04MB375167CFC4E3CF22324C71B5E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065546.v266c3zjv2gjoycs@mpHalley.localdomain>
 <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751A7165FC7F068C1ECBB5EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 07:09, Damien Le Moal wrote:
>On 2020/06/26 15:55, Javier González wrote:
>> On 26.06.2020 06:49, Damien Le Moal wrote:
>>> On 2020/06/26 15:13, Javier González wrote:
>>>> On 26.06.2020 00:04, Damien Le Moal wrote:
>>>>> On 2020/06/26 6:49, Keith Busch wrote:
>>>>>> On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier González wrote:
>>>>>>>  drivers/nvme/host/zns.c | 7 +++++++
>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>>>>>> index 7d8381fe7665..de806788a184 100644
>>>>>>> --- a/drivers/nvme/host/zns.c
>>>>>>> +++ b/drivers/nvme/host/zns.c
>>>>>>> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>>>>>>  		sector += ns->zsze * nz;
>>>>>>>  	}
>>>>>>>
>>>>>>> +	if (nr_zones < 0 && zone_idx != ns->nr_zones) {
>>>>>>> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
>>>>>>> +				zone_idx, ns->nr_zones);
>>>>>>> +		ret = -EINVAL;
>>>>>>> +		goto out_free;
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	ret = zone_idx;
>>>>>>
>>>>>> nr_zones is unsigned, so it's never < 0.
>>>>>>
>>>>>> The API we're providing doesn't require zone_idx equal the namespace's
>>>>>> nr_zones at the end, though. A subset of the total number of zones can
>>>>>> be requested here.
>>>>>>
>>>>
>>>> I did see nr_zones coming with -1; guess it is my compiler.
>>>
>>> See include/linux/blkdev.h. -1 is:
>>>
>>> #define BLK_ALL_ZONES  ((unsigned int)-1)
>>>
>>> Which is documented in block/blk-zoned.c:
>>>
>>> /**
>>> * blkdev_report_zones - Get zones information
>>> * @bdev:       Target block device
>>> * @sector:     Sector from which to report zones
>>> * @nr_zones:   Maximum number of zones to report
>>> * @cb:         Callback function called for each reported zone
>>> * @data:       Private data for the callback
>>> *
>>> * Description:
>>> *    Get zone information starting from the zone containing @sector for at most
>>> *    @nr_zones, and call @cb for each zone reported by the device.
>>> *    To report all zones in a device starting from @sector, the BLK_ALL_ZONES
>>> *    constant can be passed to @nr_zones.
>>> *    Returns the number of zones reported by the device, or a negative errno
>>> *    value in case of failure.
>>> *
>>> *    Note: The caller must use memalloc_noXX_save/restore() calls to control
>>> *    memory allocations done within this function.
>>> */
>>> int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>>>                        unsigned int nr_zones, report_zones_cb cb, void *data)
>>>
>>>>
>>>>>
>>>>> Yes, absolutely. zone_idx is not an absolute zone number. It is the index of the
>>>>> reported zone descriptor in the current report range requested by the user,
>>>>> which is not necessarily for the entire drive (i.e., provided nr zones is less
>>>>> than the total number of zones of the disk and/or start sector is > 0). So
>>>>> zone_idx indicates the actual number of zones reported, it is not the total
>>>>
>>>> I see. As I can see, when nr_zones comes undefined I believed we could
>>>> assume that zone_idx is absolute, but I can be wrong.
>>>
>>> No. zone_idx is *always* the index of the zone in the current report. Whatever
>>> that report is, regardless of the report starting point and number of zones
>>> requested. E.g. For a single zone report (nr_zones = 1), you will always see
>>> zone_idx = 0. For a full report, zone_idx will correspond to the zone number.
>>> This is used for example in blk_revalidate_disk_zones() to initialize the zone
>>> bitmaps.
>>>
>>>> Does it make sense to support this check with an additional counter and
>>>> a explicit nr_zones initialization when undefined or you
>>>> prefer to just remove it as Matias suggested?
>>>
>>> The check is not needed at all.
>>>
>>> If the device is buggy and reports more zones than the device capacity or any
>>> other bugs, the driver can catch that when it processes the report.
>>> blk_revalidate_disk_zones() also has many checks.
>>
>> I have managed to create a QEMU ZNS device that gave me a headache with
>> a little bit of extra capacity that triggered an additional zone report.
>> This was the motivation for the patch.
>
>The device emulation sound buggy... If the capacity is wrong, then the report
>will be too since zones are all supposed to be sequential (no holes between
>zones) and up to the disk capacity only (last zone start + len = capacity + 1)
>
>If one or the other is wrong, this should be easy to detect. Normally,
>blk_revalidate_disk_zones() should be able to catch that.

We have the capability to select the reported device capacity manually
for a number of reasons. One of the different test configurations in our
CI did go through.

But it is OK, I will remove the check on V2.

Javier
