Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeCOPI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:29 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 07/16] bcache: Reduce the number of sparse complaints about lock imbalances
Date: Thu, 15 Mar 2018 08:08:05 -0700
Message-Id: <20180315150814.9412-8-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add more annotations for sparse to inform it about which functions do
not have the same number of spin_lock() and spin_unlock() calls.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 605368ff13c9..a191fd04212f 100644
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
2.16.2
