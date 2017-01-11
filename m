Return-Path: <prvs=21847f6d31=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd-general@lists.sourceforge.net>, <kernel-team@fb.com>
Subject: [PATCH] MAINTAINERS: Update maintainer entry for NBD
Date: Wed, 11 Jan 2017 15:41:40 -0500
Message-ID: <1484167300-23220-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The old maintainers email is bouncing and I've rewritten most of this
driver in the recent months.  Also add linux-block to the mailinglist
and remove the old tree, I will send patches through the linux-block
tree.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1174508..4c07e01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8539,10 +8539,10 @@ S:	Maintained
 F:	drivers/net/ethernet/netronome/
 
 NETWORK BLOCK DEVICE (NBD)
-M:	Markus Pargmann <mpa@pengutronix.de>
+M:	Josef Bacik <jbacik@fb.com>
 S:	Maintained
+L:	linux-block@vger.kernel.org
 L:	nbd-general@lists.sourceforge.net
-T:	git git://git.pengutronix.de/git/mpa/linux-nbd.git
 F:	Documentation/blockdev/nbd.txt
 F:	drivers/block/nbd.c
 F:	include/uapi/linux/nbd.h
-- 
2.5.5
