Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34974C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFE6206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfDXQtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfDXQtB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 374B1AF67;
        Wed, 24 Apr 2019 16:49:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Guoju Fang <fangguoju@gmail.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 01/18] bcache: fix crashes stopping bcache device before read miss done
Date:   Thu, 25 Apr 2019 00:48:26 +0800
Message-Id: <20190424164843.29535-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoju Fang <fangguoju@gmail.com>

The bio from upper layer is considered completed when bio_complete()
returns. In most scenarios bio_complete() is called in search_free(),
but when read miss happens, the bio_compete() is called when backing
device reading completed, while the struct search is still in use until
cache inserting finished.

If someone stops the bcache device just then, the device may be closed
and released, but after cache inserting finished the struct search will
access a freed struct cached_dev.

This patch add the reference of bcache device before bio_complete() when
read miss happens, and put it after the search is not used.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/request.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index f101bfe8657a..f11123079fe0 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -706,14 +706,14 @@ static void search_free(struct closure *cl)
 {
 	struct search *s = container_of(cl, struct search, cl);
 
-	atomic_dec(&s->d->c->search_inflight);
+	atomic_dec(&s->iop.c->search_inflight);
 
 	if (s->iop.bio)
 		bio_put(s->iop.bio);
 
 	bio_complete(s);
 	closure_debug_destroy(cl);
-	mempool_free(s, &s->d->c->search);
+	mempool_free(s, &s->iop.c->search);
 }
 
 static inline struct search *search_alloc(struct bio *bio,
@@ -756,13 +756,13 @@ static void cached_dev_bio_complete(struct closure *cl)
 	struct search *s = container_of(cl, struct search, cl);
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 
-	search_free(cl);
 	cached_dev_put(dc);
+	search_free(cl);
 }
 
 /* Process reads */
 
-static void cached_dev_cache_miss_done(struct closure *cl)
+static void cached_dev_read_error_done(struct closure *cl)
 {
 	struct search *s = container_of(cl, struct search, cl);
 
@@ -800,7 +800,22 @@ static void cached_dev_read_error(struct closure *cl)
 		closure_bio_submit(s->iop.c, bio, cl);
 	}
 
-	continue_at(cl, cached_dev_cache_miss_done, NULL);
+	continue_at(cl, cached_dev_read_error_done, NULL);
+}
+
+static void cached_dev_cache_miss_done(struct closure *cl)
+{
+	struct search *s = container_of(cl, struct search, cl);
+	struct bcache_device *d = s->d;
+
+	if (s->iop.replace_collision)
+		bch_mark_cache_miss_collision(s->iop.c, s->d);
+
+	if (s->iop.bio)
+		bio_free_pages(s->iop.bio);
+
+	cached_dev_bio_complete(cl);
+	closure_put(&d->cl);
 }
 
 static void cached_dev_read_done(struct closure *cl)
@@ -833,6 +848,7 @@ static void cached_dev_read_done(struct closure *cl)
 	if (verify(dc) && s->recoverable && !s->read_dirty_data)
 		bch_data_verify(dc, s->orig_bio);
 
+	closure_get(&dc->disk.cl);
 	bio_complete(s);
 
 	if (s->iop.bio &&
-- 
2.16.4

