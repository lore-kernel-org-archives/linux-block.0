Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964963AbeF0MqQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 08:46:16 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org
Subject: [PATCH V7 01/24] dm: use bio_split() when splitting out the already processed bio
Date: Wed, 27 Jun 2018 20:45:25 +0800
Message-Id: <20180627124548.3456-2-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Use of bio_clone_bioset() is inefficient if there is no need to clone
the original bio's bio_vec array.  Best to use the bio_clone_fast()
variant.  Also, just using bio_advance() is only part of what is needed
to properly setup the clone -- it doesn't account for the various
bio_integrity() related work that also needs to be performed (see
bio_split).

Address both of these issues by switching from bio_clone_bioset() to
bio_split().

Fixes: 18a25da8 ("dm: ensure bio submission follows a depth-first tree walk")
Cc: stable@vger.kernel.org
Reported-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: NeilBrown <neilb@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e65429a29c06..a3b103e8e3ce 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1606,10 +1606,9 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 				 * the usage of io->orig_bio in dm_remap_zone_report()
 				 * won't be affected by this reassignment.
 				 */
-				struct bio *b = bio_clone_bioset(bio, GFP_NOIO,
-								 &md->queue->bio_split);
+				struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
+							  GFP_NOIO, &md->queue->bio_split);
 				ci.io->orig_bio = b;
-				bio_advance(bio, (bio_sectors(bio) - ci.sector_count) << 9);
 				bio_chain(b, bio);
 				ret = generic_make_request(bio);
 				break;
-- 
2.9.5
