Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A1C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 06:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGRG3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 02:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRG3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 02:29:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A132FE
        for <linux-block@vger.kernel.org>; Sun, 17 Jul 2022 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NxytYu9RL3B84gpoej13M9pXSFpOfq2+Z2HWvYdbMgY=; b=06gVrBOwijLm9U4zg75uwHkEKV
        0n+P6UpPecI8nYrHKTOss/gnsi+IzG9XrYtOvsIw45rNk63IagAGDAQ2nHvrHSvqBmJC7r1VoWeIG
        CgDStOKwnnUrsdwRRnxJ8FadRK+xlbWfcwGhpFNdmAHIqNrhJO2VVIppnG82XjthUvoZS6NZEjq0o
        s+LOj3hB2nb0+NvY81nZ6fMLW14YsmyqYSS5yV+rTQNVkI3BtIY0np8jAjzTb3H4kgTcf15Bzqg6O
        PghrIzdkw1JeUnjE4uMOsuuPL6UZNZ2IowTELl4pdgwa6qWh/0z2GbSCydWnjE/a6w/2si5xqga6T
        +lf0ZS4A==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKG2-00BD5H-SX; Mon, 18 Jul 2022 06:29:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release for never added disks
Date:   Mon, 18 Jul 2022 08:29:27 +0200
Message-Id: <20220718062928.335399-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To undo the all initialization from blk_mq_init_allocated_queue in case
of a probe failure where add_disk is never called we have to call
blk_mq_exit_queue from put_disk.

We should be doing this in general, but can't do it for the normal
teardown case (yet) as the tagset can be gone by the time the disk is
released once it was added.  I hope to sort this out properly eventual
but for now this isolated hack will do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 44dfcf67ed96a..ad8a3678d4480 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1138,6 +1138,18 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	/*
+	 * To undo the all initialization from blk_mq_init_allocated_queue in
+	 * case of a probe failure where add_disk is never called we have to
+	 * call blk_mq_exit_queue here. We can't do this for the more common
+	 * teardown case (yet) as the tagset can be gone by the time the disk
+	 * is released once it was added.
+	 */
+	if (queue_is_mq(disk->queue) &&
+	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
+	    !test_bit(GD_ADDED, &disk->state))
+		blk_mq_exit_queue(disk->queue);
+
 	blkcg_exit_queue(disk->queue);
 
 	disk_release_events(disk);
-- 
2.30.2

