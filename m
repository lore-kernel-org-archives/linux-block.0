Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 06/10] bcache: fix mistaken comments in request.c
Date: Thu,  9 Aug 2018 15:48:47 +0800
Message-Id: <20180809074851.11027-7-colyli@suse.de>
In-Reply-To: <20180809074851.11027-1-colyli@suse.de>
References: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch updates code comment in bch_keylist_realloc() by fixing
incorrected function names, to make the code to be more comprehennsible.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 43af905920f5..914d501ad1e0 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -107,7 +107,7 @@ static int bch_keylist_realloc(struct keylist *l, unsigned u64s,
 	/*
 	 * The journalling code doesn't handle the case where the keys to insert
 	 * is bigger than an empty write: If we just return -ENOMEM here,
-	 * bio_insert() and bio_invalidate() will insert the keys created so far
+	 * bch_data_insert_keys() will insert the keys created so far
 	 * and finish the rest when the keylist is empty.
 	 */
 	if (newsize * sizeof(uint64_t) > block_bytes(c) - sizeof(struct jset))
-- 
2.18.0
