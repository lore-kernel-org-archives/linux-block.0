Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C0C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 23:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2E207F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 23:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzsPSssK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgG2XFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:05:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgG2XFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 19:05:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TN1hQL103700;
        Wed, 29 Jul 2020 23:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=0tbYHrOBWwzcf5HrETLgMCgGqZIQeqATuP8f2eSdIwQ=;
 b=hzsPSssKabaK/pxg7Anbkqd3G/K9GzuPd70OP4heEX3vAdsLgm5xaY4h703NfCvlY8Mh
 QL6hLwD3OLsgrGD+14NQhiod/sIdsXJsdIekI5g/Nb0yC5XKbIjheGoGu5zgzLdPwSuv
 /Yy3G12NhXSzp6vuDpQBMNFTws/mEGsT3Q/PSxAWKIAEPXueRmGb8ixmaxY43svCgOTl
 pfBrtV7yx/1KXtMvJp2pm+ARJkBuDs9F7RvjSPWXx/sh3tKQ006C+vssRJxOetozt8+o
 vK5eSDBa911flkNid3osf1n8vCHytn9AFwnq7m2b2zBrfGwdDuQ41lIFZDPTuHV5NWhm gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jrk3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 23:05:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TN2n1P177380;
        Wed, 29 Jul 2020 23:03:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5wguf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 23:03:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TN3KH6014096;
        Wed, 29 Jul 2020 23:03:21 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 16:03:20 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ritika.srivastava@oracle.com
Subject: [PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not supported
Date:   Wed, 29 Jul 2020 15:47:58 -0700
Message-Id: <1596062878-4238-3-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=1 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290155
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
 block/blk-core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d241ab8..a6ebfeb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1223,10 +1223,24 @@ blk_qc_t submit_bio(struct bio *bio)
 static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
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
+
+		/* If storage does not support the operation,
+		 * the following SCSI error will be returned.
+		 * Illegal Request
+		 * Invalid command operation code
+		 *
+		 * In turn device will set the corresponding queue limit to 0.
+		 *
+		 * If limit is 0, do not return IO error,
+		 * instead return operation not supported.
+		 */
+		if (queue_max_sector == 0)
+			return BLK_STS_NOTSUPP;
 		return BLK_STS_IOERR;
 	}
 
@@ -1253,8 +1267,10 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
-	if (blk_cloned_rq_check_limits(q, rq))
-		return BLK_STS_IOERR;
+	blk_status_t cloned_limit_check = blk_cloned_rq_check_limits(q, rq);
+
+	if (cloned_limit_check != BLK_STS_OK)
+		return cloned_limit_check;
 
 	if (rq->rq_disk &&
 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
-- 
1.8.3.1

