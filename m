Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVIlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 04:41:05 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] lib/crc64.c: add MODULE_LICENSE("GPL")
Date: Tue, 22 May 2018 16:40:58 +0800
Message-Id: <20180522084058.66520-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds MODULE_LICENSE("GPL") to lib/crc64.c to remove a compiling
warninng.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/crc64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/crc64.c b/lib/crc64.c
index ed0ffac7b26a..586e46684ee8 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -135,3 +135,4 @@ uint64_t crc64(const void *data, size_t len)
 EXPORT_SYMBOL_GPL(crc64);
 
 MODULE_DESCRIPTION("CRC64 calculations");
+MODULE_LICENSE("GPL");
-- 
2.16.3
