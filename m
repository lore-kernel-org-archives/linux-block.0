Return-Path: <SRS0=qKaS=BD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C28C433DF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF4920674
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AKpxBSKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGXQso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:48:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60208 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jul 2020 12:48:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGVt58099130;
        Fri, 24 Jul 2020 16:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=8jDaDjjGEgb8b9pwjImoVbxzSY6YeuKGwEYJvT3kk2E=;
 b=AKpxBSKNRh87CQZDrJNEbCCT6i9qgnywvTgsfUnJk95f3Tv9SLyDBc4N1xRmkCrPwWYW
 PLaK3WWEKdUh/yOPWZj/ynioQKSaDVDNDFwsd5hLjU2HtxibMy2PfH5Msik0DyoO17hx
 s5jBJxP6kAc4KrRodAG2ktd4meuBtDOOA7gtS5cEsJRgIb2c2adDSsyGwrKF6kh2ft0r
 R7SApzdJokb70fN0ts+69qexwYs4O0iiVUvlMa5oOdtjoGzucHC1LC7LmaygMAbClac5
 KYszH6wm/CfT0z16AOl+PitTYuwVZCcSXuIqkQt3tRD6rIreKzDGmvzIGNzyZ/W/oysO VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1n04ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 16:48:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGWTHT159479;
        Fri, 24 Jul 2020 16:48:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32fsr7m7cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 16:48:40 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OGmdMd012483;
        Fri, 24 Jul 2020 16:48:39 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 16:48:39 +0000
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ritika.srivastava@oracle.com
Subject: [PATCH 1/1] block: return BLK_STS_NOTSUPP if operation is not supported
Date:   Fri, 24 Jul 2020 09:33:22 -0700
Message-Id: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240128
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
blk_cloned_rq_check_limits() will return -EIO which will cause
device-mapper to fail the paths.

Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
paths.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
---
 block/blk-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9bfaee0..173bb04 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1223,10 +1223,13 @@ blk_qc_t submit_bio(struct bio *bio)
 static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	unsigned int queue_max_sector = blk_queue_get_max_sectors(q, req_op(rq));
+
+	if (blk_rq_sectors(rq) > queue_max_sector) {
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
-			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			__func__, blk_rq_sectors(rq), queue_max_sector);
+		if (queue_max_sector == 0)
+			return -EOPNOTSUPP;
 		return -EIO;
 	}
 
@@ -1253,7 +1256,11 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
-	if (blk_cloned_rq_check_limits(q, rq))
+	int cloned_limit_check = blk_cloned_rq_check_limits(q, rq);
+
+	if (cloned_limit_check == -EOPNOTSUPP)
+		return BLK_STS_NOTSUPP;
+	else if (cloned_limit_check)
 		return BLK_STS_IOERR;
 
 	if (rq->rq_disk &&
-- 
1.8.3.1

