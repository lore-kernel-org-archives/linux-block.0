Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD6DC433E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3E214D8
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="WzRE8OKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbgFSSkQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732927AbgFSSkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:40:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBEC06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:40:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so9286602oic.9
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQ9K1KPsC1AxCg2WQw20A8A+1B/U0h1NofeCWjoKf/U=;
        b=WzRE8OKgYeBMsudMxocNKWuutVLmPfmen63YhDp+JhMxYN1ewqFTWrSgRlOy1xSRcG
         PpRNJShVtDbxZGPqh7Euh+tVjQZI+R3QPopi6ivmCVD3gGM0596gIFWr4sOHSmLJBSrc
         ccNj/YBdrAY7CA7SPp+HazR0xvzhjydkutT1uUB9NPAy5mp7AuvXReAxdQPSj9RnDySS
         Gt400H0FgcEzxtpmyJQwQPm24kvuWetDwWFtUZsDr0RDRJP8Bdoga/RDAjUnfSow9T22
         bJ/Oq5MAX3triPdD4uQcC/ipaHtpGuCk4iXAMNtu36SktiqDb9kFb97nndNLEBx4iDdI
         Jdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQ9K1KPsC1AxCg2WQw20A8A+1B/U0h1NofeCWjoKf/U=;
        b=dZv/qq9Yc0xyQrR6wYDwPT6NTpmuxLpZw5y8/3EvIEff4q9LQ46ExnheBmlZiv+bgz
         E/9h308g3Quoa2oa77nxIwtfzpK23WW2T91QDvwpb1iL7AlvGPqoDFOoPWyYfOQpmhm3
         j4hqQr77NULTgSbsJyBYVv6ESc4gw0Yc/KX5X1JHQsAw19xkIXwwE8nVnkgWdqL5hC6P
         bAr1wD7NMfpXNLmxdGTTxX17lhZ6OlZmYUeJsd8j+cgnAIEkkZ71quxY7lPsvdNcfF02
         ZX9uJA++KYcf0FSUubQy9j67HOb2zla4OQWI+MIwPfqP2i8qOh8PnhARxsWr1hsn3snp
         y0Tg==
X-Gm-Message-State: AOAM532cmWDWGElx8Cm632/9VdYM4BHsOTR9nlHSBeVq/r5+hltteSnL
        NAWgtriUOLQnTmnirYAh/VPXBjRPfkkh1P2uRoRfHg==
X-Google-Smtp-Source: ABdhPJyk3XAOXnBaPtc4RJnRX6rjDA/CR2prnluNjPITmd68l6UCpJPgLR9HK/W4peLzN5dCG6a96aLB1MGR4HFWBGw=
X-Received: by 2002:aca:d15:: with SMTP id 21mr3930082oin.41.1592592015216;
 Fri, 19 Jun 2020 11:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6> <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com> <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
In-Reply-To: <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Fri, 19 Jun 2020 11:40:04 -0700
Message-ID: <CAJbgVnXodOZg_UAe0s5qu_t8rKu9KU=zt4qhfDpnNi0NBvbLKg@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Keith Busch <kbusch@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

That makes sense. We are generally paying a high price for
implementing in-order interfaces over out-of-order communication
channels (e.g. TCP buffers) and append() seems to be a much more
lightweight solution.

On Fri, Jun 19, 2020 at 11:25 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 19/06/2020 20.17, Heiner Litz wrote:
> >> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> >>> Hi Matias,
> >>> no, I am rather saying that the Linux kernel has a deficit or at leas=
t
> >>> is not a good fit for ZNS because it cannot enforce in-order delivery=
.
> >> FYI, the nvme protocol can't even enforce in-order delivery, so callin=
g
> >> out linux for this is a moot point.
> > How does it work in SPDK then? I had understood that SPDK supported
> > QD>1 for ZNS devices.
> It doesn't. Out of order delivery is not guaranteed in NVMe.
> > I am not saying that Linux is the only problem. The fact remains that
> > out of order delivery is not a good fit for an interface that requires
> > sequential writes.
>
> That why zone append was introduced in ZNS. It removes this constraint,
> and makes it such that any process (or host) can write to a specific
> zone. It's neat! That is why the command was introduced.
>
> It is not only Linux specific - it applies to everyone that wants to use
> it. It is solving a fundamental distributed system problem, as it
> removes the need for fine-grained coordinating between process or host.
> It allows the SSD to coordinate data placement, which historically has
> been done by the host. It is awesome!
>
> >
> >>> The requirement of sequential writes basically imposes this
> >>> requirement. Append essentially a Linux specific fix on the ZNS level
> >>> and that enforcing ordering would be a cleaner way to enable QD>1.
>
>
