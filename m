Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk, axboe@fb.com
Cc: milosz@adfin.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 4/6] vfs: add the RWF_HIPRI flag for preadv2/pwritev2
Date: Thu,  3 Mar 2016 16:04:01 +0100
Message-Id: <1457017443-17662-5-git-send-email-hch@lst.de>
In-Reply-To: <1457017443-17662-1-git-send-email-hch@lst.de>
References: <1457017443-17662-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This adds a flag that tells the file system that this is a high priority
request for which it's worth to poll the hardware.  The flag is purely
advisory and can be ignored if not supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stephen Bates <stephen.bates@pmcs.com>
Tested-by: Stephen Bates <stephen.bates@pmcs.com>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/read_write.c         | 6 ++++--
 include/linux/fs.h      | 1 +
 include/uapi/linux/fs.h | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 799d25f..cf377cf 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -698,10 +698,12 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	struct kiocb kiocb;
 	ssize_t ret;
 
-	if (flags)
+	if (flags & ~RWF_HIPRI)
 		return -EOPNOTSUPP;
 
 	init_sync_kiocb(&kiocb, filp);
+	if (flags & RWF_HIPRI)
+		kiocb.ki_flags |= IOCB_HIPRI;
 	kiocb.ki_pos = *ppos;
 
 	ret = fn(&kiocb, iter);
@@ -716,7 +718,7 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 {
 	ssize_t ret = 0;
 
-	if (flags)
+	if (flags & ~RWF_HIPRI)
 		return -EOPNOTSUPP;
 
 	while (iov_iter_count(iter)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 875277a..a1f731c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -320,6 +320,7 @@ struct writeback_control;
 #define IOCB_EVENTFD		(1 << 0)
 #define IOCB_APPEND		(1 << 1)
 #define IOCB_DIRECT		(1 << 2)
+#define IOCB_HIPRI		(1 << 3)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 149bec8..d246339 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -304,4 +304,7 @@ struct fsxattr {
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
 
+/* flags for preadv2/pwritev2: */
+#define RWF_HIPRI			0x00000001 /* high priority request, poll if possible */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.1.4

