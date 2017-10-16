Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbdJPSBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 14:01:02 -0400
To: LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] block: fix Sphinx kernel-doc warning
Message-ID: <a966c745-387b-f36a-8ed3-f613a56f88d2@infradead.org>
Date: Mon, 16 Oct 2017 11:01:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Sphinx treats symbols that end with '_' as a kind of special
documentation indicator, so fix that by adding an ending '*'
to it.

../block/bio.c:404: ERROR: Unknown target name: "gfp".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 block/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414-rc5.orig/block/bio.c
+++ lnx-414-rc5/block/bio.c
@@ -400,7 +400,7 @@ static void punt_bios_to_rescuer(struct
 
 /**
  * bio_alloc_bioset - allocate a bio for I/O
- * @gfp_mask:   the GFP_ mask given to the slab allocator
+ * @gfp_mask:   the GFP_* mask given to the slab allocator
  * @nr_iovecs:	number of iovecs to pre-allocate
  * @bs:		the bio_set to allocate from.
  *
