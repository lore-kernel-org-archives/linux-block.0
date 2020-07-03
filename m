Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E36C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE79204EA
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="UgefPym9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGCG2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGCG2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 02:28:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2902C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 23:28:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t25so31008380lji.12
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uK3mwKv/yp0t2DwgOrfs5kiC68mQubJ/L1AM6RTod8k=;
        b=UgefPym9ErHK2/aVRTeJ6mCcjG0m5OQF5GXsp9tamHJiSsLAsDLNgeX4OxHyxOiD1l
         +CwFrtxE6I1OtPZn13QYNmMHF9T8hm3hDRpPgYWPYbzT29WDmd3AfADGciQ2ca2BnkFW
         vSgCIFzQb1dbvWso6u94elYIgOhKCL0uabHLmAO52tWpuqmGJr9B+OZAmKltpBzPBUzD
         2VjaLGKXCr4LNHcIJE/u98W6bBhbxvaGP2wia8vj7eGgAgC/mbQ0m0UjcDLKxQ+jy++v
         ylXIA+jFscgwFbA2Mbb46OYctwKH5Al2/XxG5hTAngHC4ebMAn1puM7f+2pIc25nNUX6
         cxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uK3mwKv/yp0t2DwgOrfs5kiC68mQubJ/L1AM6RTod8k=;
        b=Eagdq69cTs4Aa1UvH4L5Qze0I5GzMUd+UslRClm4aXN56VubHOF1RdKQ9BCeou5LS5
         3JznM4W59NyUvFMbqEKAtRJiivlF0ovkuHLfZE5ESozU3X982do0P2L8pk3ZAUrgssSd
         iExMLyCwxG93se8qxbGAPHuSvnHI8s119ukHPBFSZB7fCM7Z2EvcsalEAwd0mCe350SU
         2uD6VXZcVvoWsWaqxOy1K+OhwACmAfOENO6h4VrOM4+divG4UMMwrkEOSOZa3Jm3XSr9
         qvNt+uNuAsxl9sIQ6BZQObgIhMv2WhlEg7oWMlsw2eYRP9esh5JNfizOVeIlxv76ZfWg
         DKYg==
X-Gm-Message-State: AOAM533ZP2Qgo9fGMDVBSwLaFiuMFak+4pmOPhshZujLHZLfAdPEfvMF
        6RlYzwNSVl4nqryL9+ZI/dM/8g==
X-Google-Smtp-Source: ABdhPJyr6khFUU5UhSD5RiGyq9MsGTkzGBvcTm6AWEj3nl8eYfu9gVGhiF6KtCMNbd0Ffdki3nv0Qw==
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr11327552ljj.168.1593757699071;
        Thu, 02 Jul 2020 23:28:19 -0700 (PDT)
Received: from localhost ([2a02:aa7:4606:7611:70c8:f018:3365:d1d6])
        by smtp.gmail.com with ESMTPSA id f13sm4293876lfs.29.2020.07.02.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:28:18 -0700 (PDT)
Date:   Fri, 3 Jul 2020 08:28:15 +0200
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
Message-ID: <20200703062815.qfo7tvonmgqqfcha@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-2-javier@javigon.com>
 <CY4PR04MB37511008EEBF1A77DB4F423BE76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702083430.miax2cd44mkhc5fb@mpHalley.local>
 <CY4PR04MB375100663B25D1E1D8490758E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702102714.d5igoqcvcavlunmv@mpHalley.local>
 <CY4PR04MB3751F621B2D32B5A47332644E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751F621B2D32B5A47332644E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.07.2020 05:20, Damien Le Moal wrote:
