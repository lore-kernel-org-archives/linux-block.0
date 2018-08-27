Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
References: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/3] drivers/block/z2ram: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date: Mon, 27 Aug 2018 16:10:25 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: no change

 drivers/block/z2ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index d0c5bc4e0703..cfbd70520eeb 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 			vfree(vmalloc (size));
 		}
 
-		vaddr = (unsigned long) __ioremap (paddr, size, 
-						   _PAGE_WRITETHRU);
+		vaddr = (unsigned long)ioremap_wt(paddr, size);
 
 #else
 		vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);
-- 
2.13.3
