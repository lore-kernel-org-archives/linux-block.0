Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <ming.lei@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Stephen Bates <sbates@raithlin.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jerome Glisse <jglisse@redhat.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 24 May 2017 15:42:15 -0600
Message-Id: <1495662147-18277-5-git-send-email-logang@deltatee.com>
In-Reply-To: <1495662147-18277-1-git-send-email-logang@deltatee.com>
References: <1495662147-18277-1-git-send-email-logang@deltatee.com>
Subject: [RFC PATCH 04/16] um: add dummy ioremap and iounmap functions
List-ID: <linux-block@vger.kernel.org>

The user mode architecture does not provide ioremap or iounmap, and
because of this, the arch won't build when the functions are used in some
core libraries.

I have designs to use these functions in scatterlist.c where they'd
almost certainly never be called on the um architecture but it does need
to compile.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 arch/um/include/asm/io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/um/include/asm/io.h

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
new file mode 100644
index 0000000..8f35d57
--- /dev/null
+++ b/arch/um/include/asm/io.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_UM_IO_H
+#define _ASM_UM_IO_H
+
+#define ioremap ioremap
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return (void __iomem *)(unsigned long)offset;
+}
+
+#define iounmap iounmap
+static inline void iounmap(void __iomem *addr)
+{
+}
+
+#include <asm-generic/io.h>
+
+#endif
-- 
2.1.4
