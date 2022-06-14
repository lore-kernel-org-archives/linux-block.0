Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B40C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353011AbiFNHsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354846AbiFNHst (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827F3EBAC
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bf/1TtBlN1Sg1Rd9prNezMyvptZTS3qFHBE4Wn3okkM=; b=NJqB3llOUPXgNirXOcOnGgGMOH
        pmCVNhyi2U+XmL1uv9Zjn8oWK/3+k++2F0et/JGqmengWOvdbFNILN7NSWYhdbWgt7HTTNveGzkGf
        GTC73SXLEYemK4ZZPzfyDqxyshJZty6LkzCe6JJfcjOTIbqaQvO/2M9OTb9RV5qjqnWoFa86i1XfF
        ZX+eVzcnWrwCxhx0o8TUIFl3SmYZ4q6kpWfXkso7joR7zkSG0GPPAkIIjAsK0iziLAUsxZO4g8GAz
        yKwfleFT9goiiGTUSM+htCtuiWpqhYQ4tFJAxAxNe/4CSV9KgXY9GbR0+WTe7ZlNjqmSQJJspnl2y
        8JpKbwhQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11I1-0082ls-TD; Tue, 14 Jun 2022 07:48:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: freeze the queue earlier in del_gendisk
Date:   Tue, 14 Jun 2022 09:48:27 +0200
Message-Id: <20220614074827.458955-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614074827.458955-1-hch@lst.de>
References: <20220614074827.458955-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Freeze the queue earlier in del_gendisk so that the state does not
change while we remove debugfs and sysfs files.

Ming mentioned that being able to observer request in debugfs might
be useful while the queue is being frozen in del_gendisk, which is
made possible by this change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e0675772178b0..278227ba1d531 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -623,6 +623,7 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
+	blk_mq_freeze_queue_wait(q);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -646,8 +647,6 @@ void del_gendisk(struct gendisk *disk)
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
-	blk_mq_freeze_queue_wait(q);
-
 	blk_throtl_cancel_bios(disk->queue);
 
 	blk_sync_queue(q);
-- 
2.30.2

