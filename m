Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2844C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CF92064A
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfHALGi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:06:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729084AbfHALGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Aug 2019 07:06:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71B3R0a046597
        for <linux-block@vger.kernel.org>; Thu, 1 Aug 2019 07:06:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3v82y7tf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 07:06:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 1 Aug 2019 12:06:34 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 12:06:32 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71B6Ebk18874734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 11:06:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEDA6AE055;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC935AE053;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Aug 2019 11:06:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 779F4E0218; Thu,  1 Aug 2019 13:06:30 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
Subject: [PATCH 1/1] s390/dasd: fix endless loop after read unit address configuration
Date:   Thu,  1 Aug 2019 13:06:30 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801110630.82432-1-sth@linux.ibm.com>
References: <20190801110630.82432-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080111-0020-0000-0000-000003594D60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080111-0021-0000-0000-000021AD5C01
Message-Id: <20190801110630.82432-2-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After getting a storage server event that causes the DASD device driver
to update its unit address configuration during a device shutdown there is
the possibility of an endless loop in the device driver.

In the system log there will be ongoing DASD error messages with RC: -19.

The reason is that the loop starting the ruac request only terminates when
the retry counter is decreased to 0. But in the sleep_on function there are
early exit paths that do not decrease the retry counter.

Prevent an endless loop by handling those cases separately.

Remove the unnecessary do..while loop since the sleep_on function takes
care of retries by itself.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org # 2.6.25+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

---
 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index b9ce93e9df89..99f86612f775 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -383,6 +383,20 @@ suborder_not_supported(struct dasd_ccw_req *cqr)
 	char msg_format;
 	char msg_no;
 
+	/*
+	 * intrc values ENODEV, ENOLINK and EPERM
+	 * will be optained from sleep_on to indicate that no
+	 * IO operation can be started
+	 */
+	if (cqr->intrc == -ENODEV)
+		return 1;
+
+	if (cqr->intrc == -ENOLINK)
+		return 1;
+
+	if (cqr->intrc == -EPERM)
+		return 1;
+
 	sense = dasd_get_sense(&cqr->irb);
 	if (!sense)
 		return 0;
@@ -447,12 +461,8 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	lcu->flags &= ~NEED_UAC_UPDATE;
 	spin_unlock_irqrestore(&lcu->lock, flags);
 
-	do {
-		rc = dasd_sleep_on(cqr);
-		if (rc && suborder_not_supported(cqr))
-			return -EOPNOTSUPP;
-	} while (rc && (cqr->retries > 0));
-	if (rc) {
+	rc = dasd_sleep_on(cqr);
+	if (rc && !suborder_not_supported(cqr)) {
 		spin_lock_irqsave(&lcu->lock, flags);
 		lcu->flags |= NEED_UAC_UPDATE;
 		spin_unlock_irqrestore(&lcu->lock, flags);
-- 
2.17.1

