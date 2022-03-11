Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E2C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348936AbiCKUUx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCKUUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 15:20:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB691AAFDB
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MpI45wlvGUQQIIXcSerz+MOcA7TLJXYLedSG9trvAkU=; b=HFTzTsclVZNK3jW3t8ryUWQEPi
        7oG+q6EqxWwG/w1TLFNJiJ83d2HL2/qEtXtCjX1ihGzr5jGDFoLnntb8UxA4sL8N4Md9H7ug2rGde
        vJgJaWa48q1rrzs1rkgvCT9m+uWm8JhBwK99t6XqrZ7ROj3tr+U6B4I7vEgycqOTlKX55VznnrKKj
        YyBkOyj3qdpR+Vf2C0gNAQhTb1dxvP+2if7AyOlH0pPuou1CWaeZFqDvZLRYHDCAD2CGEdjPVpXpC
        sPfWz972bd2TJTiIRItpbNyPOle/HG5BL4mj2c95/7PVtN5aTVzXZRGr836l14GY7jhcJfXrfXWTd
        mSlf1d2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSlje-000AIC-MI; Fri, 11 Mar 2022 20:19:38 +0000
Date:   Fri, 11 Mar 2022 12:19:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310144449.GA1695@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 03:44:49PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 01:57:58PM +0100, Pankaj Raghav wrote:
> > Yes, these drives are intended for Linux users that would use the zoned
> > block device. Append is supported but holes in the LBA space (due to
> > diff in zone cap and zone size) is still a problem for these users.
> 
> I'd really like to hear from the users.  Because really, either they
> should use a proper file system abstraction (including zonefs if that is
> all they need),

That requires access to at least the block device and without PO2
emulation that is not possible. Using zonefs is not possible today
for !PO2 devices.

> or raw nvme passthrough which will alredy work for this
> case. 

This effort is not upstream yet, however, once and if this does land
upstream it does mean something other than zonefs must be used since
!PO2 devices are not supported by zonefs. So although the goal with the
zonefs was to provide a unified interface for raw access for
applications, the PO2 requirement will essentially create
fragmenetation.

> But adding a whole bunch of crap because people want to use the
> block device special file for something it is not designed for just
> does not make any sense.

Using Linux requires PO2. And so on behalf of Damien's request the
logical thing to do was to upkeep that requirement and to avoid any
performance regressions. That "crap" was done to slowly pave the way
forward to then later remove the PO2 requirement.

I think we'll all acknowledge that doing emulation just means adding more
software for something that is not a NAND requirement, but a requirement
imposed by the inheritance of zoned software designed for SMR HDDs. I
think we may also all acknowledge now that keeping this emulation code
*forever* seems like complete insanity.

Since the PO2 requirement imposed on Linux today seems to be now
sending us down a dubious effort we'd need to support, let me
then try to get folks who have been saying that we must keep this
requirement to answer the following question:

Are you 100% sure your ZNS hardware team and firmware team will always
be happy you have caked in a PO2 requirement for ZNS drives on Linux
and are you ready to deal with those consequences on Linux forever? Really?

NAND has no PO2 requirement. The emulation effort was only done to help
add support for !PO2 devices because there is no alternative. If we
however are ready instead to go down the avenue of removing those
restrictions well let's go there then instead. If that's not even
something we are willing to consider I'd really like folks who stand
behind the PO2 requirement to stick their necks out and clearly say that
their hw/fw teams are happy to deal with this requirement forever on ZNS.

From what I am seeing this is a legacy requirement which we should be
able to remove. Keeping the requirement will only do harm to ZNS
adoption on Linux and it will also create *more* fragmentation.

  Luis
