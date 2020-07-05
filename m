Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D6AC433DF
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2157520737
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGEP4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:38192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgGEP4e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Jul 2020 11:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEC4BAC37;
        Sun,  5 Jul 2020 15:56:32 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH 10/16] bcache: handle c->uuids properly for bucket size > 8MB
Date:   Sun,  5 Jul 2020 23:55:55 +0800
Message-Id: <20200705155601.5404-11-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705155601.5404-1-colyli@suse.de>
References: <20200705155601.5404-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bcache allocates a whole bucket to store c->uuids on cache device, and
allocates continuous pages to store it in-memory. When the bucket size
exceeds maximum allocable continuous pages, bch_cache_set_alloc() will
fail and cache device registration will fail.

This patch allocates c->uuids by alloc_meta_bucket_pages(), and uses
ilog2(meta_bucket_pages(c)) to indicate order of c->uuids pages when
free it. When writing c->uuids to cache device, its size is decided
by meta_bucket_pages(c) * PAGE_SECTORS. Now c->uuids is properly handled
for bucket size > 8MB.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index ec60145277c4..898b28bb8f17 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -466,6 +466,7 @@ static int __uuid_write(struct cache_set *c)
 	BKEY_PADDED(key) k;
 	struct closure cl;
 	struct cache *ca;
+	unsigned int size;
 
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
@@ -473,7 +474,8 @@ static int __uuid_write(struct cache_set *c)
 	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
 		return 1;
 
-	SET_KEY_SIZE(&k.key, c->sb.bucket_size);
+	size =  meta_bucket_pages(&c->sb) * PAGE_SECTORS;
+	SET_KEY_SIZE(&k.key, size);
 	uuid_io(c, REQ_OP_WRITE, 0, &k.key, &cl);
 	closure_sync(&cl);
 
@@ -1656,7 +1658,7 @@ static void cache_set_free(struct closure *cl)
 		}
 
 	bch_bset_sort_state_free(&c->sort);
-	free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
+	free_pages((unsigned long) c->uuids, ilog2(meta_bucket_pages(&c->sb)));
 
 	if (c->moving_gc_wq)
 		destroy_workqueue(c->moving_gc_wq);
@@ -1855,7 +1857,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	c->sb.last_mount	= sb->last_mount;
 	c->bucket_bits		= ilog2(sb->bucket_size);
 	c->block_bits		= ilog2(sb->block_size);
-	c->nr_uuids		= bucket_bytes(c) / sizeof(struct uuid_entry);
+	c->nr_uuids		= meta_bucket_bytes(&c->sb) / sizeof(struct uuid_entry);
 	c->devices_max_used	= 0;
 	atomic_set(&c->attached_dev_nr, 0);
 	c->btree_pages		= bucket_pages(c);
@@ -1906,7 +1908,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
 		goto err;
 
-	c->uuids = alloc_bucket_pages(GFP_KERNEL, c);
+	c->uuids = alloc_meta_bucket_pages(GFP_KERNEL, &c->sb);
 	if (!c->uuids)
 		goto err;
 
-- 
2.26.2

