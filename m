Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227801B5824
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954217; cv=none; b=VcsJCmd1VvJzURB0n+AhYYilHxoQ/awwuNaTrksuCmUClz8lIkka6yg9eQXjal4+AVhO7gzYINq3aJtQKZI0tOs3Q9wxA9fjxLsh7R/Wm1QrLjNHGCOtsWpbcYa0gU19doemD3UAjn08/CpK3+LpSjq4nNvvLTsi5oT2cEwPCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954217; c=relaxed/simple;
	bh=WygMds+JjYt3QKO+5G/DDmyBOvqp2yyCYa15a7J/2H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY8m/HRG35BEHLw4NXJ09rg4YpLbyZ9jDoxGlJBrRirr9HMBE/xtQ/oaOt+rc2OexW/yDwPs9Tvmeupxho/Au3EVzkC2plUYbVLvzHpxCEnRBpoLXqseMlo0iLGec5ISR8biiqYkM+n14X0Emwuep8VepoE7rfGAB+Vw0rtqr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tKDp8q9r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tKDp8q9r"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THeOOH010288;
	Thu, 29 Aug 2024 17:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=64lPvutV+uFnh
	wmpUl2SZH6ht8xzdcUoDaU2jVe7yow=; b=tKDp8q9rBpPTpK8IdZDjF4Dbco1fP
	Drre6kGbUOWmwS9OZiiVQQXQ6OVPZ1Uy3V3H797kHzeTffpxzSvFxmY58baPK9dX
	FSh3Gke4+W6Jptqp4Akh+EuoTYTdILw1fQDo3j+te8VHi48L+1JYBqODrFhq8Jk+
	f4xivRHJNIkzSyv21RTtB6BRlP/e2fP5XD3PvMN5z7NVSJ/G0l/E8yI6Kd2dDTIB
	GutgMMCOq6DEHyTMMe4PYRUELz6qNWquWkSZLDub/W0KUcxJzqIW1f4gZFh45Yfe
	yjf0Cybw8mKq7lRT54OaLQ07geXvAUNedC5qKbLoxk9M/M6VfiLn46Iqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u99ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 17:56:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFpWjf008239;
	Thu, 29 Aug 2024 17:56:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 417v2mwnt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 17:56:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47THueuE4457126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:56:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52A7E58073;
	Thu, 29 Aug 2024 17:56:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF1075809D;
	Thu, 29 Aug 2024 17:56:39 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Aug 2024 17:56:39 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, msuchanek@suse.de, jonathan.derrick@linux.dev,
        gjoyce@linux.ibm.com, dwagner@suse.de
Subject: [PATCH v2 1/1] block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
Date: Thu, 29 Aug 2024 12:56:11 -0500
Message-ID: <20240829175639.6478-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829175639.6478-1-gjoyce@linux.ibm.com>
References: <20240829175639.6478-1-gjoyce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AzjONqdFWvvrJNla_Ad8Kp3DuEePtufI
X-Proofpoint-ORIG-GUID: AzjONqdFWvvrJNla_Ad8Kp3DuEePtufI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=805 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290125

From: Greg Joyce <gjoyce@linux.ibm.com>

After a SED drive is provisioned, there is no way to change the SID
password via the ioctl() interface. A new ioctl IOC_OPAL_SET_SID_PW
will allow the password to be changed. The valid current password is
required.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
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

