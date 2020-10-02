Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D8DC4363D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19D6206DD
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f+4JmQoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgJBTju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:39:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388388AbgJBTjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JWcJq083989;
        Fri, 2 Oct 2020 15:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cmRhm5RWbH8nvBw5uMmLZoLYPMNncOpN/su8TUL7RcI=;
 b=f+4JmQoPy/sfWTqZ2V/Bb+GAiaADXb50L/DEtcwnu959kPT92MTl84tPjDdwWyWIa42T
 RrW6Ou69jiCuWkysJ9vZtFHmLR02TDbcIqoR3IIob//Nh5Xq5MKY0RpbNcIQoTQo6yQ4
 PZK+Vp3zEqKq5t/uVb384dq6neqqsFZT1qhj5dw3hV5lmYDLbC1tARqVwPqo9o/QkIrY
 O82gTxoOaQ8oJM5u4l1Hs4idSUfDcIXjwsAHK4B2nuyMmyzBfV1nFNMJTpDY20lHyzwW
 91FMn3PDkrNCNVBw2XoC+CXeCHOn6PSr9jsRVknEXO0UlWWYxoyJIHmzDz7RZC7nTZTU tA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33xa7r0f0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092Jc1Rw028000;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 33v5kg1umv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092Jdfqh33095938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BEEEAE051;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69DDBAE055;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id B568FE0361; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 08/10] s390/dasd: Display FC Endpoint Security information via sysfs
Date:   Fri,  2 Oct 2020 21:39:38 +0200
Message-Id: <20201002193940.24012-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 spamscore=0 mlxlogscore=949 malwarescore=0 suspectscore=3 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

Add a new sysfs attribute (fc_security) per device and per operational
channel path. The information of the current FC Endpoint Security state
is received through the CIO layer.

The state of the FC Endpoint Security can be either "Unsupported",
"Authentication", or "Encryption".

For example:
$ cat /sys/bus/ccw/devices/0.0.c600/fc_security
Encryption

If any of the operational paths is in a state different from all
others, the device sysfs attribute will display the additional state
"Inconsistent".

The sysfs attributes per paths are organised in a new directory called
"paths_info" with subdirectories for each path.

/sys/bus/ccw/devices/0.0.c600/paths_info/
├── 0.38
│   └── fc_security
├── 0.39
│   └── fc_security
├── 0.3a
│   └── fc_security
└── 0.3b
    └── fc_security

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c   |  30 +++++++++
 drivers/s390/block/dasd_int.h    |  68 ++++++++++++++++++++
 3 files changed, 203 insertions(+)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 32fc51341d99..d4af087ecfe7 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -576,6 +576,11 @@ dasd_create_device(struct ccw_device *cdev)
 	dev_set_drvdata(&cdev->dev, device);
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 
+	device->paths_info = kset_create_and_add("paths_info", NULL,
+						 &device->cdev->dev.kobj);
+	if (!device->paths_info)
+		dev_warn(&cdev->dev, "Could not create paths_info kset\n");
+
 	return device;
 }
 
@@ -622,6 +627,9 @@ dasd_delete_device(struct dasd_device *device)
 	wait_event(dasd_delete_wq, atomic_read(&device->ref_count) == 0);
 
 	dasd_generic_free_discipline(device);
+
+	kset_unregister(device->paths_info);
+
 	/* Disconnect dasd_device structure from ccw_device structure. */
 	cdev = device->cdev;
 	device->cdev = NULL;
@@ -1641,6 +1649,39 @@ dasd_path_interval_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(path_interval, 0644, dasd_path_interval_show,
 		   dasd_path_interval_store);
 
+static ssize_t
+dasd_device_fcs_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct dasd_device *device;
+	int fc_sec;
+	int rc;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+	fc_sec = dasd_path_get_fcs_device(device);
+	if (fc_sec == -EINVAL)
+		rc = snprintf(buf, PAGE_SIZE, "Inconsistent\n");
+	else
+		rc = snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+	dasd_put_device(device);
+
+	return rc;
+}
+static DEVICE_ATTR(fc_security, 0444, dasd_device_fcs_show, NULL);
+
+static ssize_t
+dasd_path_fcs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct dasd_path *path = to_dasd_path(kobj);
+	unsigned int fc_sec = path->fc_security;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", dasd_path_get_fcs_str(fc_sec));
+}
+
+static struct kobj_attribute path_fcs_attribute =
+	__ATTR(fc_security, 0444, dasd_path_fcs_show, NULL);
 
 #define DASD_DEFINE_ATTR(_name, _func)					\
 static ssize_t dasd_##_name##_show(struct device *dev,			\
