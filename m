Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35AFC2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112620873
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgBMOMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:12:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgBMOMd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 09:12:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 54ECCAE34;
        Thu, 13 Feb 2020 14:12:32 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 3/3] bcache: remove macro nr_to_fifo_front()
Date:   Thu, 13 Feb 2020 22:12:07 +0800
Message-Id: <20200213141207.77219-4-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213141207.77219-1-colyli@suse.de>
References: <20200213141207.77219-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Macro nr_to_fifo_front() is only used once in btree_flush_write(),
it is unncessary indeed. This patch removes this macro and does
calculation directly in place.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 6730820780b0..0e3ff9745ac7 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -417,8 +417,6 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 
 /* Journalling */
 
-#define nr_to_fifo_front(p, front_p, mask)	(((p) - (front_p)) & (mask))
-
 static void btree_flush_write(struct cache_set *c)
 {
 	struct btree *b, *t, *btree_nodes[BTREE_FLUSH_NR];
@@ -510,9 +508,8 @@ static void btree_flush_write(struct cache_set *c)
 		 *   journal entry can be reclaimed). These selected nodes
 		 *   will be ignored and skipped in the folowing for-loop.
 		 */
-		if (nr_to_fifo_front(btree_current_write(b)->journal,
-				     fifo_front_p,
-				     mask) != 0) {
+		if (((btree_current_write(b)->journal - fifo_front_p) &
+		     mask) != 0) {
 			mutex_unlock(&b->write_lock);
 			continue;
 		}
-- 
2.16.4

