Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753356AbeFIMdR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Jun 2018 08:33:17 -0400
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
Subject: [PATCH V6 13/30] block: introduce rq_for_each_chunk()
Date: Sat,  9 Jun 2018 20:29:57 +0800
Message-Id: <20180609123014.8861-14-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
References: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There are still cases in which rq_for_each_chunk() is required, for
example, loop.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bca3a92eb55f..4eaba73c784a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -941,6 +941,10 @@ struct req_iterator {
 	__rq_for_each_bio(_iter.bio, _rq)			\
 		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
 
+#define rq_for_each_chunk(bvl, _rq, _iter)			\
+	__rq_for_each_bio(_iter.bio, _rq)			\
+		bio_for_each_chunk(bvl, _iter.bio, _iter.iter)
+
 #define rq_iter_last(bvec, _iter)				\
 		(_iter.bio->bi_next == NULL &&			\
 		 bio_iter_last(bvec, _iter.iter))
-- 
2.9.5
