Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753141AbcLNDIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 22:08:30 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBE355AS022496
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2016 19:07:58 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27arnbbyuv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2016 19:07:58 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.97) with ESMTP id
 8296e16ac1aa11e6947024be0593f280-280d5a50 for <linux-block@vger.kernel.org>;
        Tue, 13 Dec 2016 19:07:56 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH] block_dev: don't update file access position for sync direct IO
Date: Tue, 13 Dec 2016 19:07:55 -0800
Message-ID: <d78aaba0928aa012d13eb462bbfc33cdddd0621a.1481684697.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For sync direct IO, generic_file_direct_write/generic_file_read_iter
will update file access position. Don't duplicate the update in
.direct_IO. This cause my raid array can't assemble.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/block_dev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 95acbd2..1eb7dcf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -264,7 +264,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (unlikely(bio.bi_error))
 		return bio.bi_error;
-	iocb->ki_pos += ret;
 	return ret;
 }
 
@@ -411,10 +410,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	__set_current_state(TASK_RUNNING);
 
 	ret = dio->bio.bi_error;
-	if (likely(!ret)) {
+	if (likely(!ret))
 		ret = dio->size;
-		iocb->ki_pos += ret;
-	}
 
 	bio_put(&dio->bio);
 	return ret;
-- 
2.9.3

