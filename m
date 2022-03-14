Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 19:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbiCNTxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbiCNTxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 15:53:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04772403D5
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=+wsPOqK3FstI9n8pFDvW37SeuLy3op5m91iOleqnoB8=; b=g1sxDQyzAfNmAAQiPYm+lLs/WA
        6Uj0hiegYaTOUwt3dRxNF8JJ7ll66t8rUkaLbxZ7PFuNJdkX6vFIV+9WbbvtFY3QxJyXhFkCD7kWl
        KvqGG2pzGIGmIPUOsSXOZXJQ/uYunN80ZBMYzCn5C8ZvCFa55GFY6THDd4jG5nGlSY1PqzMeEGwKU
        n04AGtJFDJgzXJYriCa219sluBOCkVg2cZNwda1xl8JPPJkEiwyz6Yadkbif8wZZnFvPSWzkgZTP6
        zGbCOq9R+9hxtkUv6cCdwaoF/716k2vzKLRXSBONPdxXrFWH8ym2+SH20dxfgXdHpq/4XAPPDKQ9f
        LDQdPKzQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTqjB-006eed-0E; Mon, 14 Mar 2022 19:51:37 +0000
Date:   Mon, 14 Mar 2022 12:51:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <Yi+cyIHeaTzc/cpq@bombadil.infradead.org>
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <Yi9sFmQ3pN6+drKE@bombadil.infradead.org>
 <BYAPR04MB49681A28DEBF815225019BECF10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49681A28DEBF815225019BECF10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 07:30:25PM +0000, Matias Bjørling wrote:
> > -----Original Message-----
> > From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis
> > Chamberlain
> > Sent: Monday, 14 March 2022 17.24
> > To: Matias Bjørling <Matias.Bjorling@wdc.com>
> > Cc: Javier González <javier@javigon.com>; Damien Le Moal
> > <damien.lemoal@opensource.wdc.com>; Christoph Hellwig <hch@lst.de>;
> > Keith Busch <kbusch@kernel.org>; Pankaj Raghav <p.raghav@samsung.com>;
> > Adam Manzanares <a.manzanares@samsung.com>;
> > jiangbo.365@bytedance.com; kanchan Joshi <joshi.k@samsung.com>; Jens
> > Axboe <axboe@kernel.dk>; Sagi Grimberg <sagi@grimberg.me>; Pankaj
> > Raghav <pankydev8@gmail.com>; Kanchan Joshi <joshiiitr@gmail.com>; linux-
> > block@vger.kernel.org; linux-nvme@lists.infradead.org
> > Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
> > 
> > On Mon, Mar 14, 2022 at 02:16:36PM +0000, Matias Bjørling wrote:
> > > I want to turn the argument around to see it from the kernel
> > > developer's point of view. They have communicated the PO2 requirement
> > > clearly,
> > 
> > Such requirement is based on history and effort put in place to assume a PO2
> > requirement for zone storage, and clearly it is not. And clearly even vendors
> > who have embraced PO2 don't know for sure they'll always be able to stick to
> > PO2...
> 
> Sure - It'll be naïve to give a carte blanche promise.

Exactly. So taking a position to not support NPO2 I think seems counter
productive to the future of ZNS, the question whould be, *how* to best
do this in light of what we need to support / avoid performance
regressions / strive towards avoiding fragmentation.

> However, you're skipping the next two elements, which state that there
> are both good precedence working with PO2 zone sizes and that
> holes/unmapped LBAs can't be avoided.

I'm not, but I admit that it's a good point of having the possibility of
zones being taken offline also implicates holes. I also think it was a
good excercise to discuss and evaluate emulation given I don't think
this point you made would have been made clear otherwise. This is why
I treat ZNS as evolving effort, and I can't seriously take any position
stating all answers are known.

> Making an argument for why NPO2
> zone sizes may not bring what one is looking for. It's a lot of work
> for little practical change, if any. 

NAND does not incur a PO2 requirement, that should be enough to
implicate that PO2 zones *can* be expected. If no vendor wants
to take a position that they know for a fact they'll never adopt
PO2 zones should be enough to keep an open mind to consider *how*
to support them.

> > > there's good precedence working with PO2 zone sizes, and at last,
> > > holes can't be avoided and are part of the overall design of zoned
> > > storage devices. So why should the kernel developer's take on the
> > > long-term maintenance burden of NPO2 zone sizes?
> > 
> > I think the better question to address here is:
> > 
> > Do we *not* want to support NPO2 zone sizes in Linux out of principal?
> > 
> > If we *are* open to support NPO2 zone sizes, what path should we take to
> > incur the least pain and fragmentation?
> > 
> > Emulation was a path being considered, and I think at this point the answer to
> > eveluating that path is: this is cumbersome, probably not.
> > 
> > The next question then is: are we open to evaluate what it looks like to slowly
> > shave off the PO2 requirement in different layers, with an goal to avoid further
> > fragmentation? There is effort on evaluating that path and it doesn't seem to
> > be that bad.
> > 
> > So I'd advise to evaluate that, there is nothing to loose other than awareness of
> > what that path might look like.
> > 
> > Uness of course we already have a clear path forward for NPO2 we can all
> > agree on.
> 
> It looks like there isn't currently one that can be agreed upon.

I'm not quite sure that is the case. To reach consensus one has
to take a position of accepting the right answer may not be known
and we evaluate all prospects. It is not clear to me that we've done
that yet and it is why I think a venue such as LSFMM may be good to
review these things.

> If evaluating different approaches, it would be helpful to the
> reviewers if interfaces and all of its kernel users are converted in a
> single patchset. This would also help to avoid users getting hit by
> what is supported, and what isn't supported by a particular device
> implementation and allow better to review the full set of changes
> required to add the support.

Sorry I didn't understand the suggestion here, can you clarify what it
is you are suggesting?

Thanks!

  Luis
