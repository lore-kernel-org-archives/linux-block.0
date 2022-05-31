Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB942C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiEaPGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiEaPGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 11:06:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7AB04
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 08:06:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84B8968AFE; Tue, 31 May 2022 17:06:35 +0200 (CEST)
Date:   Tue, 31 May 2022 17:06:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/3] block: document debugfs_mutex
Message-ID: <20220531150635.GA23096@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move debugfs_mutex next to the dentries that it protects and document
what it is used for.

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c      | 1 -
 include/linux/blkdev.h | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 095a0d68c9b41..5ddcc7b77de0f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -481,7 +481,6 @@ struct request_queue {
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 	int			node;
-	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 #endif
@@ -527,6 +526,10 @@ struct request_queue {
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
+	/*
+	 * Serializes all debugfs metadata operations using the above dentries.
+	 */
+	struct mutex		debugfs_mutex;
 
 	bool			mq_sysfs_init_done;
 
-- 
2.30.2

