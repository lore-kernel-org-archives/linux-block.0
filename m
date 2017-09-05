Return-Path: <rdunlap@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] block: fix bio.c kernel-doc notation warning
Message-ID: <187e2dfe-56b9-e112-cd4c-81b279df3528@infradead.org>
Date: Mon, 4 Sep 2017 19:44:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Sphinx treats symbols that end with '_' as some kind of special
documentation indicator, so fix that by adding an ending '*'
to it.

../block/bio.c:404: ERROR: Unknown target name: "gfp".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 block/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-413.orig/block/bio.c
+++ lnx-413/block/bio.c
@@ -400,7 +400,7 @@ static void punt_bios_to_rescuer(struct
 
 /**
  * bio_alloc_bioset - allocate a bio for I/O
- * @gfp_mask:   the GFP_ mask given to the slab allocator
+ * @gfp_mask:   the GFP_* mask given to the slab allocator
  * @nr_iovecs:	number of iovecs to pre-allocate
  * @bs:		the bio_set to allocate from.
  *
