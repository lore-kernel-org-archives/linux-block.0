Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/9] mtip32xx: add missing endianess annotations on struct smart_attr
Date: Fri,  9 Nov 2018 14:48:58 +0100
Message-Id: <20181109134902.32057-6-hch@lst.de>
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
References: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 0aa1ea210822..e8b4b3d5365a 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -172,10 +172,10 @@ enum {
 
 struct smart_attr {
 	u8 attr_id;
-	u16 flags;
+	__le16 flags;
 	u8 cur;
 	u8 worst;
-	u32 data;
+	__le32 data;
 	u8 res[3];
 } __packed;
 
-- 
2.19.1
