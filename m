Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D8C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0920820
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437608AbeKWB7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:59:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:45170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730517AbeKWB7h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 20:59:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDF7DADD7;
        Thu, 22 Nov 2018 15:19:47 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 1/5] bcache: introduce force_wake_up_gc()
Date:   Thu, 22 Nov 2018 23:19:20 +0800
Message-Id: <20181122151924.103644-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181122151924.103644-1-colyli@suse.de>
References: <20181122151924.103644-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Garbage collection thread starts to work when c->sectors_to_gc is
negative value, otherwise nothing will happen even the gc thread
is woken up by wake_up_gc().

force_wake_up_gc() sets c->sectors_to_gc to -1 before calling
wake_up_gc(), then gc thread may have chance to run if no one else
sets c->sectors_to_gc to a positive value before gc_should_run().

This routine can be called where the gc thread is woken up and
required to run in force.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.h | 18 ++++++++++++++++++
 drivers/md/bcache/sysfs.c | 17 ++---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index a68d6c55783b..d1c72ef64edf 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -266,6 +266,24 @@ static inline void wake_up_gc(struct cache_set *c)
 	wake_up(&c->gc_wait);
 }
 
+static inline void force_wake_up_gc(struct cache_set *c)
+{
+	/*
+	 * Garbage collection thread only works when sectors_to_gc < 0,
+	 * calling wake_up_gc() won't start gc thread if sectors_to_gc is
+	 * not a nagetive value.
+	 * Therefore sectors_to_gc is set to -1 here, before waking up
+	 * gc thread by calling wake_up_gc(). Then gc_should_run() will
+	 * give a chance to permit gc thread to run. "Give a chance" means
+	 * before going into gc_should_run(), there is still possibility
+	 * that c->sectors_to_gc being set to other positive value. So
+	 * this routine won't 100% make sure gc thread will be woken up
+	 * to run.
+	 */
+	atomic_set(&c->sectors_to_gc, -1);
+	wake_up_gc(c);
+}
+
 #define MAP_DONE	0
 #define MAP_CONTINUE	1
 
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index d2e5c9892d4d..7351ee4940f3 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -725,21 +725,8 @@ STORE(__bch_cache_set)
 		bch_cache_accounting_clear(&c->accounting);
 	}
 
-	if (attr == &sysfs_trigger_gc) {
-		/*
-		 * Garbage collection thread only works when sectors_to_gc < 0,
-		 * when users write to sysfs entry trigger_gc, most of time
-		 * they want to forcibly triger gargage collection. Here -1 is
-		 * set to c->sectors_to_gc, to make gc_should_run() give a
-		 * chance to permit gc thread to run. "give a chance" means
-		 * before going into gc_should_run(), there is still chance
-		 * that c->sectors_to_gc being set to other positive value. So
-		 * writing sysfs entry trigger_gc won't always make sure gc
-		 * thread takes effect.
-		 */
-		atomic_set(&c->sectors_to_gc, -1);
-		wake_up_gc(c);
-	}
+	if (attr == &sysfs_trigger_gc)
+		force_wake_up_gc(c);
 
 	if (attr == &sysfs_prune_cache) {
 		struct shrink_control sc;
-- 
2.16.4

