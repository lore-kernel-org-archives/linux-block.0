Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:52847 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbdIVKts (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 06:49:48 -0400
Date: Fri, 22 Sep 2017 12:09:54 +0200
From: Wouter Verhelst <w@uter.be>
To: nbd@other.debian.org, jbacik@fb.com, linux-block@vger.kernel.org
Subject: [Nbd] [PATCH] MAINTAINERS: update list for NBD
Message-ID: <20170922100954.2kxokpys5onj32ef@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nbd-general@sourceforge.net becomes nbd@other.debian.org, because
sourceforge is just a spamtrap these days.

Signed-off-by: Wouter Verhelst <w@uter.be>
Reviewed-by: Josef Bacik <jbacik@fb.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fbb269415f06..2f8824995a93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9326,7 +9326,7 @@ NETWORK BLOCK DEVICE (NBD)
 M:	Josef Bacik <jbacik@fb.com>
 S:	Maintained
 L:	linux-block@vger.kernel.org
-L:	nbd-general@lists.sourceforge.net
+L:	nbd@other.debian.org
 F:	Documentation/blockdev/nbd.txt
 F:	drivers/block/nbd.c
 F:	include/uapi/linux/nbd.h
-- 
2.14.1
