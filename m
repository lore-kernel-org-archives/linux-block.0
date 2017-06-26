Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbdFZMNk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:13:40 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v2 06/51] f2fs: f2fs_read_end_io: comment on direct access to bvec table
Date: Mon, 26 Jun 2017 20:09:49 +0800
Message-Id: <20170626121034.3051-7-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7697d03e8a98..622c44a1be78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -56,6 +56,10 @@ static void f2fs_read_end_io(struct bio *bio)
 	int i;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
+	/*
+	 * It is still safe to retrieve the 1st page of the bio
+	 * in this way after supporting multipage bvec.
+	 */
 	if (time_to_inject(F2FS_P_SB(bio->bi_io_vec->bv_page), FAULT_IO)) {
 		f2fs_show_injection_info(FAULT_IO);
 		bio->bi_status = BLK_STS_IOERR;
-- 
2.9.4
