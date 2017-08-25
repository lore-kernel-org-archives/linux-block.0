Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932836AbdHYUq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 16:46:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7PKigUe022393
        for <linux-block@vger.kernel.org>; Fri, 25 Aug 2017 13:46:26 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2cjt8107rn-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 25 Aug 2017 13:46:26 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 76124fe889d611e7985e0002c9dfb610-1b189150 for <linux-block@vger.kernel.org>;
        Fri, 25 Aug 2017 13:46:25 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <dan.carpenter@oracle.com>, <axboe@kernel.dk>
Subject: [PATCH] block/nullb: fix NULL deference
Date: Fri, 25 Aug 2017 13:46:25 -0700
Message-ID: <b70eb4a71a01a72a75f2f1efb1fadc4ef77fc7ff.1503693884.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dan reported this:

The patch 2984c8684f96: "nullb: factor disk parameters" from Aug 14,
2017, leads to the following Smatch complaint:

drivers/block/null_blk.c:1759 null_init_tag_set()
	 error: we previously assumed 'nullb' could be null (see line
1750)

  1755		set->cmd_size	= sizeof(struct nullb_cmd);
  1756		set->flags = BLK_MQ_F_SHOULD_MERGE;
  1757		set->driver_data = NULL;
  1758
  1759		if (nullb->dev->blocking)
                    ^^^^^^^^^^^^^^^^^^^^
And an unchecked dereference.

nullb could be NULL here.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/null_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 2032360..4d328e3 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1756,7 +1756,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	set->driver_data = NULL;
 
-	if (nullb->dev->blocking)
+	if ((nullb && nullb->dev->blocking) || g_blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 
 	return blk_mq_alloc_tag_set(set);
-- 
2.9.5
