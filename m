Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB8C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DCD208C3
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="UT7SqyQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgFQGSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgFQGSR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 02:18:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16127C061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 23:18:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so1002333eja.7
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OwY3Pi3Y2m/cslIRUdM6gQylau0fFLxBokRuP5QyBxU=;
        b=UT7SqyQqsRi6AB8xwZliU/sOeMTg8kTk2GGeTGd1rb6Z2TrusMlr0LiTeANXvWjB8J
         cmBJ7wlimAuZLlPOwkbPbBwj/5PLXM7loBtNSQrqgofcie+XSSdTZQTOCQE6dDT4zNpO
         RuABj0rXmrjdEMVAPZqZPeXBsA7+aXN3LSoz/hXeCuXoIZ7J5bWzhOtDokarUE0d3n8G
         iAE6WefjFz3EkXdtYO2EOZmrbNgRVRxh3uLf2u3Q4Kk5U9ZzRB+7s0JlbC6l+qyA4W1H
         fpt2vs72bKY0ZkGgrZXtk1wxhtF3WOAkXwuZJXvdKNZINBMZu0pADgdCi9JAQ1iFHiQt
         5OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OwY3Pi3Y2m/cslIRUdM6gQylau0fFLxBokRuP5QyBxU=;
        b=b/+k6mfchAopAdcl4fOnSZpnu4IgmNA+kfMYtcM7Rr8zPdIBy9VIXfv21BgQ/dSrlX
         nWsKv8AqISYOh0XYkc00NUgqstWzqt9QiloTu+TlWxB1110WtejEyDthQsLk3bj2grtl
         0a583opZEiN3uuiLhFecwaqMmoKy6yCYIXTvuDMy4w6flc6npNxu4HtSohhL5KGgXF0G
         +HPbWMy00YEiVgTrO4aFoVPMkEZmIbh63Mfuc4z2YbWwC2bNHL8Ttk+NUUKSP7lFZ7yA
         WyQfzq+SEkIuH7YPHjn8MvIlmYUP3oe6KmMvOz4C9r+8dLlud/KOZzamGS3vElDDsTyT
         CdhA==
X-Gm-Message-State: AOAM532HGmQr+RMZkEFsOCorucHJZfy7NqEALEOhZYaBifmT4jYFztBQ
        wEoAwvL9wHge7rjWJ1W/XHP97w==
X-Google-Smtp-Source: ABdhPJzLtetu863KvnlKLBrTGSqRFO2yUqL8EGy9MwbEhuAgZkK2OfAGRND7zfsSiWrUmUqPJo+J0A==
X-Received: by 2002:a17:906:6dcd:: with SMTP id j13mr5769660ejt.131.1592374695799;
        Tue, 16 Jun 2020 23:18:15 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id l8sm12717319ejz.52.2020.06.16.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:18:14 -0700 (PDT)
Date:   Wed, 17 Jun 2020 08:18:14 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
References: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 00:38, Damien Le Moal wrote:
>On 2020/06/17 1:13, Javier González wrote:
>> On 16.06.2020 09:07, Keith Busch wrote:
>>> On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier González wrote:
>>>> On 16.06.2020 08:48, Keith Busch wrote:
>>>>> On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
>>>>>> This depends very much on how the FS / application is managing
>>>>>> stripping. At the moment our main use case is enabling user-space
>>>>>> applications submitting I/Os to raw ZNS devices through the kernel.
>>>>>>
>>>>>> Can we enable this use case to start with?
>>>>>
>>>>> I think this already provides that. You can set the nsid value to
>>>>> whatever you want in the passthrough interface, so a namespace block
>>>>> device is not required to issue I/O to a ZNS namespace from user space.
>>>>
>>>> Mmmmm. Problem now is that the check on the nvme driver prevents the ZNS
>>>> namespace from being initialized. Am I missing something?
>>>
>>> Hm, okay, it may not work for you. We need the driver to create at least
>>> one namespace so that we have tags and request_queue. If you have that,
>>> you can issue IO to any other attached namespace through the passthrough
>>> interface, but we can't assume there is an available namespace.
>>
>> That makes sense for now.
>>
>> The next step for us is to enable a passthrough on uring, making sure
>> that I/Os do not split.
>
>Passthrough as in "application issues directly NVMe commands" like for SG_IO
>with SCSI ? Or do you mean raw block device file accesses by the application,
>meaning that the IO goes through the block IO stack as opposed to directly going
>to the driver ?
>
>For the latter case, I do not think it is possible to guarantee that an IO will
>not get split unless we are talking about single page IOs (e.g. 4K on X86). See
>a somewhat similar request here and comments about it.
>
>https://www.spinics.net/lists/linux-block/msg55079.html

At the moment we are doing the former, but it looks like a hack to me to
go directly to the NVMe driver.

I was thinking that we could enable the second path by making use of
chunk_sectors and limit the I/O size just as the append_max_io_size
does. Is this the complete wrong way of looking at it?

Thanks,
Javier
