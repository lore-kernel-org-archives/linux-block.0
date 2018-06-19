Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Tue, 19 Jun 2018 17:27:38 +0300
From: Kitone Elvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: REMOVE CODING STYLE WARNING
Message-ID: <20180619142738.GA12449@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Added a license identifier for this file to remove the malformed
license warning. This will specify which license the file is
using.
---
 block/blk-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index bd365a9..83220b9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block stat tracking code
  *
-- 
2.7.4
