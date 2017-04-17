Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30122 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753883AbdDQTRa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2017 15:17:30 -0400
Subject: [resend PATCH v2 25/33] x86,
 dax: replace clear_pmem() with open coded memset + dax_ops->flush
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, dm-devel@redhat.com,
        Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 17 Apr 2017 12:11:04 -0700
Message-ID: <149245626477.10206.6621037965629437437.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The clear_pmem() helper simply combines a memset() plus a cache flush.
Now that the flush routine is optionally provided by the dax device
driver we can avoid unnecessary cache management on dax devices fronting
volatile memory.

With clear_pmem() gone we can follow on with a patch to make pmem cache
management completely defined within the pmem driver.

Cc: <x86@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/pmem.h |   13 -------------
 fs/dax.c                    |    3 ++-
 include/linux/pmem.h        |   21 ---------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/pmem.h b/arch/x86/include/asm/pmem.h
index 60e8edbe0205..f4c119d253f3 100644
--- a/arch/x86/include/asm/pmem.h
+++ b/arch/x86/include/asm/pmem.h
@@ -65,19 +65,6 @@ static inline void arch_wb_cache_pmem(void *addr, size_t size)
 		clwb(p);
 }
 
-/**
- * arch_clear_pmem - zero a PMEM memory range
- * @addr:	virtual start address
- * @size:	number of bytes to zero
- *
- * Write zeros into the memory range starting at 'addr' for 'size' bytes.
- */
-static inline void arch_clear_pmem(void *addr, size_t size)
-{
-	memset(addr, 0, size);
-	arch_wb_cache_pmem(addr, size);
-}
-
 static inline void arch_invalidate_pmem(void *addr, size_t size)
 {
 	clflush_cache_range(addr, size);
diff --git a/fs/dax.c b/fs/dax.c
index edbf988de86c..edee7e8298bc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -982,7 +982,8 @@ int __dax_zero_page_range(struct block_device *bdev,
 			dax_read_unlock(id);
 			return rc;
 		}
-		clear_pmem(kaddr + offset, size);
+		memset(kaddr + offset, 0, size);
+		dax_flush(dax_dev, pgoff, kaddr + offset, size);
 		dax_read_unlock(id);
 	}
 	return 0;
diff --git a/include/linux/pmem.h b/include/linux/pmem.h
index 9d542a5600e4..772bd02a5b52 100644
--- a/include/linux/pmem.h
+++ b/include/linux/pmem.h
@@ -31,11 +31,6 @@ static inline void arch_memcpy_to_pmem(void *dst, const void *src, size_t n)
 	BUG();
 }
 
-static inline void arch_clear_pmem(void *addr, size_t size)
-{
-	BUG();
-}
-
 static inline void arch_wb_cache_pmem(void *addr, size_t size)
 {
 	BUG();
@@ -73,22 +68,6 @@ static inline void memcpy_to_pmem(void *dst, const void *src, size_t n)
 }
 
 /**
- * clear_pmem - zero a PMEM memory range
- * @addr:	virtual start address
- * @size:	number of bytes to zero
- *
- * Write zeros into the memory range starting at 'addr' for 'size' bytes.
- * See blkdev_issue_flush() note for memcpy_to_pmem().
- */
-static inline void clear_pmem(void *addr, size_t size)
-{
-	if (arch_has_pmem_api())
-		arch_clear_pmem(addr, size);
-	else
-		memset(addr, 0, size);
-}
-
-/**
  * invalidate_pmem - flush a pmem range from the cache hierarchy
  * @addr:	virtual start address
  * @size:	bytes to invalidate (internally aligned to cache line size)
