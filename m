Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7FFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 07:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhLMH0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 02:26:49 -0500
Received: from verein.lst.de ([213.95.11.211]:46405 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhLMH0t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 02:26:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 911BB68AA6; Mon, 13 Dec 2021 08:26:45 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:26:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
Message-ID: <20211213072645.GA20552@lst.de>
References: <20211206070409.2836165-1-hch@lst.de> <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 10, 2021 at 11:52:26AM -0700, Jens Axboe wrote:
> > Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Not sure why I didn't spot this until now, but:
> 
> drivers/mtd/mtd_blkdevs.c: In function ‘add_mtd_blktrans_dev’:
> drivers/mtd/mtd_blkdevs.c:362:30: error: ‘GENHD_FL_NO_PART’ undeclared (first use in this function); did you mean ‘GENHD_FL_NO_PART_SCAN’?
>   362 |                 gd->flags |= GENHD_FL_NO_PART;
>       |                              ^~~~~~~~~~~~~~~~
>       |                              GENHD_FL_NO_PART_SCAN
> drivers/mtd/mtd_blkdevs.c:362:30: note: each undeclared identifier is reported only once for each function it appears in
> 
> Hmm?
> 
> I'm going to revert this one for now, not sure how it could've been
> tested in this form.

It was tested in a tree that also contains the commit identified by the
Fixed tag, which is in the for-next tree but not the block-5.16 one.
