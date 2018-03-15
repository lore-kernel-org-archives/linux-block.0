Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeCOPI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 03/16] bcache: Annotate switch fall-through
Date: Thu, 15 Mar 2018 08:08:01 -0700
Message-Id: <20180315150814.9412-4-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch avoids that building with W=1 triggers complaints about
switch fall-throughs.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index a23cd6a14b74..6198041f0ee2 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -32,20 +32,27 @@ int bch_ ## name ## _h(const char *cp, type *res)		\
 	case 'y':						\
 	case 'z':						\
 		u++;						\
+		/* fall through */				\
 	case 'e':						\
 		u++;						\
+		/* fall through */				\
 	case 'p':						\
 		u++;						\
+		/* fall through */				\
 	case 't':						\
 		u++;						\
+		/* fall through */				\
 	case 'g':						\
 		u++;						\
+		/* fall through */				\
 	case 'm':						\
 		u++;						\
+		/* fall through */				\
 	case 'k':						\
 		u++;						\
 		if (e++ == cp)					\
 			return -EINVAL;				\
+		/* fall through */				\
 	case '\n':						\
 	case '\0':						\
 		if (*e == '\n')					\
-- 
2.16.2
