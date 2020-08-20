Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EABC433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E942086A
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHTDyH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:54:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTDyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 23:54:07 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 284B850163286839D6B4;
        Thu, 20 Aug 2020 11:54:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:53:57 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Date:   Thu, 20 Aug 2020 11:53:57 +0800
Message-ID: <20200820035357.1634-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_revalidate_disk translate return error to 0 if it is not a fatal
error, thus avoid false remove namespace. If return error less than 0,
now only ENOMEM be translated to 0, but other error except ENODEV,
such as EAGAIN or EBUSY etc, also need translate to 0.
Another reason for improving the error translation: If request timeout
when connect, __nvme_submit_sync_cmd will return
NVME_SC_HOST_ABORTED_CMD(>0). At this time, should terminate the
connect process, but falsely continue the connect process,
this may cause deadlock. Many functions which call
__nvme_submit_sync_cmd treat error code(> 0) as target not support and
continue, but NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both
are cancled io by host, to fix this bug, we need set the flag:
NVME_REQ_CANCELLED, thus __nvme_submit_sync_cmd will translate return
error to INTR. This is conflict with error translation of
nvme_revalidate_disk, may cause false remove namespace.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..43ac8a1ad65d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2130,10 +2130,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
 	 * Only fail the function if we got a fatal error back from the
 	 * device, otherwise ignore the error and just move on.
 	 */
-	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
-		ret = 0;
-	else if (ret > 0)
+	if (ret > 0 && (ret & NVME_SC_DNR))
 		ret = blk_status_to_errno(nvme_error_status(ret));
+	else if (ret != -ENODEV)
+		ret = 0;
 	return ret;
 }
 
-- 
2.16.4

