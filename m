Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10182 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265AbcEFVxn (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 6 May 2016 17:53:43 -0400
From: Vishal Verma <vishal.l.verma@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	xfs@oss.sgi.com, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Boaz Harrosh <boaz@plexistor.com>
Subject: [PATCH v5 1/5] dax: fallback from pmd to pte on error
Date: Fri,  6 May 2016 15:53:07 -0600
Message-Id: <1462571591-3361-2-git-send-email-vishal.l.verma@intel.com>
In-Reply-To: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
References: <1462571591-3361-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

In preparation for consulting a badblocks list in pmem_direct_access(),
teach dax_pmd_fault() to fallback rather than fail immediately upon
encountering an error.  The thought being that reducing the span of the
dax request may avoid the error region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5a34f08..52f0044 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1111,8 +1111,8 @@ int __dax_pmd_fault(struct vm_area_struct *vma, unsigned long address,
 		long length = dax_map_atomic(bdev, &dax);
 
 		if (length < 0) {
-			result = VM_FAULT_SIGBUS;
-			goto out;
+			dax_pmd_dbg(&bh, address, "dax-error fallback");
+			goto fallback;
 		}
 		if (length < PMD_SIZE) {
 			dax_pmd_dbg(&bh, address, "dax-length too small");
-- 
2.5.5