@@ -1697,6 +1738,7 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_path_reset.attr,
 	&dev_attr_hpf.attr,
 	&dev_attr_ese.attr,
+	&dev_attr_fc_security.attr,
 	NULL,
 };
 
@@ -1777,6 +1819,69 @@ dasd_set_feature(struct ccw_device *cdev, int feature, int flag)
 }
 EXPORT_SYMBOL(dasd_set_feature);
 
+static struct attribute *paths_info_attrs[] = {
+	&path_fcs_attribute.attr,
+	NULL,
+};
+
+static struct kobj_type path_attr_type = {
+	.release	= dasd_path_release,
+	.default_attrs	= paths_info_attrs,
+	.sysfs_ops	= &kobj_sysfs_ops,
+};
+
+static void dasd_path_init_kobj(struct dasd_device *device, int chp)
+{
+	device->path[chp].kobj.kset = device->paths_info;
+	kobject_init(&device->path[chp].kobj, &path_attr_type);
+}
+
+void dasd_path_create_kobj(struct dasd_device *device, int chp)
+{
+	int rc;
+
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags))
+		return;
+	if (!device->paths_info) {
+		dev_warn(&device->cdev->dev, "Unable to create paths objects\n");
+		return;
+	}
+	if (device->path[chp].in_sysfs)
+		return;
+	if (!device->path[chp].conf_data)
+		return;
+
+	dasd_path_init_kobj(device, chp);
+
+	rc = kobject_add(&device->path[chp].kobj, NULL, "%x.%02x",
+			 device->path[chp].cssid, device->path[chp].chpid);
+	if (rc)
+		kobject_put(&device->path[chp].kobj);
+	device->path[chp].in_sysfs = true;
+}
+EXPORT_SYMBOL(dasd_path_create_kobj);
+
+void dasd_path_create_kobjects(struct dasd_device *device)
+{
+	u8 lpm, opm;
+
+	opm = dasd_path_get_opm(device);
+	for (lpm = 0x80; lpm; lpm >>= 1) {
+		if (!(lpm & opm))
+			continue;
+		dasd_path_create_kobj(device, pathmask_to_pos(lpm));
+	}
+}
+EXPORT_SYMBOL(dasd_path_create_kobjects);
+
+void dasd_path_remove_kobj(struct dasd_device *device, int chp)
+{
+	if (device->path[chp].in_sysfs) {
+		kobject_put(&device->path[chp].kobj);
+		device->path[chp].in_sysfs = false;
+	}
+}
+EXPORT_SYMBOL(dasd_path_remove_kobj);
 
 int dasd_add_sysfs_files(struct ccw_device *cdev)
 {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 271768e4606c..63061ff5ecab 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1030,6 +1030,30 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
 		dasd_path_notoper(device, i);
+		dasd_path_remove_kobj(device, i);
+	}
+}
+
+static void dasd_eckd_read_fc_security(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+	u8 esm_valid;
+	u8 esm[8];
+	int chp;
+	int rc;
+
+	rc = chsc_scud(private->uid.ssid, (u64 *)esm, &esm_valid);
+	if (rc) {
+		for (chp = 0; chp < 8; chp++)
+			device->path[chp].fc_security = 0;
+		return;
+	}
+
+	for (chp = 0; chp < 8; chp++) {
+		if (esm_valid & (0x80 >> chp))
+			device->path[chp].fc_security = esm[chp];
+		else
+			device->path[chp].fc_security = 0;
 	}
 }
 
@@ -1159,6 +1183,8 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 		}
 	}
 
+	dasd_eckd_read_fc_security(device);
+
 	return path_err;
 }
 
