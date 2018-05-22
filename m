Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbeEVIyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 04:54:07 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v2] lib/crc64.c: add license information
Date: Tue, 22 May 2018 16:54:00 +0800
Message-Id: <20180522085400.66980-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds MODULE_LICENSE("GPL") to remove a kernel build warning
information. Also as Andy Shevchenko suggested, adds a SPDX header into
lib/crc64.c file.

Signed-off-by: Coly Li <colyli@suse.de>
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/crc64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/crc64.c b/lib/crc64.c
index ed0ffac7b26a..30d1bb58dd5c 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Portions Copyright (c) 1996-2001, PostgreSQL Global Development Group (Any
  * use permitted, subject to terms of PostgreSQL license; see.)
@@ -135,3 +136,4 @@ uint64_t crc64(const void *data, size_t len)
 EXPORT_SYMBOL_GPL(crc64);
 
 MODULE_DESCRIPTION("CRC64 calculations");
+MODULE_LICENSE("GPL");
-- 
2.16.3
