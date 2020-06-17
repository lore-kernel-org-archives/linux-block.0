Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F135C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AF9212CC
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="W3TtD5kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFQS2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgFQS2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 14:28:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE4C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 11:28:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q19so3553871eja.7
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j/V1hr10ITS8yidyCmaznz+Ljxp2V68wF9QK22/RMEk=;
        b=W3TtD5kzoXuIbeeO1mrGtVOk1wATd49f9OYQH03fq+G7uVQ6x8RPt+o1ArMX2np76y
         G7Ux6yoDJX98vFUo3OVj6gjBQR410flTKkT41lSdzjSEd38jyXy1kucc5R7dT361/8tg
         RXFFNB8rZ3U5xs+1x7S8PMESWyyMA4L7TgzWV+d8zmndJmUTADrQ+7Mu6BLo6DF1pzOC
         LjQoIdJchLb+xpMfzE2fogUHuvukW0qS3YQ2hbbsZZ57rIN3jTyuhf8SoIX/BnKBs+mG
         NYizivxfsevMZAZQ/BODqtqkvyLBCalu54l+g5jJsUHv2n3U+40rKb+PBMzpD2iBLC14
         II1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j/V1hr10ITS8yidyCmaznz+Ljxp2V68wF9QK22/RMEk=;
        b=ir3h9iT8kaI5BsZDI8hlx4oQG+2xU0knJ2zCqV9qwwy3Szvr55NNxlPtd58qvNhzJO
         y0BolaSFKn4enQKzc/Zcv1ZAcEvylSt6hBtz1F3PYBsKOUib372sIKy0XiAN9yx8fDEw
         k22jEjiN6tp88g8Vtzio9Aub8DKlqnMsUnhIteeM2kvyI456UEX7kxILJQVjw54AMYqR
         +oCpXkaCfyth5JrYvZEmd2aZcu2FRTbJnY0cuvZ9HieK97LH5/tLFhAECZSdQWebQgOe
         dN8SOFlMDd8h9gHZHlKoj9xUYkcNOXSa0rVQuuKPSKORCDnNyHGfPvX8sQbLssUQ3OX+
         ikmQ==
X-Gm-Message-State: AOAM532NOK5rkW2S5Jd0cCpc3rvWiV24FR40yUgIKwiAPkQRZ8N1rpsO
        EYX2+EK29U/8D1KnEIRXHm/8kg==
X-Google-Smtp-Source: ABdhPJxnxSFCdIJ/HsoQh4E9pWuoJ9049b1UC/dDe6gfWPEpcOoZ0wzAzGSnT5EgF068irB0iWnutA==
X-Received: by 2002:a17:906:1a06:: with SMTP id i6mr469085ejf.9.1592418522888;
        Wed, 17 Jun 2020 11:28:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id p4sm273990edj.64.2020.06.17.11.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:28:41 -0700 (PDT)
Date:   Wed, 17 Jun 2020 20:28:41 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 19:57, Matias Bjørling wrote:
>On 17/06/2020 16.42, Javier González wrote:
>>On 17.06.2020 09:43, Christoph Hellwig wrote:
>>>On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
>>>>On 16.06.2020 08:34, Keith Busch wrote:
>>>>>Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>>>>in NVM Express TP4053. Zoned namespaces are discovered based on their
>>>>>Command Set Identifier reported in the namespaces Namespace
>>>>>Identification Descriptor list. A successfully discovered Zoned
>>>>>Namespace will be registered with the block layer as a host managed
>>>>>zoned block device with Zone Append command support. A namespace that
>>>>>does not support append is not supported by the driver.
>>>>
>>>>Why are we enforcing the append command? Append is optional on the
>>>>current ZNS specification, so we should not make this mandatory in the
>>>>implementation. See specifics below.
>>>
>>>Because Append is the way to go and we've moved the Linux zoned block
>>>I/O stack to required it, as should have been obvious to anyone
>>>following linux-block in the last few months.  I also have to say I'm
>>>really tired of the stupid politics tha your company started in the
>>>NVMe working group, and will say that these do not matter for Linux
>>>development at all.  If you think it is worthwhile to support devices
>>>without Zone Append you can contribute support for them on top of this
>>>series by porting the SCSI Zone Append Emulation code to NVMe.
>>>
>>>And I'm not even going to read the rest of this thread as I'm on a
>>>vacation that I badly needed because of the Samsung TWG bullshit.
>>
>>My intention is to support some Samsung ZNS devices that will not enable
>>append. I do not think this is an unreasonable thing to do. How / why
>>append ended up being an optional feature in the ZNS TP is orthogonal to
>>this conversation. Bullshit or not, it ends up on devices that we would
>>like to support one way or another.
>
>I do not believe any of us have said that it is unreasonable to 
>support. We've only asked that you make the patches for it.
>
>All of us have communicated why Zone Append is a great addition to the 
>Linux kernel. Also, as Christoph points out, this has not been a 
>secret for the past couple of months, and as Martin pointed out, have 
>been a wanted feature for the past decade in the Linux community.

>
>I do want to politely point out, that you've got a very clear signal 
>from the key storage maintainers. Each of them is part of the planet's 
>best of the best and most well-respected software developers, that 
>literally have built the storage stack that most of the world depends 
>on. The storage stack that recently sent manned rockets into space. 
>They each unanimously said that the Zone Append command is the right 
>approach for the Linux kernel to reduce the overhead of I/O tracking 
>for zoned block devices. It may be worth bringing this information to 
>your engineering organization, and also potentially consider Zone 
>Append support for devices that you intend to used with the Linux 
>kernel storage stack.

I understand and I have never said the opposite. Append is a great
addition that we also have been working on for several months (see
patches additions from today). We just have a couple of use cases where
append is not required and I would like to make sure that they are
supported.

At the end of the day, the only thing I have disagreed on is that the
NVMe driver rejects ZNS SSDs that do not support append, as opposed to
doing this instead when an in-kernel user wants to utilize the drive
(e.g., formatting a FS with zoned support) This would allow _today_
ioctl() passthru to work for normal writes.

I still believe the above would be a more inclusive solution with the
current ZNS specification, but I can see that the general consensus is
different.

So we will go back, apply the feedback that we got and return with an
approach that better fits the ecosystem.

>
>Another approach, is to use SPDK, and bypass the Linux kernel. This 
>might even be an advantage, your customers does not have to wait on 
>the Linux distribution being released with a long term release, before 
>they can even get started and deploy in volume. I.e., they will 
>actually get faster to market, and your company will be able to sell 
>more drives.

I think I will refrain from discussing our business strategy on an open
mailing list. Appreciate the feedback though. Very insightful.

Thanks,
Javier
