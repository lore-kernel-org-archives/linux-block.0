Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36546 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932860AbcL0QGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:06:16 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH v1 40/54] fs/direct-io: convert to bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:49 +0800
Message-Id: <1482854706-14128-9-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index aeae8c063451..e2ecd9fbbffb 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -487,7 +487,9 @@ static int dio_bio_complete(struct dio *dio, struct bio *bio)
 		err = bio->bi_error;
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		bio_for_each_segment_all(bvec, bio, i) {
+		struct bvec_iter_all bia;
+
+		bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 			struct page *page = bvec->bv_page;
 
 			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
-- 
2.7.4

