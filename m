Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CECC46466
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AA5208B6
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F3KpKB82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbgJBTjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388387AbgJBTjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JXGcj080817;
        Fri, 2 Oct 2020 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7MJll4Pg3o/l4ks3Ke8ALpGnf1XwsE7WLh6RMZ6Y+kA=;
 b=F3KpKB822LzV2WFG0PIeczEL0ynIJEufOO67EIBEo6Ww7dsIldd398VCKUPuD/rU277t
 hJ3Z0YtmHuIJar6iQhDm9cjJQi0lHxlRvQJwbPysxBe7m6nabL3wSEuVL4kONdtCZOsr
 VR8/ye9fSkKPh9yUoBBgPer0E/l9v34QkJQxKQW3vXtAFRKwPxy3e3M/kdbLK0p4Gz+o
 n484/flHhI/jw0xTlDrp64HwCKrJLOq5U9NNLlHdyGFwPF0yeq15pB/i+t1FBxxDFZEQ
 rPS256SpVANUG0On33z1XMd1k1iUuUgixYTOgZcLt/vPNwrQWMbly7WAZQ9cy2GC7fVL FQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33xa670hcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092JcXNH031093;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw986vmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092JdfB228049694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E96611C052;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667B111C050;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id AD654E0320; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 05/10] s390/dasd: Move duplicate code to separate function
Date:   Fri,  2 Oct 2020 21:39:35 +0200
Message-Id: <20201002193940.24012-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

For storing retrieved path information both the if and else block in
dasd_eckd_read_conf() use the same code. To avoid duplicate code this
should be done after the if/else block. To further increase readability,
move the code to a new function, dasd_eckd_store_conf_data().

Reference-ID: IO1812
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

