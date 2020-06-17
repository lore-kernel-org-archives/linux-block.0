Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5222C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB2C2082F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="xC8Lmh7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFQHee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQHed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 03:34:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97EC061573
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 00:34:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so1211300eja.7
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0dhH/VXyy0ISpjwzTNRZXOZQID4Ea+00PzZYc8ZmdJM=;
        b=xC8Lmh7dh+zvNB8HexJfGodQpW9e4A29s+xJQjZ3bzP0f67D1QVx92/OjD3zkt8eOv
         dpxJ99UmZni3GMTHoDArYKthJHLMD/ucJzix6RO3Ru3ydByk9mAOZ/4Lf5LiaGWjOBXx
         G10nRX5AVI95JOA1vFPOfiL5rQgJBsUYzECAoUdaJipLh6yEVPhsgr7pWnQl2rxT/vvp
         iJBO2uhOWNuNH0UD2gm33fCAI78jKiwvKSqzqf1J6BwLudL5fm33b7aGOwSLLGznNwfS
         tUZOVb3Kpv/2d8m2uoiuJX2Apz0lfiEkNENT/dfOosWdHLOJxJ4BUNIK5y55wMLRY6tv
         D8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0dhH/VXyy0ISpjwzTNRZXOZQID4Ea+00PzZYc8ZmdJM=;
        b=iG4I13Ys2BCmSM5zNMy/cSllW9sTUXF5iCk3p9fMJN0It2LfobUcgNPEmaM4Uyxj6p
         n42KBNI1VKiAevyWUxHLbo6E3hJlxBdE+1kGrLDaVXQgZ9gjPsIf1F+03IRNTGbJ/A/t
         SF9eq/7uR4HFOl4VdNQkYZn2y/YqPFoCdbIyqww5CMMS5xoHAQQfWknRX4bHSa5Z/nHD
         VA0ojwnjYIsWvoQp/8lZVJC0ulrEeINjy8DFa65Klb9Iwa6sr+rzq+DI/OIyL8VJWPgD
         wxUdV45FjNGPDzDVN+9jrJ88WXeIFEDFW/kvYrZYNFLwHSel2BO0omZqt0vftyYA6f36
         5fUg==
X-Gm-Message-State: AOAM533GvWLMME1wYp59R2wQeOCYi0AoN7zVbMhqj45AeC20HouI4CMn
        dipXSNgnCetKLY/3gkv7lxSlkw==
X-Google-Smtp-Source: ABdhPJye0PUF5hLF7M8Q9UGm5EJmqESbm3d5n0laKC9jEj8n14C5uR8RkOQBDJPMHNRJeyUCwVPCkg==
X-Received: by 2002:a17:906:7c56:: with SMTP id g22mr6213967ejp.507.1592379271743;
        Wed, 17 Jun 2020 00:34:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id o4sm11469968edt.15.2020.06.17.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:34:30 -0700 (PDT)
Date:   Wed, 17 Jun 2020 09:34:30 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617073430.htbwj6ybkbui7jai@mpHalley.localdomain>
References: <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
 <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617071141.rfy545k2vlzkroby@mpHalley.localdomain>
 <CY4PR04MB375134A3B37A43AD6AF07815E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB375134A3B37A43AD6AF07815E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 07:29, Damien Le Moal wrote:
