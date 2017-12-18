Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933925AbdLRMcM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:32:12 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 38/45] exofs: conver to bio_for_each_page_all2
Date: Mon, 18 Dec 2017 20:22:40 +0800
Message-Id: <20171218122247.3488-39-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_page_all2().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/exofs/ore.c      | 3 ++-
 fs/exofs/ore_raid.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 80517934d7c4..5a1d3cd14b44 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -406,8 +406,9 @@ static void _clear_bio(struct bio *bio)
 {
 	struct bio_vec *bv;
 	unsigned i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_page_all(bv, bio, i) {
+	bio_for_each_page_all2(bv, bio, i, bia) {
 		unsigned this_count = bv->bv_len;
 
 		if (likely(PAGE_SIZE == this_count))
diff --git a/fs/exofs/ore_raid.c b/fs/exofs/ore_raid.c
index 2c3346cd1b29..bb0cc314a987 100644
--- a/fs/exofs/ore_raid.c
+++ b/fs/exofs/ore_raid.c
@@ -433,11 +433,12 @@ static void _mark_read4write_pages_uptodate(struct ore_io_state *ios, int ret)
 	/* loop on all devices all pages */
 	for (d = 0; d < ios->numdevs; d++) {
 		struct bio *bio = ios->per_dev[d].bio;
+		struct bvec_iter_all bia;
 
 		if (!bio)
 			continue;
 
-		bio_for_each_page_all(bv, bio, i) {
+		bio_for_each_page_all2(bv, bio, i, bia) {
 			struct page *page = bv->bv_page;
 
 			SetPageUptodate(page);
-- 
2.9.5
