Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF14C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 20:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C5D208C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="imu7nPHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFRUrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRUrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 16:47:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0BC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 13:47:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n70so5647825ota.5
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCIz8rBcyOtzZ+pf5psWEfkMjtB5nSw0yMDYUhyKIo0=;
        b=imu7nPHeSFosqaUvtjQ93+rkE27kTrG1AuDzq38OZkZ4KIyxaSfqG/t/uJ+yONPwNJ
         0YZANWwY6yB+ApmmJ/XAO2txNHFU4hvwOSvNod6dVqg2q4wHW4OkrwLuW70vhvdpa4U3
         FGUta/WPtOAZrFWTvZ173FwIkDD+gjSx8c7p6uP43ew/pr4SupzvVWySo05j1Z4lstN9
         jtrUtO7ODxP/cGBBHyVpQk2MQ8WWQ3LxbRojhcW6IBgyQjaJkAXF+snMxVaNBxIro7Pf
         LYz4W1Omn5Ek/u7+Fg119AVl66icNJHZo6W9AB8eA7kf1rHxalL2Er0XAOSTOG7Gv3HT
         gCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCIz8rBcyOtzZ+pf5psWEfkMjtB5nSw0yMDYUhyKIo0=;
        b=gtTd7b8IannbSFNqJV5diwWRrlnO2YJnCsVRfTpDGw0x2KC6cr4fVnzLIAe7J5xC4/
         TLDRFWZeZ8HxU6NqHi0ECsmcRADec/5hWSdfxq2zDObgKwiF9IYV590stXCcwCKXwlgD
         qW9NAlrBHnqNOk/8erWiSDHsFeQRQv+GPeLvOhM3zN22/E7fAkltgNxpUpph9gUaYwOt
         D/Zqsbnuxc4YVO9T+mnrWC5a5xra8mgH26aJ6W5KzbRHkTyRpoGfAAjE1XejAb1cwqnI
         f5D01Hc+UCwhV3rKewHpFYNTsNENgSmx5YrBTQiOtOloqm+cFVV3oixGpewBWduSOZwS
         LLjw==
X-Gm-Message-State: AOAM530SSBUjr5MfiPp7kP5n/qVOOq22YbNyxiNJm/osL+kYntK7fU7C
        8PWFJVq6rlQ+yQ92G4Z6tmfDqp7C/jW5ovzVo9i3IOWT
X-Google-Smtp-Source: ABdhPJwCqJrVFPy1agTJt+A/o0Kg0zzaPnM6Yo6UXuyX5iMcAoHLSYvjs0Z96RcY8ycSHGJ0V6Vzcdi+i6iDm58//3k=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr431341oto.331.1592513251287;
 Thu, 18 Jun 2020 13:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de> <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io> <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local> <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local> <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com> <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 18 Jun 2020 13:47:20 -0700
Message-ID: <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
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

Thanks Damien,
the striping explanation makes sense. In this case will rephase to: It
is sufficient to support large enough un-splittable writes to achieve
full per-zone bandwidth with a single writer/single QD.

My main point is: There is no fundamental reason for splitting up
requests intermittently just to re-assemble them in the same form
later.

On Wed, Jun 17, 2020 at 10:15 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/06/18 13:24, Heiner Litz wrote:
> > What is the purpose of making zones larger than the erase block size
> > of flash? And why are large writes fundamentally unreasonable?
>
> It is up to the drive vendor to decide how zones are mapped onto flash media.
> Different mapping give different properties for different use cases. Zones, in
> many cases, will be much larger than an erase block due to stripping across many
> dies for example. And erase block size also has a tendency to grow over time
> with new media generations.
> The block layer management of zoned block devices also applies to SMR HDDs,
> which can have any zone size they want. This is not all about flash.
>
> As for large writes, they may not be possible due to memory fragmentation and/or
> limited SGL size of the drive interface. E.g. AHCI max out at 168 segments, most
> HBAs are at best 256, etc.
>
> > I don't see why it should be a fundamental problem for e.g. RocksDB to
> > issue single zone-sized writes (whatever the zone size is because
> > RocksDB needs to cope with it). The write buffer exists as a level in
> > DRAM anyways and increasing write latency will not matter either.
>
> Rocksdb is an application, so of course it is free to issue a single write()
> call with a buffer size equal to the zone size. But due to the buffer mapping
> limitations stated above, there is a very high probability that this single
> zone-sized large write operation will end-up being split into multiple write
> commands in the kernel.
>
> >
> > On Wed, Jun 17, 2020 at 6:55 PM Keith Busch <kbusch@kernel.org> wrote:
> >>
> >> On Wed, Jun 17, 2020 at 04:44:23PM -0700, Heiner Litz wrote:
> >>> Mandating zone-sized writes would address all problems with ease and
> >>> reduce request rate and overheads in the kernel.
> >>
> >> Yikes, no. Typical zone sizes are much to large for that to be
> >> reasonable.
> >
>
>
> --
> Damien Le Moal
> Western Digital Research