>On 2020/07/02 19:27, Javier González wrote:
>> On 02.07.2020 08:49, Damien Le Moal wrote:
>>> On 2020/07/02 17:34, Javier González wrote:
>>>> On 02.07.2020 07:54, Damien Le Moal wrote:
>>>>> On 2020/07/02 15:55, Javier González wrote:
>>>>>> From: Javier González <javier.gonz@samsung.com>
>>>>>>
>>>>>> As the zoned block device will have to deal with features that are
>>>>>> optional for the backend device, add a flag field to inform the block
>>>>>> layer about supported features. This builds on top of
>>>>>> blk_zone_report_flags and extendes to the zone report code.
>>>>>>
>>>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>> ---
>>>>>>  block/blk-zoned.c              | 3 ++-
>>>>>>  drivers/block/null_blk_zoned.c | 2 ++
>>>>>>  drivers/nvme/host/zns.c        | 1 +
>>>>>>  drivers/scsi/sd.c              | 2 ++
>>>>>>  include/linux/blkdev.h         | 3 +++
>>>>>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>>> index 81152a260354..0f156e96e48f 100644
>>>>>> --- a/block/blk-zoned.c
>>>>>> +++ b/block/blk-zoned.c
>>>>>> @@ -312,7 +312,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>>>>>>  		return ret;
>>>>>>
>>>>>>  	rep.nr_zones = ret;
>>>>>> -	rep.flags = BLK_ZONE_REP_CAPACITY;
>>>>>> +	rep.flags = q->zone_flags;
>>>>>
>>>>> zone_flags seem to be a fairly generic flags field while rep.flags is only about
>>>>> the reported descriptors structure. So you may want to define a
>>>>> BLK_ZONE_REP_FLAGS_MASK and have:
>>>>>
>>>>> 	rep.flags = q->zone_flags & BLK_ZONE_REP_FLAGS_MASK;
>>>>>
>>>>> to avoid flags meaningless for the user being set.
>>>>>
>>>>> In any case, since *all* zoned block devices now report capacity, I do not
>>>>> really see the point to add BLK_ZONE_REP_FLAGS_MASK to q->zone_flags, especially
>>>>> considering that you set the flag for all zoned device types, including scsi
>>>>> which does not have zone capacity. This makes q->zone_flags rather confusing
>>>>> instead of clearly defining the device features as you mentioned in the commit
>>>>> message.
>>>>>
>>>>> I think it may be better to just drop this patch, and if needed, introduce the
>>>>> zone_flags field where it may be needed (e.g. OFFLINE zone ioctl support).
>>>>
>>>> I am using this as a way to pass the OFFLINE support flag to the block
>>>> layer. I used this too for the attributes. Are you thinking of a
>>>> different way to send this?
>>>>
>>>> I believe this fits too for capacity, but we can just pass it in
>>>> all report as before if you prefer.
>>>
>>> The point is that this patch as is does nothing and is needed as a preparatory
>>> patch if we want to have the offline flag set in the report. But:
>>> 1) As commented in the offline ioctl patch, I am not sure the flag makes a lot
>>> of sense. sysfs or nothing at all may be OK as well. When we introduced the new
>>> open/close/finish ioctls, we did not add flags to signal that the device
>>> supports them. Granted, it was for nullblk and scsi, and both had the support.
>>> But running an application using these on an old kernel, and you will get
>>> -ENOTTY, meaning, not supported. So simply introducing the offline ioctl without
>>> any flag would be OK I think.
>>
>> I see. My understanding after some comments from Christoph was that we
>> should use these bits to signal any optional features / capabilities
>> that would depend on the underlying driver, just as it is done with the
>> capacity flag today.
>>
>> If not for the offline transition, for the attributes, I see it exactly
>> as the same use case as capacity, where we signal that a new field is
>> reported in the report structure.
>>
>> Am I missing something here?
>
>Using the report flags for reporting supported operations/features is fine, but
>as already mentioned, then document that by changing the description of enum
>blk_zone_report_flags. Right now, it still says:
>
> * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>
>Which kind of really point to things the zone descriptor itself has compared to
>earlier versions of the descriptor rather than what the device can do or not.

I see how the offline transition collides with this model. But can we
agree that the zone attributes is something that fits here?

>
>And as I argued already, using a flag is fine only for letting a user know about
>a supported feature, but that is far from ideal to have device-mapper easily
>discover what a target can support or not. For that, stacked queue limits are
>much simpler. Which leads to exporting that limit in sysfs rather than using a
>flag for the user interface.

See below

>
>>> Since DM support for this would be nice too and we now are in a situation where
>>> not all devices support the  ioctl, instead of a report flag (a little out of
>>> place), a queue limit exported through sysfs may be a cleaner way to both
>>> support DM correctly (stacked limits) and signal the support to the user. If you
>>> choose this approach, then this patch is not needed. The zoned_flags, or a
>>> regular queue flag like for RESET_ALL can be added in the offline ioctl patch.
>>
>> I see. If we can reach an agreement that the above is a bad
>> understanding on my side, I will be happy to translate this into a sysfs
>> entry. If it is OK, I'll give it this week in the mailing list and send
>> a V4 next week.
>
>It is all about device mapper support... How are you planning to do it using a
>queue flag without said flags being stackable as queue limits ?

I guess what I am struggle with here is that you see the capacity
feature as a different extension than the attributes and the offline
transition.

The way I see it, there are things the device supports and things that
the driver supports. ZAC/ZBC does not support a size != capacity, but
the driver sets these values to be the same. One thing I struggle with
is that saying that we support capacity and setting size = capacity puts
the burden in the user to check these values across all zones to
determine if they can support the driver or not. I think it would be
clear to have a feature explicitly stating that capacity != size.

For the attributes, this is very similar - some apply, some don't, and
we only report the ones that make sense for each driver. I do not see
how device mappers are treated differently here than in the existing
capacity features.

For the offline transition, I see that the current patches do not set
flags properly and we would need to inherit the underlying device if we
want to do it this way. I can understand from your comments that this is
not a good way of doing it. I see in one of your comments from V1 that
we could deal with this transition in the scsi driver and keep it in
memory (i.e., device is still read-only, but driver transitions to
offline) - can you comment on this?

Javier
