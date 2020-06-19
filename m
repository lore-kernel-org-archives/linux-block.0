Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68BC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F256121527
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="ChZ+VoMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbgFSSIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgFSSIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:08:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205CC06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:08:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so9235250oid.4
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D3DT/dvyeplutPzx9MyRCxvTfOCv1fH0L/e2zdrU1Ts=;
        b=ChZ+VoMRW2BGAarmRuTatpQt+A2gEkWMBVqgXJQbdxvS/j/qrK6g25/SiVVsKmXji/
         +bMSnPiyyTYYOQ0ggSaV7+oDGigp9Ml1dXNICrLE9+rx+oh4USC6aACXJ/Sv7u2eCFFh
         kZclDbM2oLieqMEwbtoW7QLCkhhN40mapJV4kGCuWSZhfjXBCAwUaZXh3ubbmooiB+yQ
         GVCuUfEd7ZhVrf3WQd5s+QlsNsLZhMf5kHugGn/67c9r7Xza2Wk9L3FEiEwy/our4Pqe
         9cl83b50tBF/HBiba/3ldJLV/8qqrq4EZWio+jjwLwaePR3d9UEi21HZDd2DzsbDsPDF
         teog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D3DT/dvyeplutPzx9MyRCxvTfOCv1fH0L/e2zdrU1Ts=;
        b=UpumzrLUxm2uS0CQ8FPDf1kuXvEk4wl8mkCabHsqN40A2/3UjcBhstR6RHy94Nk2sA
         kkm75jHAxiFmdYW1UcRIiVZEl2RPar8kZ8iAf7lcIPPWIx11VNw5p6LJpbf8opnDQLw9
         6U/l1toYBQHigQRysqPcQ12VewuRV+X1SOdwuMuXtpiA5b5e7JOy/gO2VLEnEaI7Brk7
         EzhmYYS4tkgqk/OwCaB5y/1AXon1PX/77OGpD+1DnG5BVvKVqSB0+OJhsKMCkLEbbhah
         u/13wOyaNF2xDA9NPF5114A1+fB6BQ0YUG4FRqQssP1VFSfN4TQ6cXLL7TKZigqnPiIV
         Du8Q==
X-Gm-Message-State: AOAM531hEwDI/2qFRA9vtXrLCH+nkQyeMqI/askhv74803hFjE2Wi/Lg
        28RL7YY9hwmktAgG6rsc5jJa1Z+b6jKx3mGdDPOlsw==
X-Google-Smtp-Source: ABdhPJyw4j4Q+v1uB8Pg2InuO2lrwXJPlBJJQTkw1GKIuJ75wkL37Vt92Kh2YqsyukJqYxXP2jT4LnMzUhmplwQ2634=
X-Received: by 2002:aca:d15:: with SMTP id 21mr3826252oin.41.1592590117336;
 Fri, 19 Jun 2020 11:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local> <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local> <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6> <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Fri, 19 Jun 2020 11:08:26 -0700
Message-ID: <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Matias Bjorling <Matias.Bjorling@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Matias,
no, I am rather saying that the Linux kernel has a deficit or at least
is not a good fit for ZNS because it cannot enforce in-order delivery.
The requirement of sequential writes basically imposes this
requirement. Append essentially a Linux specific fix on the ZNS level
and that enforcing ordering would be a cleaner way to enable QD>1.

On Fri, Jun 19, 2020 at 3:29 AM Matias Bjorling <Matias.Bjorling@wdc.com> w=
rote:
>
> > -----Original Message-----
> > From: Heiner Litz <hlitz@ucsc.edu>
> > Sent: Friday, 19 June 2020 00.05
> > To: Keith Busch <kbusch@kernel.org>
> > Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Javier Gonz=C3=A1lez
> > <javier@javigon.com>; Matias Bj=C3=B8rling <mb@lightnvm.io>; Matias Bjo=
rling
> > <Matias.Bjorling@wdc.com>; Christoph Hellwig <hch@lst.de>; Keith Busch
> > <Keith.Busch@wdc.com>; linux-nvme@lists.infradead.org; linux-
> > block@vger.kernel.org; Sagi Grimberg <sagi@grimberg.me>; Jens Axboe
> > <axboe@kernel.dk>; Hans Holmberg <Hans.Holmberg@wdc.com>; Dmitry
> > Fomichev <Dmitry.Fomichev@wdc.com>; Ajay Joshi <Ajay.Joshi@wdc.com>;
> > Aravind Ramesh <Aravind.Ramesh@wdc.com>; Niklas Cassel
> > <Niklas.Cassel@wdc.com>; Judy Brock <judy.brock@samsung.com>
> > Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
> >
> > Matias, Keith,
> > thanks, this all sounds good and it makes total sense to hide striping =
from the
> > user.
> >
> > In the end, the real problem really seems to be that ZNS effectively re=
quires in-
> > order IO delivery which the kernel cannot guarantee. I think fixing thi=
s problem
> > in the ZNS specification instead of in the communication substrate (ker=
nel) is
> > problematic, especially as out-of-order delivery absolutely has no bene=
fit in the
> > case of ZNS.
> > But I guess this has been discussed before..
>
> I'm a bit dense, by the above, is your conclusion that ZNS has a deficit/=
feature, which OCSSD didn't already have? They both had the same requiremen=
t that a chunk/zone must be written sequentially. It's the name of the game=
 when deploying NAND-based media, I am not sure how ZNS should be able to h=
elp with this. The goal of ZNS is to align with the media (and OCSSD), whic=
h makes writes required to be sequential, and one thereby gets a bunch of b=
enefits.
>
> If there was an understanding that ZNS would allow one to write randomly,=
 I must probably disappoint. For random writes, typical implementations eit=
her use a write-back scheme, that stores data in random write media first, =
and then later write it out sequentially, or write a host-side FTL (with it=
s usual overheads).
