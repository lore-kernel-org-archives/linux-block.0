Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7B1BDA9C
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822576; cv=none; b=OC7JVrNaLbCfo+oRtLWH+dUEF8AzHF6CDH6QlfZD9Yb/epPBm0YeH2zDcXcVQhC2kYiMvm5Ll7kNsgdaKN06DAjeg7ucPqybKIXl6MI0gZmm/otk5J8RHgRnW6et9FQpY0/AlEw3i8Ky1y04EIGa1f9cy9CS8QgopxAEx48NZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822576; c=relaxed/simple;
	bh=lC240onsi8NsKlL3gj1Ng0HABuwhLZLWIXAcUcacBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBoLU85Jd35hS6wZOH3CPul/7vpFlmSR1PCiy0oN6GMHlNYI3InPbPpo0mAoZBqDH6fgLgF4N7eqQYbfrRfHnLT+2rh43yolYZRHzl+2nStXr+TvOEEl7JzG0Qs2+64k16cGMhT1xWeDuYipXRPqmEwpuMhEwmz85DFQ+DPiVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMAJyinT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMAJyinT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GBLUpa005892;
	Fri, 16 Aug 2024 15:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=uLrTSB0eQcs0G
	6bBGLLNzhf6ihtvt1st+VJLhMrZ4vo=; b=AMAJyinTwbFn0BXhOJE+QnFQVDMdM
	Y7FsYuzxu6b4KQ7gM8z5zV0moITEWVSezmpNHUwDfOo7VWDYuhWsJaUC0QqA4CdN
	No8TgrP1ErzaPTz/wuHr2V0MJQTbbERsao9a5fpDoNlTaHC4lB+9aqSPiMHp7f1/
	ciUwYoHDVM7T9OTU2n9xoCNsoGA+3P2SiaRbufdUc3+w9UVC0Sgx2we14AntDOSF
	HUh6vovyrbgA8DV5/WOKRVW2CFyMDMDE0ZmVoESJ8Jckken5o1Zll1x+m86N9+d7
	1tDICL51RMkLOuafd6JppCsUboJQvXjJq6ZTX4r1Apde7v75CBLzWLMcQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6h1tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:36:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47GFGKkn016980;
	Fri, 16 Aug 2024 15:36:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhq49fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:36:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47GFZxZC63045974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 15:36:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23DA58063;
	Fri, 16 Aug 2024 15:35:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FF2D58055;
	Fri, 16 Aug 2024 15:35:58 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 15:35:58 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, msuchanek@suse.de, jonathan.derrick@linux.dev,
        gjoyce@linux.ibm.com
Subject: [PATCH 1/1] block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
Date: Fri, 16 Aug 2024 10:35:57 -0500
Message-ID: <20240816153557.11734-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240816153557.11734-1-gjoyce@linux.ibm.com>
References: <20240816153557.11734-1-gjoyce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yGUHPpYM2if56Nw_wi3382nNL31lmzqz
X-Proofpoint-GUID: yGUHPpYM2if56Nw_wi3382nNL31lmzqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=819 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160109

From: Greg Joyce <gjoyce@linux.ibm.com>

After a SED drive is provisioned, there is no way to change the SID
password via the ioctl() interface. A new ioctl IOC_OPAL_SET_SID_PW
will allow the password to be changed. The valid current password is
required.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
---
 block/sed-opal.c              | 26 ++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 598fd3e7fcc8..5a28f23f7f22 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -3037,6 +3037,29 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	return ret;
 }
 
+static int opal_set_new_sid_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
+{
+	int ret;
+	struct opal_key *newkey = &opal_pw->new_user_pw.opal_key;
+	struct opal_key *oldkey = &opal_pw->session.opal_key;
+
+	const struct opal_step pw_steps[] = {
+		{ start_SIDASP_opal_session, oldkey },
+		{ set_sid_cpin_pin, newkey },
+		{ end_opal_session, }
+	};
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 static int opal_activate_user(struct opal_dev *dev,
 			      struct opal_session_info *opal_session)
 {
@@ -3286,6 +3309,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_DISCOVERY:
 		ret = opal_get_discv(dev, p);
 		break;
+	case IOC_OPAL_SET_SID_PW:
+		ret = opal_set_new_sid_pw(dev, p);
+		break;
 
 	default:
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 2ac50822554e..80f33a93f944 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -52,6 +52,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_GET_GEOMETRY:
 	case IOC_OPAL_DISCOVERY:
 	case IOC_OPAL_REVERT_LSP:
+	case IOC_OPAL_SET_SID_PW:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index d3994b7716bc..9025dd5a4f0f 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -215,5 +215,6 @@ struct opal_revert_lsp {
 #define IOC_OPAL_GET_GEOMETRY       _IOR('p', 238, struct opal_geometry)
 #define IOC_OPAL_DISCOVERY          _IOW('p', 239, struct opal_discovery)
 #define IOC_OPAL_REVERT_LSP         _IOW('p', 240, struct opal_revert_lsp)
+#define IOC_OPAL_SET_SID_PW         _IOW('p', 241, struct opal_new_pw)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
gjoyce@linux.ibm.com

