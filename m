Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B1EC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5E42086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfF1MCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:02:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1MCB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:02:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07889B62B;
        Fri, 28 Jun 2019 12:02:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 27/37] bcache: add code comments for journal_read_bucket()
Date:   Fri, 28 Jun 2019 19:59:50 +0800
Message-Id: <20190628120000.40753-28-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more code comments in journal_read_bucket(), this is an
effort to make the code to be more understandable.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 54f8886b6177..98ee467ec3f7 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -100,6 +100,20 @@ reread:		left = ca->sb.bucket_size - offset;
 
 			blocks = set_blocks(j, block_bytes(ca->set));
 
+			/*
+			 * Nodes in 'list' are in linear increasing order of
+			 * i->j.seq, the node on head has the smallest (oldest)
+			 * journal seq, the node on tail has the biggest
+			 * (latest) journal seq.
+			 */
+
+			/*
+			 * Check from the oldest jset for last_seq. If
+			 * i->j.seq < j->last_seq, it means the oldest jset
+			 * in list is expired and useless, remove it from
+			 * this list. Otherwise, j is a condidate jset for
+			 * further following checks.
+			 */
 			while (!list_empty(list)) {
 				i = list_first_entry(list,
 					struct journal_replay, list);
@@ -109,13 +123,22 @@ reread:		left = ca->sb.bucket_size - offset;
 				kfree(i);
 			}
 
+			/* iterate list in reverse order (from latest jset) */
 			list_for_each_entry_reverse(i, list, list) {
 				if (j->seq == i->j.seq)
 					goto next_set;
 
+				/*
+				 * if j->seq is less than any i->j.last_seq
+				 * in list, j is an expired and useless jset.
+				 */
 				if (j->seq < i->j.last_seq)
 					goto next_set;
 
+				/*
+				 * 'where' points to first jset in list which
+				 * is elder then j.
+				 */
 				if (j->seq > i->j.seq) {
 					where = &i->list;
 					goto add;
@@ -129,6 +152,7 @@ reread:		left = ca->sb.bucket_size - offset;
 			if (!i)
 				return -ENOMEM;
 			memcpy(&i->j, j, bytes);
+			/* Add to the location after 'where' points to */
 			list_add(&i->list, where);
 			ret = 1;
 
-- 
2.16.4

