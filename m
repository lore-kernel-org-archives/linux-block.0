Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750890AbdH3TRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 15:17:21 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.21/8.16.0.21) with SMTP id v7UJGvDR003702
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 12:17:21 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2cnywks06r-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 12:17:21 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH 2/3] block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
Date: Wed, 30 Aug 2017 12:17:17 -0700
Message-ID: <d2ceb45ef504bb78ba19725fc55eff327ff9f3ed.1504120418.git.shli@fb.com>
In-Reply-To: <cover.1504120418.git.shli@fb.com>
References: <cover.1504120418.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

REQ_OP_WRITE_ZEROES really means zero the data. And the in
blkdev_fallocate, FALLOC_FL_ZERO_RANGE will retry but
FALLOC_FL_PUNCH_HOLE not, even loop request doesn't have
BLKDEV_ZERO_NOFALLBACK set.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 054dccc..a30aa45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -430,6 +430,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	int ret;
 
+	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
+		mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+
 	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 
2.9.5
