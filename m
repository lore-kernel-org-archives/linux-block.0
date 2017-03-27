Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 03/18] blk-throttle: add configure option for new .low interface
Date: Mon, 27 Mar 2017 10:51:31 -0700
Message-ID: <e3d3888887f9c89e32314961a0e06434b4c79944.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

As discussed in LSF, add configure option for the interface and mark it
as experimental, so people can try/test.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index e9f780f..89cd28f 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -115,6 +115,18 @@ config BLK_DEV_THROTTLING
 
 	See Documentation/cgroups/blkio-controller.txt for more information.
 
+config BLK_DEV_THROTTLING_LOW
+	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
+	depends on BLK_DEV_THROTTLING
+	default n
+	---help---
+	Add .low limit interface for block throttling. The low limit is a best
+	effort limit to prioritize cgroups. Depending on the setting, the limit
+	can be used to protect cgroups in terms of bandwidth/iops and better
+	utilize disk resource.
+
+	Note, this is an experimental interface and could be changed someday.
+
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
 	default n
-- 
2.9.3
