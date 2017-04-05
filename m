Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] mtd: nand: nandsim: convert to memalloc_noreclaim_*()
Date: Wed,  5 Apr 2017 09:47:00 +0200
Message-Id: <20170405074700.29871-5-vbabka@suse.cz>
In-Reply-To: <20170405074700.29871-1-vbabka@suse.cz>
References: <20170405074700.29871-1-vbabka@suse.cz>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Nandsim has own functions set_memalloc() and clear_memalloc() for robust
setting and clearing of PF_MEMALLOC. Replace them by the new generic helpers.
No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/nandsim.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index cef818f535ed..03a0d057bf2f 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/seq_file.h>
@@ -1368,31 +1369,18 @@ static int get_pages(struct nandsim *ns, struct file *file, size_t count, loff_t
 	return 0;
 }
 
-static int set_memalloc(void)
-{
-	if (current->flags & PF_MEMALLOC)
-		return 0;
-	current->flags |= PF_MEMALLOC;
-	return 1;
-}
-
-static void clear_memalloc(int memalloc)
-{
-	if (memalloc)
-		current->flags &= ~PF_MEMALLOC;
-}
-
 static ssize_t read_file(struct nandsim *ns, struct file *file, void *buf, size_t count, loff_t pos)
 {
 	ssize_t tx;
-	int err, memalloc;
+	int err;
+	unsigned int noreclaim_flag;
 
 	err = get_pages(ns, file, count, pos);
 	if (err)
 		return err;
-	memalloc = set_memalloc();
+	noreclaim_flag = memalloc_noreclaim_save();
 	tx = kernel_read(file, pos, buf, count);
-	clear_memalloc(memalloc);
+	memalloc_noreclaim_restore(noreclaim_flag);
 	put_pages(ns);
 	return tx;
 }
@@ -1400,14 +1388,15 @@ static ssize_t read_file(struct nandsim *ns, struct file *file, void *buf, size_
 static ssize_t write_file(struct nandsim *ns, struct file *file, void *buf, size_t count, loff_t pos)
 {
 	ssize_t tx;
-	int err, memalloc;
+	int err;
+	unsigned int noreclaim_flag;
 
 	err = get_pages(ns, file, count, pos);
 	if (err)
 		return err;
-	memalloc = set_memalloc();
+	noreclaim_flag = memalloc_noreclaim_save();
 	tx = kernel_write(file, buf, count, pos);
-	clear_memalloc(memalloc);
+	memalloc_noreclaim_restore(noreclaim_flag);
 	put_pages(ns);
 	return tx;
 }
-- 
2.12.2
