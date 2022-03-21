Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D2EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 16:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbiCUQpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiCUQpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 12:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE513D05
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 09:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8BB461358
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 16:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC2C340E8;
        Mon, 21 Mar 2022 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647881066;
        bh=heIQRclqnJOihkE3LB+L8qLurZ7/aTuI5/WEz1hUMVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0bO/OVcuUCBDRrQKsdCdbGzszR/JAhZlf359KKxswE6GX06QN+DfWodNC7AyWBCu
         NVVnC80RTUR7DKVugIS0dt1wPn/dPely1nLs6SwiM7WJ99HyD+x192J27Dfm6IcmZo
         YJwgVPTUT64GTitczpPQFNlXCCK5DAOnAiBnTboiRHPLhKhQ26Ot3XSiooctsSs5Ta
         678ZdMecLsmdG1G+F1S3tiRz+sxBAf2E7JxnPsbys64HV5tBg6614qjGspYU3b+lPI
         Hmp93qTAGJk304SdhXLbMzllwyhhalL6Bee5lsuYXLCC+MruKEJ+6jBSgoO7dX6VhE
         zF2J65SPzczUw==
Date:   Mon, 21 Mar 2022 10:44:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjirZ88zbuDX5hT7@C02CK6Q3MD6M>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <a707d1c9-3af8-d573-6d71-e4b8168a7ced@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a707d1c9-3af8-d573-6d71-e4b8168a7ced@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:36AM -0600, Jonathan Derrick wrote:
> 
> 
> On 3/11/2022 1:51 PM, Keith Busch wrote:
> > On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
> > > NAND has no PO2 requirement. The emulation effort was only done to help
> > > add support for !PO2 devices because there is no alternative. If we
> > > however are ready instead to go down the avenue of removing those
> > > restrictions well let's go there then instead. If that's not even
> > > something we are willing to consider I'd really like folks who stand
> > > behind the PO2 requirement to stick their necks out and clearly say that
> > > their hw/fw teams are happy to deal with this requirement forever on ZNS.
> > 
> > Regardless of the merits of the current OS requirement, it's a trivial
> > matter for firmware to round up their reported zone size to the next
> > power of 2. This does not create a significant burden on their part, as
> > far as I know.
> 
> Sure wonder why !PO2 keeps coming up if it's so trivial to fix in firmware as you claim.

The triviality to adjust alignment in firmware has nothing to do with
some users' desire to not see gaps in LBA space.

> I actually find the hubris of the Linux community wrt the whole PO2 requirement
> pretty exhausting.
>
> Consider that some SSD manufacturers are having to rely on a NAND shortage and
> existing ASIC architecture limitations that may define the sizes of their erase blocks
> and write units. A !PO2 implementation in the Linux kernel would enable consumers
> to be able to choose more options in the marketplace for their Linux ZNS application.

All zone block devices through the linux kernel use a common abstraction
interface. Users expect you can swap out one zone device for another and all
their previously used features will continue to work. That does not necessarily
hold with relaxing the long existing zone alignment. Fragmenting uses harms
adoption, so this discussion seems appropriate.
