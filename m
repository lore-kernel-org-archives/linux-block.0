Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6170BC2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C47B239CF
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQQC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:02:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgLQQCZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:02:25 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFXU0L094712;
        Thu, 17 Dec 2020 11:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=kvtkeYjiDUlIWNTcAsIHNC5mPc3XkAtxft1jxP7pxhM=;
 b=mdfTMtbIiBfEo+WOHIJiNYhmfrQNlyBXdOKAeXa9fCa0+ZdSxvWB3FqZHR2CcEZfDCmT
 g9wZ8FzMD4Sm/M80yEbC6pnewTE2lvYcTBc8L2o0hdtEfvuSN0Dt7DMew8DKGJwURtXl
 tS3W7Lav95e8yyYjc4mJ00qmK3Qr5UFe2OWSW5BBof/3QN+Oq08Q9nXSICADtHe6sg0V
 dM4GL7gqnYZbeCiCidBKAfu7O0wV3oOM889hBcPIs3uQPjfSN0ubT7968NleSSI+n4OR
 ffsimQTtoUeYmN5cfaDWqQQziU4gWmC5LLodrJG3dnfps7Bmjx7+QCzjyyVdGJq5AALM Ww== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35g8mv46na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 11:01:44 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFrBuR023407;
        Thu, 17 Dec 2020 16:01:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8g65c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 16:01:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHFx7xH37618022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 15:59:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9852EAE057;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 839A8AE051;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2DF02E01E6; Thu, 17 Dec 2020 16:59:07 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/4] s390/dasd: fix hanging device offline processing
Date:   Thu, 17 Dec 2020 16:59:04 +0100
Message-Id: <20201217155907.36436-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For an LCU update a read unit address configuration IO is required.
This is started using sleep_on(), which has early exit paths in case the
device is not usable for IO. For example when it is in offline processing.

In those cases the LCU update should fail and not be retried.
Therefore lcu_update_work checks if EOPNOTSUPP is returned or not.

Commit 47825e05d93e ("s390/dasd: fix endless loop after read unit address configuration")
accidentally removed the EOPNOTSUPP return code from
read_unit_address_configuration(), which in turn might lead to an endless
loop of the LCU update in offline processing.

Fix by returning EOPNOTSUPP again if the device is not able to perform the
request.

Fixes: 47825e05d93e ("s390/dasd: fix endless loop after read unit address configuration")
Cc: stable@vger.kernel.org #5.3
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 99f86612f775..31e8b5d48e86 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -462,11 +462,19 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	spin_unlock_irqrestore(&lcu->lock, flags);
 
 	rc = dasd_sleep_on(cqr);
-	if (rc && !suborder_not_supported(cqr)) {
+	if (!rc)
+		goto out;
+
+	if (suborder_not_supported(cqr)) {
+		/* suborder not supported or device unusable for IO */
+		rc = -EOPNOTSUPP;
+	} else {
+		/* IO failed but should be retried */
 		spin_lock_irqsave(&lcu->lock, flags);
 		lcu->flags |= NEED_UAC_UPDATE;
 		spin_unlock_irqrestore(&lcu->lock, flags);
 	}
+out:
 	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
-- 
2.17.1

