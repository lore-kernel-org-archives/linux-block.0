Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45117 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757448AbdDRPwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2017 11:52:49 -0400
From: Christoph Hellwig <hch@bombadil.infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <jbacik@fb.com>,
        James Smart <james.smart@broadcom.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: block: add a error_count field to struct request
Date: Tue, 18 Apr 2017 08:52:23 -0700
Message-Id: <20170418155229.5977-18-hch@bombadil.infradead.org>
In-Reply-To: <20170418155229.5977-1-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This is for the legacy floppy and ataflop drivers that currently abuse
->errors for this purpose.  It's stashed away in a union to not grow
the struct size, the other fields are either used by modern drivers
for different purposes or the I/O scheduler before queing the I/O
to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5986e1250d7d..e618164462e8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -175,6 +175,7 @@ struct request {
 		struct rb_node rb_node;	/* sort/lookup */
 		struct bio_vec special_vec;
 		void *completion_data;
+		int error_count; /* for legacy drivers, don't use */
 	};
 
 	/*
-- 
2.11.0
