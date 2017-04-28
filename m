Return-Path: <ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: bfq: Add Paolo as maintainer for the BFQ I/O scheduler
Date: Fri, 28 Apr 2017 12:10:36 +0200
Message-Id: <1493374236-26221-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Seems like this was forgotten in the bfq-series from Paolo. Let's do it now
so people don't miss out involving Paolo for any future changes or when
reporting bugs.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38d3e4e..1bb06c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2544,6 +2544,14 @@ F:	block/
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
+BFQ I/O SCHEDULER
+M:	Paolo Valente <paolo.valente@linaro.org>
+M:	Jens Axboe <axboe@kernel.dk>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	block/bfq-*
+F:	Documentation/block/bfq-iosched.txt
+
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.7.4
