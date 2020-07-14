Return-Path: <SRS0=uy3D=AZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CAEC433E2
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA56820720
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgGNUDh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729383AbgGNUDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 16:03:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06EK2j4a030068;
        Tue, 14 Jul 2020 16:03:35 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329bgh87r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 16:03:35 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EJvD7v003179;
        Tue, 14 Jul 2020 20:03:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 328rbqrp75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 20:03:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06EK3RPH59506780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 20:03:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C30F4A4054;
        Tue, 14 Jul 2020 20:03:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF70A4060;
        Tue, 14 Jul 2020 20:03:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Jul 2020 20:03:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 0EB7AE05A7; Tue, 14 Jul 2020 22:03:27 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
Date:   Tue, 14 Jul 2020 22:03:26 +0200
Message-Id: <20200714200327.40927-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714200327.40927-1-sth@linux.ibm.com>
References: <20200714200327.40927-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_08:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=3 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During initialization of the DASD DIAG driver a request is issued
that has a bio structure that resides on the stack. With virtually
mapped kernel stacks this bio address might be in virtual storage
which is unsuitable for usage with the diag250 call.
In this case the device can not be set online using the DIAG
discipline and fails with -EOPNOTSUP.
In the system journal the following error message is presented:

dasd: X.X.XXXX Setting the DASD online with discipline DIAG failed
with rc=-95

Fix by allocating the bio structure instead of having it on the stack.

Fixes: ce3dc447493f ("s390: add support for virtually mapped kernel stacks")
Cc: stable@vger.kernel.org #4.20
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/block/dasd_diag.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index facb588d09e4..069d6b39cacf 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -319,7 +319,7 @@ dasd_diag_check_device(struct dasd_device *device)
 	struct dasd_diag_characteristics *rdc_data;
 	struct vtoc_cms_label *label;
 	struct dasd_block *block;
-	struct dasd_diag_bio bio;
+	struct dasd_diag_bio *bio;
 	unsigned int sb, bsize;
 	blocknum_t end_block;
 	int rc;
@@ -395,29 +395,36 @@ dasd_diag_check_device(struct dasd_device *device)
 		rc = -ENOMEM;
 		goto out;
 	}
+	bio = kzalloc(sizeof(*bio), GFP_KERNEL);
+	if (bio == NULL)  {
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "No memory to allocate initialization bio");
+		rc = -ENOMEM;
+		goto out_label;
+	}
 	rc = 0;
 	end_block = 0;
 	/* try all sizes - needed for ECKD devices */
 	for (bsize = 512; bsize <= PAGE_SIZE; bsize <<= 1) {
 		mdsk_init_io(device, bsize, 0, &end_block);
-		memset(&bio, 0, sizeof (struct dasd_diag_bio));
-		bio.type = MDSK_READ_REQ;
-		bio.block_number = private->pt_block + 1;
-		bio.buffer = label;
+		memset(bio, 0, sizeof(*bio));
+		bio->type = MDSK_READ_REQ;
+		bio->block_number = private->pt_block + 1;
+		bio->buffer = label;
 		memset(&private->iob, 0, sizeof (struct dasd_diag_rw_io));
 		private->iob.dev_nr = rdc_data->dev_nr;
 		private->iob.key = 0;
 		private->iob.flags = 0;	/* do synchronous io */
 		private->iob.block_count = 1;
 		private->iob.interrupt_params = 0;
-		private->iob.bio_list = &bio;
+		private->iob.bio_list = bio;
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
 		if (rc == 3) {
 			pr_warn("%s: A 64-bit DIAG call failed\n",
 				dev_name(&device->cdev->dev));
 			rc = -EOPNOTSUPP;
-			goto out_label;
+			goto out_bio;
 		}
 		mdsk_term_io(device);
 		if (rc == 0)
@@ -427,7 +434,7 @@ dasd_diag_check_device(struct dasd_device *device)
 		pr_warn("%s: Accessing the DASD failed because of an incorrect format (rc=%d)\n",
 			dev_name(&device->cdev->dev), rc);
 		rc = -EIO;
-		goto out_label;
+		goto out_bio;
 	}
 	/* check for label block */
 	if (memcmp(label->label_id, DASD_DIAG_CMS1,
@@ -457,6 +464,8 @@ dasd_diag_check_device(struct dasd_device *device)
 			(rc == 4) ? ", read-only device" : "");
 		rc = 0;
 	}
+out_bio:
+	kfree(bio);
 out_label:
 	free_page((long) label);
 out:
-- 
2.17.1

