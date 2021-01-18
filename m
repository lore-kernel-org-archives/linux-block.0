Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCAC433DB
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AECC22C9D
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405609AbhARQ4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:56:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406684AbhARQ4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 11:56:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10IGWaXF004155;
        Mon, 18 Jan 2021 11:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RC1xhbTe7wxkWEZk4LzbGbBpARHXPzdvw3PGsGMOJpU=;
 b=hOPp//xVYLewuVCjVEW4Ak+/Uh2YClMC6GmTvIANUA7AHlNjQZkZsPue2MTlpDLTv7sy
 4nnQZT5Dx5xRpR52PW94zSmjtBpFwZjoNkznftWEkfK4lRpx6PbWWnrERBg/dwGCwAWY
 JCVhxrZp3z14MhPnyP7XbcPqPFZYzAN/LEKcG5sKA/jECjX+/MUMLRgSrlOCZldYN99u
 MaXyxx2nWAUSdUCPeVyktEecuM3HIr+/poRTk91JOELfNqbPUi+uqeE36MaOvWmTExlp
 uy9dR2z26oG346+pth+QdyyBqT5539B/lA3qORkXFEzR0W1qsA4QqiRngNYG2M3h/kR/ hg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 365dfd1esp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 11:55:23 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10IGqgvE016792;
        Mon, 18 Jan 2021 16:55:21 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 363qs8a8xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 16:55:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10IGtIPX16580976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 16:55:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18014C059;
        Mon, 18 Jan 2021 16:55:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB4704C046;
        Mon, 18 Jan 2021 16:55:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Jan 2021 16:55:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 6A35CE0A39; Mon, 18 Jan 2021 17:55:18 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Date:   Mon, 18 Jan 2021 17:55:18 +0100
Message-Id: <20210118165518.14578-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210118165518.14578-1-sth@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_13:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101180095
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

Our intention was to only remove path kobjects whenever a device is
being set offline. However, one corner case was missing.

If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE and
BIODASDENABLE respectively), the enabling process will call
dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
order to update path information. During that update,
dasd_eckd_clear_conf_data() clears all old data and also removes all
kobjects. This will leave us with an inconsistent state of path kobjects
and a subsequent path verification leads to a failing kobject creation.

Fix this by removing kobjects only in the context of offlining a device
as initially intended.

Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security information via sysfs")
Reported-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
 drivers/s390/block/dasd_eckd.c   |  3 ++-
 drivers/s390/block/dasd_int.h    |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 16bb135c20aa..03d27ee9cac6 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1874,18 +1874,26 @@ void dasd_path_create_kobjects(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_path_create_kobjects);
 
-/*
- * As we keep kobjects for the lifetime of a device, this function must not be
- * called anywhere but in the context of offlining a device.
- */
-void dasd_path_remove_kobj(struct dasd_device *device, int chp)
+static void dasd_path_remove_kobj(struct dasd_device *device, int chp)
 {
 	if (device->path[chp].in_sysfs) {
 		kobject_put(&device->path[chp].kobj);
 		device->path[chp].in_sysfs = false;
 	}
 }
-EXPORT_SYMBOL(dasd_path_remove_kobj);
+
+/*
+ * As we keep kobjects for the lifetime of a device, this function must not be
+ * called anywhere but in the context of offlining a device.
+ */
+void dasd_path_remove_kobjects(struct dasd_device *device)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		dasd_path_remove_kobj(device, i);
+}
+EXPORT_SYMBOL(dasd_path_remove_kobjects);
 
 int dasd_add_sysfs_files(struct ccw_device *cdev)
 {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 3caa1ee5f4b0..65eb87cbbb9b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1036,7 +1036,6 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
 		dasd_path_notoper(device, i);
-		dasd_path_remove_kobj(device, i);
 	}
 }
 
@@ -2173,6 +2172,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->block = NULL;
 out_err1:
 	dasd_eckd_clear_conf_data(device);
+	dasd_path_remove_kobjects(device);
 	kfree(device->private);
 	device->private = NULL;
 	return rc;
@@ -2191,6 +2191,7 @@ static void dasd_eckd_uncheck_device(struct dasd_device *device)
 	private->vdsneq = NULL;
 	private->gneq = NULL;
 	dasd_eckd_clear_conf_data(device);
+	dasd_path_remove_kobjects(device);
 }
 
 static struct dasd_ccw_req *
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3bc008f9136c..b8a04c42d1d2 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -858,7 +858,7 @@ int dasd_add_sysfs_files(struct ccw_device *);
 void dasd_remove_sysfs_files(struct ccw_device *);
 void dasd_path_create_kobj(struct dasd_device *, int);
 void dasd_path_create_kobjects(struct dasd_device *);
-void dasd_path_remove_kobj(struct dasd_device *, int);
+void dasd_path_remove_kobjects(struct dasd_device *);
 
 struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
 struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);
-- 
2.17.1

