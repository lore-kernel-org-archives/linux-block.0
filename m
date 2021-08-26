Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1CFC43214
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9501160FDC
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhHZNXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:23:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhHZNXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:23:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QD7HQj143909;
        Thu, 26 Aug 2021 09:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=si7NNdhVzKzPsm16qmcpk+CZ6bQ+9tv7NIs9cbunYuQ=;
 b=nkdNrxXQUUomLxcdQtiguGfnSQthkThHB7nER+lDwK8/iI/0EYK7ewWy+kpHrWe3gNxm
 XvxnY1NYDU+30/S2gG/geDguIrUcE4RlSY7YYqCk+1qMSH1kYDY+5nROcnApSX4uNsiI
 Wf0j8UYZfvCbf/YQBnsJxO98tCiIn1EOKrHMH0G3/j+LfC3leA3IMLmuyFkfuswyPTwn
 iJLxdbB8hgWdEPiEvjurv/OsQAsPMLM9caPOueghMOziBPn60/I7JIm0VFe+5Xqkxk0q
 cIe3xMK0eVKDXAes3BfDR00JZeR1m9UVa9P7kqt8+daniNQBF9MOAoUF+4/Ge9BB9bYv Tg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apajsa26c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 09:23:05 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17QDCM7s029931;
        Thu, 26 Aug 2021 13:23:03 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3ajs4ef39j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 13:23:03 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17QDN2cP36569388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 13:23:02 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 798E5AE060;
        Thu, 26 Aug 2021 13:23:02 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC676AE05C;
        Thu, 26 Aug 2021 13:23:01 +0000 (GMT)
Received: from li-85aba201-53f2-11cb-b5ad-ae21909f0c1f (unknown [9.160.59.78])
        by b01ledav005.gho.pok.ibm.com (Postfix) with SMTP;
        Thu, 26 Aug 2021 13:23:01 +0000 (GMT)
Date:   Thu, 26 Aug 2021 08:23:01 -0500
From:   dougmill@linux.vnet.ibm.com
To:     jonathan.derrick@intel.com, revanth.rajashekar@intel.com,
        linux-block@vger.kernel.org
Subject: [PATCH V2] block: sed-opal: Add ioctl to return device status
Message-ID: <612795b5.tj7FMS9wzchsMzrK%dougmill@linux.vnet.ibm.com>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 10yhcLxszbYGrQs7xaQN7_iatXYl9YDd
X-Proofpoint-ORIG-GUID: 10yhcLxszbYGrQs7xaQN7_iatXYl9YDd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_03:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260081
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a mechanism to retrieve basic status information about
the device, including the "supported" flag indicating whether
SED-OPAL is supported. The information returned is from the various
feature descriptors received during the discovery0 step, and so
this ioctl does nothing more than perform the discovery0 step
and then save the information received. See "struct opal_status"
and OPAL_FL_* bits for the status information currently returned.

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 kernel/block/opal_proto.h            |  5 ++
 kernel/block/sed-opal.c              | 90 ++++++++++++++++++++++++----
 kernel/include/linux/sed-opal.h      |  1 +
 kernel/include/uapi/linux/sed-opal.h | 12 ++++
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/kernel/block/opal_proto.h b/kernel/block/opal_proto.h
index b486b3e..7152aa1 100644
--- a/kernel/block/opal_proto.h
+++ b/kernel/block/opal_proto.h
@@ -39,7 +39,12 @@ enum opal_response_token {
 #define FIRST_TPER_SESSION_NUM	4096
 
 #define TPER_SYNC_SUPPORTED 0x01
+/* FC_LOCKING features */
+#define LOCKING_SUPPORTED_MASK 0x01
+#define LOCKING_ENABLED_MASK 0x02
+#define LOCKED_MASK 0x04
 #define MBR_ENABLED_MASK 0x10
+#define MBR_DONE_MASK 0x20
 
 #define TINY_ATOM_DATA_MASK 0x3F
 #define TINY_ATOM_SIGNED 0x40
diff --git a/kernel/block/sed-opal.c b/kernel/block/sed-opal.c
index daafadb..3a9c235 100644
--- a/kernel/block/sed-opal.c
+++ b/kernel/block/sed-opal.c
@@ -74,8 +74,7 @@ struct parsed_resp {
 };
 
 struct opal_dev {
-	bool supported;
-	bool mbr_enabled;
+	u32 flags;
 
 	void *data;
 	sec_send_recv *send_recv;
@@ -280,6 +279,30 @@ static bool check_tper(const void *data)
 	return true;
 }
 
+static bool check_lcksuppt(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKING_SUPPORTED_MASK);
+}
+
+static bool check_lckenabled(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKING_ENABLED_MASK);
+}
+
+static bool check_locked(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & LOCKED_MASK);
+}
+
 static bool check_mbrenabled(const void *data)
 {
 	const struct d0_locking_features *lfeat = data;
@@ -288,6 +311,14 @@ static bool check_mbrenabled(const void *data)
 	return !!(sup_feat & MBR_ENABLED_MASK);
 }
 
