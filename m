Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 1/5] block: fix MAINTAINERS email for nbd
Date: Wed, 16 May 2018 14:36:01 -0400
Message-Id: <20180516183605.16159-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

I've been missing stuff because it's been going into my work email which
is a black hole.  Update to the email I actually use so I stop missing
patches and bug reports.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb2559a..10eca48b11b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9700,7 +9700,7 @@ S:	Maintained
 F:	drivers/net/ethernet/netronome/
 
 NETWORK BLOCK DEVICE (NBD)
-M:	Josef Bacik <jbacik@fb.com>
+M:	Josef Bacik <josef@toxicpanda.com>
 S:	Maintained
 L:	linux-block@vger.kernel.org
 L:	nbd@other.debian.org
-- 
2.14.3
