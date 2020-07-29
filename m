Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D156C433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 23:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16365207E8
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 23:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uTUSawaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG2XDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:03:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG2XDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 19:03:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TN1vC4103750;
        Wed, 29 Jul 2020 23:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=0NlWs2ClWwYLlXtdJTNwxEJ2TIt1gX6RNuBQ46Mfrt0=;
 b=uTUSawaJpR5nqzhEt5g6kjSXErfB6k/3NGUqW5Czj/7XP4KO3pZQzKrrsSRBImM3PN/a
 eawedBUdJu7mWZKQMbb1krOtqYRGE5QC8RGHkLsUYC5fhhTaaKojoav459nwQcF7pi9z
 2YIjvsFcjLHcErRCNNEjR82RHjewR3KLr58/1AZZLhLe8PzupNCnbptf+AfWTN1LyLZ8
 aQb0uKf3mH3WNtMf9RAwwlpDSSgRudAKAsRwk5tyJZiGp+/JaMPmllKqbJyRp4LacuIh
 BTTdylT46ux8HzRH2bfN3sSHbvLtj3DoBg4TgCE5F28Zrq6tAQ3+qyOS/nlC/wV6uEAy vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jrjv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 23:03:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TMqdbE190837;
        Wed, 29 Jul 2020 23:03:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32hu5vqxs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 23:03:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TN3KNM023293;
        Wed, 29 Jul 2020 23:03:20 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 16:03:20 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ritika.srivastava@oracle.com
Subject: [PATCH 1/2] block: Return blk_status_t instead of errno codes
Date:   Wed, 29 Jul 2020 15:47:57 -0700
Message-Id: <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290154
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

Replace returning legacy errno codes with blk_status_t in
blk_cloned_rq_check_limits().

Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
---
 block/blk-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9bfaee0..d241ab8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1220,14 +1220,14 @@ blk_qc_t submit_bio(struct bio *bio)
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
@@ -1240,10 +1240,10 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
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

