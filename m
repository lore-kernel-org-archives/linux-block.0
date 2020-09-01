Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7EC433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AC8208DB
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gCFFbBRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIAUdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:33:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIAUda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 16:33:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KTh67124032;
        Tue, 1 Sep 2020 20:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=P+tHuN2j7ySHCLrFBcgTXmWcfEmvY0ARBZ773+JVuL0=;
 b=gCFFbBRzAPYjsD7aEnl7FrtBeSxafto3yuhA3iWtR96zq7hWeOuLeDocpx5/KQAdPuab
 gzqNaKmh7jSfkwChJD4rF67KSvJDWjI/dp3vX0QdWK00PDx6pkETr2+49MXe9mXlFCIu
 pRKwxwpNYjenF8xLoUAvQAo9ODQ4uIXzMNHDpZt8TW4bGt45ayk9ksbTj2SeTGZ06Ny/
 Vm8Tqr+AAVQ39qYcTKgAVsUQpwsIc3wjzBL/gCSnQEf2OvUr4ufTepEyz7R5kqlJ+3SN
 1xCqXeXaYy1MY1Uoz0j9qMWPeH0XX4EF5zHRVl9b/f5NQiPuLEGnaCkPXyT/1ykK/Tej /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmmw73k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 20:33:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KV1cw152682;
        Tue, 1 Sep 2020 20:33:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380ssh10m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 20:33:27 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081KXQNN008814;
        Tue, 1 Sep 2020 20:33:26 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 13:33:25 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ritika.srivastava@oracle.com
Subject: [PATCH 1/2] block: Return blk_status_t instead of errno codes
Date:   Tue,  1 Sep 2020 13:17:30 -0700
Message-Id: <1598991451-9655-2-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
References: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010174
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace returning legacy errno codes with blk_status_t in
blk_cloned_rq_check_limits().

Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1028c34..4c1af34 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1144,14 +1144,14 @@ blk_qc_t submit_bio(struct bio *bio)
  *    limits when retrying requests on other queues. Those requests need
  *    to be checked against the new queue limits again during dispatch.
  */
-static int blk_cloned_rq_check_limits(struct request_queue *q,
+static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
 	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
 			__func__, blk_rq_sectors(rq),
 			blk_queue_get_max_sectors(q, req_op(rq)));
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
 
 	/*
@@ -1164,10 +1164,10 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
 		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
 			__func__, rq->nr_phys_segments, queue_max_segments(q));
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
 
-	return 0;
+	return BLK_STS_OK;
 }
 
 /**
-- 
1.8.3.1

