Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeCOPIc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:32 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 10/16] bcache: Suppress a compiler warning in bch_##name##_h()
Date: Thu, 15 Mar 2018 08:08:08 -0700
Message-Id: <20180315150814.9412-11-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that building with W=1 triggers the following compiler warning:

drivers/md/bcache/util.c: In function 'bch_strtoull_h':
drivers/md/bcache/util.c:70:10: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
       (i < 0 && -ANYSINT_MAX(type) / 1024 > i)) \
          ^

The only functional change in this patch is that (type) ~0 is changed
into ~(type)0. That makes a difference for unsigned types for which
sizeof(type) > sizeof(int). I think this change is a bug fix.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 74febd5230df..755523474649 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -25,6 +25,7 @@ int bch_ ## name ## _h(const char *cp, type *res)		\
 	int u = 0;						\
 	char *e;						\
 	type i = simple_ ## name(cp, &e, 10);			\
+	const type zero = 0;					\
 								\
 	switch (tolower(*e)) {					\
 	default:						\
@@ -63,11 +64,10 @@ int bch_ ## name ## _h(const char *cp, type *res)		\
 		return -EINVAL;					\
 								\
 	while (u--) {						\
-		if ((type) ~0 > 0 &&				\
-		    (type) ~0 / 1024 <= i)			\
+		if (~zero > 0 && ~zero / 1024 <= i)		\
 			return -EINVAL;				\
-		if ((i > 0 && ANYSINT_MAX(type) / 1024 < i) ||	\
-		    (i < 0 && -ANYSINT_MAX(type) / 1024 > i))	\
+		if ((i > zero && ANYSINT_MAX(type) / 1024 < i) ||\
+		    (i < zero && -ANYSINT_MAX(type) / 1024 > i))\
 			return -EINVAL;				\
 		i *= 1024;					\
 	}							\
-- 
2.16.2
