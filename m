Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeHJJxs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:53:48 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 09/17] bcache: fix typo 'succesfully' to 'successfully'
Date: Fri, 10 Aug 2018 15:23:49 +0800
Message-Id: <20180810072357.19823-10-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch fixes typo 'succesfully' to correct 'successfully', which is
suggested by checkpatch.pl.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/io.c      | 2 +-
 drivers/md/bcache/request.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index cfc56add799a..c25097968319 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -86,7 +86,7 @@ void bch_count_io_errors(struct cache *ca,
 
 			/*
 			 * First we subtract refresh from count; each time we
-			 * succesfully do so, we rescale the errors once:
+			 * successfully do so, we rescale the errors once:
 			 */
 
 			count = atomic_cmpxchg(&ca->io_count, old, new);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 858dd3da9dc5..55264e71369d 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -154,7 +154,7 @@ static void bch_data_insert_error(struct closure *cl)
 
 	/*
 	 * Our data write just errored, which means we've got a bunch of keys to
-	 * insert that point to data that wasn't succesfully written.
+	 * insert that point to data that wasn't successfully written.
 	 *
 	 * We don't have to insert those keys but we still have to invalidate
 	 * that region of the cache - so, if we just strip off all the pointers
-- 
2.18.0
