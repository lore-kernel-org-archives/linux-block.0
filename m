Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34410 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750851AbdH3VvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 17:51:07 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7ULnfX7018895
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 14:51:07 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2cp12g98fn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 14:51:07 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH] block/loop: fix use after free
Date: Wed, 30 Aug 2017 14:51:06 -0700
Message-ID: <e2e2ac0d5f87e79ee9038de9ce709732a7e1ab29.1504129849.git.shli@fb.com>
In-Reply-To: <e1da431a2f961cc0b04241808a31bb58b120fc07.1504129490.git.shli@fb.com>
References: <e1da431a2f961cc0b04241808a31bb58b120fc07.1504129490.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

lo_rw_aio->call_read_iter->
1	aops->direct_IO
2	iov_iter_revert
lo_rw_aio_complete could happen between 1 and 2, the bio and bvec could
be freed before 2, which accesses bvec.

This conflicts with my direcio performance improvement patches, which
I'll resend.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef83349..153ab3c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -490,6 +490,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
 		      bio_segments(bio), blk_rq_bytes(cmd->rq));
+	bio_inc_remaining(bio);
 	/*
 	 * This bio may be started from the middle of the 'bvec'
 	 * because of bio splitting, so offset from the bvec must
@@ -507,6 +508,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
+	bio_endio(bio);
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
 	return 0;
-- 
2.9.5
