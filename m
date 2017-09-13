Return-Path: <mpatocka@redhat.com>
Date: Wed, 13 Sep 2017 09:17:57 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Dan Williams <dan.j.williams@intel.com>
cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] brd: fix overflow in __brd_direct_access
Message-ID: <alpine.LRH.2.02.1709130909570.1354@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

The code in __brd_direct_access multiplies the pgoff variable by page size
and divides it by 512. It can cause overflow on 32-bit architectures. The
overflow happens if we create ramdisk larger than 4G and use it as a
sparse device.

This patch replaces multiplication and division with multiplication by the
number of sectors per page.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 1647b9b959c7 ("brd: add dax_operations support")
Cc: stable@vger.kernel.org	# 4.12+

---
 drivers/block/brd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-4.13/drivers/block/brd.c
===================================================================
--- linux-4.13.orig/drivers/block/brd.c
+++ linux-4.13/drivers/block/brd.c
@@ -339,7 +339,7 @@ static long __brd_direct_access(struct b
 
 	if (!brd)
 		return -ENODEV;
-	page = brd_insert_page(brd, PFN_PHYS(pgoff) / 512);
+	page = brd_insert_page(brd, (sector_t)pgoff << PAGE_SECTORS_SHIFT);
 	if (!page)
 		return -ENOSPC;
 	*kaddr = page_address(page);
