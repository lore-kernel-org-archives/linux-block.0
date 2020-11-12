Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187AC56202
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACBB22227
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dg3u/9dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgKLQuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLQuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 11:50:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6F1C0613D1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=c5oCRBlxtgRGXrI/d/I4LS7stPgEE9Ug5dvIoVe5k9w=; b=dg3u/9dR+X/rqQyAA3MpvSDmky
        2bjAMdLRoeXx9bU9/wzUbcQFf7c9HXKai4cMAjkxnYWNtrZ+Kaqsn/n7gaQciYnMrXOyWKL89z2Z8
        9+StHLJeus5Kj3mi6yWBW788odi7uhALHxGtHwoNgqYlsY4qDtwO9jqP49UD/C4Gox4AZvRt1WMhV
        j0bSYVOSnFS4VxQ/mwWAY1cxy5jE6J3sCFifpIkrB1+odFTTtQDiq1LI3VXlykL5WiRGbXcPe5Wlr
        Mz1fHYEVq4ExVqUtp2l6ZuBuqAmU62BstXbhUyJqDtfuDu29xfXJBonHgj4taK4vjhgjZSOXVYXhd
        x2Xnyyeg==;
Received: from [2001:4bb8:180:6600:5c73:9bb4:23ff:391c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdFnU-0006yo-V6; Thu, 12 Nov 2020 16:50:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Petr Vorel <pvorel@suse.cz>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a return value to set_capacity_revalidate_and_notify
Date:   Thu, 12 Nov 2020 17:50:04 +0100
Message-Id: <20201112165005.4022502-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112165005.4022502-1-hch@lst.de>
References: <20201112165005.4022502-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return if the function ended up sending an uevent or not.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 5 ++++-
 include/linux/genhd.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec283..9387f050c248a7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -49,7 +49,7 @@ static void disk_release_events(struct gendisk *disk);
  * Set disk capacity and notify if the size is not currently
  * zero and will not be set to zero
  */
-void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 					bool update_bdev)
 {
 	sector_t capacity = get_capacity(disk);
@@ -62,7 +62,10 @@ void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 		char *envp[] = { "RESIZE=1", NULL };
 
 		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+		return true;
 	}
+
+	return false;
 }
 
 EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 38f23d75701379..03da3f603d309c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,7 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 		bool update_bdev);
 
 /* drivers/char/random.c */
-- 
2.28.0

