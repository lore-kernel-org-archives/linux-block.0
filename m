Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA38421789
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="NYZlVUwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQTXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 15:23:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1984C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 12:23:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so3237225wmc.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3dKbPP3eDtyGR49clYMy81qkvxaAQtCk+88ZEFUV1hs=;
        b=NYZlVUwJIE3zS0bX76oEmu4gzb+UcfiZust4L+voBvVC9uC8J6E0mWawlDoRdXivwj
         gsl3p/kOTpw3pI4ywTEVREShX/C4KcRmBIQZzGPwQntTWJOChPNxX3cpOJjHg8eGyD03
         3JYyZKRaXmFKrPLResc9CoCQFqJDmNRdCiKTBUW9SXeJYedVdn7wIekSD6eAk/YSvPud
         TsCJsLrbWClq6h252hqYrQADJZ2/iI3oYtEazEIdphBss3dYXMpB37OBozp+tXrI+WwP
         s1EgYkU+VyhuFxzzHs+yLsVb6KXRyHlYlfYLr9LhRoZ1eoPrqyI/eA8T6korMdmUZKx7
         DyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3dKbPP3eDtyGR49clYMy81qkvxaAQtCk+88ZEFUV1hs=;
        b=GGvdpj9mWBwihuQ7TzBuF+hHjd+4xeYPxcxu0VGePQPGNbfZlFyg4aLt6jnBhA+pKR
         cMXDMCTIVAnqq53QfoCXhwl+nsx1L/4sIvTiwc1kiwee2nnkzh8sADs0Rn/kYf+Lor6j
         hqBLESO5sfIPMvL/5Afjnp+9Tp2OUQ8FInDKMk7utILMak2UWXUn/BTO57Ar/Fxjno0i
         0Z52q7P5CLFFHA0td8xzxgbhRZ3BaxbZjtSGrSVOj0LTp9drnrL+zhgMLZNWf4kzhEfe
         bKzkTN4/+CDHRFBkVKguSTEnFJ3xnr9SiSWErsFPgtMI1HsZf+cVDpWvYwoxNj8Qfe8x
         en1w==
X-Gm-Message-State: AOAM533g8gd1oALMvtD5EAby75KHeoO6LUW0V9U8c92UFx6E5Z8z6xkr
        3dNoAaJiCVQSK5P20Hfpgbj4Yw==
X-Google-Smtp-Source: ABdhPJwqKrw0uuSaRBa9T5zFW+UI6fKVOsbiCtXpEWjfsmyzGw9wYC8zTs+7hZqZObf/sL2pcMK8bw==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr216651wmf.163.1592421786521;
        Wed, 17 Jun 2020 12:23:06 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id n23sm751601wmc.21.2020.06.17.12.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 12:23:05 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
