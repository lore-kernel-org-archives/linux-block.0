Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752275AbdJKUW4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2017 16:22:56 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BKI9B3017741
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2017 13:22:56 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2dhr6qrh2v-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2017 13:22:56 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, <Kernel-team@fb.com>
Subject: [PATCH] blk-throttle: allow configure 0 for some settings
Date: Wed, 11 Oct 2017 13:22:08 -0700
Message-ID: <8113e6416a121db19c9c80212c63be960f3a45df.1507753200.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For io.low, latency target 0 is legit. 0 for rbps/wbps/rios/wios is ok
too as long as not all of them are 0.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0fea76a..ee6d7b0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1632,7 +1632,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -ERANGE;
-		if (!val)
+		if (!val && off != LIMIT_LOW)
 			goto out_finish;
 
 		ret = -EINVAL;
-- 
2.9.5
