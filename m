Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291CFC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B961103
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0G2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0G2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:28:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1CC061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wBwc3BUmXI8vS7nsHzvDmg1l6ZTgMjHTsIaJNTmQH8s=; b=sShZuBru8udc4DDB33gbprMjXE
        k18kT6bwJOGUfb8ek8e5uoROyAQ7Gv+p9yDKicsv6kwbbC934wqJ8lYBjmZaYEwqMOP9yXDBejT6t
        0tkCdhz0ZPx9hgxyDBThtR9xGs6Jbt21FKJ5GWC12oqDwS5EzYEYPdCOnLlyhDJk0yqqODwj2ph/X
        vZJzNdIFZG2fi8GuZqKg3z+dvoLb64awLSvc+wNJaxOyDFV6zW0nEqouSgI2/tQxtHhpIeCzKNzmc
        bLujYVE4tsJj5f7uG7ZFuwcbXsugf5slK/nUc97QVxbaaH3dfbA2LSAisAghlucpz8S2viJ2meFOs
        KSdtDXLQ==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GYD-00EkKE-MV; Tue, 27 Jul 2021 06:27:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: reduce stack usage in diskstats_show
Date:   Tue, 27 Jul 2021 08:25:13 +0200
Message-Id: <20210727062518.122108-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>

I have compiled the kernel with a cross compiler "hppa-linux-gnu-" v9.3.0
on x86-64 host machine. I got the following warning:

block/genhd.c: In function ‘diskstats_show’:
block/genhd.c:1227:1: warning: the frame size of 1688 bytes is larger
than 1280 bytes [-Wframe-larger-than=]
 1227  |  }

By Reduced the stack footprint by using the %pg printk specifier instead
of disk_name to remove the need for the on-stack buffer.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..80ad85822419 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1117,7 +1117,6 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 {
 	struct gendisk *gp = v;
 	struct block_device *hd;
-	char buf[BDEVNAME_SIZE];
 	unsigned int inflight;
 	struct disk_stats stat;
 	unsigned long idx;
@@ -1140,15 +1139,14 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		else
 			inflight = part_in_flight(hd);
 
-		seq_printf(seqf, "%4d %7d %s "
+		seq_printf(seqf, "%4d %7d %pg "
 			   "%lu %lu %lu %u "
 			   "%lu %lu %lu %u "
 			   "%u %u %u "
 			   "%lu %lu %lu %u "
 			   "%lu %u"
 			   "\n",
-			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev),
-			   disk_name(gp, hd->bd_partno, buf),
+			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), hd,
 			   stat.ios[STAT_READ],
 			   stat.merges[STAT_READ],
 			   stat.sectors[STAT_READ],
-- 
2.30.2

