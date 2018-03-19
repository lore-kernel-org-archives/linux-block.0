Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43680 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbeCSAg6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id f23-v6so9219243plr.10
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:58 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 15/20] bcache: Annotate switch fall-through
Date: Sun, 18 Mar 2018 17:36:28 -0700
Message-Id: <20180319003633.27225-16-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

This patch avoids that building with W=1 triggers complaints about
switch fall-throughs.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
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
2.14.1
