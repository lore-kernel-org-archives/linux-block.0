Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC05C4727F
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8092184D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tTJM52JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgJHNNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:13:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729765AbgJHNNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 09:13:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098D2SWD003761;
        Thu, 8 Oct 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=LkZ9mOcsN75+6VKyp/uhQHULNViDK4IGXC/wD0vqNio=;
 b=tTJM52JNmLq63L28lpEYgQhYTCn9/zfhwoxNZoVdmSkqMHvOXkvkt6OGZEjShzq6a4rc
 NPQsmxH+BP3pHbPEWRonwGjtbo+XX2lVYB1HOGjhZlVYFJppHhjsoasfBkezyP0JMUlT
 uLtQ6grBqmqbAoJcO4MFg4FwAvuBZZMpJ7Egs7cWzwh3QKMe+pE8XJX5GUgEeFw6bda+
 BBPvWh2zhzHB11P/VGX4CSDlv4Qt2geOyGIMv32I5GYcvFleJdSxDlNgZHuCV5aigV2G
 7SenV87FmlCVlo9H6umEyUNUXzQ4XjH88vYvkxX+myue+M29oopMq8BGP7xbwJdLDDwx 5g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3421ebv8rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 09:13:42 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098DD6Ul018246;
        Thu, 8 Oct 2020 13:13:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx82tkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:13:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098DDbuq20185348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 13:13:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79F9AE045;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF06EAE058;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 13:13:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 37799E24D4; Thu,  8 Oct 2020 15:13:36 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 10/10] s390/dasd: Process FCES path event notification
Date:   Thu,  8 Oct 2020 15:13:36 +0200
Message-Id: <20201008131336.61100-11-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_08:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=691 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

If the Fibre Channel Endpoint-Security status of a path changes, a
corresponding path event is received from the CIO layer.

Process this event by re-reading the FCES information.

As the information is retrieved for all paths on a single CU in one
call, the internal status can also be updated for all paths and no
processing per path is necessary.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 19 +++++++++++----
 drivers/s390/block/dasd_eckd.c | 12 +++++++---
 drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 97c11d557052..7119a34fef5c 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2107,20 +2107,25 @@ static void __dasd_device_start_head(struct dasd_device *device)
 
 static void __dasd_device_check_path_events(struct dasd_device *device)
 {
+	__u8 tbvpm, fcsecpm;
 	int rc;
 
-	if (!dasd_path_get_tbvpm(device))
+	tbvpm = dasd_path_get_tbvpm(device);
+	fcsecpm = dasd_path_get_fcsecpm(device);
+
+	if (!tbvpm && !fcsecpm)
 		return;
 
 	if (device->stopped &
 	    ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM))
 		return;
