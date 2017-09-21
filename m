Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49413 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751629AbdIUTRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 15:17:19 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8LJ7mHc013033
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 12:17:19 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2d4g4q0xdw-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 12:17:19 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <Kernel-team@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>
Subject: [PATCH] block: fix a crash caused by wrong API
Date: Thu, 21 Sep 2017 12:17:16 -0700
Message-ID: <bbf02e9095a5e8d5d71c7001881aa6d5c765bda2.1506021255.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

part_stat_show takes a part device not a disk, so we should use
part_to_disk.

Fix: d62e26b3ffd2(block: pass in queue to inflight accounting)
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 86e8fe1..88c555d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -112,7 +112,7 @@ ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	struct request_queue *q = dev_to_disk(dev)->queue;
+	struct request_queue *q = part_to_disk(p)->queue;
 	unsigned int inflight[2];
 	int cpu;
 
-- 
2.9.5
