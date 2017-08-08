Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbdHHIyv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Aug 2017 04:54:51 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 47/49] fs/direct-io: convert to bio_for_each_segment_all_sp()
Date: Tue,  8 Aug 2017 16:45:46 +0800
Message-Id: <20170808084548.18963-48-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 08cf27811e5a..8447f4d55730 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -491,7 +491,9 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
 	} else {
-		bio_for_each_segment_all(bvec, bio, i) {
+		struct bvec_iter_all bia;
+
+		bio_for_each_segment_all_sp(bvec, bio, i, bia) {
 			struct page *page = bvec->bv_page;
 
 			if (dio->op == REQ_OP_READ && !PageCompound(page) &&
-- 
2.9.4
