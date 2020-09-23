Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDCC4727D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAD52220D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S46VDRbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWSI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWSI6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 14:08:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B566C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H9e307+src3+CqxQxRVqFOAFuCBWoUAf5W/mH1UEQ/k=; b=S46VDRbLoF9smEweTG2wzgrM3x
        9LCW7QWgh+gUlYgMfCQCiZv2m6SU57njr9xmNbpH9yhxAsC7t3JDGn7+ZnRc1mMQj//SK5SJTheay
        QxUMu6x/cTzz12YkuAKE4ZwY4xuSPUHaTFJoCKlctanVi1MV83BWHVFeW8A96qiUXG2VoMV56lccb
        qaVZkKBoBDoL2yP5DsW7mnuAemnxF/LsAPTWUhtTNpQ7dTBo/xzL22YzVBULLuZZyu2L7yxKQ5e9G
        2E5UREDkHrpZpsiFRiOLZ+JyW+758jhCChUPIVptZZ5kKYTKq5jO7rpStujdny8S+xHSQLgnGGIe4
        H37Y5wNw==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL9CI-0001ZL-HL; Wed, 23 Sep 2020 18:08:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ztong0001@gmail.com, linux-block@vger.kernel.org
Subject: [PATCH] block: fix potential double free during probe failure
Date:   Wed, 23 Sep 2020 20:08:53 +0200
Message-Id: <20200923180853.505641-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_release drops the reference on the request_queue if disk->queue
is set.  But many drivers set the pointer early, which means they
have to clear it before calling put_disk during a probe failure,
which is often forgotten.  Even worse for drivers that refcount their
per-disk structure like nvme the path for a real teardown vs probe
failure can be shared.  Fix all this by setting a gendisk flag only
when add_disk has acquired a request_queue reference, and only drop
the reference when the flag was set.  Also make sure add_disk always
grabs a reference, even if the queue is marked dying, as we expect
the reference.

This patch fixes a potential use after free during nvme probe failure.
The fact that nvme can call add_disk on a dying queue is another bug
in the nvme code that we'll fix separatel.

Reported-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 6 ++++--
 include/linux/genhd.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9d060e79eb31d8..ef2784c69d59ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -832,7 +832,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	WARN_ON_ONCE(blk_queue_dying(disk->queue));
+	__blk_get_queue(disk->queue);
+	disk->flags |= GENHD_FL_QUEUE_REF;
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1564,7 +1566,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1c97cf84f011a7..822a619924e3b5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -133,6 +133,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.28.0

