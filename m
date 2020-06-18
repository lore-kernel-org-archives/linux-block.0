Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C1CC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D3620734
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="TWsaugqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgFRWFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbgFRWFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 18:05:40 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B86C06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 15:05:39 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v26so1504768oof.7
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukeJ1uDwqwEFaLI3EARWl0bw73efHeUYm2hJguJBEBo=;
        b=TWsaugqPxzvYuOI9ohFUzP1FTDrrg8y4AA/KmWfWmbczPncUMlMhThod3UZpj28ywk
         roaj/d/J45UjumfnOvFcM0Eo360LueE8Y4lftPmaDi0yK3Vc2EkliMkI7Wks15ZHZ96M
         Lq2uyX4V4UvfgEeZmSNRzyZedyj6WaphzMLs5b9wv0uOVWyy0SCfR2JnIgQkK6dtkg9p
         rO9jmbaqtq64Q4s1rxIr0t+03wrVVKgdxEv38hOq0NKuolFwNfmRde6yUSrB/WBYHsrR
         YWQTHJZxzhtvOagUiMX7GHoRaEjYWswuVodmZoffC8pZoTBUhdm1hF4YYIZhq62edZ9i
         Ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukeJ1uDwqwEFaLI3EARWl0bw73efHeUYm2hJguJBEBo=;
        b=t0A/XNOZpBNBgliGICwE4WiEQUCnHRCqp5XOGk1N6WIEY/DBzALsUTNk9NnBeGo0zJ
         UPcS6kuaN4huRNKlGRxDDhwkl5I6T2yI3gbcmDrT6HUpTgmkt6sofXZgN1KZpNjedU6h
         LEDSINVtHoNhddPoAo2OAkNJ5u1p1nUUzFr6gO0j+JIdCOQR7Nwyv4T9MkrIJdqNOMnP
         XsI34dr1FS2KpgV+3JATMs9R5/dp4qxjx/PVsQtAdtUIT/vEvrKW9S0540qgEe8b8ZUM
         JWeZWjVWcrLMb9NvCg9ygGptt/0qWfIjYR3g3KSSq9/ftDxujernN4ef+ykwWzZE63zv
         IsXw==
X-Gm-Message-State: AOAM533/M6dqZxKheWwsZfYG6OECK58Dkcmp8WKc+xlOsFtYWMSuyjoY
        SbKiJmgqhEjZoldgb3dm5tFv2msG/Ud8is5Pib4vGA==
X-Google-Smtp-Source: ABdhPJzgFvQAYhWUzETFTkrodlO0t+L2/qMyxslngVbk0NI8jAwHLqUx5rCztsTSMazNASVi9EBmZJo6GnZHM8bVwNI=
X-Received: by 2002:a4a:bc8c:: with SMTP id m12mr911865oop.44.1592517938482;
 Thu, 18 Jun 2020 15:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local> <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local> <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com> <20200618211945.GA2347@C02WT3WMHTD6>
In-Reply-To: <20200618211945.GA2347@C02WT3WMHTD6>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Thu, 18 Jun 2020 15:05:27 -0700
Message-ID: <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Keith Busch <kbusch@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
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

Matias, Keith,
thanks, this all sounds good and it makes total sense to hide striping
from the user.

In the end, the real problem really seems to be that ZNS effectively
requires in-order IO delivery which the kernel cannot guarantee. I
think fixing this problem in the ZNS specification instead of in the
communication substrate (kernel) is problematic, especially as
out-of-order delivery absolutely has no benefit in the case of ZNS.
But I guess this has been discussed before..

On Thu, Jun 18, 2020 at 2:19 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jun 18, 2020 at 01:47:20PM -0700, Heiner Litz wrote:
> > the striping explanation makes sense. In this case will rephase to: It
> > is sufficient to support large enough un-splittable writes to achieve
> > full per-zone bandwidth with a single writer/single QD.
>
> This is subject to the capabilities of the device and software's memory
> constraints. The maximum DMA size for a single request an nvme device can
> handle often range anywhere from 64k to 4MB. The pci nvme driver maxes out at
> 4MB anyway because that's the most we can guarantee forward progress right now,
> otherwise the scatter lists become to big to ensure we'll be able to allocate
> one to dispatch a write command.
>
> We do report the size and the alignment constraints so that it won't get split,
> but we still have to work with applications that don't abide by those
> constraints.
>
> > My main point is: There is no fundamental reason for splitting up
> > requests intermittently just to re-assemble them in the same form
> > later.
