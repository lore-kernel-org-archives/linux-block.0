Return-Path: <BATV+7a06f17d5f5fa9909705+5378+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH] jsflash: fix compilation
Date: Tue, 15 May 2018 20:32:58 +0200
Message-Id: <20180515183258.4440-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

No bio in this whole function, use req->bio instead.

Fixes: 37a5b5c6 ("jsflash: handle highmem pages");
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Looks like no one except for Guenters build bot cared.  I wonder if we
should just get rid of the driver given that it doesn't look in a good
shape at all based on his build logs even with the fix..

 drivers/sbus/char/jsflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
index 8520587b8d09..821367ef9dd3 100644
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -230,7 +230,7 @@ static void jsfd_request(void)
 			goto end;
 		}
 
-		p = kmap_atomic(bio_page(bio)) + bio_offset(bio);
+		p = kmap_atomic(bio_page(req->bio)) + bio_offset(req->bio);
 		jsfd_read(p, jdp->dbase + offset, len);
 		kunmap_atomic(p);
 		err = BLK_STS_OK;
-- 
2.17.0
