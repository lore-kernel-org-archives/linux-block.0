Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D259CC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DF22186A
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 04:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="hm5PPa7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgFREYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgFREYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 00:24:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C13AC06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 21:24:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c194so3899223oig.5
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOsrVVpLSM50tEJi2S8kutSfV6ieFvtbO8gT5T6dr88=;
        b=hm5PPa7t61uEa4ETyg7rmAQTRPGK9AdbEETgiEil+YMBlym65FfHyT2Gwzv2cUwpWf
         9oPcKTOew1zP9ZLah/CCYWWHxzYJnvzJVP1mtZmorqhFhsCuc1Pa8prBGAzV1Bn9cSj6
         zc2XF7IwvN31Ao4wwOZDNTCM4c7l9qS2YkmuYIhh2DkkgshL43beCK3AQtjBEMgYh2Ur
         WCoBVqBm/dIuCwDoBbpwEB4TJ0UAJogQCSZ0GuF0QJoqjfq1YtbIDtAfnkK5PzEqUSuk
         nDZM6rAIAf+SPM8XLFH/8O1gIoB9XHhxShlwyemp5Ncr0RsUY1n1HUKvkqqnDrtnuWQF
         f2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOsrVVpLSM50tEJi2S8kutSfV6ieFvtbO8gT5T6dr88=;
        b=apdCDTwi0rmqMU74HySNLY4spUoQpdC5VYZqwPDJ8AB6mx0ugnxCSYsFJ8+M8EtJLj
         xQynWp3ei0linC6PN9gXrn3ahrG4Ax68gItV8Jc/QLgsq4r7ZGjq2sOOBC92oGoAz4wb
         sw6cOnU2vNSg8dD73NNueBcHfAlqd0v0pHjAlcq8iU5dHg+HmL1BOxa/Wbf33Mkc2ZHq
         XAyCaoz289Fldu3QC2AyEFKFHJIVM9tW8jfIyn5Bl7mSwRiTmp5symF7fT7JzKiZcEm8
         d5WSaFB+Vr+cSvP7EK3dG5MOLUlT3BfHXF76t5DtmPXL8vVPZDbqHJ/LobpVAThiTIXE
         Cvfg==
X-Gm-Message-State: AOAM530CEYO7cDdSh7S5F6Va2wCShpQ3Pk+7EAi3dX3JupxRAyEwtX2T
        DMrSSfyACmQ4uX6hPAND2dXIc9OOvSsDv5oemDyPXwD4
X-Google-Smtp-Source: ABdhPJyAROsCPZIxK2iGphL388L2akjXMocUivha9hTp78r5rL5IsXCma76dskLFmk8HFP/iOJIbQd+pbJ62FWZcuCc=
X-Received: by 2002:aca:d15:: with SMTP id 21mr1467624oin.41.1592454254725;
 Wed, 17 Jun 2020 21:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de> <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io> <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local> <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local> <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Wed, 17 Jun 2020 21:24:03 -0700
Message-ID: <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Keith Busch <kbusch@kernel.org>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What is the purpose of making zones larger than the erase block size
of flash? And why are large writes fundamentally unreasonable?

I don't see why it should be a fundamental problem for e.g. RocksDB to
issue single zone-sized writes (whatever the zone size is because
RocksDB needs to cope with it). The write buffer exists as a level in
DRAM anyways and increasing write latency will not matter either.

On Wed, Jun 17, 2020 at 6:55 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Jun 17, 2020 at 04:44:23PM -0700, Heiner Litz wrote:
> > Mandating zone-sized writes would address all problems with ease and
> > reduce request rate and overheads in the kernel.
>
> Yikes, no. Typical zone sizes are much to large for that to be
> reasonable.
