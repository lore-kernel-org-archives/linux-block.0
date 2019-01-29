Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972BC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49A02177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfA2Ia3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:30:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfA2Ia3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:30:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFA94A4AEC4721849EF6;
        Tue, 29 Jan 2019 16:30:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 16:30:22 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <dan.carpenter@oracle.com>
CC:     <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH v2] floppy: check_events callback should not return a negative number
Date:   Tue, 29 Jan 2019 16:34:04 +0800
Message-ID: <20190129083404.47318-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

floppy_check_events() is supposed to return bit flags to say which
events occured. We should return zero to say that no event flags are
set.  Only BIT(0) and BIT(1) are used in the caller. And .check_events
interface also expect to return an unsigned int value.

However, after commit a0c80efe5956, it may return -EINTR (-4u).
Here, both BIT(0) and BIT(1) are cleared. So this patch shouldn't
affect runtime, but it obviously is still worth fixing.

Fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6f2856c6d0f2..55481b40df9a 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4075,7 +4075,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (lock_fdc(drive))
-			return -EINTR;
+			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
-- 
2.16.2.dirty

