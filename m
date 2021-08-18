Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC97C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE1F61051
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhHRMWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 08:22:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233634AbhHRMWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 08:22:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ICESJv104296
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 08:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Q35Mc2eLLkalVrnznk1W3lDRDTISHBFaqMOwseF/74k=;
 b=qXn2cjV6t876uZi8zi9F1659Chgk8mgovxhjnd871ftarVRhd+JxjzUteri6bzXiCmhN
 gB28Bskmaff1iRMlEcxggtnRtC/qSRPajT3UrkzyISy0As8IWoOVG2kKDHz5ZGjfMI5S
 VEPZmqLYlycW8jLSRzfSLUqNkzNDl18dg+oB8tBogJ53zzD1HdXZhNu4VNBVuUuTG1+9
 XNSmmaG9gLd7/I18RhnMhYJxmARh47eMcpa8QF1NJBpkBmxbFzxeJNzRNmUx+rSi3wGn
 SibWn1KN4OMk800EX9iGL1Auz8gJSA4lkUHvz28nmSDJ++IyVV35Lg911vfvCoPy62++ eA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp1yhrq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 08:22:12 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ICC77N021424
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 12:22:11 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3ae5fdc4rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 12:22:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ICMAL614090518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 12:22:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99090124064;
        Wed, 18 Aug 2021 12:22:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F29F124052;
        Wed, 18 Aug 2021 12:22:10 +0000 (GMT)
Received: from oc5726284525.ibm.com (unknown [9.160.59.86])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Aug 2021 12:22:10 +0000 (GMT)
From:   Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH RESEND] block: sed-opal: Add ioctl to return device status
To:     linux-block@vger.kernel.org
Message-ID: <c43a9295-1dad-fa0a-590d-0182bba643a1@linux.vnet.ibm.com>
Date:   Wed, 18 Aug 2021 07:22:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RKA38lT0VXx9ugL3FThqWtPhcUSFGwy-
X-Proofpoint-GUID: RKA38lT0VXx9ugL3FThqWtPhcUSFGwy-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_04:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180076
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a mechanism to retrieve basic status information about
the device, including the "supported" flag indicating whether
SED-OPAL is supported. The information returned is from the various
feature descriptors received during the discovery0 step, and so
this ioctl does nothing more than perform the discovery0 step
and then save the information received. See "struct opal_status"
for the status information currently returned.

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
  block/opal_proto.h            |  5 +++
  block/sed-opal.c              | 81 ++++++++++++++++++++++++++++++++++--
  include/linux/sed-opal.h      |  1 +
  include/uapi/linux/sed-opal.h | 11 +++++
  4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3e..7152aa1 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
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
diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadb..6a67b20 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -75,7 +75,11 @@ struct parsed_resp {
  
  struct opal_dev {
  	bool supported;
+	bool locking_supported;
+	bool locking_enabled;
+	bool locked;
  	bool mbr_enabled;
+	bool mbr_done;
  
  	void *data;
  	sec_send_recv *send_recv;
@@ -280,6 +284,30 @@ static bool check_tper(const void *data)
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
@@ -288,6 +316,14 @@ static bool check_mbrenabled(const void *data)
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
@@ -435,7 +471,11 @@ static int opal_discovery0_end(struct opal_dev *dev)
  	u32 hlen = be32_to_cpu(hdr->length);
  
  	print_buffer(dev->resp, hlen);
+	dev->locking_supported = false;
+	dev->locking_enabled = false;
+	dev->locked = false;
  	dev->mbr_enabled = false;
+	dev->mbr_done = false;
  
  	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
  		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
@@ -461,7 +501,11 @@ static int opal_discovery0_end(struct opal_dev *dev)
  			check_geometry(dev, body);
  			break;
  		case FC_LOCKING:
+			dev->locking_supported = check_lcksuppt(body->features);
+			dev->locking_enabled = check_lckenabled(body->features);
+			dev->locked = check_locked(body->features);
  			dev->mbr_enabled = check_mbrenabled(body->features);
+			dev->mbr_done = check_mbrdone(body->features);
  			break;
  		case FC_ENTERPRISE:
  		case FC_DATASTORE:
@@ -2620,6 +2664,29 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
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
+		sts.opal_supported = dev->supported;
+		sts.locking_supported = dev->locking_supported;
+		sts.locking_enabled = dev->locking_enabled;
+		sts.locked = dev->locked;
+		sts.mbr_enabled = dev->mbr_enabled;
+		sts.mbr_done = dev->mbr_done;
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
@@ -2632,9 +2699,11 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
  	if (!dev->supported)
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
@@ -2685,11 +2754,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
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
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 1ac0d71..6f837bb 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
  	case IOC_OPAL_MBR_DONE:
  	case IOC_OPAL_WRITE_SHADOW_MBR:
  	case IOC_OPAL_GENERIC_TABLE_RW:
+	case IOC_OPAL_GET_STATUS:
  		return true;
  	}
  	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 6f5af1a..535ffc5 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -132,6 +132,16 @@ struct opal_read_write_table {
  	__u64 priv;
  };
  
+struct opal_status {
+	__u8 opal_supported;
+	__u8 locking_supported;
+	__u8 locking_enabled;
+	__u8 locked;
+	__u8 mbr_enabled;
+	__u8 mbr_done;
+	__u8 __align[2];
+};
+
  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -148,5 +158,6 @@ struct opal_read_write_table {
  #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
  #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
  #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
+#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
  
  #endif /* _UAPI_SED_OPAL_H */
-- 
1.8.3.1

