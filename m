Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Fri, 22 Jun 2018 14:33:25 +0300
From: Kitone Elvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] block: Use SPDX License Identifier
Message-ID: <20180622113325.GA6552@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

There is need to identify a license in source code files
for open source software.

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 66cb0f8..4f998ed 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Ram backed block device driver.
  *
-- 
2.7.4
