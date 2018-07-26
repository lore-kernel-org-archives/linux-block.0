Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730533AbeGZPkR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 11:40:17 -0400
From: Coly Li <colyli@suse.de>
To: colyli@suse.de, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/9] bcache: fix mistaken code comments in struct cache
Date: Thu, 26 Jul 2018 22:22:35 +0800
Message-Id: <20180726142239.44669-6-colyli@suse.de>
In-Reply-To: <20180726142239.44669-1-colyli@suse.de>
References: <20180726142239.44669-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

---
 drivers/md/bcache/bcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index a44bd427e5ba..5f7082aab1b0 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -423,8 +423,8 @@ struct cache {
 	/*
 	 * When allocating new buckets, prio_write() gets first dibs - since we
 	 * may not be allocate at all without writing priorities and gens.
-	 * prio_buckets[] contains the last buckets we wrote priorities to (so
-	 * gc can mark them as metadata), prio_next[] contains the buckets
+	 * prio_last_buckets[] contains the last buckets we wrote priorities to (so
+	 * gc can mark them as metadata), prio_buckets[] contains the buckets
 	 * allocated for the next prio write.
 	 */
 	uint64_t		*prio_buckets;
-- 
2.17.1
