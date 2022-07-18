Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C5C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 06:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiGRGSM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiGRGSD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 02:18:03 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3CE083;
        Sun, 17 Jul 2022 23:18:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJcpb.B_1658125077;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJcpb.B_1658125077)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 14:17:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     axboe@kernel.dk, mingo@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] blktrace: Fix some kernel-doc comments
Date:   Mon, 18 Jul 2022 14:17:55 +0800
Message-Id: <20220718061755.114599-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove warnings found by running scripts/kernel-doc, which is caused by
using 'make W=1'.
kernel/trace/blktrace.c:1884: warning: Function parameter or member 'opf' not described in 'blk_fill_rwbs'
kernel/trace/blktrace.c:1884: warning: Excess function parameter 'op' description in 'blk_fill_rwbs'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 150058f5daa9..5632b6159d88 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1873,7 +1873,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 /**
  * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.
  * @rwbs:	buffer to be filled
- * @op:		REQ_OP_XXX for the tracepoint
+ * @opf:	a combination of a request operation and request flags
  *
  * Description:
  *     Maps the REQ_OP_XXX to character and fills the buffer provided by the
-- 
2.20.1.7.g153144c

