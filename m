Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0357DC433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5368207D3
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9rauWSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgIAUdc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:33:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIAUd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 16:33:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KTGlK002581;
        Tue, 1 Sep 2020 20:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=dAL9PNUovTNojWTLyzYl4b7bJaoVwchTfDBmdqsutYM=;
 b=H9rauWSRbc2xh9fkTLl/Dk/bHCNKNnOuh+JnPTRf3WAo4bef14Tobi2Zl/hs8aakZzdS
 iwMjfrvEOJLdw7xDeLLRj/LdTLuAYi4lIqBKGiDGuiSiAlFD/wIAI/S0w5utCZwsRHwc
 c/MYBS2x8O1mMt8kxulSI7T2Axf5HnOSqnIKPqPtFhrHYnjIz1anA0JLcvWONXd7DF4d
 /rzjnevuu8tgr9OU//j9k/ROIUUetlWLNrEUxhg8t0EOQmyEIRm8bb6ZJGbERKJbvZPU
 ch+MegRqvKrF3ufvDyPsCzgy+LsEJIDDRN16TZQCtxVwrEOorjk03QZwlqygV/9/dttB Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eeqxsfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 20:33:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KVC19030728;
        Tue, 1 Sep 2020 20:33:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380knuafv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 20:33:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081KXQLE003306;
        Tue, 1 Sep 2020 20:33:26 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 13:33:26 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ritika.srivastava@oracle.com
Subject: [PATCH v4 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
Date:   Tue,  1 Sep 2020 13:17:31 -0700
Message-Id: <1598991451-9655-3-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
References: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010174
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 4c1af34..d857344 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1147,10 +1147,24 @@ blk_qc_t submit_bio(struct bio *bio)
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
 
@@ -1177,8 +1191,11 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
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

