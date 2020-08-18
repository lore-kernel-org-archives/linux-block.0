Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B4C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CC82080C
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bEm1IP/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRRzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:55:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRRzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 13:55:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHr3l8033796;
        Tue, 18 Aug 2020 17:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=/FwaGN+wrydZZfTNsKFAkl2WnvJ4DlMNQaGHrGo2l7Q=;
 b=bEm1IP/ttrAkBqk/8coCDkmUE3dKIi8WXTGShbxelKwoSPonM0+Ck2aWUScOQt5+eG7J
 6MlWD0o3u59qKAvA8x0MeF3HkO/7CTxPrnzTk9c7qImdx1+AVGs2oaoxzDr8kKw9Fc+l
 keyARJ9auEfHlHpHVRkZtyzdJ18b16bNGZVZJQ5d5EHMYKQRpV1/aKasPdUHASW7KQen
 N49oEBxLNSo7VoUL/Gi+OWhHPZZGIm6ZXheHdnG029GdysEgG04pfRhRUx1xyh1v2UHG
 tFrA6jRU2voL6LIb/6bI2O3xa5gMtbXgG/v7GaJdUgN3AjqAD1sSn5DuReEKz5lixxR1 hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32x8bn69cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 17:55:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IHlmtd073275;
        Tue, 18 Aug 2020 17:55:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32xsm3egcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 17:55:05 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IHt4OE017638;
        Tue, 18 Aug 2020 17:55:04 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 10:55:04 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     martin.petersen@oracle.com, hch@infradead.org,
        ritika.srivastava@oracle.com
Subject: [PATCH v4 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
Date:   Tue, 18 Aug 2020 10:39:40 -0700
Message-Id: <1597772380-3034-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
blk_cloned_rq_check_limits() will return IO error which will cause
device-mapper to fail the paths.

Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
paths.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
Changelog:
v4: Explain the window of error in the comments.
    Add reviewed-by tag from Martin
v3: Formatting changes and subject updated from previous version
    -block: return BLK_STS_NOTSUPP if operation is not supported
v2: Document scenario and SCSI error encountered in a comment in
    blk_cloned_rq_check_limits().
---
 block/blk-core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d241ab8..43401d3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1223,10 +1223,24 @@ blk_qc_t submit_bio(struct bio *bio)
 static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+
+	if (blk_rq_sectors(rq) > max_sectors) {
+		/*
+		 * SCSI device does not have a good way to return if
+		 * Write Same/Zero is actually supported. If a device rejects
+		 * a non-read/write command (discard, write same,etc.) the
+		 * low-level device driver will set the relevant queue limit to
+		 * 0 to prevent blk-lib from issuing more of the offending
+		 * operations. Commands queued prior to the queue limit being
+		 * reset need to be completed with BLK_STS_NOTSUPP to avoid I/O
+		 * errors being propagated to upper layers.
+		 */
+		if (max_sectors == 0)
+			return BLK_STS_NOTSUPP;
+
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
-			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			__func__, blk_rq_sectors(rq), max_sectors);
 		return BLK_STS_IOERR;
 	}
 
@@ -1253,8 +1267,11 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
-	if (blk_cloned_rq_check_limits(q, rq))
-		return BLK_STS_IOERR;
+	blk_status_t ret;
+
+	ret = blk_cloned_rq_check_limits(q, rq);
+	if (ret != BLK_STS_OK)
+		return ret;
 
 	if (rq->rq_disk &&
 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
-- 
1.8.3.1