+static bool check_mbrdone(const void *data)
+{
+	const struct d0_locking_features *lfeat = data;
+	u8 sup_feat = lfeat->supported_features;
+
+	return !!(sup_feat & MBR_DONE_MASK);
+}
+
 static bool check_sum(const void *data)
 {
 	const struct d0_single_user_mode *sum = data;
@@ -435,7 +466,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	u32 hlen = be32_to_cpu(hdr->length);
 
 	print_buffer(dev->resp, hlen);
-	dev->mbr_enabled = false;
+	dev->flags &= OPAL_FL_SUPPORTED;
 
 	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
 		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
@@ -461,7 +492,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
 			check_geometry(dev, body);
 			break;
 		case FC_LOCKING:
-			dev->mbr_enabled = check_mbrenabled(body->features);
+			if (check_lcksuppt(body->features))
+				dev->flags |= OPAL_FL_LOCKING_SUPPORTED;
+			if (check_lckenabled(body->features))
+				dev->flags |= OPAL_FL_LOCKING_ENABLED;
+			if (check_locked(body->features))
+				dev->flags |= OPAL_FL_LOCKED;
+			if (check_mbrenabled(body->features))
+				dev->flags |= OPAL_FL_MBR_ENABLED;
+			if (check_mbrdone(body->features))
+				dev->flags |= OPAL_FL_MBR_DONE;
 			break;
 		case FC_ENTERPRISE:
 		case FC_DATASTORE:
@@ -2109,7 +2149,8 @@ static int check_opal_support(struct opal_dev *dev)
 	mutex_lock(&dev->dev_lock);
 	setup_opal_dev(dev);
 	ret = opal_discovery0_step(dev);
-	dev->supported = !ret;
+	if (!ret)
+		dev->flags |= OPAL_FL_SUPPORTED;
 	mutex_unlock(&dev->dev_lock);
 
 	return ret;
@@ -2148,6 +2189,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 
 	INIT_LIST_HEAD(&dev->unlk_lst);
 	mutex_init(&dev->dev_lock);
+	dev->flags = 0;
 	dev->data = data;
 	dev->send_recv = send_recv;
 	if (check_opal_support(dev) != 0) {
@@ -2528,7 +2570,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 	if (!dev)
 		return false;
 
-	if (!dev->supported)
+	if (!(dev->flags & OPAL_FL_SUPPORTED))
 		return false;
 
 	mutex_lock(&dev->dev_lock);
@@ -2546,7 +2588,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 			was_failure = true;
 		}
 
-		if (dev->mbr_enabled) {
+		if (dev->flags & OPAL_FL_MBR_ENABLED) {
 			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
 			if (ret)
 				pr_debug("Failed to set MBR Done in S3 resume\n");
@@ -2620,6 +2662,24 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_get_status(struct opal_dev *dev, void __user *data)
+{
+	struct opal_status sts = {0};
+
+	/*
+	 * check_opal_support() error is not fatal,
+	 * !dev->supported is a valid condition
+	 */
+	if (!check_opal_support(dev)) {
+		sts.flags = dev->flags;
+	}
+	if (copy_to_user(data, &sts, sizeof(sts))) {
+		pr_debug("Error copying status to userspace\n");
+		return -EFAULT;
+	}
+	return 0;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -2629,12 +2689,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 		return -EACCES;
 	if (!dev)
 		return -ENOTSUPP;
-	if (!dev->supported)
+	if (!(dev->flags & OPAL_FL_SUPPORTED))
 		return -ENOTSUPP;
 
-	p = memdup_user(arg, _IOC_SIZE(cmd));
-	if (IS_ERR(p))
-		return PTR_ERR(p);
+	if (cmd & IOC_IN) {
+		p = memdup_user(arg, _IOC_SIZE(cmd));
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+	}
 
 	switch (cmd) {
 	case IOC_OPAL_SAVE:
@@ -2685,11 +2747,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GENERIC_TABLE_RW:
 		ret = opal_generic_read_write_table(dev, p);
 		break;
+	case IOC_OPAL_GET_STATUS:
+		ret = opal_get_status(dev, arg);
+		break;
 	default:
 		break;
 	}
 
-	kfree(p);
+	if (cmd & IOC_IN)
+		kfree(p);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sed_ioctl);
diff --git a/kernel/include/linux/sed-opal.h b/kernel/include/linux/sed-opal.h
index 1ac0d71..6f837bb 100644
--- a/kernel/include/linux/sed-opal.h
+++ b/kernel/include/linux/sed-opal.h
@@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_MBR_DONE:
 	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_GENERIC_TABLE_RW:
+	case IOC_OPAL_GET_STATUS:
 		return true;
 	}
 	return false;
diff --git a/kernel/include/uapi/linux/sed-opal.h b/kernel/include/uapi/linux/sed-opal.h
index 6f5af1a..c55bc79 100644
--- a/kernel/include/uapi/linux/sed-opal.h
+++ b/kernel/include/uapi/linux/sed-opal.h
@@ -132,6 +132,17 @@ struct opal_read_write_table {
 	__u64 priv;
 };
 
+#define OPAL_FL_SUPPORTED		0x00000001
+#define OPAL_FL_LOCKING_SUPPORTED	0x00000002
+#define OPAL_FL_LOCKING_ENABLED		0x00000004
+#define OPAL_FL_LOCKED			0x00000008
+#define OPAL_FL_MBR_ENABLED		0x00000010
+#define OPAL_FL_MBR_DONE		0x00000020
+
+struct opal_status {
+	__u32 flags;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -148,5 +159,6 @@ struct opal_read_write_table {
 #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
+#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.27.0

