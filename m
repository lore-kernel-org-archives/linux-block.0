Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35079 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbcL0QHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:07:07 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH v1 49/54] fs/iomap.c: convert to bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:58 +0800
Message-Id: <1482854706-14128-18-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 354a123f170e..11da77b24599 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -698,8 +698,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	} else {
 		struct bio_vec *bvec;
 		int i;
+		struct bvec_iter_all bia;
 
-		bio_for_each_segment_all(bvec, bio, i)
+		bio_for_each_segment_all_sp(bvec, bio, i, bia)
 			put_page(bvec->bv_page);
 		bio_put(bio);
 	}
-- 
2.7.4

