Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D7ECAAD5
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 06:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiIEGes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 02:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiIEGeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 02:34:19 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6993CBDE;
        Sun,  4 Sep 2022 23:33:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VOMk2nI_1662359576;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VOMk2nI_1662359576)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 14:33:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] block/blk-map: Remove set but unused variable 'added'
Date:   Mon,  5 Sep 2022 14:32:53 +0800
Message-Id: <20220905063253.120082-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The variable added is not effectively used in the function, so delete
it.

block/blk-map.c:273:16: warning: variable 'added' set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2049
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Remove offs initialization.

 block/blk-map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 2fbe298d3822..8d1e84b04b4a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -270,7 +270,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;
-		size_t offs, added = 0;
+		size_t offs;
 		int npages;
 
 		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
@@ -306,7 +306,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					break;
 				}
 
-				added += n;
 				bytes -= n;
 				offs = 0;
 			}
-- 
2.20.1.7.g153144c

