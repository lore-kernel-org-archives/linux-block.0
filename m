Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E32C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 09:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD97921736
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 09:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfA1JDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:03:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfA1JDK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 04:03:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EBABC5E712EDAACA04A;
        Mon, 28 Jan 2019 17:03:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 17:03:03 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <osandov@fb.com>
CC:     <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH] floppy: check_events callback should not return a negative number
Date:   Mon, 28 Jan 2019 17:06:46 +0800
Message-ID: <20190128090646.44747-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since .check_events interface return an unsigned int value,
floppy_check_events() should not return a negative error number.
Otherwise, disk_check_events() may process wiht an unexpected path.

fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
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

