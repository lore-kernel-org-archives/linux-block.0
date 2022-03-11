Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735AC4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiCKWrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiCKWqs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F9812AEA
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h3izCrrB93CBYwtoMxE0Bi7jHqe4dGvNIGbN9crwFws=; b=CZvXMT9hH+Xs1E4x/snbSq8WWb
        a/B0gJIjgmFq2iZnK4ysmFZZ6lYdiazSsIMJya78DJ9jSryyWtqbYlm79Yuyb3m4NEDeUmvFeZngk
        +GBRPyRqPMyYz/cGGaOcNbBniYOUy60NW1a4+uaNpP9x2ZreWshKfZE0tf6z7hg4lOw1n9pdmy06m
        dAGxewIq4N8yc0BJT/KN85I0EWBbL8GUmY6+OWZxe6p/aGr7WMUlz0XJGvwXJS1bhMK+cDAtaY6V6
        1zfuZ5JQ0YCK/94LII7wt0zULT7dBSlzcDUFDPiW01l+vXrOurEvC8gaYqj0bxePJFjHpEFse0uHs
        jdzRBprw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSmR9-000HGX-64; Fri, 11 Mar 2022 21:04:35 +0000
Date:   Fri, 11 Mar 2022 13:04:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
> > NAND has no PO2 requirement. The emulation effort was only done to help
> > add support for !PO2 devices because there is no alternative. If we
> > however are ready instead to go down the avenue of removing those
> > restrictions well let's go there then instead. If that's not even
> > something we are willing to consider I'd really like folks who stand
> > behind the PO2 requirement to stick their necks out and clearly say that
> > their hw/fw teams are happy to deal with this requirement forever on ZNS.
> 
> Regardless of the merits of the current OS requirement, it's a trivial
> matter for firmware to round up their reported zone size to the next
> power of 2. This does not create a significant burden on their part, as
> far as I know.

Sure sure.. fw can do crap like that too...

> And po2 does not even seem to be the real problem here. The holes seem
> to be what's causing a concern, which you have even without po2 zones.

Exactly.

> I'm starting to like the previous idea of creating an unholey
> device-mapper for such users...

Won't that restrict nvme with chunk size crap. For instance later if we
want much larger block sizes.

  Luis
