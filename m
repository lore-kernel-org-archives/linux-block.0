Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3AC4363C
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC482083B
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SvdELXhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgJHNNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgJHNNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D3f6R181846;
        Thu, 8 Oct 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Psjdtc1XXSUmGQhQZnQemz3bPjUovx+J7A1YOaYkIho=;
 b=SvdELXhn05ujjU3LSNJkK94aGg7Y0FbPsOjJxr2CFBldafUi1v48M18fjNvBKN3WqK9M
 mfUNm8hFXzON5XiYVolix3eas9n3HHXvLXtBFSlSCgxEbjAurOZxABAII93mvMpsaX9Q
 IOY4JWsNq54zoolUNK35HV4wqeUF85+IRXCONc9BI//IUBYG+EeRNuVgg/5sHuP768L5
 x/MltzEO+CXFImmWJbSs05RB9Z7Ai0IWIb8B712l6EHey7jeYtRDHgsuCbWpXsrpxuWb
 Gl2r4xNz7T+UI0mqZHxMfbvccBWLR8J2CDcJKshyUi2OjKwsTM8s/bIJtJ178AeafExl 2Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3420p45s96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DDJJf009202;
        Thu, 8 Oct 2020 13:13:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 33xgx8dc9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDaev19661274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D92DFAE059;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D2AAE045;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 2A79BE24CF; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 05/10] s390/dasd: Move duplicate code to separate function
Date:   Thu,  8 Oct 2020 15:13:31 +0200
Message-Id: <20201008131336.61100-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010080097
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

For storing retrieved path information both the if and else block in
dasd_eckd_read_conf() use the same code. To avoid duplicate code this
should be done after the if/else block. To further increase readability,
move the code to a new function, dasd_eckd_store_conf_data().

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 42 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2b39d2a5965f..497aa81778b6 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1000,6 +1000,22 @@ static unsigned char dasd_eckd_path_access(void *conf_data, int conf_len)
 		return 0;
 }
 
+static void dasd_eckd_store_conf_data(struct dasd_device *device,
+				      struct dasd_conf_data *conf_data, int chp)
+{
+	struct channel_path_desc_fmt0 *chp_desc;
+	struct subchannel_id sch_id;
+
+	ccw_device_get_schid(device->cdev, &sch_id);
+	device->path[chp].conf_data = conf_data;
+	device->path[chp].cssid = sch_id.cssid;
+	device->path[chp].ssid = sch_id.ssid;
+	chp_desc = ccw_device_get_chp_desc(device->cdev, chp);
+	if (chp_desc)
+		device->path[chp].chpid = chp_desc->chpid;
+	kfree(chp_desc);
+}
+
 static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
@@ -1016,7 +1032,6 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 	}
 }
 
-
 static int dasd_eckd_read_conf(struct dasd_device *device)
 {
 	void *conf_data;
@@ -1026,12 +1041,9 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 	struct dasd_eckd_private *private, path_private;
 	struct dasd_uid *uid;
 	char print_path_uid[60], print_device_uid[60];
-	struct channel_path_desc_fmt0 *chp_desc;
-	struct subchannel_id sch_id;
 
 	private = device->private;
 	opm = ccw_device_get_path_mask(device->cdev);
-	ccw_device_get_schid(device->cdev, &sch_id);
 	conf_data_saved = 0;
 	path_err = 0;
 	/* get configuration data per operational path */
@@ -1066,15 +1078,6 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 				kfree(conf_data);
 				continue;
 			}
-			pos = pathmask_to_pos(lpm);
-			/* store per path conf_data */
-			device->path[pos].conf_data = conf_data;
-			device->path[pos].cssid = sch_id.cssid;
-			device->path[pos].ssid = sch_id.ssid;
-			chp_desc = ccw_device_get_chp_desc(device->cdev, pos);
-			if (chp_desc)
-				device->path[pos].chpid = chp_desc->chpid;
-			kfree(chp_desc);
 			/*
 			 * build device UID that other path data
 			 * can be compared to it
@@ -1132,18 +1135,13 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 				dasd_path_add_cablepm(device, lpm);
 				continue;
 			}
-			pos = pathmask_to_pos(lpm);
-			/* store per path conf_data */
-			device->path[pos].conf_data = conf_data;
-			device->path[pos].cssid = sch_id.cssid;
-			device->path[pos].ssid = sch_id.ssid;
-			chp_desc = ccw_device_get_chp_desc(device->cdev, pos);
-			if (chp_desc)
-				device->path[pos].chpid = chp_desc->chpid;
-			kfree(chp_desc);
 			path_private.conf_data = NULL;
 			path_private.conf_len = 0;
 		}
+
+		pos = pathmask_to_pos(lpm);
+		dasd_eckd_store_conf_data(device, conf_data, pos);
+
 		switch (dasd_eckd_path_access(conf_data, conf_len)) {
 		case 0x02:
 			dasd_path_add_nppm(device, lpm);
-- 
2.17.1

