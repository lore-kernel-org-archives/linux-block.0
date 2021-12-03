Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D4C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 06:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378707AbhLCHAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:00:54 -0500
Received: from verein.lst.de ([213.95.11.211]:41727 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345605AbhLCHAy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 02:00:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2F6868AFE; Fri,  3 Dec 2021 07:57:26 +0100 (CET)
Date:   Fri, 3 Dec 2021 07:57:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC -nxt] mtd_blkdevs: Set GENHD_FL_NO_PART
Message-ID: <20211203065726.GA3072@lst.de>
References: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think we need the patch below to restore the old behavior where a
partitions scan happens only for those sub-drivers that do report a
partition shift.

MTD maintainers: is this intentional that raw mtdblock does not support
partitions, but the various "FTL" modules do?

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 113f86df76038..57a22d2ebaeca 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -345,6 +345,8 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	gd->first_minor = (new->devnum) << tr->part_bits;
 	gd->minors = 1 << tr->part_bits;
 	gd->fops = &mtd_block_ops;
+	if (!tr->part_bits)
+		gd->flags |= GENHD_FL_NO_PART;
 
 	if (tr->part_bits)
 		if (new->devnum < 26)
