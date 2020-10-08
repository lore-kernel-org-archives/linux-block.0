Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050FAC04EBE
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5D12184D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B/iDUOd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgJHNNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729756AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D1gxC136349;
        Thu, 8 Oct 2020 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=PAtGIA8yWszHVij0LjuERgb7YS8jZgWkJ0jZQB12TBE=;
 b=B/iDUOd2PAt6DFSApPwEHaYitzCXE5napWu9ZKIYRt5QiaCcq32a5vdeUGdZlIWt3tdN
 p/rT1mG+d/iAVj6JV5K71rn0f5LY0QjkaySa8jKiXmqYjXZ//x7GXlv929LSXY4Oxhxk
 BwvJasfhLQW2KojFN8g0E3X5OVZDLguBskr69+1CKZaNNo0plILJ8q95yXE/WD4mH1kZ
 NUERq1cndJt2/fDPFB2WooWJQoNCSYl6OWlDDER5w+eA2xUXH116dgK4tToHK+W6Uapn
 k6/Y2Di2Z4QtSjiajWImT0WPdw1njyJkxqA3JSTPWw2praB4K3wnpqxAIXK3qm9vPX2d yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34230ph0gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DC1G7008194;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33xgx8dc9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDa2w23855564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929D6A4060;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A452A405B;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 27E63E24CE; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 04/10] s390/dasd: Remove unused parameter from dasd_generic_probe()
Date:   Thu,  8 Oct 2020 15:13:30 +0200
Message-Id: <20201008131336.61100-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_07:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=964 mlxscore=0 lowpriorityscore=0
 suspectscore=2 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010080094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

The discipline argument in dasd_generic_probe() isn't used and there is
no history how it was used in the past. Remove it.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 3 +--
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_fba.c  | 2 +-
 drivers/s390/block/dasd_int.h  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c..9a0300d2e744 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3465,8 +3465,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
  */
-int dasd_generic_probe(struct ccw_device *cdev,
-		       struct dasd_discipline *discipline)
+int dasd_generic_probe(struct ccw_device *cdev)
 {
 	int ret;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ad44d22e8859..2b39d2a5965f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -143,7 +143,7 @@ dasd_eckd_probe (struct ccw_device *cdev)
 				"ccw-device options");
 		return ret;
 	}
-	ret = dasd_generic_probe(cdev, &dasd_eckd_discipline);
+	ret = dasd_generic_probe(cdev);
 	return ret;
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 1a44e321b54e..5b0ebf6bf20f 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -58,7 +58,7 @@ static struct ccw_driver dasd_fba_driver; /* see below */
 static int
 dasd_fba_probe(struct ccw_device *cdev)
 {
-	return dasd_generic_probe(cdev, &dasd_fba_discipline);
+	return dasd_generic_probe(cdev);
 }
 
 static int
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..6dce9d4c55ce 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -774,7 +774,7 @@ void dasd_block_set_timer(struct dasd_block *, int);
 void dasd_block_clear_timer(struct dasd_block *);
 int  dasd_cancel_req(struct dasd_ccw_req *);
 int dasd_flush_device_queue(struct dasd_device *);
-int dasd_generic_probe (struct ccw_device *, struct dasd_discipline *);
+int dasd_generic_probe(struct ccw_device *);
 void dasd_generic_free_discipline(struct dasd_device *);
 void dasd_generic_remove (struct ccw_device *cdev);
 int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
-- 
2.17.1