>On 2020/06/17 16:11, Javier González wrote:
>> On 17.06.2020 06:54, Damien Le Moal wrote:
>>> On 2020/06/17 15:18, Javier González wrote:
>>>> On 17.06.2020 00:38, Damien Le Moal wrote:
>>>>> On 2020/06/17 1:13, Javier González wrote:
>>>>>> On 16.06.2020 09:07, Keith Busch wrote:
>>>>>>> On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier González wrote:
>>>>>>>> On 16.06.2020 08:48, Keith Busch wrote:
>>>>>>>>> On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
>>>>>>>>>> This depends very much on how the FS / application is managing
>>>>>>>>>> stripping. At the moment our main use case is enabling user-space
>>>>>>>>>> applications submitting I/Os to raw ZNS devices through the kernel.
>>>>>>>>>>
>>>>>>>>>> Can we enable this use case to start with?
>>>>>>>>>
>>>>>>>>> I think this already provides that. You can set the nsid value to
>>>>>>>>> whatever you want in the passthrough interface, so a namespace block
>>>>>>>>> device is not required to issue I/O to a ZNS namespace from user space.
>>>>>>>>
>>>>>>>> Mmmmm. Problem now is that the check on the nvme driver prevents the ZNS
>>>>>>>> namespace from being initialized. Am I missing something?
>>>>>>>
>>>>>>> Hm, okay, it may not work for you. We need the driver to create at least
>>>>>>> one namespace so that we have tags and request_queue. If you have that,
>>>>>>> you can issue IO to any other attached namespace through the passthrough
>>>>>>> interface, but we can't assume there is an available namespace.
>>>>>>
>>>>>> That makes sense for now.
>>>>>>
>>>>>> The next step for us is to enable a passthrough on uring, making sure
>>>>>> that I/Os do not split.
>>>>>
>>>>> Passthrough as in "application issues directly NVMe commands" like for SG_IO
>>>>> with SCSI ? Or do you mean raw block device file accesses by the application,
>>>>> meaning that the IO goes through the block IO stack as opposed to directly going
>>>>> to the driver ?
>>>>>
>>>>> For the latter case, I do not think it is possible to guarantee that an IO will
>>>>> not get split unless we are talking about single page IOs (e.g. 4K on X86). See
>>>>> a somewhat similar request here and comments about it.
>>>>>
>>>>> https://www.spinics.net/lists/linux-block/msg55079.html
>>>>
>>>> At the moment we are doing the former, but it looks like a hack to me to
>>>> go directly to the NVMe driver.
>>>
>>> That is what the nvme driver ioctl() is for no ? An application can send an NVMe
>>> command directly to the driver with it. That is not a hack, but the regular way
>>> of doing passthrough for NVMe, isn't it ?
>>
>> We have enabled it through uring to get async() passthru submission.
>> Looks like a hack at the moment, but we might just send a RFC to have
>> something concrete to based the discussion on.
>
>Yes, that would clarify things.
>
>>>> I was thinking that we could enable the second path by making use of
>>>> chunk_sectors and limit the I/O size just as the append_max_io_size
>>>> does. Is this the complete wrong way of looking at it?
>>>
>>> The block layer cannot limit the size of a passthrough command since the command
>>> is protocol specific and the block layer is a protocol independent interface.
>>
>> Agree. This work depend in the application being aware of a max I/O size
>> at the moment. Down the road, we will remove (or at least limit a lot)
>> this constraint for ZNS devices that can eventually cache out-of-order
>> I/Os.
>
>I/Os with a data buffer all need mapping for DMA, no matter the device
>functionalities or the command being executed. With passthrough, I do not think
>it is possible to have the block layer limit anything. It will likely always be
>pass-or-fail. With passthrough, the application needs to understand what it is
>doing.

Yes. It is definitely for applications that are implementing directly
zone-aware logic.

>
>>
>>> SCSI SG does not split passthrough requests, it cannot. For passthrough
>>> commands, the command buffer can be dma-mapped or it cannot. If mapping
>>> succeeds, the command is issued. If it cannot, the command is failed. At least,
>>> that is my understanding of how the stack is working.
>>
>> I am not familiar with SCSI SG. This looks like how the ioctl() passthru
>> works in NVMe, but as mentioned above, we would like to enable an
>> async() passthru path.
>
>That is done with bsg for SCSI I believe. You may want to have a look around
>there. The SG driver used to have the write() system call mapped to "issuing a
>command" and read() for "getting a command result". That was removed however.
>But I think bsg has a replacement for that defunct async passthrough interface.
>Not sure. I have not looked at that for a while.
>

Thanks for the pointer; I was not aware of this. We will look into it.

Thanks again for the help Damien!
Javier
