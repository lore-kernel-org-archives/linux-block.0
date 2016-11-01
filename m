Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/16] block: don't use REQ_SYNC in the READ_SYNC definition
Date: Tue,  1 Nov 2016 07:40:07 -0600
Message-Id: <1478007617-18715-7-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Reads are synchronous per defintion, don't add another flag for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3e878f..5e0078f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -196,7 +196,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define READ			REQ_OP_READ
 #define WRITE			REQ_OP_WRITE
 
-#define READ_SYNC		REQ_SYNC
+#define READ_SYNC		0
 #define WRITE_SYNC		(REQ_SYNC | REQ_NOIDLE)
 #define WRITE_ODIRECT		REQ_SYNC
 #define WRITE_FLUSH		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH)
-- 
2.1.4

