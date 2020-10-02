Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272CC47423
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC57920719
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mL6QElBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgJBTjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388418AbgJBTju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JWBJb051475;
        Fri, 2 Oct 2020 15:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sOMspBYf38TVT6jznvYpqZktxxx7WH+DAcAAN00i/2k=;
 b=mL6QElBvesHHNGRPvjGAliKT4YGtozvW9HDg5QBpzuyw5oaj0qJklM5GanhKWO9YiKKh
 LBa8sG/5qrH8c6L2fWHXldSyiiM1L/ABP2xoJhE+vPV7gsssLAAWGDZaZHcXL1ZbigM+
 BxaUpufzYqJGatwXFgvgKbhs6oIEB9LhUy3q2ZkSB3/gTxgpJE/G7/fCjN45E9M+McCJ
 lkUOn5Il4ecXgpkH0761GWE+5sQy0oZ6CTpPkkGH5Meg2LvoSU5TXWOFe31YQI169CrC
 M/PIqcrOYmjzYCiDZITWSALgbHfxvK4fJJ3NtQ6ndXpqwnF3+ZObtLcBOOSJwIhLpl8b pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33x9uas2d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:48 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092Jb1ae017212;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 33sw97xvuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092Jdfa527722126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2E4A4062;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 740B3A405F;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id B81E7E0364; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 09/10] s390/dasd: Prepare for additional path event handling
Date:   Fri,  2 Oct 2020 21:39:39 +0200
Message-Id: <20201002193940.24012-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=718
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

As more path events need to be handled for ECKD the current path
verification infrastructure can be reused. Rename all path verifcation
code to fit the more broadly based task of path event handling and put
the path verification in a new separate function.

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      |  4 +-
 drivers/s390/block/dasd_eckd.c | 78 +++++++++++++++++++---------------
 drivers/s390/block/dasd_int.h  |  1 +
 3 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 9a0300d2e744..97c11d557052 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2115,8 +2115,8 @@ static void __dasd_device_check_path_events(struct dasd_device *device)
 	if (device->stopped &
 	    ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM))
 		return;
-	rc = device->discipline->verify_path(device,
-					     dasd_path_get_tbvpm(device));
+	rc = device->discipline->pe_handler(device,
+					    dasd_path_get_tbvpm(device));
 	if (rc)
 		dasd_device_set_timer(device, 50);
 	else
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 63061ff5ecab..822a8ad4e338 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -103,7 +103,7 @@ struct ext_pool_exhaust_work_data {
 };
 
 /* definitions for the path verification worker */
