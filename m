Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463BCC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146E12086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146E12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeLMOyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:51320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbeLMOyv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:54:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74C5CAD5C;
        Thu, 13 Dec 2018 14:54:49 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 01/12] bcache: add comment for cache_set->fill_iter
Date:   Thu, 13 Dec 2018 22:53:46 +0800
Message-Id: <20181213145357.38528-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

We have the following define for btree iterator:
	struct btree_iter {
		size_t size, used;
	#ifdef CONFIG_BCACHE_DEBUG
		struct btree_keys *b;
	#endif
		struct btree_iter_set {
			struct bkey *k, *end;
		} data[MAX_BSETS];
	};

We can see that the length of data[] field is static MAX_BSETS, which is
defined as 4 currently.

But a btree node on disk could have too many bsets for an iterator to fit
on the stack - maybe far more that MAX_BSETS. Have to dynamically allocate
space to host more btree_iter_sets.

bch_cache_set_alloc() will make sure the pool cache_set->fill_iter can
allocate an iterator equipped with enough room that can host
	(sb.bucket_size / sb.block_size)
btree_iter_sets, which is more than static MAX_BSETS.

bch_btree_node_read_done() will use that pool to allocate one iterator, to
host many bsets in one btree node.

Add more comment around cache_set->fill_iter to make code less confusing.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h | 6 +++++-
 drivers/md/bcache/btree.c  | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index b61b83bbcfff..96d2213f279e 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -658,7 +658,11 @@ struct cache_set {
 
 	/*
 	 * A btree node on disk could have too many bsets for an iterator to fit
-	 * on the stack - have to dynamically allocate them
+	 * on the stack - have to dynamically allocate them.
+	 * bch_cache_set_alloc() will make sure the pool can allocate iterators
+	 * equipped with enough room that can host
+	 *     (sb.bucket_size / sb.block_size)
+	 * btree_iter_sets, which is more than static MAX_BSETS.
 	 */
 	mempool_t		fill_iter;
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 3f4211b5cd33..23cb1dc7296b 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -207,6 +207,11 @@ void bch_btree_node_read_done(struct btree *b)
 	struct bset *i = btree_bset_first(b);
 	struct btree_iter *iter;
 
+	/*
+	 * c->fill_iter can allocate an iterator with more memory space
+	 * than static MAX_BSETS.
+	 * See the comment arount cache_set->fill_iter.
+	 */
 	iter = mempool_alloc(&b->c->fill_iter, GFP_NOIO);
 	iter->size = b->c->sb.bucket_size / b->c->sb.block_size;
 	iter->used = 0;
-- 
2.16.4

