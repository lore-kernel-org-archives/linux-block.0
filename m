Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E16C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C23208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF1MAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:00:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfF1MAO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49841B631;
        Fri, 28 Jun 2019 12:00:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 01/37] bcache: don't set max writeback rate if gc is running
Date:   Fri, 28 Jun 2019 19:59:24 +0800
Message-Id: <20190628120000.40753-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When gc is running, user space I/O processes may wait inside
bcache code, so no new I/O coming. Indeed this is not a real idle
time, maximum writeback rate should not be set in such situation.
Otherwise a faster writeback thread may compete locks with gc thread
and makes garbage collection slower, which results a longer I/O
freeze period.

This patch checks c->gc_mark_valid in set_at_max_writeback_rate(). If
c->gc_mark_valid is 0 (gc running), set_at_max_writeback_rate() returns
false, then update_writeback_rate() will not set writeback rate to
maximum value even c->idle_counter reaches an idle threshold.

Now writeback thread won't interfere gc thread performance.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 73f0efac2b9f..262f7ef20992 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -122,6 +122,9 @@ static void __update_writeback_rate(struct cached_dev *dc)
 static bool set_at_max_writeback_rate(struct cache_set *c,
 				       struct cached_dev *dc)
 {
+	/* Don't set max writeback rate if gc is running */
+	if (!c->gc_mark_valid)
+		return false;
 	/*
 	 * Idle_counter is increased everytime when update_writeback_rate() is
 	 * called. If all backing devices attached to the same cache set have
-- 
2.16.4

