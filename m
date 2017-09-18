Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751343AbdIRUIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2017 16:08:54 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8IK7Yx4019132
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 13:08:54 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2d2mqg01xd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 13:08:54 -0700
From: Dan Melnic <dmm@fb.com>
To: <josef@toxicpanda.com>, <axboe@fb.com>,
        <linux-block@vger.kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH V3] block/ndb: add WQ_UNBOUND to the knbd-recv workqueue
Date: Mon, 18 Sep 2017 13:08:51 -0700
Message-ID: <20170918200851.2478536-1-dmm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add WQ_UNBOUND to the knbd-recv workqueue so we're not bound
to a single CPU that is selected at device creation time.

Signed-off-by: Dan Melnic <dmm@fb.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2aa87cb..f5d8c9a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2080,7 +2080,8 @@ static int __init nbd_init(void)
 	if (nbds_max > 1UL << (MINORBITS - part_shift))
 		return -EINVAL;
 	recv_workqueue = alloc_workqueue("knbd-recv",
-					 WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+					 WQ_MEM_RECLAIM | WQ_HIGHPRI |
+					 WQ_UNBOUND, 0);
 	if (!recv_workqueue)
 		return -ENOMEM;
 
-- 
2.9.5