-	rc = device->discipline->pe_handler(device,
-					    dasd_path_get_tbvpm(device));
-	if (rc)
+	rc = device->discipline->pe_handler(device, tbvpm, fcsecpm);
+	if (rc) {
 		dasd_device_set_timer(device, 50);
-	else
+	} else {
 		dasd_path_clear_all_verify(device);
+		dasd_path_clear_all_fcsec(device);
+	}
 };
 
 /*
@@ -3868,6 +3873,10 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			if (device->discipline->kick_validate)
 				device->discipline->kick_validate(device);
 		}
+		if (path_event[chp] & PE_PATH_FCES_EVENT) {
+			dasd_path_fcsec_update(device, chp);
+			dasd_schedule_device_bh(device);
+		}
 	}
 	hpfpm = dasd_path_get_hpfpm(device);
 	ifccpm = dasd_path_get_ifccpm(device);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2e1cfacbf4d8..0d319c21c287 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -111,6 +111,7 @@ struct pe_handler_work_data {
 	__u8 rcd_buffer[DASD_ECKD_RCD_DATA_SIZE];
 	int isglobal;
 	__u8 tbvpm;
+	__u8 fcsecpm;
 };
 static struct pe_handler_work_data *pe_handler_worker;
 static DEFINE_MUTEX(dasd_pe_handler_mutex);
@@ -1466,7 +1467,10 @@ static void do_pe_handler_work(struct work_struct *work)
 		return;
 	}
 
-	dasd_eckd_path_available_action(device, data);
+	if (data->tbvpm)
+		dasd_eckd_path_available_action(device, data);
+	if (data->fcsecpm)
+		dasd_eckd_read_fc_security(device);
 
 	clear_bit(DASD_FLAG_PATH_VERIFY, &device->flags);
 	dasd_put_device(device);
@@ -1476,7 +1480,8 @@ static void do_pe_handler_work(struct work_struct *work)
 		kfree(data);
 }
 
-static int dasd_eckd_pe_handler(struct dasd_device *device, __u8 lpm)
+static int dasd_eckd_pe_handler(struct dasd_device *device,
+				__u8 tbvpm, __u8 fcsecpm)
 {
 	struct pe_handler_work_data *data;
 
@@ -1495,7 +1500,8 @@ static int dasd_eckd_pe_handler(struct dasd_device *device, __u8 lpm)
 	INIT_WORK(&data->worker, do_pe_handler_work);
 	dasd_get_device(device);
 	data->device = device;
-	data->tbvpm = lpm;
+	data->tbvpm = tbvpm;
+	data->fcsecpm = fcsecpm;
 	schedule_work(&data->worker);
 	return 0;
 }
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3ae1c8d42b8a..8486ed3c877b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -298,7 +298,7 @@ struct dasd_discipline {
 	 * configuration.
 	 */
 	int (*verify_path)(struct dasd_device *, __u8);
-	int (*pe_handler)(struct dasd_device *, __u8);
+	int (*pe_handler)(struct dasd_device *, __u8, __u8);
 
 	/*
 	 * Last things to do when a device is set online, and first things
@@ -423,6 +423,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_PATH_NOHPF        6
 #define DASD_PATH_CUIR	       7
 #define DASD_PATH_IFCC	       8
+#define DASD_PATH_FCSEC	       9
 
 #define DASD_THRHLD_MAX		4294967295U
 #define DASD_INTERVAL_MAX	4294967295U
@@ -965,6 +966,29 @@ static inline void dasd_path_clear_all_verify(struct dasd_device *device)
 		dasd_path_clear_verify(device, chp);
 }
 
+static inline void dasd_path_fcsec(struct dasd_device *device, int chp)
+{
+	__set_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline void dasd_path_clear_fcsec(struct dasd_device *device, int chp)
+{
+	__clear_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline int dasd_path_need_fcsec(struct dasd_device *device, int chp)
+{
+	return test_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline void dasd_path_clear_all_fcsec(struct dasd_device *device)
+{
+	int chp;
+
+	for (chp = 0; chp < 8; chp++)
+		dasd_path_clear_fcsec(device, chp);
+}
+
 static inline void dasd_path_operational(struct dasd_device *device, int chp)
 {
 	__set_bit(DASD_PATH_OPERATIONAL, &device->path[chp].flags);
@@ -1090,6 +1114,17 @@ static inline __u8 dasd_path_get_tbvpm(struct dasd_device *device)
 	return tbvpm;
 }
 
+static inline int dasd_path_get_fcsecpm(struct dasd_device *device)
+{
+	int chp;
+
+	for (chp = 0; chp < 8; chp++)
+		if (dasd_path_need_fcsec(device, chp))
+			return 1;
+
+	return 0;
+}
+
 static inline __u8 dasd_path_get_nppm(struct dasd_device *device)
 {
 	int chp;
@@ -1347,6 +1382,11 @@ static inline void dasd_path_notoper(struct dasd_device *device, int chp)
 	dasd_path_clear_nonpreferred(device, chp);
 }
 
+static inline void dasd_path_fcsec_update(struct dasd_device *device, int chp)
+{
+	dasd_path_fcsec(device, chp);
+}
+
 /*
  * remove all paths from normal operation
  */
-- 
2.17.1

