Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27456C433F5
	for <linux-block@archiver.kernel.org>; Sat, 25 Dec 2021 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhLYRHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Dec 2021 12:07:14 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46347 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhLYRHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Dec 2021 12:07:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.jHh7P_1640452026;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V.jHh7P_1640452026)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Dec 2021 01:07:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tim@cyberelk.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] paride: clean up some inconsistent indenting
Date:   Sun, 26 Dec 2021 01:07:04 +0800
Message-Id: <20211225170704.113893-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Eliminate the follow smatch warning:

drivers/block/paride/bpck.c:66 bpck_read_regr() warn: inconsistent
indenting.

drivers/block/paride/bpck.c:294 bpck_test_proto() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/paride/bpck.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
index d880a9465e9b..e7f97620fb63 100644
--- a/drivers/block/paride/bpck.c
+++ b/drivers/block/paride/bpck.c
@@ -55,16 +55,16 @@ static int bpck_read_regr( PIA *pi, int cont, int regr )
 	switch (pi->mode) {
 
 	case 0: w0(r & 0xf); w0(r); t2(2); t2(4);
-	        l = r1();
-        	t2(4);
-        	h = r1();
-        	return j44(l,h);
+		l = r1();
+		t2(4);
+		h = r1();
+		return j44(l, h);
 
 	case 1: w0(r & 0xf); w0(r); t2(2);
-	        e2(); t2(0x20);
+		e2(); t2(0x20);
 		t2(4); h = r0();
-	        t2(1); t2(0x20);
-	        return h;
+		t2(1); t2(0x20);
+		return h;
 
 	case 2:
 	case 3:
@@ -289,9 +289,9 @@ static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
 		WR(0x13,0x7f);
 		w0(0x13); t2(2);
 		for(i=0;i<TEST_LEN;i++) {
-                    t2(4); l = r1();
-                    t2(4); h = r1();
-                    buf[i] = j44(l,h);
+		    t2(4); l = r1();
+		    t2(4); h = r1();
+		    buf[i] = j44(l, h);
 		}
 		bpck_disconnect(pi);
 		break;
-- 
2.20.1.7.g153144c

