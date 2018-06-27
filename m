Return-Path: <linux-fsdevel-owner@vger.kernel.org>
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
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V7 03/24] exofs: use bio_clone_fast in _write_mirror
Date: Wed, 27 Jun 2018 20:45:27 +0800
Message-Id: <20180627124548.3456-4-ming.lei@redhat.com>
In-Reply-To: <20180627124548.3456-1-ming.lei@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

The mirroring code never changes the bio data or biovecs.  This means
we can reuse the biovec allocation easily instead of duplicating it.

Acked-by: Boaz Harrosh <ooo@electrozaur.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exofs/ore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 1b8b44637e70..5331a15a61f1 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -873,8 +873,8 @@ static int _write_mirror(struct ore_io_state *ios, int cur_comp)
 			struct bio *bio;
 
 			if (per_dev != master_dev) {
-				bio = bio_clone_kmalloc(master_dev->bio,
-							GFP_KERNEL);
+				bio = bio_clone_fast(master_dev->bio,
+						     GFP_KERNEL, NULL);
 				if (unlikely(!bio)) {
 					ORE_DBGMSG(
 					      "Failed to allocate BIO size=%u\n",
-- 
2.9.5
