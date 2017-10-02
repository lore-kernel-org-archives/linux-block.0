Return-Path: <me@tobin.cc>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: add NULL argument check to bioset_free()
Date: Mon,  2 Oct 2017 18:06:03 +1100
Message-Id: <1506927963-27865-1-git-send-email-me@tobin.cc>
List-ID: <linux-block@vger.kernel.org>

Currently bioset_free() will oops if passed a NULL argument. Other
kernel 'free' functions typically check for NULL arguments and
return. The rule of least surprise dictates that bioset_free() should
behave safely even if passed a NULL argument.

Add NULL argument check to bioset_free().

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index b38e962..780aecc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1925,6 +1925,9 @@ mempool_t *biovec_create_pool(int pool_entries)
 
 void bioset_free(struct bio_set *bs)
 {
+	if (unlikely(!bs))
+		return;
+
 	if (bs->rescue_workqueue)
 		destroy_workqueue(bs->rescue_workqueue);
 
-- 
2.7.4
