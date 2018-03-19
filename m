Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42612 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbeCSAhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:37:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id o14so2013975pgv.9
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:37:03 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 19/20] bcache: Reduce the number of sparse complaints about lock imbalances
Date: Sun, 18 Mar 2018 17:36:32 -0700
Message-Id: <20180319003633.27225-20-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Add more annotations for sparse to inform it about which functions do
not have the same number of spin_lock() and spin_unlock() calls.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index acd0e5c074dd..18f1b5239620 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -594,6 +594,7 @@ static void journal_write_done(struct closure *cl)
 }
 
 static void journal_write_unlock(struct closure *cl)
+	__releases(&c->journal.lock)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
 
@@ -705,6 +706,7 @@ static void journal_try_write(struct cache_set *c)
 
 static struct journal_write *journal_wait_for_write(struct cache_set *c,
 						    unsigned nkeys)
+	__acquires(&c->journal.lock)
 {
 	size_t sectors;
 	struct closure cl;
-- 
2.14.1
