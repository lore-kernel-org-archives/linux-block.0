Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751194AbdH1Utd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 16:49:33 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7SKipow025954
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2017 13:49:32 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2cmsfcg8xf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2017 13:49:32 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.99) with ESMTP id
 64453bbe8c3211e7b40b0002c99293a0-cef20150 for <linux-block@vger.kernel.org>;
        Mon, 28 Aug 2017 13:49:31 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <dan.carpenter@oracle.com>, <axboe@kernel.dk>
Subject: [PATCH] block/nullb: delete unnecessary memory free
Date: Mon, 28 Aug 2017 13:49:31 -0700
Message-ID: <9df1970109b84fc170530a5ffa5c07e4480e445f.1503953204.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 2984c86(nullb: factor disk parameters) has a typo. The
nullb_device allocation/free is done outside of null_add_dev. The commit
accidentally frees the nullb_device in error code path.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/null_blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 4d328e3..18f2cb3 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1909,7 +1909,6 @@ static int null_add_dev(struct nullb_device *dev)
 out_free_nullb:
 	kfree(nullb);
 out:
-	null_free_dev(dev);
 	return rv;
 }
 
-- 
2.9.5
