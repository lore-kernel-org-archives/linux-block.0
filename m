Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A40C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 07:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiCNHgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiCNHgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 03:36:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF840E48
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:35:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D43EF68AFE; Mon, 14 Mar 2022 08:35:37 +0100 (CET)
Date:   Mon, 14 Mar 2022 08:35:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220314073537.GA4204@lst.de>
References: <20220308165349.231320-1-p.raghav@samsung.com> <20220310094725.GA28499@lst.de> <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com> <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org> <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com> <Yiu5YzxU/PjxLiUL@bombadil.infradead.org> <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com> <YivMBj7+j/EZcMVV@bombadil.infradead.org> <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 12, 2022 at 04:58:08PM +0900, Damien Le Moal wrote:
> The reason for the power of 2 requirement is 2 fold:
> 1) At the time we added zone support for SMR, chunk_sectors had to be a
> power of 2 number of sectors.
> 2) SMR users did request power of 2 zone sizes and that all zones have
> the same size as that simplified software design. There was even a
> de-facto agreement that 256MB zone size is a good compromise between
> usability and overhead of zone reclaim/GC. But that particular number is
> for HDD due to their performance characteristics.

Also for NVMe we initially went down the road to try to support
non power of two sizes.  But there was another major early host that
really wanted the power of two zone sizes to support hardware based
hosts that can cheaply do shifts but not divisions.  The variable
zone capacity feature (something that Linux does not currently support)
is a feature requested by NVMe members on the host and device side
also can only be supported with the the zone size / zone capacity split.

> The other solution would be adding a dm-unhole target to remap sectors
> to remove the holes from the device address space. Such target would be
> easy to write, but in my opinion, this would still not change the fact
> that applications still have to deal with error recovery and active/open
> zone resources. So they still have to be zone aware and operate per zone.

I don't think we even need a new target for it.  I think you can do
this with a table using multiple dm-linear sections already if you
want.

> My answer to your last question ("Are we sure?") is thus: No. I am not
> sure this is a good idea. But as always, I would be happy to be proven
> wrong. So far, I have not seen any argument doing that.

Agreed. Supporting non-power of two sizes in the block layer is fairly
easy as shown by some of the patches seens in this series.  Supporting
them properly in the whole ecosystem is not trivial and will create a
long-term burden.  We could do that, but we'd rather have a really good
reason for it, and right now I don't see that.
