Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB28C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D558120759
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XR3MGsF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgINRnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:43:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3874 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgINMRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 08:17:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EBWsjW161884;
        Mon, 14 Sep 2020 07:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7wuOUPm/sjHl+NmTypGhAvRmwj23r9kM+KqHBJ0iPMU=;
 b=XR3MGsF8W0Tv+JexWqUEnFObdtAObaWkAcQ/m//2dzuJrjlg4h3mUyZSEhM+06GyFMhO
 xyjKF5P4OImPUYiy1cIohmHcmOMO4dRB0EFeBBgcqJFHtUsVUIalMhO3MFsFpbdbflvu
 ikmgN5E5sekGePct8YdTp+CN++4KibECl8sOsJc6cSiRzERSjeOkEi1q5piTtz/iyLJq
 MLeDHvgC9QqjxdsNUipsyjHNBVNITlepAmNy8E8lWGXFUifb1JuSoqnTKbcrI3F7xN8U
 wIISsn5qXTYp3lg9s+fx38j2ixKir5tDZPMpqJjkNJxHvYLURM6x1xpYNLPbzZRRJU70 WQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33j656u8u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 07:56:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EBtL4g026040;
        Mon, 14 Sep 2020 11:56:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 33gny814wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 11:56:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08EBum2Z23855416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 11:56:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32DAFA405B;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0C0A405F;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Sep 2020 11:56:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id A33B9E0287; Mon, 14 Sep 2020 13:56:47 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 1/1] s390/dasd: Fix zero write for FBA devices
Date:   Mon, 14 Sep 2020 13:56:47 +0200
Message-Id: <20200914115647.94062-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115647.94062-1-sth@linux.ibm.com>
References: <20200914115647.94062-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_02:2020-09-10,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=3 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140094
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

A discard request that writes zeros using the global kernel internal
ZERO_PAGE will fail for machines with more than 2GB of memory due to the
location of the ZERO_PAGE.

Fix this by using a driver owned global zero page allocated with GFP_DMA
flag set.

Fixes: 28b841b3a7cb ("s390/dasd: Add discard support for FBA devices")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index cbb770824226..1a44e321b54e 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -40,6 +40,7 @@
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_fba_discipline;
+static void *dasd_fba_zero_page;
 
 struct dasd_fba_private {
 	struct dasd_fba_characteristics rdc_data;
@@ -270,7 +271,7 @@ static void ccw_write_zero(struct ccw1 *ccw, int count)
 	ccw->cmd_code = DASD_FBA_CCW_WRITE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = count;
-	ccw->cda = (__u32) (addr_t) page_to_phys(ZERO_PAGE(0));
+	ccw->cda = (__u32) (addr_t) dasd_fba_zero_page;
 }
 
 /*
@@ -830,6 +831,11 @@ dasd_fba_init(void)
 	int ret;
 
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
+
+	dasd_fba_zero_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!dasd_fba_zero_page)
+		return -ENOMEM;
+
 	ret = ccw_driver_register(&dasd_fba_driver);
 	if (!ret)
 		wait_for_device_probe();
@@ -841,6 +847,7 @@ static void __exit
 dasd_fba_cleanup(void)
 {
 	ccw_driver_unregister(&dasd_fba_driver);
+	free_page((unsigned long)dasd_fba_zero_page);
 }
 
 module_init(dasd_fba_init);
-- 
2.17.1

