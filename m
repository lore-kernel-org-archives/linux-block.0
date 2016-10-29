Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33613 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbcJ2ILy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:11:54 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 01/60] block: bio: introduce bio_init_with_vec_table()
Date: Sat, 29 Oct 2016 16:08:00 +0800
Message-Id: <1477728600-12938-2-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some drivers often uses external bvec table, so introduce
this helper for this case. It is always safe to access the
bio->bi_io_vec in this way for this case.

After converting to this helper, it will becomes a bit easier
to evaluate the remaining direct access to bio->bi_io_vec,
so it can help to prepare for the following multipage bvec
support.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97cb48f03dc7..8634bd24984c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -664,6 +664,16 @@ static inline void bio_inc_remaining(struct bio *bio)
 	atomic_inc(&bio->__bi_remaining);
 }
 
+static inline void bio_init_with_vec_table(struct bio *bio,
+					   struct bio_vec *table,
+					   unsigned max_vecs)
+{
+	bio_init(bio);
+	bio->bi_io_vec = table;
+	bio->bi_max_vecs = max_vecs;
+}
+
+
 /*
  * bio_set is used to allow other portions of the IO system to
  * allocate their own private memory pools for bio and iovec structures.
-- 
2.7.4

