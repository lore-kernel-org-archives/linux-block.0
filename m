Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35792 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcL0QB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:01:29 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH v1 21/54] block: introduce bio_can_convert_to_sp()
Date: Tue, 27 Dec 2016 23:56:10 +0800
Message-Id: <1482854250-13481-22-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces bio_can_convert_to_sp() for checking
if one multipage bio can be converted into one singlepage
bio. If not, returns how many sectors we need to split for
converting the splitted one into singlepage bio.

In the following patches, block bounce and bcache will use
the helper.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/bio.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0f2859f96468..79079bc5a1be 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -262,6 +262,35 @@ static inline unsigned bio_segments_mp(struct bio *bio)
 }
 
 /*
+ * This helper checks @bio and see if we can convert it into one
+ * singlepage bvec based bio. Return true if yes, otherwise false
+ * is returned.
+ *
+ * @sectors returns how many sectors we need to split for converting
+ * the splitted one into a singlepage bio if the whole bio can't be
+ * converted into a singlepage bio.
+ */
+static inline bool bio_can_convert_to_sp(struct bio *bio, unsigned *sectors)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	unsigned len = 0;
+	bool ret = true;
+	unsigned segs = 0;
+
+	bio_for_each_segment(bv, bio, iter) {
+		if (++segs > BIO_MAX_PAGES) {
+			ret = false;
+			*sectors = len >> 9;
+			break;
+		}
+		len += bv.bv_len;
+	}
+
+	return ret;
+}
+
+/*
  * get a reference to a bio, so it won't disappear. the intended use is
  * something like:
  *
-- 
2.7.4

