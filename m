Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A70AC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A8461103
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhG0Gag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhG0Gag (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:30:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B6C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nDP4xRRzFiKbBiQ6tFnm8G1SA/DaVhM02ciHDiUFtQg=; b=IUSoHgWRgdO7A2XGmedeuQ3N7O
        Ub4Bkmd/AVIdcp+pZHrMYafSCp50Ubu5deMunQ0VPXJVjpuUEeqW4MICsFqKfObWMuk34aVYHMliM
        4tIowaxzArdIn+K+shrPmSTgWaVbzdUtFERl2YM77AcA/R3xF6x9xGAC0itmnYpFHWiasKzooPM5i
        BYdwHymhwH86Xtopm6liI7/2qRBc1H93cFQ1ZwNVP9F3rJA3wqkyIrNQWVrN+IachJlUn6ytWhiUT
        frlDHBgJ5jC8A1di2QB5MkTFR/ujjz8cHnnu2sQuqvKg/Aaw0X0lzsvd+w2SP8v7tD6kxZF38bUmP
        WZqLt0Cw==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Ga6-00EkUP-LE; Tue, 27 Jul 2021 06:29:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: use the %pg format specifier in show_partition
Date:   Tue, 27 Jul 2021 08:25:15 +0200
Message-Id: <20210727062518.122108-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify printing the partition name by using the %pg format specifier
that is equivalent to a bdevname call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e07b1b028875..ffdbdefdea7b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -783,7 +783,6 @@ static int show_partition(struct seq_file *seqf, void *v)
 	struct gendisk *sgp = v;
 	struct block_device *part;
 	unsigned long idx;
-	char buf[BDEVNAME_SIZE];
 
 	/* Don't show non-partitionable removeable devices or empty devices */
 	if (!get_capacity(sgp) || (!disk_max_parts(sgp) &&
@@ -796,10 +795,9 @@ static int show_partition(struct seq_file *seqf, void *v)
 	xa_for_each(&sgp->part_tbl, idx, part) {
 		if (!bdev_nr_sectors(part))
 			continue;
-		seq_printf(seqf, "%4d  %7d %10llu %s\n",
+		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
 			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
-			   bdev_nr_sectors(part) >> 1,
-			   disk_name(sgp, part->bd_partno, buf));
+			   bdev_nr_sectors(part) >> 1, part);
 	}
 	rcu_read_unlock();
 	return 0;
-- 
2.30.2

