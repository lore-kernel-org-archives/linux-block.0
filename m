Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC959C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDE208B8
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592515189;
	bh=euvryYw2Su0+ZqEYxrZpDt2JMdrm52zn+shG4NDenjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bxj7tkaPMJ2kHG8j5csqYMJmHSTVCDRQdphpchkpZArgRJs9uiZCCO1A0VDzj9p3p
	 3W/t7V0eEdZbkSmhKg5Y+9lSHGJujClYbPA4bfc+ZUxbwMQ2nOxwEuf8+3998VTL3g
	 297/2ud9cCTVOKEUFgFPbY/6IAUoslE9RLzu7JX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFRVTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgFRVTs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 17:19:48 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FC1206B7;
        Thu, 18 Jun 2020 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592515188;
        bh=euvryYw2Su0+ZqEYxrZpDt2JMdrm52zn+shG4NDenjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8v11+M3nOCnCsVka3QDOITEDFPLK3/EkPgZXAGsuyLbszTOL51zY9RJzfNv36B3d
         V8gSb7Gte5yyz4w2O3iSEPtlHFiUlcYohQdeByeYJtREZ3Q6MoLncUZXMAeIG2nYAu
         wmdVY8ZaI5eE1Ow/hcTG771yZ5XwFohtBFYfg0uo=
Date:   Thu, 18 Jun 2020 15:19:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
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
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200618211945.GA2347@C02WT3WMHTD6>
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 01:47:20PM -0700, Heiner Litz wrote:
> the striping explanation makes sense. In this case will rephase to: It
> is sufficient to support large enough un-splittable writes to achieve
> full per-zone bandwidth with a single writer/single QD.

This is subject to the capabilities of the device and software's memory
constraints. The maximum DMA size for a single request an nvme device can
handle often range anywhere from 64k to 4MB. The pci nvme driver maxes out at
4MB anyway because that's the most we can guarantee forward progress right now,
otherwise the scatter lists become to big to ensure we'll be able to allocate
one to dispatch a write command.

We do report the size and the alignment constraints so that it won't get split,
but we still have to work with applications that don't abide by those
constraints.
 
> My main point is: There is no fundamental reason for splitting up
> requests intermittently just to re-assemble them in the same form
> later.
