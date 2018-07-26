Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730452AbeGZPkU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 11:40:20 -0400
From: Coly Li <colyli@suse.de>
To: colyli@suse.de, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/9] bcache: fix mistaken comments in bch_keylist_realloc()
Date: Thu, 26 Jul 2018 22:22:36 +0800
Message-Id: <20180726142239.44669-7-colyli@suse.de>
In-Reply-To: <20180726142239.44669-1-colyli@suse.de>
References: <20180726142239.44669-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

---
 drivers/md/bcache/request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 8eece9ef9f46..91206f329971 100644
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
2.17.1