@@ -1425,6 +1451,8 @@ static void do_path_verification_work(struct work_struct *work)
 		dasd_path_add_cablepm(device, cablepm);
 		dasd_path_add_nohpfpm(device, hpfpm);
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+
+		dasd_path_create_kobj(device, pos);
 	}
 	clear_bit(DASD_FLAG_PATH_VERIFY, &device->flags);
 	dasd_put_device(device);
@@ -2064,6 +2092,8 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	if (rc)
 		goto out_err3;
 
+	dasd_path_create_kobjects(device);
+
 	/* Read Feature Codes */
 	dasd_eckd_read_features(device);
 
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 6dce9d4c55ce..93d9cc938924 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -426,6 +426,35 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_THRHLD_MAX		4294967295U
 #define DASD_INTERVAL_MAX	4294967295U
 
+/* FC Endpoint Security Capabilities */
+#define DASD_FC_SECURITY_UNSUP		0
+#define DASD_FC_SECURITY_AUTH		1
+#define DASD_FC_SECURITY_ENC_FCSP2	2
+#define DASD_FC_SECURITY_ENC_ERAS	3
+
+#define DASD_FC_SECURITY_ENC_STR	"Encryption"
+static const struct {
+	u8 value;
+	char *name;
+} dasd_path_fcs_mnemonics[] = {
+	{ DASD_FC_SECURITY_UNSUP,	"Unsupported" },
+	{ DASD_FC_SECURITY_AUTH,	"Authentication" },
+	{ DASD_FC_SECURITY_ENC_FCSP2,	DASD_FC_SECURITY_ENC_STR },
+	{ DASD_FC_SECURITY_ENC_ERAS,	DASD_FC_SECURITY_ENC_STR },
+};
+
+static inline char *dasd_path_get_fcs_str(int val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dasd_path_fcs_mnemonics); i++) {
+		if (dasd_path_fcs_mnemonics[i].value == val)
+			return dasd_path_fcs_mnemonics[i].name;
+	}
+
+	return dasd_path_fcs_mnemonics[0].name;
+}
+
 struct dasd_path {
 	unsigned long flags;
 	u8 cssid;
@@ -434,8 +463,18 @@ struct dasd_path {
 	struct dasd_conf_data *conf_data;
 	atomic_t error_count;
 	unsigned long errorclk;
+	u8 fc_security;
+	struct kobject kobj;
+	bool in_sysfs;
 };
 
+#define to_dasd_path(path) container_of(path, struct dasd_path, kobj)
+
+static inline void dasd_path_release(struct kobject *kobj)
+{
+/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
+}
+
 
 struct dasd_profile_info {
 	/* legacy part of profile data, as in dasd_profile_info_t */
@@ -547,6 +586,7 @@ struct dasd_device {
 	struct dentry *hosts_dentry;
 	struct dasd_profile profile;
 	struct dasd_format_entry format_entry;
+	struct kset *paths_info;
 };
 
 struct dasd_block {
@@ -824,6 +864,9 @@ int dasd_set_feature(struct ccw_device *, int, int);
 
 int dasd_add_sysfs_files(struct ccw_device *);
 void dasd_remove_sysfs_files(struct ccw_device *);
+void dasd_path_create_kobj(struct dasd_device *, int);
+void dasd_path_create_kobjects(struct dasd_device *);
+void dasd_path_remove_kobj(struct dasd_device *, int);
 
 struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
 struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);
@@ -1113,6 +1156,31 @@ static inline __u8 dasd_path_get_hpfpm(struct dasd_device *device)
 	return hpfpm;
 }
 
+static inline u8 dasd_path_get_fcs_path(struct dasd_device *device, int chp)
+{
+	return device->path[chp].fc_security;
+}
+
+static inline int dasd_path_get_fcs_device(struct dasd_device *device)
+{
+	u8 fc_sec = 0;
+	int chp;
+
+	for (chp = 0; chp < 8; chp++) {
+		if (device->opm & (0x80 >> chp)) {
+			fc_sec = device->path[chp].fc_security;
+			break;
+		}
+	}
+	for (; chp < 8; chp++) {
+		if (device->opm & (0x80 >> chp))
+			if (device->path[chp].fc_security != fc_sec)
+				return -EINVAL;
+	}
+
+	return fc_sec;
+}
+
 /*
  * add functions for path masks
  * the existing path mask will be extended by the given path mask
-- 
2.17.1

