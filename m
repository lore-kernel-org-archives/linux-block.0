Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23307 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeCOPIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:30 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 12/16] bcache: Make it easier for static analyzers to analyze bch_allocator_thread()
Date: Thu, 15 Mar 2018 08:08:10 -0700
Message-Id: <20180315150814.9412-13-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality but avoids that smatch
reports the following:

drivers/md/bcache/alloc.c:334: bch_allocator_thread() error: uninitialized symbol 'bucket'.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/alloc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 458e1d38577d..6a98d48c5f5f 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -316,6 +316,7 @@ static int bch_allocator_push(struct cache *ca, long bucket)
 static int bch_allocator_thread(void *arg)
 {
 	struct cache *ca = arg;
+	long bucket;
 
 	mutex_lock(&ca->set->bucket_lock);
 
@@ -325,11 +326,7 @@ static int bch_allocator_thread(void *arg)
 		 * possibly issue discards to them, then we add the bucket to
 		 * the free list:
 		 */
-		while (!fifo_empty(&ca->free_inc)) {
-			long bucket;
-
-			fifo_pop(&ca->free_inc, bucket);
-
+		while (fifo_pop(&ca->free_inc, bucket)) {
 			if (ca->discard) {
 				mutex_unlock(&ca->set->bucket_lock);
 				blkdev_issue_discard(ca->bdev,
-- 
2.16.2
