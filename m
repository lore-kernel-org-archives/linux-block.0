Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 49/51] fs/direct-io: convert to bio_for_each_segment_all_sp()
Date: Mon, 26 Jun 2017 20:10:32 +0800
Message-Id: <20170626121034.3051-50-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index c87077d1dc33..a139b3bbad8e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -489,7 +489,9 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
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
