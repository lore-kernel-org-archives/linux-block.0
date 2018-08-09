Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 05/10] bcache: fix mistaken code comments in bcache.h
Date: Thu,  9 Aug 2018 15:48:46 +0800
Message-Id: <20180809074851.11027-6-colyli@suse.de>
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
References: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch updates the code comment in struct cache with correct array
names, to make the code to be more comprehensible.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 0a3e82b0876d..b393b3fd06b6 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -423,9 +423,9 @@ struct cache {
 	/*
 	 * When allocating new buckets, prio_write() gets first dibs - since we
 	 * may not be allocate at all without writing priorities and gens.
-	 * prio_buckets[] contains the last buckets we wrote priorities to (so
-	 * gc can mark them as metadata), prio_next[] contains the buckets
-	 * allocated for the next prio write.
+	 * prio_last_buckets[] contains the last buckets we wrote priorities to
+	 * (so gc can mark them as metadata), prio_buckets[] contains the
+	 * buckets allocated for the next prio write.
 	 */
 	uint64_t		*prio_buckets;
 	uint64_t		*prio_last_buckets;
-- 
2.18.0
