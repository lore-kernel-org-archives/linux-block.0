Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/16] ceph: don't include blk_types.h in messenger.h
Date: Tue,  1 Nov 2016 07:40:15 -0600
Message-Id: <1478007617-18715-15-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

The file only needs the struct bvec_iter delcaration, which is available
from bvec.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ceph/messenger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 8dbd787..67bcef2 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -1,7 +1,7 @@
 #ifndef __FS_CEPH_MESSENGER_H
 #define __FS_CEPH_MESSENGER_H
 
-#include <linux/blk_types.h>
+#include <linux/bvec.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
-- 
2.1.4

