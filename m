Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753408AbeFIMfP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Jun 2018 08:35:15 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 25/30] exofs: conver to bio_for_each_chunk_segment_all
Date: Sat,  9 Jun 2018 20:30:09 +0800
Message-Id: <20180609123014.8861-26-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_for_each_segment_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_chunk_segment_all()

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/exofs/ore.c      | 3 ++-
 fs/exofs/ore_raid.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index ddbf87246898..fe2eb28de358 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -406,8 +406,9 @@ static void _clear_bio(struct bio *bio)
 {
 	struct bio_vec *bv;
 	unsigned i;
+	struct bvec_chunk_iter citer;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_chunk_segment_all(bv, bio, i, citer) {
 		unsigned this_count = bv->bv_len;
 
 		if (likely(PAGE_SIZE == this_count))
diff --git a/fs/exofs/ore_raid.c b/fs/exofs/ore_raid.c
index 27cbdb697649..4da3065ce976 100644
--- a/fs/exofs/ore_raid.c
+++ b/fs/exofs/ore_raid.c
@@ -433,11 +433,12 @@ static void _mark_read4write_pages_uptodate(struct ore_io_state *ios, int ret)
 	/* loop on all devices all pages */
 	for (d = 0; d < ios->numdevs; d++) {
 		struct bio *bio = ios->per_dev[d].bio;
+		struct bvec_chunk_iter citer;
 
 		if (!bio)
 			continue;
 
-		bio_for_each_segment_all(bv, bio, i) {
+		bio_for_each_chunk_segment_all(bv, bio, i, citer) {
 			struct page *page = bv->bv_page;
 
 			SetPageUptodate(page);
-- 
2.9.5
