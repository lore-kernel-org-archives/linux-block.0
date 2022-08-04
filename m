Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304A1C19F2B
	for <linux-block@archiver.kernel.org>; Thu,  4 Aug 2022 08:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiHDINi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHDINi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 04:13:38 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124316555B;
        Thu,  4 Aug 2022 01:13:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VLLUOvo_1659600799;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VLLUOvo_1659600799)
          by smtp.aliyun-inc.com;
          Thu, 04 Aug 2022 16:13:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tim@cyberelk.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] paride:  Clean up some inconsistent indenting
Date:   Thu,  4 Aug 2022 16:13:18 +0800
Message-Id: <20220804081318.92116-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No functional modification involved.

drivers/block/paride/bpck.c:66 bpck_read_regr() warn: inconsistent
indenting.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1822
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/paride/bpck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
index d880a9465e9b..6627b6f43a44 100644
--- a/drivers/block/paride/bpck.c
+++ b/drivers/block/paride/bpck.c
@@ -61,10 +61,10 @@ static int bpck_read_regr( PIA *pi, int cont, int regr )
         	return j44(l,h);
 
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
-- 
2.20.1.7.g153144c

