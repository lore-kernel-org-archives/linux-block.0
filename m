Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8321FC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E54218D3
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 08:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfBRI2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:28:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbfBRI2y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 03:28:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 345C4E5C08A9B5C0AA2C;
        Mon, 18 Feb 2019 16:28:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 16:28:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-block@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] floppy: remove set but not used variable 'q'
Date:   Mon, 18 Feb 2019 08:42:32 +0000
Message-ID: <20190218084232.193878-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/block/floppy.c: In function 'request_done':
drivers/block/floppy.c:2233:24: warning:
 variable 'q' set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/floppy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 55481b40df9a..95f608d1a098 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2230,7 +2230,6 @@ static void floppy_end_request(struct request *req, blk_status_t error)
 static void request_done(int uptodate)
 {
 	struct request *req = current_req;
-	struct request_queue *q;
 	int block;
 	char msg[sizeof("request done ") + sizeof(int) * 3];
 
@@ -2243,8 +2242,6 @@ static void request_done(int uptodate)
 		return;
 	}
 
-	q = req->q;
-
 	if (uptodate) {
 		/* maintain values for invalidation on geometry
 		 * change */



