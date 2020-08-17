Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CAEC433DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1992072E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEP6Bdpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHQVrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:47:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50016 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgHQVrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 17:47:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HLgAfk037035;
        Mon, 17 Aug 2020 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=eGF5gZpPSLrm1QOo1tikDPVxCmgxjscLD/IBq8LeXcw=;
 b=FEP6Bdpkps3E4Oy6yn66ECHYPAW6WYrmhA4HreMMv6b3OSBu0VQbFqLq/CWzinbarH7Y
 LOyY8fRnfRVM5DQmJ375bD+yebBTZW8XfxEA6CJmzdpGh3OJcDTUCooaqUovXa5b5+oo
 OkOt22SbClqJFEFc2vTryyvEzRecIoe45LqlVaSlw+TQLDr3Kv+SJSRuP3CXPZ7n/pmR
 4LKfSnYA2ddoqKMhODo1U3damYs/wXE+8XCkbGGQUGKV8PfGWvwKg4el6xuaXcUy5bQS
 7SfdhNk5NQWYlJI0hBOqVici6x5rg7HdW46TQxG+YQPVV234c4eNXoVYEHLghIL0lbpI 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32x74r1e4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 21:47:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07HLi7w4093155;
        Mon, 17 Aug 2020 21:47:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32xs9m8h4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 21:47:00 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07HLl0YW008209;
        Mon, 17 Aug 2020 21:47:00 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 14:46:59 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org, hch@infradead.org
Cc:     axboe@kernel.dk, ritika.srivastava@oracle.com
Subject: [PATCH v3 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
Date:   Mon, 17 Aug 2020 14:31:38 -0700
Message-Id: <1597699898-21157-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170147
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
---
Changelog:
v3: Formatting changes and subject updated from previous version
    -block: return BLK_STS_NOTSUPP if operation is not supported
v2: Document scenario and SCSI error encountered in a comment in
    blk_cloned_rq_check_limits().
---
 block/blk-core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d241ab8..ea6eae5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1223,10 +1223,21 @@ blk_qc_t submit_bio(struct bio *bio)
 static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+
+	if (blk_rq_sectors(rq) > max_sectors) {
+		/*
+		 * At least SCSI device does not have a good way to return if
+		 * Write Same/Zero is actually supported. To detect this, first
+		 * try to issue one and if it fails clear the max sectors value.
+		 * If this occurs on the lower device, the right error code
+		 * needs to be propagated to upper layers.
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
 
@@ -1253,8 +1264,11 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
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

