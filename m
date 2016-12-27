Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34192 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbcL0P7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:53 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH v1 13/54] block: comments on bio_for_each_segment[_all]
Date: Tue, 27 Dec 2016 23:56:02 +0800
Message-Id: <1482854250-13481-14-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch clarifies the fact that even though both
bio_for_each_segment() and bio_for_each_segment_all()
are named as _segment/_segment_all, they still returns
one page one time, instead of real segment(multipage bvec).

With comming multipage bvec, both the two helpers
are capable of returning real segment(multipage bvec),
but the callers(users) of the two helpers may not be
capable of handling of the multipage bvec or real
segment, so we still keep the interfaces of the helpers
not changed. And new helpers for returning multipage bvec
should be introduced.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7cf8a6c70a3f..714fbf495af7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -156,7 +156,10 @@ static inline void *bio_data(struct bio *bio)
 
 /*
  * drivers should _never_ use the all version - the bio may have been split
- * before it got to the driver and the driver won't own all of it
+ * before it got to the driver and the driver won't own all of it.
+ *
+ * Even though the helper is named as _segment_all, it still returns
+ * page one by one instead of real segment.
  */
 #define bio_for_each_segment_all(bvl, bio, i)				\
 	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)
@@ -178,6 +181,10 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
 	     bio_advance_iter((bio), &(iter), (bvl).bv_len))
 
+/*
+ * Even though the helper is named as _segment, it still returns
+ * page one by one instead of real segment.
+ */
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
-- 
2.7.4

