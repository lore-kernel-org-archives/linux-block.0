Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14EC388F9
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172A722243
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="YxyJVBMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgKCOKa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgKCOK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 09:10:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91575C0613D1
        for <linux-block@vger.kernel.org>; Tue,  3 Nov 2020 06:10:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gn41so6993563ejc.4
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2020 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6JH066wfbr2npDz5gl/1SYKZVrWlCGM4iR0jRxp+WVw=;
        b=YxyJVBMKQ3BTTIHH8LWuaH1mHoyk5Jj1dDaI9SW23lROVXKwAq7SGSrCWm/oH4HAXL
         n5X5h2lrPNbrd3cdRRpMGIG0fmE/oMl31mYhigw67jZ/YuFv/Llxh9j7KxauFkyRFt6K
         0fk6lrmHOKsskXoT6NxSFelsMwGvLqMwfzrtV+HPabl+3cz6u3eeNXz9nELFB1LOTKQc
         EgCOZFoMum7b3GI91d0LnPrnWfgD36EyFodK0cSRx6zdXBst09+I2BWiNDLUuza6dWux
         +rUJDDoH4ZFQ798oKm0rYXp2SNK2Vrrm+VfvCx7tZMxTfIZfsO8mAg8SSz0PaR3wEBHZ
         WOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6JH066wfbr2npDz5gl/1SYKZVrWlCGM4iR0jRxp+WVw=;
        b=mX1qrlVg1Rbmgu+5j1CRYRZfVxlbIPI3pLs6qFZpLr/GHW9FDPSGZu4JNEXHQJs1YF
         j2vBoseDnxPwBsCJW6O9KeHJX+vJhkvV9fiGjQeSjQCJDv5qCqdBE1+lL5jv2z/WNyCr
         HcBSD51O49RnVWjB7v9LbfWaPtypaI5q9pfCNcbvVp0sO5E9/azw2ek/VwBxEzCbG01y
         IldabOBXbyAT0LygI3xHiU7C+MADoe4nKa1MP22d7erThmVVlfxWCF4TUEw2JiRSpin4
         LcIsxi9N9PdpWlKrwyvUlU6sqW64mEGn85Hy7Pj4K7Gc6NJntzKcBHWBoANdRoZTzdoE
         GRtw==
X-Gm-Message-State: AOAM530M38CAFoR1ZviVHiIYofBy+GSNz9OpkfOjUkVSrINw3j9InwnO
        CfxekkdYFYGbrXfgTwRqPqizzQ==
X-Google-Smtp-Source: ABdhPJxCo+QbcFQGkaf0UIcCeiTnf17zeNpC22eu+9Tmczhm1wKWQAhX3bN1HI/xXA2SsP+9BHxUyw==
X-Received: by 2002:a17:906:1f92:: with SMTP id t18mr7302329ejr.539.1604412622075;
        Tue, 03 Nov 2020 06:10:22 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id n25sm10971551ejd.114.2020.11.03.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:10:20 -0800 (PST)
Date:   Tue, 3 Nov 2020 15:10:19 +0100
From:   Javier Gonzalez <javier@javigon.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103141019.5eomaxs4qn4ezaeh@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
 <20201103090628.GA15656@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103090628.GA15656@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.11.2020 10:06, hch@lst.de wrote:
>On Mon, Nov 02, 2020 at 10:24:05PM +0100, Javier Gonzalez wrote:
>> If I understand correctly, the model would be that a namespace will
>> always have (i) a character device associated where I/O is always allowed
>> through user formed commands, and if the namespace has full support in
>> the kernel (ii) a block device where I/O is as it is today. In case of
>> (ii) both interfaces can be used for I/O.
>
>Yes.

Thanks for confirming.

One question here is that we are preparing a RFC for a io_uring passthru
using the block device. Based on this discussion, it seems to me that
you see this more suitable through the char device.

Does it make sense that we post this RFC using the block device? It
would be helpful to get early feedback before starting the char device.

>
>> While we work on iterations for c), do you believe it is reasonable to
>> merge a version of the current path that follows the PI convention for
>> unsupported command sets and features? I would assume that we will have
>> to convert PI to this model too when it is available.
>
>I'm rather torn.  I think the model of the zero capacity block device
>is a really, really bad one and we should haver never added it.  That
>being said, for a ZNS namespace that does not support Zone Append I
>can think of a model that actually makes sense:  expose it as a read-only
>block device, as we can actually read from it perfectly fine, and that
>would also allow ioctl access.

This is reasonable. I can re-spin this for append to become read-only
and then we work in parallel for the char device interface.

I see that this does not make much sense for the other non-supported
features in this patch (i.e., !po2 zone size and zoc). Since this is
very much like PI today, is it OK we add these the same way (capacity 0)
and then move to the char device when ready?
