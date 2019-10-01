Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FAECE58A
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E521872
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfJAPes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:34:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389331AbfJAPer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Oct 2019 11:34:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91FS4L1194276
        for <linux-block@vger.kernel.org>; Tue, 1 Oct 2019 11:34:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjssrak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 11:34:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 1 Oct 2019 16:34:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Oct 2019 16:34:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91FYd6B50856148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 15:34:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A19B4AE045;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CCB6AE04D;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 15938E0600; Tue,  1 Oct 2019 17:34:39 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 1/2] s390/dasd: Fix error handling during online processing
Date:   Tue,  1 Oct 2019 17:34:38 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
References: <20191001153439.62672-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100115-0012-0000-0000-000003530433
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100115-0013-0000-0000-0000218E0446
Message-Id: <20191001153439.62672-2-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

It is possible that the CCW commands for reading volume and extent pool
information are not supported, either by the storage server (for
dedicated DASDs) or by z/VM (for virtual devices, such as MDISKs).

As a command reject will occur in such a case, the current error
handling leads to a failing online processing and thus the DASD can't be
used at all.

Since the data being read is not essential for an fully operational
DASD, the error handling can be removed. Information about the failing
command is sent to the s390dbf debug feature.

Fixes: c729696bcf8b ("s390/dasd: Recognise data for ESE volumes")
Cc: <stable@vger.kernel.org> # 5.3
Reported-by: Frank Heimes <frank.heimes@canonical.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index fc53e1e221f0..b213c40d1a51 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1553,8 +1553,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	if (rc == 0) {
 		memcpy(&private->vsq, vsq, sizeof(*vsq));
 	} else {
-		dev_warn(&device->cdev->dev,
-			 "Reading the volume storage information failed with rc=%d\n", rc);
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Reading the volume storage information failed with rc=%d", rc);
 	}
 
 	if (useglobal)
@@ -1737,8 +1737,8 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	if (rc == 0) {
 		dasd_eckd_cpy_ext_pool_data(device, lcq);
 	} else {
-		dev_warn(&device->cdev->dev,
-			 "Reading the logical configuration failed with rc=%d\n", rc);
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Reading the logical configuration failed with rc=%d", rc);
 	}
 
 	dasd_sfree_request(cqr, cqr->memdev);
@@ -2020,14 +2020,10 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	dasd_eckd_read_features(device);
 
 	/* Read Volume Information */
-	rc = dasd_eckd_read_vol_info(device);
-	if (rc)
-		goto out_err3;
+	dasd_eckd_read_vol_info(device);
 
 	/* Read Extent Pool Information */
-	rc = dasd_eckd_read_ext_pool_info(device);
-	if (rc)
-		goto out_err3;
+	dasd_eckd_read_ext_pool_info(device);
 
 	/* Read Device Characteristics */
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
@@ -5663,14 +5659,10 @@ static int dasd_eckd_restore_device(struct dasd_device *device)
 	dasd_eckd_read_features(device);
 
 	/* Read Volume Information */
-	rc = dasd_eckd_read_vol_info(device);
-	if (rc)
-		goto out_err2;
+	dasd_eckd_read_vol_info(device);
 
 	/* Read Extent Pool Information */
-	rc = dasd_eckd_read_ext_pool_info(device);
-	if (rc)
-		goto out_err2;
+	dasd_eckd_read_ext_pool_info(device);
 
 	/* Read Device Characteristics */
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
-- 
2.17.1

