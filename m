Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36679 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbcL0P7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM)
Subject: [PATCH v1 06/54] f2fs: f2fs_read_end_io: comment on direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:55 +0800
Message-Id: <1482854250-13481-7-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ac262564fa6..5d1a192e1c3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -55,6 +55,10 @@ static void f2fs_read_end_io(struct bio *bio)
 	int i;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
+	/*
+	 * It is still safe to retrieve the 1st page of the bio
+	 * in this way after supporting multipage bvec.
+	 */
 	if (time_to_inject(F2FS_P_SB(bio->bi_io_vec->bv_page), FAULT_IO))
 		bio->bi_error = -EIO;
 #endif
-- 
2.7.4

