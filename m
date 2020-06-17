Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA10C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E80821527
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="MdJf6dQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFQR5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFQR5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 13:57:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B5C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 10:57:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t13so884785wrs.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rIjWNx6XtFvOaVapPdlfjvt5hio5VdS/1XdOtnEqP6s=;
        b=MdJf6dQv2+sYp+jJ5ELYlyLJpFY/pBbTQqKzXs0P4SBT86BliYBL+5dtVB9/Ing9nq
         YXFBfOBUDb5BrQ7qBEjuHDgGuOX+u30/S5Wx3M27yRHSUplsr24jYavnLY94YAbmrx5j
         opGKxl4qUqgH9wr3bZQ/y9Tpo7hcVQmkTXhD6lJG8S42wsFANwENIxIriPSpRgt6v7vM
         nImpnpKhGi9SG+ZqGqoWxrk5KYy/yrH74NFCRAC6mJ88mCiwCBpxdaJDBHiwRfdPXtpG
         7/bmOO/BK2pZ2++WLnPu+dA9v/Wp9uD0GXHTrhp8frO2GUn9OsmZsC9B0qdREDuGrkPO
         Rwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rIjWNx6XtFvOaVapPdlfjvt5hio5VdS/1XdOtnEqP6s=;
        b=qayNIl9w8OqQrtuiKb0Zolhmxxy3KPgLSZFt1vdG8e6pe7zGhy1qt1tap5DMFZEl/4
         Z6UhA3lGr1Z2Um/kX/AV7WDMmANJ+oq359D2+RFN6AgV6I+IhbxypQZXpPovlLy7czBM
         M2DfeG7NSe65R/TJhWUJjQVfxExCL+eg8Hw/X63LxjATuVvbifSXNrCt/0bUk8cFrkK8
         4w087iFpb1yb2bh0xpKdRFsJQs/UytHNlHBbyFr/QnN3xBcFENW8TUilnULq1zfikhEe
         GmlCkrdyU0tLbG6W90Jc7JqNzap1ttD7Nss3Qp08oM7M9ygvIVVMEhzFefEDCA6ip+0t
         UyvQ==
X-Gm-Message-State: AOAM531WHoe7ET/WHUuRflm4rY3wH1DzTf/V5TMmHFkPlfdCCPZ9HTDO
        lt47e8MUkvmX1c74KlKhmH8riQ==
X-Google-Smtp-Source: ABdhPJxTMIVt2FHfC+p1ihCFlr89jxg/pE35pU+VVcTqvqSFNe3A2i0Q1AmNjb7CT1Pv9tAIwFQSHQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr413622wrw.199.1592416667209;
        Wed, 17 Jun 2020 10:57:47 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id h27sm473209wrb.18.2020.06.17.10.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 10:57:46 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
Date:   Wed, 17 Jun 2020 19:57:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17/06/2020 16.42, Javier González wrote:
> On 17.06.2020 09:43, Christoph Hellwig wrote:
>> On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>>> in NVM Express TP4053. Zoned namespaces are discovered based on their
>>>> Command Set Identifier reported in the namespaces Namespace
>>>> Identification Descriptor list. A successfully discovered Zoned
>>>> Namespace will be registered with the block layer as a host managed
>>>> zoned block device with Zone Append command support. A namespace that
>>>> does not support append is not supported by the driver.
>>>
>>> Why are we enforcing the append command? Append is optional on the
>>> current ZNS specification, so we should not make this mandatory in the
>>> implementation. See specifics below.
>>
>> Because Append is the way to go and we've moved the Linux zoned block
>> I/O stack to required it, as should have been obvious to anyone
>> following linux-block in the last few months.  I also have to say I'm
>> really tired of the stupid politics tha your company started in the
>> NVMe working group, and will say that these do not matter for Linux
>> development at all.  If you think it is worthwhile to support devices
>> without Zone Append you can contribute support for them on top of this
>> series by porting the SCSI Zone Append Emulation code to NVMe.
>>
>> And I'm not even going to read the rest of this thread as I'm on a
>> vacation that I badly needed because of the Samsung TWG bullshit.
>
> My intention is to support some Samsung ZNS devices that will not enable
> append. I do not think this is an unreasonable thing to do. How / why
> append ended up being an optional feature in the ZNS TP is orthogonal to
> this conversation. Bullshit or not, it ends up on devices that we would
> like to support one way or another.

I do not believe any of us have said that it is unreasonable to support. 
We've only asked that you make the patches for it.

All of us have communicated why Zone Append is a great addition to the 
Linux kernel. Also, as Christoph points out, this has not been a secret 
for the past couple of months, and as Martin pointed out, have been a 
wanted feature for the past decade in the Linux community.

I do want to politely point out, that you've got a very clear signal 
from the key storage maintainers. Each of them is part of the planet's 
best of the best and most well-respected software developers, that 
literally have built the storage stack that most of the world depends 
on. The storage stack that recently sent manned rockets into space. They 
each unanimously said that the Zone Append command is the right approach 
for the Linux kernel to reduce the overhead of I/O tracking for zoned 
block devices. It may be worth bringing this information to your 
engineering organization, and also potentially consider Zone Append 
support for devices that you intend to used with the Linux kernel 
storage stack.

Another approach, is to use SPDK, and bypass the Linux kernel. This 
might even be an advantage, your customers does not have to wait on the 
Linux distribution being released with a long term release, before they 
can even get started and deploy in volume. I.e., they will actually get 
faster to market, and your company will be able to sell more drives.

