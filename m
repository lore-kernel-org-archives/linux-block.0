Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <ming.lei@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Stephen Bates <sbates@raithlin.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jerome Glisse <jglisse@redhat.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 24 May 2017 15:42:25 -0600
Message-Id: <1495662147-18277-15-git-send-email-logang@deltatee.com>
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Subject: [RFC PATCH 14/16] block: bio: go straight from pfn_t to phys instead of through page
List-ID: <linux-block@vger.kernel.org>

Going straight from pfn_t to physical address is cheaper and
avoids the potential BUG_ON in bvec_page for unmappable memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 include/linux/bio.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index bc5f5d3..890c94d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,8 @@
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
 
+#define bio_iter_pfn_t(bio, iter)				\
+	bvec_iter_pfn_t((bio)->bi_io_vec, (iter))
 #define bio_iter_page(bio, iter)				\
 	bvec_iter_page((bio)->bi_io_vec, (iter))
 #define bio_iter_len(bio, iter)					\
@@ -53,6 +55,7 @@
 #define bio_iter_offset(bio, iter)				\
 	bvec_iter_offset((bio)->bi_io_vec, (iter))
 
+#define bio_pfn_t(bio)		bio_iter_pfn_t((bio), (bio)->bi_iter)
 #define bio_page(bio)		bio_iter_page((bio), (bio)->bi_iter)
 #define bio_offset(bio)		bio_iter_offset((bio), (bio)->bi_iter)
 #define bio_iovec(bio)		bio_iter_iovec((bio), (bio)->bi_iter)
@@ -118,8 +121,8 @@ static inline void *bio_data(struct bio *bio)
 /*
  * will die
  */
-#define bio_to_phys(bio)	(page_to_phys(bio_page((bio))) + (unsigned long) bio_offset((bio)))
-#define bvec_to_phys(bv)	(page_to_phys(bvec_page((bv))) + (unsigned long) (bv)->bv_offset)
+#define bio_to_phys(bio)	(pfn_t_to_phys(bio_pfn_t((bio))) + (unsigned long) bio_offset((bio)))
+#define bvec_to_phys(bv)	(pfn_t_to_phys((bv)->bv_pfn) + (unsigned long) (bv)->bv_offset)
 
 /*
  * queues that have highmem support enabled may still need to revert to
-- 
2.1.4
