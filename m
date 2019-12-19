Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B6EC3F68F
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5678924650
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 08:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLSIoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:44:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfLSIoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 03:44:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ8gaZ5122320
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 03:43:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x00shtsqk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 19 Dec 2019 08:43:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Dec 2019 08:43:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJ8hroQ36110468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:43:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05B23AE058;
        Thu, 19 Dec 2019 08:43:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E81DEAE04D;
        Thu, 19 Dec 2019 08:43:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Dec 2019 08:43:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 91757E02C5; Thu, 19 Dec 2019 09:43:52 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 3/3] s390/dasd: fix typo in copyright statement
Date:   Thu, 19 Dec 2019 09:43:52 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121908-0012-0000-0000-000003767B16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121908-0013-0000-0000-000021B26D11
Message-Id: <20191219084352.75114-4-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=1
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=696 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912190074
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

coypright -> copyright

Reported-by: Kate Stewart <kstewart@linuxfoundation.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.h  | 2 +-
 drivers/s390/block/dasd_proc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.h b/drivers/s390/block/dasd_fba.h
index 8f75df06e893..45ddabec4017 100644
--- a/drivers/s390/block/dasd_fba.h
+++ b/drivers/s390/block/dasd_fba.h
@@ -2,7 +2,7 @@
 /*
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * Coypright IBM Corp. 1999, 2000
+ * Copyright IBM Corp. 1999, 2000
  *
  */
 
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 1770b99f607e..8d4d69ea5baf 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -5,7 +5,7 @@
  *		    Carsten Otte <Cotte@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
- * Coypright IBM Corp. 1999, 2002
+ * Copyright IBM Corp. 1999, 2002
  *
  * /proc interface for the dasd driver.
  *
-- 
2.17.1

