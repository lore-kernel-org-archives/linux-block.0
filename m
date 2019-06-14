Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10926C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2E821537
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfFNNOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:14:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbfFNNOR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57630AE1F;
        Fri, 14 Jun 2019 13:14:16 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 03/29] bcache: add code comments for journal_read_bucket()
Date:   Fri, 14 Jun 2019 21:13:32 +0800
Message-Id: <20190614131358.2771-4-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
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
index f18c1e7b012c..50c9a1e405e6 100644
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

