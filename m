Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA3C433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509FC24125
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="UTbTzGsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgFTRxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jun 2020 13:53:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32920 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTRxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jun 2020 13:53:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id n6so9858117otl.0
        for <linux-block@vger.kernel.org>; Sat, 20 Jun 2020 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Mz+T0R3CmrVkyAiLGaJ8kfGJk+hpqodjeuLQrL/aRA=;
        b=UTbTzGsbWCKY/FImoY5WfQYJ7oZQz6/Ykxs8LQYJMijNBHRsKDLOXj/FjddGttn6qx
         kCa13NDUM5mZK78I7Q2goO+/lgcuR2s8zgvKdXPVCUyPnDJgCSkzwtW0T6YQ7v9rSyx4
         uS1E49tNhzLY3qcO8SVTQmAq0x5hf9Hjpoid/6a/LL0Y03UFgfI4Bg6SmxN6AI8dty75
         7q4jKtGdH3WQT8cI5+Wuzm3J7Kz/LCTFsTqcPITvQAsI4aAXhVPdqlN0H6TaM0bZR6c4
         Kx+9/PHkDkRoXrIn+j5LJ6IwGNfb0Ulwa344Vo4VDrKj+WUmFjgztCsMmvpDGt7yK/gJ
         2uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Mz+T0R3CmrVkyAiLGaJ8kfGJk+hpqodjeuLQrL/aRA=;
        b=E0Zgg6Pbs17zKyFj1aMZS0uhaB4Bnj1zPCoGFA/Ubzk0tU1IsxMJSC7ig8kOd6gnGQ
         z/AezMMQpmSGJqu8O6T2Ugfwervl2y/CrMh6AuFy6VPN635fo3hHyfZaZCtepnHJ/znp
         DAqRBV69/RgwITYW+Pidq+khfkY9kOYiCL1QGLsGxDIWlihBdjlgfNkY3OGPE+W4+Itu
         +gHsI+P2utF8tvEJlw3oJBBgKcyHoKKApJVw/Yu61IJzpkSymfdg3gEAS1Gaun7MNIWz
         vO9a4q+hTWlv41jQhcFzkJfCVL3l9FFSVQRCUUYhu9CJgx8o4hvvvAqEFsgdzpl5+txZ
         Ed0g==
X-Gm-Message-State: AOAM530KG4v7gGsfYw0SJVg+k1gxNcCVPTGbZ0K2S+zT5QJDNrfZV3pt
        guXiFUCWKhWD9/FjiNIJS6gJ0u2LfzuYAmg3i9grzQ==
X-Google-Smtp-Source: ABdhPJxG+NI+bUalvZTD9CwojB6vkCx6LZzpiseaSnMY0H1DGp8x/RDwPQKR3Fz+UXS/Hl1LCzDCAnWHbKU8D+6S4Y0=
X-Received: by 2002:a9d:4503:: with SMTP id w3mr7491080ote.38.1592675552497;
 Sat, 20 Jun 2020 10:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6> <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com> <20200620063301.GA2381@lst.de>
In-Reply-To: <20200620063301.GA2381@lst.de>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Sat, 20 Jun 2020 10:52:21 -0700
Message-ID: <CAJbgVnUFzP27Nx2jr4rLOuw9J0C5dRDdD+LfFMCwHY3=oBDYDw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
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

I don't remember saying that I don't understand the basics of NVMe, so
I am not sure where you got this from.

That being said, the point I am trying to discuss is not about NVMe in
particular. It is the general question of: What is the benefit of
splitting and reordering (on whatever layer) for a hardware device
that requires sequential writes? I claim that there is no benefit.

I have worked with SSDs in the past that exposed raw flash blocks over
NVMe and that achieved maximum write bandwidth without append by
enforcing splitting/ordering guarantees, so I know it is possible.

I will accept that there is no interest in discussing the question
above, so I'll stop here.

On Fri, Jun 19, 2020 at 11:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > Hi Matias,
> > no, I am rather saying that the Linux kernel has a deficit or at least
> > is not a good fit for ZNS because it cannot enforce in-order delivery.
>
> Seriously, if you don't understand the basics of NVMe can you please stop
> spamming this list with your crap?
