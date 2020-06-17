Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF5C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1098F20888
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bAPRE0JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQOmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQOme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 10:42:34 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D5C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 07:42:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e12so2165449eds.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+wmlp3TUuoCAlHj/LRi5Py3tIwsBfqYCvq+vpZAYdfY=;
        b=bAPRE0JBfWg0oR0Ok+btLS+2KJwnv+ZCBYdpUraCke6A9U66YT6LvKfU/hAgMyGEca
         n2uvj3kzoC2C3FbUwM/9E8rJYLuU+coH+TbsJ+ujWPbfU8XvZq0MxKdEzF3o1zqbuCeZ
         We27K7087fLQfW44s7LSQqmuuNarBq6HwRX6d3Muw9brf5LGGPyk7JgkVSM8VbokIUBJ
         /DE9l5TmsCuGGC5t2JuMgStMoR1f8dcxf1i6+8WK2I6kXGkanjYaYAQ+H3xsiMEbtuK8
         LISKkNRRQ3m1OC3JDr28hkJcjShVLClUo4DP+xujOoNO1K0Tfs0k09mV1XCshV7AYpGa
         wCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+wmlp3TUuoCAlHj/LRi5Py3tIwsBfqYCvq+vpZAYdfY=;
        b=Qfn4VL1lgWqfx4miGH6LSMg86ca+xD7+bU3rx2K1f9s+1dAHqu6nk5vgnpiKo77c5g
         2jng4URMvgoMDjcwDDmPUOZmP8Un5SgqabnU9wUwwahaKAYWs4Zqn/hJ9FGEisOUjlvo
         SrfvbKKcwhbuxMZCi/WYKt1zpvuiC2PZdhPC+W4TmhX6yp+Hzygc2fujAfyzwIi6Qo3s
         Tm6IrVJRcDRQm8NNcjdCDOycQC7zTozGtqY+gbrf/AO54dnEOVET2NxPQh6AG3NfWpha
         AIekL7XJvQyvN1+4PVxzf9im4jNW0DrvwczizGOhk+C5RG8efzxphsfKbXX9CAcPl1L+
         IqjQ==
X-Gm-Message-State: AOAM5307+JyMDWW5awfnNkdfie5hWsB3VDENATMEH8UkAOChmUD8ox5V
        nkj6Tj6PRtpdgoI8DFVD17CRYA==
X-Google-Smtp-Source: ABdhPJzlTAmS3TBcxmUH68KPghT5S/KE85nkYi1efdB6MzA7a1CZZhyhR/kr8pTSuNz8Bjfh2KiJhw==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr7273823eds.267.1592404951890;
        Wed, 17 Jun 2020 07:42:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id dk19sm12272136edb.78.2020.06.17.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:42:30 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:42:30 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617074328.GA13474@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 09:43, Christoph Hellwig wrote:
>On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
>> On 16.06.2020 08:34, Keith Busch wrote:
>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>> in NVM Express TP4053. Zoned namespaces are discovered based on their
>>> Command Set Identifier reported in the namespaces Namespace
>>> Identification Descriptor list. A successfully discovered Zoned
>>> Namespace will be registered with the block layer as a host managed
>>> zoned block device with Zone Append command support. A namespace that
>>> does not support append is not supported by the driver.
>>
>> Why are we enforcing the append command? Append is optional on the
>> current ZNS specification, so we should not make this mandatory in the
>> implementation. See specifics below.
>
>Because Append is the way to go and we've moved the Linux zoned block
>I/O stack to required it, as should have been obvious to anyone
>following linux-block in the last few months.  I also have to say I'm
>really tired of the stupid politics tha your company started in the
>NVMe working group, and will say that these do not matter for Linux
>development at all.  If you think it is worthwhile to support devices
>without Zone Append you can contribute support for them on top of this
>series by porting the SCSI Zone Append Emulation code to NVMe.
>
>And I'm not even going to read the rest of this thread as I'm on a
>vacation that I badly needed because of the Samsung TWG bullshit.

My intention is to support some Samsung ZNS devices that will not enable
append. I do not think this is an unreasonable thing to do. How / why
append ended up being an optional feature in the ZNS TP is orthogonal to
this conversation. Bullshit or not, it ends up on devices that we would
like to support one way or another.

After the discussion with Damien and Keith I have a clear idea how we
can do this and we will go ahead with the work.

I apologize that this conversation got mixed with leftovers from NVMe
TWG internals. This is a public mailing list, so I guess anyone can
comment on it.

Thanks,
Javier
