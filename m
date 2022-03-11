Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D159C4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiCKWrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiCKWqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2262DBB97
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CORCsW85L9pqGOpLrx1bc5XyZ9E33aiq8UjLnt/1kLQ=; b=orR5OjqbqZrl2kWZGXtRboOnMa
        LLKCJWoZhE+QDTz6JGFegfiO+UTEjZlH85NcAKvwmjnlXEPxNuI1r45NCn68/woIppszt0Z/jk8Ke
        1pjgQ9L8IdrUVa3sD20Tfbk7yW9DFiipNEZyU1l+bShyZiYzQgq2WIDOLyOOBj98xkncg1qVAiKtA
        rM4ROrdoee4zYAlJ1N1ii5UOgFLCgtXqSTsYyvJ/W659H+0r3j9jJcfmA1yCkXy2udhKa9y9yHybS
        RYQ57cYi5g3lXHe+JjWtK/Zdxl98LE/oPAdkihahqft8k0+YNL6fqoWw55bmBioGuGeDJ5JPkakUL
        ST5pvmnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSng6-000O0E-FW; Fri, 11 Mar 2022 22:24:06 +0000
Date:   Fri, 11 Mar 2022 14:24:06 -0800
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
Message-ID: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 01:31:02PM -0800, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 01:04:35PM -0800, Luis Chamberlain wrote:
> > On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> > 
> > > I'm starting to like the previous idea of creating an unholey
> > > device-mapper for such users...
> > 
> > Won't that restrict nvme with chunk size crap. For instance later if we
> > want much larger block sizes.
> 
> I'm not sure I understand. The chunk_size has nothing to do with the
> block size. And while nvme is a user of this in some circumstances, it
> can't be used concurrently with ZNS because the block layer appropriates
> the field for the zone size.

Many device mapper targets split I/O into chunks, see max_io_len(),
wouldn't this create an overhead?

Using a device mapper target also creates a divergence in strategy
for ZNS. Some will use the block device, others the dm target. The
goal should be to create a unified path.

And all this, just because SMR. Is that worth it? Are we sure?

  Luis
