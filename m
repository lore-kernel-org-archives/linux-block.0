Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5CDC4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 20:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbiCXUhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353433AbiCXUhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 16:37:05 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC85A8EDE
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:32 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id s11so4949792qtc.3
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yd52i0i0a5XNUmDGQ87h84LHgrvu7ZnpYDPKqDqFs1o=;
        b=0DCFYxKERySlNgZly77x++YC8Jr96+PvXeX6mo3Lhk0/k23MnJGKWhkZUb4zFUv0OZ
         rQ35h33tzcSNen9eHReCuLh7ZBs7R3f5BSWucBHqB17VyiqXJU+CZB3+IntDZKfSgCN6
         oxGy5ha9wgkP3fQsLw72ZWNbQPa//bShBM3ChbiicOcaXU/wou5BsvDILjHhgRTRR+Cb
         kQhDGtYbdil6VbUgwg136Eb+S9m9PAi7c/jQU8suCxelLb5WcYbsJPjzf9oWURjLEg1r
         OwNZNmAnVB3zaHQ2Gx4++TdRqQGiQBcqPVRCGd9mIs/bEJ2XGgtCfEry4Epq6JkJyX+g
         5uXg==
X-Gm-Message-State: AOAM531tLD0huMs1n78p5fF5uGqMfpzi23GJsU9lv5E3e8sC5Y0C1jd5
        mc4DKly4JqIK+Kk6V9QO8377uXq1NInN
X-Google-Smtp-Source: ABdhPJxZ6t3UdQbj3qpY2z9A3nIrwL17ZMx/IWJPv3yGVUOB5gE/GLjHEMCnf/vE7K3JiRWmi0un2w==
X-Received: by 2002:ac8:7e8d:0:b0:2e0:6314:d5f3 with SMTP id w13-20020ac87e8d000000b002e06314d5f3mr6313001qtj.352.1648154131721;
        Thu, 24 Mar 2022 13:35:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id k1-20020ac85fc1000000b002e1c6420790sm3492494qta.40.2022.03.24.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:35:31 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v3 3/3] dm: conditionally enable BIOSET_PERCPU_CACHE for dm_io bioset
Date:   Thu, 24 Mar 2022 16:35:26 -0400
Message-Id: <20220324203526.62306-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220324203526.62306-1-snitzer@kernel.org>
References: <20220324203526.62306-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bioset's per-cpu alloc cache may have broader utility in the future
but for now constrain it to being tightly coupled to QUEUE_FLAG_POLL.

Also change dm_io_complete() to use bio_clear_polled() so that it
properly clears all associated bio state on requeue.

This commit improves DM's hipri bio polling (REQ_POLLED) perf by
7 - 20% depending on the system.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c | 11 ++++++++---
 drivers/md/dm.c       |  8 ++++----
 drivers/md/dm.h       |  4 ++--
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index c0be4f60b427..7ebc70e3eb2f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1002,6 +1002,8 @@ bool dm_table_request_based(struct dm_table *t)
 	return __table_type_request_based(dm_table_get_type(t));
 }
 
+static int dm_table_supports_poll(struct dm_table *t);
+
 static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *md)
 {
 	enum dm_queue_mode type = dm_table_get_type(t);
@@ -1009,21 +1011,24 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 	unsigned min_pool_size = 0;
 	struct dm_target *ti;
 	unsigned i;
+	bool poll_supported = false;
 
 	if (unlikely(type == DM_TYPE_NONE)) {
 		DMWARN("no table type is set, can't allocate mempools");
 		return -EINVAL;
 	}
 
-	if (__table_type_bio_based(type))
+	if (__table_type_bio_based(type)) {
 		for (i = 0; i < t->num_targets; i++) {
 			ti = t->targets + i;
 			per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
 			min_pool_size = max(min_pool_size, ti->num_flush_bios);
 		}
+		poll_supported = !!dm_table_supports_poll(t);
+	}
 
-	t->mempools = dm_alloc_md_mempools(md, type, t->integrity_supported,
-					   per_io_data_size, min_pool_size);
+	t->mempools = dm_alloc_md_mempools(md, type, per_io_data_size, min_pool_size,
+					   t->integrity_supported, poll_supported);
 	if (!t->mempools)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b762a48d3fdf..b3e32116c31f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -898,7 +898,7 @@ static void dm_io_complete(struct dm_io *io)
 		 * may only reflect a subset of the pre-split original,
 		 * so clear REQ_POLLED in case of requeue
 		 */
-		bio->bi_opf &= ~REQ_POLLED;
+		bio_clear_polled(bio);
 		return;
 	}
 
@@ -2915,8 +2915,8 @@ int dm_noflush_suspending(struct dm_target *ti)
 EXPORT_SYMBOL_GPL(dm_noflush_suspending);
 
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned integrity, unsigned per_io_data_size,
-					    unsigned min_pool_size)
+					    unsigned per_io_data_size, unsigned min_pool_size,
+					    bool integrity, bool poll)
 {
 	struct dm_md_mempools *pools = kzalloc_node(sizeof(*pools), GFP_KERNEL, md->numa_node_id);
 	unsigned int pool_size = 0;
@@ -2932,7 +2932,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_qu
 		pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
 		front_pad = roundup(per_io_data_size, __alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
 		io_front_pad = roundup(per_io_data_size,  __alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
-		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, 0);
+		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, poll ? BIOSET_PERCPU_CACHE : 0);
 		if (ret)
 			goto out;
 		if (integrity && bioset_integrity_create(&pools->io_bs, pool_size))
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 9013dc1a7b00..3f89664fea01 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -221,8 +221,8 @@ void dm_kcopyd_exit(void);
  * Mempool operations
  */
 struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_queue_mode type,
-					    unsigned integrity, unsigned per_bio_data_size,
-					    unsigned min_pool_size);
+					    unsigned per_io_data_size, unsigned min_pool_size,
+					    bool integrity, bool poll);
 void dm_free_md_mempools(struct dm_md_mempools *pools);
 
 /*
-- 
2.15.0

