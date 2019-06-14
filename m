Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B7C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47220850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfFNNPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728017AbfFNNPM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EBF2AE07;
        Fri, 14 Jun 2019 13:15:11 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 18/29] bcache: check CACHE_SET_IO_DISABLE in allocator code
Date:   Fri, 14 Jun 2019 21:13:47 +0800
Message-Id: <20190614131358.2771-19-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If CACHE_SET_IO_DISABLE of a cache set flag is set by too many I/O
errors, currently allocator routines can still continue allocate
space which may introduce inconsistent metadata state.

This patch checkes CACHE_SET_IO_DISABLE bit in following allocator
routines,
- bch_bucket_alloc()
- __bch_bucket_alloc_set()
Once CACHE_SET_IO_DISABLE is set on cache set, the allocator routines
may reject allocation request earlier to avoid potential inconsistent
metadata.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index f8986effcb50..6f776823b9ba 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -393,6 +393,11 @@ long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait)
 	struct bucket *b;
 	long r;
 
+
+	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
+	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &ca->set->flags)))
+		return -1;
+
 	/* fastpath */
 	if (fifo_pop(&ca->free[RESERVE_NONE], r) ||
 	    fifo_pop(&ca->free[reserve], r))
@@ -484,6 +489,10 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 {
 	int i;
 
+	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
+	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
+		return -1;
+
 	lockdep_assert_held(&c->bucket_lock);
 	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
-- 
2.16.4

