Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70644C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 05:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CEE206A2
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 05:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ha+Y3KvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeLQFvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:51:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64736 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQFvL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 00:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545025909; x=1576561909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1XpF4terpMKtfzfoWNMvYnKL6nRCz/bXa10U7mub71k=;
  b=Ha+Y3KvXHL8xD+/Lif3VRtSPBqjDSrVKIi1G5zkmORCRHeYTkFbvXS0t
   E2fZTdjTwJLJO3d/IGVqRbeDkpxaFBizObBIgC69rQlprZN4dRy+ySCp1
   N8ftD2l6KpDwgKvIZzT5enjx6Fgwhn5VXFz+pTUH/FGZ+LF76DgGwvTb5
   smgTFizfG4raNc2KwWvB1OI7SctkKQNt2X3uGKSXxfy3PSH8j1Ig/f1nk
   8B1EBAcWlpMswFoDTOklsAxhWi6TxKnhUFdolin2cz/fxB3h1o6uTSK+2
   MQuKcSn23zApRy2FXS8nLYP2DDC6AY92i2FtIQm5HWp+xu1kFuOBsLv/X
   w==;
X-IronPort-AV: E=Sophos;i="5.56,364,1539619200"; 
   d="scan'208";a="194656269"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2018 13:51:48 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 16 Dec 2018 21:33:20 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Dec 2018 21:51:09 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>
Subject: [PATCH blktests] blktests: Fix compilation warning
Date:   Mon, 17 Dec 2018 14:51:08 +0900
Message-Id: <20181217055108.11461-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix strncpy length to "sizeof(buf) - 1" to avoid the compiler warning:
cc  -O2 -Wall -Wshadow  -o sg/syzkaller1 sg/syzkaller1.c
sg/syzkaller1.c: In function ‘syz_open_dev.constprop’:
sg/syzkaller1.c:204:16: warning: ‘strncpy’ specified bound 1024 equals
destination size [-Wstringop-truncation]
     NONFAILING(strncpy(buf, (char*)a0, sizeof(buf)));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sg/syzkaller1.c:143:7: note: in definition of macro ‘NONFAILING’
       __VA_ARGS__;                                                     \
       ^~~~~~~~~~~

Since the last character of buf is forced set to 0, there is no
functional change introduced by this patch.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 src/sg/syzkaller1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sg/syzkaller1.c b/src/sg/syzkaller1.c
index 60bd9a6..743859a 100644
--- a/src/sg/syzkaller1.c
+++ b/src/sg/syzkaller1.c
@@ -201,7 +201,7 @@ static uintptr_t syz_open_dev(uintptr_t a0, uintptr_t a1, uintptr_t a2)
   } else {
     char buf[1024];
     char* hash;
-    NONFAILING(strncpy(buf, (char*)a0, sizeof(buf)));
+    NONFAILING(strncpy(buf, (char*)a0, sizeof(buf) - 1));
     buf[sizeof(buf) - 1] = 0;
     while ((hash = strchr(buf, '#'))) {
       *hash = '0' + (char)(a1 % 10);
-- 
2.19.2

