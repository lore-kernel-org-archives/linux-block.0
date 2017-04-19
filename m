Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60262 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966065AbdDSRjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 13:39:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: assume 64-bit lba numbers
Date: Wed, 19 Apr 2017 19:39:13 +0200
Message-Id: <20170419173931.3902058-1-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The driver uses both u64 and sector_t to refer to offsets, and assigns between the
two. This causes one harmless warning when sector_t is 32-bit:

drivers/lightnvm/pblk-rb.c: In function 'pblk_rb_write_entry_gc':
include/linux/lightnvm.h:215:20: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
drivers/lightnvm/pblk-rb.c:324:22: note: in expansion of macro 'ADDR_EMPTY'

As the driver is already doing this inconsistently, changing the type
won't make it worse and is an easy way to avoid the warning.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/lightnvm/pblk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c82120ce3be5..11ed7d83f572 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -119,7 +119,7 @@ struct pblk_w_ctx {
 	struct bio_list bios;		/* Original bios - used for completion
 					 * in REQ_FUA, REQ_FLUSH case
 					 */
-	sector_t lba;			/* Logic addr. associated with entry */
+	u64 lba;			/* Logic addr. associated with entry */
 	struct ppa_addr ppa;		/* Physic addr. associated with entry */
 	int flags;			/* Write context flags */
 };
-- 
2.9.0