Date:   Wed, 17 Jun 2020 21:23:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17/06/2020 21.09, Javier González wrote:
> On 17.06.2020 18:55, Matias Bjorling wrote:
>>> -----Original Message-----
>>> From: Javier González <javier@javigon.com>
>>> Sent: Wednesday, 17 June 2020 20.29
>>> To: Matias Bjørling <mb@lightnvm.io>
>>> Cc: Christoph Hellwig <hch@lst.de>; Keith Busch <Keith.Busch@wdc.com>;
>>> linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; Damien 
>>> Le Moal
>>> <Damien.LeMoal@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>;
>>> Sagi Grimberg <sagi@grimberg.me>; Jens Axboe <axboe@kernel.dk>; Hans
>>> Holmberg <Hans.Holmberg@wdc.com>; Dmitry Fomichev
>>> <Dmitry.Fomichev@wdc.com>; Ajay Joshi <Ajay.Joshi@wdc.com>; Aravind
>>> Ramesh <Aravind.Ramesh@wdc.com>; Niklas Cassel
>>> <Niklas.Cassel@wdc.com>; Judy Brock <judy.brock@samsung.com>
>>> Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
>>>
>>> On 17.06.2020 19:57, Matias Bjørling wrote:
>>> >On 17/06/2020 16.42, Javier González wrote:
>>> >>On 17.06.2020 09:43, Christoph Hellwig wrote:
>>> >>>On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
>>> >>>>On 16.06.2020 08:34, Keith Busch wrote:
>>> >>>>>Add support for NVM Express Zoned Namespaces (ZNS) Command Set
>>> >>>>>defined in NVM Express TP4053. Zoned namespaces are discovered
>>> >>>>>based on their Command Set Identifier reported in the namespaces
>>> >>>>>Namespace Identification Descriptor list. A successfully 
>>> discovered
>>> >>>>>Zoned Namespace will be registered with the block layer as a host
>>> >>>>>managed zoned block device with Zone Append command support. A
>>> >>>>>namespace that does not support append is not supported by the 
>>> driver.
>>> >>>>
>>> >>>>Why are we enforcing the append command? Append is optional on the
>>> >>>>current ZNS specification, so we should not make this mandatory in
>>> >>>>the implementation. See specifics below.
>>> >>>
>>> >>>Because Append is the way to go and we've moved the Linux zoned 
>>> block
>>> >>>I/O stack to required it, as should have been obvious to anyone
>>> >>>following linux-block in the last few months.  I also have to say 
>>> I'm
>>> >>>really tired of the stupid politics tha your company started in the
>>> >>>NVMe working group, and will say that these do not matter for Linux
>>> >>>development at all.  If you think it is worthwhile to support 
>>> devices
>>> >>>without Zone Append you can contribute support for them on top of
>>> >>>this series by porting the SCSI Zone Append Emulation code to NVMe.
>>> >>>
>>> >>>And I'm not even going to read the rest of this thread as I'm on a
>>> >>>vacation that I badly needed because of the Samsung TWG bullshit.
>>> >>
>>> >>My intention is to support some Samsung ZNS devices that will not
>>> >>enable append. I do not think this is an unreasonable thing to do. 
>>> How
>>> >>/ why append ended up being an optional feature in the ZNS TP is
>>> >>orthogonal to this conversation. Bullshit or not, it ends up on
>>> >>devices that we would like to support one way or another.
>>> >
>>> >I do not believe any of us have said that it is unreasonable to
>>> >support. We've only asked that you make the patches for it.
>>> >
>>> >All of us have communicated why Zone Append is a great addition to the
>>> >Linux kernel. Also, as Christoph points out, this has not been a 
>>> secret
>>> >for the past couple of months, and as Martin pointed out, have been a
>>> >wanted feature for the past decade in the Linux community.
>>>
>>> >
>>> >I do want to politely point out, that you've got a very clear signal
>>> >from the key storage maintainers. Each of them is part of the planet's
>>> >best of the best and most well-respected software developers, that
>>> >literally have built the storage stack that most of the world depends
>>> >on. The storage stack that recently sent manned rockets into space.
>>> >They each unanimously said that the Zone Append command is the right
>>> >approach for the Linux kernel to reduce the overhead of I/O tracking
>>> >for zoned block devices. It may be worth bringing this information to
>>> >your engineering organization, and also potentially consider Zone
>>> >Append support for devices that you intend to used with the Linux
>>> >kernel storage stack.
>>>
>>> I understand and I have never said the opposite.
>>>
>>> Append is a great addition that
>>
>> One may have interpreted your SDC EMEA talk the opposite. It was not
>> very neutral towards Zone Append, but that is of cause one of its least
>> problems. But I am happy to hear that you've changed your opinion.
>
> As you are well aware, there are some cases where append introduces
> challenges. This is well-documented on the bibliography around nameless
> writes. 

The nameless writes idea is vastly different from Zone append, and have 
little of the drawbacks of nameless writes, which makes the 
well-documented literature not apply.

> Part of the talk was on presenting an alternative for these
> particular use cases.
>
> This said, I am not afraid of changing my point of view when I am proven
> wrong.
>
>>
>>> we also have been working on for several months (see patches 
>>> additions from
>>> today). We just have a couple of use cases where append is not 
>>> required and I
>>> would like to make sure that they are supported.
>>>
>>> At the end of the day, the only thing I have disagreed on is that 
>>> the NVMe
>>> driver rejects ZNS SSDs that do not support append, as opposed to 
>>> doing this
>>> instead when an in-kernel user wants to utilize the drive (e.g., 
>>> formatting a FS
>>> with zoned support) This would allow _today_
>>> ioctl() passthru to work for normal writes.
>>>
>>> I still believe the above would be a more inclusive solution with 
>>> the current ZNS
>>> specification, but I can see that the general consensus is different.
>>
>> The comment from the community, including me, is that there is a
>> general requirement for Zone Append command when utilizing Zoned
>> storage devices. This is similar to implement an API that one wants to
>> support. It is not a general consensus or opinion. It is hard facts and
>> how the Linux kernel source code is implemented at this point. One must
>> implement support for ZNS SSDs that do not expose the Zone Append
>> command natively. Period.
>
> Again, I am not saying the opposite. Read the 2 lines below...

My point with the above paragraph was to clarify that we are not trying 
to be difficult or opinionated, but point out that the reason we give 
you the specific feedback, is that it is the way it is in the kernel as 
today.

>
>>>
>>> So we will go back, apply the feedback that we got and return with an
>>> approach that better fits the ecosystem.
>>>
>>> >
>>> >Another approach, is to use SPDK, and bypass the Linux kernel. This
>>> >might even be an advantage, your customers does not have to wait on 
>>> the
>>> >Linux distribution being released with a long term release, before 
>>> they
>>> >can even get started and deploy in volume. I.e., they will actually 
>>> get
>>> >faster to market, and your company will be able to sell more drives.
>>>
>>> I think I will refrain from discussing our business strategy on an 
>>> open mailing
>>> list. Appreciate the feedback though. Very insightful.
>>
>> I am not asking for you to discuss your business strategy on the 
>> mailing list. My comment was to give you genuinely advise that may 
>> save a lot of work, and might even get better results.
>>
>>>
>>> Thanks,
>>> Javier
>

