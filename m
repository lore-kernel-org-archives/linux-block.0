Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62702C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiCNQZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiCNQZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 12:25:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9AA1BB
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=tQgIUowUVcJV9+ARp5fYSJ+KQStcHeklBFbgy0SSRww=; b=a923MdGDxT0E7LDACdXQWKwUDu
        toCNWPUvTAmkBfiTminG54F7H+ssGK8oZkA265KHpX6GB0rAdLKblDaJgSKvPratSA6cqp6xUpvFV
        gmNEoY2n5CCpY+AJtCgjbMUXiHfAmqZ2rXp9xesGMtmR/gflE+/FbHCzkv2PUp5c14ZGHtlW+G8s3
        w3RjGnxGBuEyrwBFf7p0uEmSlQeHxlbZ4CcmblQy5vTFsdzankjnPfWUQBeEoUap0nN2aVtLxawdC
        RYJfy2kgnoYUwpDi+PWeYSGn3xcc1fF98wvTE5mRrH9IAE9skLRMNc/uT/ThdqEHaY0zjtCxYYxj4
        4YPG+eJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTnU6-00602U-H8; Mon, 14 Mar 2022 16:23:50 +0000
Date:   Mon, 14 Mar 2022 09:23:50 -0700
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
Message-ID: <Yi9sFmQ3pN6+drKE@bombadil.infradead.org>
References: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 14, 2022 at 02:16:36PM +0000, Matias Bjørling wrote:
> I want to turn the argument around to see it from the kernel
> developer's point of view. They have communicated the PO2 requirement
> clearly,

Such requirement is based on history and effort put in place to assume
a PO2 requirement for zone storage, and clearly it is not. And clearly
even vendors who have embraced PO2 don't know for sure they'll always
be able to stick to PO2...

> there's good precedence working with PO2 zone sizes, and at
> last, holes can't be avoided and are part of the overall design of
> zoned storage devices. So why should the kernel developer's take on
> the long-term maintenance burden of NPO2 zone sizes?

I think the better question to address here is:

Do we *not* want to support NPO2 zone sizes in Linux out of principal?

If we *are* open to support NPO2 zone sizes, what path should we take to
incur the least pain and fragmentation?

Emulation was a path being considered, and I think at this point the
answer to eveluating that path is: this is cumbersome, probably not.

The next question then is: are we open to evaluate what it looks like
to slowly shave off the PO2 requirement in different layers, with an
goal to avoid further fragmentation? There is effort on evaluating that
path and it doesn't seem to be that bad.

So I'd advise to evaluate that, there is nothing to loose other than
awareness of what that path might look like.

Uness of course we already have a clear path forward for NPO2 we can
all agree on.

  Luis
