Return-Path: <SRS0=Vt9R=CB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38EDC433E3
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44E520768
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 09:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBHmhgX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHWJLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Aug 2020 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgHWJK7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Aug 2020 05:10:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2FC061574;
        Sun, 23 Aug 2020 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YPbj+jYW6lSNd//SqFpfbe0WS/0uxusHOvL8V2ZlRJE=; b=PBHmhgX3NKK5fsFULhyEkxdAjV
        lcuLxZeeBDtHkLtVSr+FauH/Uhg6/Cib7sLCpnO32g6qDNrlzXmVZmfVtfpk+9H/ZIBjWDMBmpPLZ
        aY4KfRVmILHn9aLbdzWIv773n8eTQtoMuFG1abn4VejyUN0fjHqCPi7WYIvBXxMqpui7rMsj4JnLJ
        mVKZi0VsGgtKf0i9Mz+bJoj+LA5U4Ye4Ya0rRFA0iGsSKX+JHs0uflLrCN0kLhtBFessERgmXbpWs
        FcYN815nGaIhqgZ1VEeGKGy0QdlTgZwmMWU/mrknMU/raoGtBKjOR8ojSgw6S2OWYbcek3QqYOxC2
        SunijzaA==;
Received: from 171.168.43.195.cust.ip.kpnqwest.it ([195.43.168.171] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9m1a-0003LF-G4; Sun, 23 Aug 2020 09:10:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/3] nvme: don't call revalidate_disk from nvme_set_queue_dying
Date:   Sun, 23 Aug 2020 11:10:43 +0200
Message-Id: <20200823091043.2600261-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823091043.2600261-1-hch@lst.de>
References: <20200823091043.2600261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nvme_set_queue_dying we really just want to ensure the disk and bdev
sizes are set to zero.  Going through revalidate_disk leads to a somewhat
arcance and complex callchain relying on special behavior in a few
places.  Instead just lift the set_capacity directly to
nvme_set_queue_dying, and rename and move the nvme_mpath_update_disk_size
helper so that we can use it in nvme_set_queue_dying to propagate the
size to the bdev without detours.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++++++++----------
 drivers/nvme/host/nvme.h | 13 -------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4f0..12dea15527f61a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,21 +94,34 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static void nvme_update_bdev_size(struct gendisk *disk)
+{
+	struct block_device *bdev = bdget_disk(disk, 0);
+
+	if (bdev) {
+		bd_set_nr_sectors(bdev, get_capacity(disk));
+		bdput(bdev);
+	}
+}
+
+/*
+ * Prepare a queue for teardown.
+ *
+ * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
+ * the capacity to 0 after that to avoid blocking dispatchers that may be
+ * holding bd_butex.  This will end buffered writers dirtying pages that can't
+ * be synced.
+ */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
-	/*
-	 * Revalidating a dead namespace sets capacity to 0. This will end
-	 * buffered writers dirtying pages that can't be synced.
-	 */
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
+
 	blk_set_queue_dying(ns->queue);
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
-	/*
-	 * Revalidate after unblocking dispatchers that may be holding bd_butex
-	 */
-	revalidate_disk(ns->disk);
+
+	set_capacity(ns->disk, 0);
+	nvme_update_bdev_size(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
@@ -2083,7 +2096,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
-		nvme_mpath_update_disk_size(ns->head->disk);
+		nvme_update_bdev_size(ns->head->disk);
 	}
 #endif
 	return 0;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5cad5a08f411..4cadaea9034ae4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -659,16 +659,6 @@ static inline void nvme_trace_bio_complete(struct request *req,
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
-static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
-{
-	struct block_device *bdev = bdget_disk(disk, 0);
-
-	if (bdev) {
-		bd_set_nr_sectors(bdev, get_capacity(disk));
-		bdput(bdev);
-	}
-}
-
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
@@ -744,9 +734,6 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 {
 }
-static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
-{
-}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.28.0

