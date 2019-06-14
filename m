Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69252C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450ED20850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfFNNPP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbfFNNPP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:15:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DB9CAF8C;
        Fri, 14 Jun 2019 13:15:14 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 19/29] bcache: check CACHE_SET_IO_DISABLE bit in bch_journal()
Date:   Fri, 14 Jun 2019 21:13:48 +0800
Message-Id: <20190614131358.2771-20-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When too many I/O errors happen on cache set and CACHE_SET_IO_DISABLE
bit is set, bch_journal() may continue to work because the journaling
bkey might be still in write set yet. The caller of bch_journal() may
believe the journal still work but the truth is in-memory journal write
set won't be written into cache device any more. This behavior may
introduce potential inconsistent metadata status.

This patch checks CACHE_SET_IO_DISABLE bit at the head of bch_journal(),
if the bit is set, bch_journal() returns NULL immediately to notice
caller to know journal does not work.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 7beff8884dd0..87af7c6513c5 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -867,6 +867,10 @@ atomic_t *bch_journal(struct cache_set *c,
 	struct journal_write *w;
 	atomic_t *ret;
 
+	/* No journaling if CACHE_SET_IO_DISABLE set already */
+	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
+		return NULL;
+
 	if (!CACHE_SYNC(&c->sb))
 		return NULL;
 
-- 
2.16.4

