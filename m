Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/13] xen: remove the xen_biovec_phys_mergeable export
Date: Tue,  4 Sep 2018 12:14:20 -0700
Message-Id: <20180904191431.20102-3-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

BIOVEC_PHYS_MERGEABLE is only called from core block code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/biomerge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 55ed80c3a17c..399c4e30f723 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -20,4 +20,3 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 	return false;
 #endif
 }
-EXPORT_SYMBOL(xen_biovec_phys_mergeable);
-- 
2.18.0
