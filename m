Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50283 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424312AbcKANkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/16] arm, arm64: don't include blk_types.h in <asm/io.h>
Date: Tue,  1 Nov 2016 07:40:14 -0600
Message-Id: <1478007617-18715-14-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need for it - we only use struct bio_vec in prototypes and already have
forward declarations for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/io.h   | 1 -
 arch/arm64/include/asm/io.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 021692c..42871fb 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -25,7 +25,6 @@
 
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/blk_types.h>
 #include <asm/byteorder.h>
 #include <asm/memory.h>
 #include <asm-generic/pci_iomap.h>
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0bba427..0c00c87 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -22,7 +22,6 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
-#include <linux/blk_types.h>
 
 #include <asm/byteorder.h>
 #include <asm/barrier.h>
-- 
2.1.4

