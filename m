Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D476C433E2
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4A22073E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="aIc1plDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393039AbgFSSRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbgFSSRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:17:14 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1080C06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:17:13 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id i4so2070456ooj.10
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFpJ6ZnD/Pgv5lWZwwqonXTZ5IkiWh8cE8PCFs48Uzw=;
        b=aIc1plDnrB11OwqyijEs1WraBz2kBavSttIEINgUZfGky3FK/lmwteaWKmLTNOv2qn
         YwxqMKR4c9xJdMo4lidSYkQ2ST2DlLzahgfM9ncPF3/IQ4XJWWCjCxJnH5lfydXJzkIt
         VlOomebMyAqXs+agUDrgNiCYjUzCBE6nVYZAS2XBH9LkNNqfF5LtS2hxwN1OQeFDmE3C
         8Cn/vL0iNJp7UpY80pT/2dIVXN2RkQsUNBP56RzjWaclX/mLZiXq3dCvQooyz6YR7Qi2
         aeAWwUQSzxijHH/u3zL3vS35ihcWrGL9BFhdFP5O60S4fU1ckTr2gfjwabBZFQTwrm6/
         Y4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFpJ6ZnD/Pgv5lWZwwqonXTZ5IkiWh8cE8PCFs48Uzw=;
        b=DpEyJ2768YXG6g7W9Q4AjYBBWVCuzeQX0te/rQ84/ED+P1G+mfMqSg4vP4C55l1Jga
         fenZQJ97e1LOt7t4uC1ZX0rgDFmu28T2iLPuCiRabefSJ/tRNadwK8No/q4WpUD1uqYO
         uIbD8Ig6SnuhW2kFYgTsoZuj1x1F2uFb1M52DNh3LKOEtKhbjitSXrLXKVkrTwoLRcYQ
         MSaXIvkKMKLfihhhcpo8W7+/6a0U0lEx4mNzHspmiKN/8JqeAuORswW94CWyV2/TIQQa
         csCnRIxXufr1zCjDRwdeSUsn0AzPc36AfKxCTpfu9bJsloo1PdC5vyd1thFVG3Kb5R+0
         OtlQ==
X-Gm-Message-State: AOAM533kpwPTHQwEJRCuXZAWYA5lnjf+Fy1ttkU60EfHSR2rq43fI4jM
        PThTzp/DnIEC5f5w5hyji809GA8Rug2gAE8XXCkkbQ==
X-Google-Smtp-Source: ABdhPJxcJwpu/6OGh4CKgU1K4xMWMqts74pwBx+f7gkrBT9pFKaQ4qd/Z3/v4cmksTNvYP5ZhWWjAJyRrpmeqO/LBWE=
X-Received: by 2002:a4a:94d1:: with SMTP id l17mr4382819ooi.88.1592590633144;
 Fri, 19 Jun 2020 11:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6> <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com> <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Fri, 19 Jun 2020 11:17:02 -0700
Message-ID: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > Hi Matias,
> > no, I am rather saying that the Linux kernel has a deficit or at least
> > is not a good fit for ZNS because it cannot enforce in-order delivery.
>
> FYI, the nvme protocol can't even enforce in-order delivery, so calling
> out linux for this is a moot point.

How does it work in SPDK then? I had understood that SPDK supported
QD>1 for ZNS devices.
I am not saying that Linux is the only problem. The fact remains that
out of order delivery is not a good fit for an interface that requires
sequential writes.

>
> > The requirement of sequential writes basically imposes this
> > requirement. Append essentially a Linux specific fix on the ZNS level
> > and that enforcing ordering would be a cleaner way to enable QD>1.
