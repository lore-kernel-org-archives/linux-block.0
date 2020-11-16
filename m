Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F98C4742C
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9302137B
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kzxlj6PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgKPPX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:23:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65316 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731076AbgKPPXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 10:23:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGF2GMc069605;
        Mon, 16 Nov 2020 10:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=vmWvqyPa32egfvLsYHMf20Ksa7fxt82DzQw8DVSIJgo=;
 b=Kzxlj6PIZ+gwFfHneyKUKb8If9pThNMbz4nu+3D0Jg1YTtAlWoDsYjP17oHsiU/2wzcJ
 Cv0H6J5ckJVOXyAhFZepHVicq0QSYT4Eqccec94zCmkfH87Dk5tnXUBhxfLw4qnIdKe0
 PeFpwKyHLSFAgULt/NeQC/AZqX4WW3hazI2GcHjU1L/Xbpxis7JqG0QBxXhdCpyXMBNh
 ZEHvozJVxC4ZeGT/bK81g1ZHYa1Ix0j7gvxlJKeJOctSFDNg5zgno6LPdG6MDd0YbUbh
 Ot1ZNS4ya2rZUG9UMY6MysVevci15J2ii/C2F9JE4lh7rly1rotxJER2wSY095AVTTPu KA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34unuaastp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 10:23:53 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AGFGuRU011359;
        Mon, 16 Nov 2020 15:23:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8a83w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 15:23:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AGFNn9K19399012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 15:23:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 101C55207B;
        Mon, 16 Nov 2020 15:23:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0735F52063;
        Mon, 16 Nov 2020 15:23:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9F720E039B; Mon, 16 Nov 2020 16:23:47 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix null pointer dereference for ERP requests
Date:   Mon, 16 Nov 2020 16:23:47 +0100
Message-Id: <20201116152347.61093-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116152347.61093-1-sth@linux.ibm.com>
References: <20201116152347.61093-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_08:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160089
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When requeueing all requests on the device request queue to the blocklayer
we might get to an ERP (error recovery) request that is a copy of an
original CQR.

Those requests do not have blocklayer request information or a pointer to
the dasd_queue set. When trying to access those data it will lead to a
null pointer dereference in dasd_requeue_all_requests().

Fix by checking if the request is an ERP request that can simply be
ignored. The blocklayer request will be requeued by the original CQR that
is on the device queue right behind the ERP request.

Fixes: 9487cfd3430d ("s390/dasd: fix handling of internal requests")

Cc: <stable@vger.kernel.org> #4.16
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c..217a7b84abdf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2980,6 +2980,12 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 
 	if (!block)
 		return -EINVAL;
+	/*
+	 * If the request is an ERP request there is nothing to requeue.
+	 * This will be done with the remaining original request.
+	 */
+	if (cqr->refers)
+		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, false);
-- 
2.17.1

