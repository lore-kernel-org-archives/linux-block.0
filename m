Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3917C2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E90223977
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLQP7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:59:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbgLQP7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 10:59:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFWljY040456;
        Thu, 17 Dec 2020 10:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=n78Whm+NCnGNz/FkpPeJINVTkqSEep29G2S3vm+pVeQ=;
 b=W4He3yD68s3x1isBJB7PqRh4wfUcZ7L0oXr5N1g7e8dM3Zajztj1+u4TmyXMNVd2M1Ta
 oMBfx4el7+sgqR+j96HDFt0L91mD4YpMriXWNoMOMFpTGY8G1KtJJNbDjIXkoPxt376A
 DmElhhqU27KLp0HZtvmmN5N/Am7je+GCfZ+o6iP+mpRNz+ItMSF7qgbkkE9Xh/IUORXP
 N/eXis53x1JW5wvG1HLodNIHfAjeOvilQ6R9r8ljkVE8Hh7+IpyFKL2ZakFDyxM9am3I
 73fdIwvSx+tm2ugo0PYvpCWMPukBtTzErswxccg+qTYMYT5xoyT8/jyS2oBEmOE0YTi2 /g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35g9k1215c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:59:13 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFqRFh002928;
        Thu, 17 Dec 2020 15:59:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 35fbp5hjrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 15:59:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHFx7Cs36634912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 15:59:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9400742049;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81CE64203F;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 30AB1E02F6; Thu, 17 Dec 2020 16:59:07 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/4] s390/dasd: prevent inconsistent LCU device data
Date:   Thu, 17 Dec 2020 16:59:05 +0100
Message-Id: <20201217155907.36436-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=923
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prevent _lcu_update from adding a device to a pavgroup if the LCU still
requires an update. The data is not reliable any longer and in parallel
devices might have been moved on the lists already.
This might lead to list corruptions or invalid PAV grouping.
Only add devices to a pavgroup if the LCU is up to date. Additional steps
are taken by the scheduled lcu update.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 31e8b5d48e86..f841518de6c5 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -511,6 +511,14 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 		return rc;
 
 	spin_lock_irqsave(&lcu->lock, flags);
+	/*
+	 * there is another update needed skip the remaining handling
+	 * the data might already be outdated
+	 * but especially do not add the device to an LCU with pending
+	 * update
+	 */
+	if (lcu->flags & NEED_UAC_UPDATE)
+		goto out;
 	lcu->pav = NO_PAV;
 	for (i = 0; i < MAX_DEVICES_PER_LCU; ++i) {
 		switch (lcu->uac->unit[i].ua_type) {
@@ -529,6 +537,7 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 				 alias_list) {
 		_add_device_to_lcu(lcu, device, refdev);
 	}
+out:
 	spin_unlock_irqrestore(&lcu->lock, flags);
 	return 0;
 }
-- 
2.17.1

