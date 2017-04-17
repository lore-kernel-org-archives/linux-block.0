Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49612 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757425AbdDQTRi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2017 15:17:38 -0400
Subject: [resend PATCH v2 32/33] filesystem-dax: gate calls to dax_flush()
 on QUEUE_FLAG_WC
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, dm-devel@redhat.com,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>, hch@lst.de
Date: Mon, 17 Apr 2017 12:11:43 -0700
Message-ID: <149245630377.10206.16395058260450137463.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some platforms arrange for cpu caches to be flushed on power-fail. On
those platforms there is no requirement that the kernel track and flush
potentially dirty cache lines. Given that we still insert entries into
the radix for locking purposes this patch only disables the cache flush
loop, not the dirty tracking.

Userspace can override the default cache setting via the block device
queue "write_cache" attribute in sysfs.

Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f37ed21e4093..5b7ee1bc74d0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -797,7 +797,8 @@ static int dax_writeback_one(struct block_device *bdev,
 	}
 
 	dax_mapping_entry_mkclean(mapping, index, pfn_t_to_pfn(pfn));
-	dax_flush(dax_dev, pgoff, kaddr, size);
+	if (test_bit(QUEUE_FLAG_WC, &bdev->bd_queue->queue_flags))
+		dax_flush(dax_dev, pgoff, kaddr, size);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
 	 * cannot be new dirty data in the pfn after the flush has completed as
@@ -982,7 +983,8 @@ int __dax_zero_page_range(struct block_device *bdev,
 			return rc;
 		}
 		memset(kaddr + offset, 0, size);
-		dax_flush(dax_dev, pgoff, kaddr + offset, size);
+		if (test_bit(QUEUE_FLAG_WC, &bdev->bd_queue->queue_flags))
+			dax_flush(dax_dev, pgoff, kaddr + offset, size);
 		dax_read_unlock(id);
 	}
 	return 0;
