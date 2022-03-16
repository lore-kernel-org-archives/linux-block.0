Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 01:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbiCPB0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 21:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiCPB0A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 21:26:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAFF2B184
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p6PzlAy7ELGFoVZquJzLBtjVeqxfG6WWLoDc1bX1xqY=; b=ek4VnTZxlAeOpKle+/FgDMjJwP
        w/r0tU7H7X0iQlAEBacnsOxib+Q065Sio4E5FN0M8S5ydJIZLCIf5aVIgdFlZtWFeF02dkXVTHY4q
        4xpDuxSHn8ixdBXIIv0dx5paRL+Rregh9ZssgmF6GGE9inWs3lnZ3zeoRgAA3sBu1HgG4JcoUFQSM
        +GRsinZBpqcHzsPVT6b8Vvtm9PNXhliMQ9eDMhj/Vp7y6ypRBFUWaT+lMo48aGAL6V+eowqtfmZNs
        HfyGvdESGowAwysH3bFum08bQh0WOjPHHFAwd5na2i1q2IgpojVhXEFWrPB6ncfU0rDnD+iko4h29
        i5PI8i2A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUIOz-00B4lt-TZ; Wed, 16 Mar 2022 01:24:37 +0000
Date:   Tue, 15 Mar 2022 18:24:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 09:46:44AM +0900, Damien Le Moal wrote:
> On 3/16/22 09:23, Luis Chamberlain wrote:
> > What applications? ZNS does not incur a PO2 requirement. So I really
> > want to know what applications make this assumption and would break
> > because all of a sudden say NPO2 is supported.
> 
> Exactly. What applications ? For ZNS, I cannot say as devices have not
> been available for long. But neither can you.

I can tell you we there is an existing NPO2 ZNS customer which chimed on
the discussion and they described having to carry a delta to support
NPO2 ZNS. So if you cannot tell me of a ZNS application which is going to
break to add NPO2 support then your original point is not valid of
suggesting that there would be a break.

> > Why would that break those ZNS applications?
> 
> Please keep in mind that there are power of 2 zone sized ZNS devices out
> there.

No one is saying otherwise.

> Applications designed for these devices and optimized to do bit
> shift arithmetic using the power of 2 size property will break.

They must not be ZNS. So they can continue to chug on.

> What the
> plan for that case ? How will you address these users complaints ?

They are not ZNS so they don't have to worry about ZNS.

ZNS applications must be aware of that fact that NPO2 can exist.
ZNS applications must be aware of that fact that any vendor may one day
sell NPO2 devices.

> >> Allowing non power of 2 zone size may prevent applications running today
> >> to run properly on these non power of 2 zone size devices. *not* nice.
> > 
> > Applications which want to support ZNS have to take into consideration
> > that NPO2 is posisble and there existing users of that world today.
> 
> Which is really an ugly approach.

Ugly is relative and subjective. NAND does not force PO2.

> The kernel

<etc> And back you go to kernel talk. I thought you wanted to
focus on applications.

> Applications correctly designed for SMR can thus also run on ZNS too.

That seems to be an incorrect assumption given ZNS drives exist
with NPO2. So you can probably say that some SMR applications can work
with PO2 ZNS drives. That is a more correct statement.

> With this in mind, the spectrum of applications that would break on non
> power of 2 ZNS devices is suddenly much larger.

We already determined you cannot identify any ZNS specific application
which would break.

SMR != ZNS

If you really want to use SMR applications for ZNS that seems to be
a bit beyond the scope of this discussion, but it seems to me that those
SMR applications should simply learn that if a device is ZNS that NPO2 can
be expected.

As technologies evolve so do specifications.

> This has always been my concern from the start: allowing non power of 2
> zone size fragments userspace support and has the potential to
> complicate things for application developers.

It's a reality though. Devices exist, and so do users. And they're
carrying their own delta to support NPO2 ZNS today on Linux.

> > You cannot negate their existance.
> > 
> >> I have yet to see any convincing argument proving that this is not an issue.
> > 
> > You are just saying things can break but not clarifying exactly what.
> > And you have not taken a position to say WD will not ever support NPO2
> > on ZNS. And so, you can't negate the prospect of that implied path for
> > support as a possibility, even if it means work towards the ecosystem
> > today.
> 
> Please do not bring in corporate strategy aspects in this discussion.
> This is a technical discussion and I am not talking as a representative
> of my employer nor should we ever dicsuss business plans on a public
> mailing list. I am a kernel developer and maintainer. Keep it technical
> please.

This conversation is about the reality that ZNS NPO2 exist and how best to
support that. You seem to want to negate that reality and support on
Linux without even considering what the changes look like to to support
ZNS NPO2.

As a maintainer I think we need to *evaluate* supporting users as best
as possible. Not denying their existance. Even if it pains us.

  Luis
