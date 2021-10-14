Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C709C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C49F610CC
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJNNEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJNNEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 09:04:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A4C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1NthEYJkbSP/qeUs2KAfucMdRZbFJTlri42psOaVEGk=; b=vnvuxZrIhrmoMh1EZMVTw66ESv
        w1s5cuX/S97Rkx6K0WDP6hMxBDipMMkVy74PGLXd9GLRe9MN4CMQYmlybD+n67MkGtFrR9bZnJXxw
        jMBKG/ddZbY+jGZV51ENu3B5glAiHYWH/qT8UdhBLqBxpK0eXDAyYtJLq+IzFgLR0lY1lZG0B+yn6
        kqc4sw6uHzqSxbP8NRZDlleJHWeDK4itYeWxi25imOoPqnb1ujuVsrgBJoZ7pV+W5aeGee3APAZwK
        ZLbBk8DXFvE9PEfMkC6lY17NkkjisLL3Vo/qTY3bdA8Lsot6fOf2/xbzoC4MOgYdlhsYRSqYUcpqb
        AoRLKSvg==;
Received: from [2001:4bb8:199:73c5:b1be:a02d:b459:cc1a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb0NW-0039HQ-Cs; Thu, 14 Oct 2021 13:02:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: warn when putting the final reference on a registered disk
Date:   Thu, 14 Oct 2021 15:02:31 +0200
Message-Id: <20211014130231.1468538-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Warn when the last reference on a live disk is put without calling
del_gendisk first.  There are some BDI related bug reports that look
like a case of this, so make sure we have the proper instrumentation
to catch it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index 5e8aa0ab66c2a..dd7e949f876ed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1057,6 +1057,7 @@ static void disk_release(struct device *dev)
 	struct gendisk *disk = dev_to_disk(dev);
 
 	might_sleep();
+	WARN_ON_ONCE(disk_live(disk));
 
 	disk_release_events(disk);
 	kfree(disk->random);
-- 
2.30.2

