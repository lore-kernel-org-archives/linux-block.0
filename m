Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 15/18] block: document usage of bio iterator helpers
Date: Sat, 10 Nov 2018 00:26:07 +0800
Message-Id: <20181109162610.18981-16-ming.lei@redhat.com>
In-Reply-To: <20181109162610.18981-1-ming.lei@redhat.com>
References: <20181109162610.18981-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now multi-page bvec is supported, some helpers may return page by
page, meantime some may return segment by segment, this patch
documents the usage.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/biovecs.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovecs.txt
index 25689584e6e0..bfafb70d0d9e 100644
--- a/Documentation/block/biovecs.txt
+++ b/Documentation/block/biovecs.txt
@@ -117,3 +117,29 @@ Other implications:
    size limitations and the limitations of the underlying devices. Thus
    there's no need to define ->merge_bvec_fn() callbacks for individual block
    drivers.
+
+Usage of helpers:
+=================
+
+* The following helpers whose names have the suffix of "_all" can only be used
+on non-BIO_CLONED bio, and usually they are used by filesystem code, and driver
+shouldn't use them because bio may have been split before they got to the driver:
+
+	bio_for_each_segment_all()
+	bio_first_bvec_all()
+	bio_first_page_all()
+	bio_last_bvec_all()
+
+* The following helpers iterate over single-page bvec, and the local
+variable of 'struct bio_vec' or the reference records single-page IO
+vector during the itearation:
+
+	bio_for_each_segment()
+	bio_for_each_segment_all()
+
+* The following helper iterates over multi-page bvec, and each bvec may
+include multiple physically contiguous pages, and the local variable of
+'struct bio_vec' or the reference records multi-page IO vector during the
+itearation:
+
+	bio_for_each_bvec()
-- 
2.9.5