-struct path_verification_work_data {
+struct pe_handler_work_data {
 	struct work_struct worker;
 	struct dasd_device *device;
 	struct dasd_ccw_req cqr;
@@ -112,8 +112,8 @@ struct path_verification_work_data {
 	int isglobal;
 	__u8 tbvpm;
 };
-static struct path_verification_work_data *path_verification_worker;
-static DEFINE_MUTEX(dasd_path_verification_mutex);
+static struct pe_handler_work_data *pe_handler_worker;
+static DEFINE_MUTEX(dasd_pe_handler_mutex);
 
 struct check_attention_work_data {
 	struct work_struct worker;
@@ -1244,7 +1244,7 @@ static int verify_fcx_max_data(struct dasd_device *device, __u8 lpm)
 }
 
 static int rebuild_device_uid(struct dasd_device *device,
-			      struct path_verification_work_data *data)
+			      struct pe_handler_work_data *data)
 {
 	struct dasd_eckd_private *private = device->private;
 	__u8 lpm, opm = dasd_path_get_opm(device);
@@ -1282,10 +1282,9 @@ static int rebuild_device_uid(struct dasd_device *device,
 	return rc;
 }
 
-static void do_path_verification_work(struct work_struct *work)
+static void dasd_eckd_path_available_action(struct dasd_device *device,
+					    struct pe_handler_work_data *data)
 {
-	struct path_verification_work_data *data;
-	struct dasd_device *device;
 	struct dasd_eckd_private path_private;
 	struct dasd_uid *uid;
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
@@ -1295,19 +1294,6 @@ static void do_path_verification_work(struct work_struct *work)
 	char print_uid[60];
 	int rc, pos;
 
-	data = container_of(work, struct path_verification_work_data, worker);
-	device = data->device;
-
-	/* delay path verification until device was resumed */
-	if (test_bit(DASD_FLAG_SUSPENDED, &device->flags)) {
-		schedule_work(work);
-		return;
-	}
-	/* check if path verification already running and delay if so */
-	if (test_and_set_bit(DASD_FLAG_PATH_VERIFY, &device->flags)) {
-		schedule_work(work);
-		return;
-	}
 	opm = 0;
 	npm = 0;
 	ppm = 0;
@@ -1454,30 +1440,54 @@ static void do_path_verification_work(struct work_struct *work)
 
 		dasd_path_create_kobj(device, pos);
 	}
+}
+
+static void do_pe_handler_work(struct work_struct *work)
+{
+	struct pe_handler_work_data *data;
+	struct dasd_device *device;
+
+	data = container_of(work, struct pe_handler_work_data, worker);
+	device = data->device;
+
+	/* delay path verification until device was resumed */
+	if (test_bit(DASD_FLAG_SUSPENDED, &device->flags)) {
+		schedule_work(work);
+		return;
+	}
+	/* check if path verification already running and delay if so */
+	if (test_and_set_bit(DASD_FLAG_PATH_VERIFY, &device->flags)) {
+		schedule_work(work);
+		return;
+	}
+
+	dasd_eckd_path_available_action(device, data);
+
 	clear_bit(DASD_FLAG_PATH_VERIFY, &device->flags);
 	dasd_put_device(device);
 	if (data->isglobal)
-		mutex_unlock(&dasd_path_verification_mutex);
+		mutex_unlock(&dasd_pe_handler_mutex);
 	else
 		kfree(data);
 }
 
-static int dasd_eckd_verify_path(struct dasd_device *device, __u8 lpm)
+static int dasd_eckd_pe_handler(struct dasd_device *device, __u8 lpm)
 {
-	struct path_verification_work_data *data;
+	struct pe_handler_work_data *data;
 
 	data = kmalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
 	if (!data) {
-		if (mutex_trylock(&dasd_path_verification_mutex)) {
-			data = path_verification_worker;
+		if (mutex_trylock(&dasd_pe_handler_mutex)) {
+			data = pe_handler_worker;
 			data->isglobal = 1;
-		} else
+		} else {
 			return -ENOMEM;
+		}
 	} else {
 		memset(data, 0, sizeof(*data));
 		data->isglobal = 0;
 	}
-	INIT_WORK(&data->worker, do_path_verification_work);
+	INIT_WORK(&data->worker, do_pe_handler_work);
 	dasd_get_device(device);
 	data->device = device;
 	data->tbvpm = lpm;
@@ -6720,7 +6730,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.check_device = dasd_eckd_check_characteristics,
 	.uncheck_device = dasd_eckd_uncheck_device,
 	.do_analysis = dasd_eckd_do_analysis,
-	.verify_path = dasd_eckd_verify_path,
+	.pe_handler = dasd_eckd_pe_handler,
 	.basic_to_ready = dasd_eckd_basic_to_ready,
 	.online_to_ready = dasd_eckd_online_to_ready,
 	.basic_to_known = dasd_eckd_basic_to_known,
@@ -6781,16 +6791,16 @@ dasd_eckd_init(void)
 				    GFP_KERNEL | GFP_DMA);
 	if (!dasd_vol_info_req)
 		return -ENOMEM;
-	path_verification_worker = kmalloc(sizeof(*path_verification_worker),
-				   GFP_KERNEL | GFP_DMA);
-	if (!path_verification_worker) {
+	pe_handler_worker = kmalloc(sizeof(*pe_handler_worker),
+				    GFP_KERNEL | GFP_DMA);
+	if (!pe_handler_worker) {
 		kfree(dasd_reserve_req);
 		kfree(dasd_vol_info_req);
 		return -ENOMEM;
 	}
 	rawpadpage = (void *)__get_free_page(GFP_KERNEL);
 	if (!rawpadpage) {
-		kfree(path_verification_worker);
+		kfree(pe_handler_worker);
 		kfree(dasd_reserve_req);
 		kfree(dasd_vol_info_req);
 		return -ENOMEM;
@@ -6799,7 +6809,7 @@ dasd_eckd_init(void)
 	if (!ret)
 		wait_for_device_probe();
 	else {
-		kfree(path_verification_worker);
+		kfree(pe_handler_worker);
 		kfree(dasd_reserve_req);
 		kfree(dasd_vol_info_req);
 		free_page((unsigned long)rawpadpage);
@@ -6811,7 +6821,7 @@ static void __exit
 dasd_eckd_cleanup(void)
 {
 	ccw_driver_unregister(&dasd_eckd_driver);
-	kfree(path_verification_worker);
+	kfree(pe_handler_worker);
 	kfree(dasd_reserve_req);
 	free_page((unsigned long)rawpadpage);
 }
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 93d9cc938924..3ae1c8d42b8a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -298,6 +298,7 @@ struct dasd_discipline {
 	 * configuration.
 	 */
 	int (*verify_path)(struct dasd_device *, __u8);
+	int (*pe_handler)(struct dasd_device *, __u8);
 
 	/*
 	 * Last things to do when a device is set online, and first things
-- 
2.17.1

