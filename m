Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092422DFF3
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577260; cv=none; b=LrCQ8TVVMNKrYYZ7iRqIdP/gBZW1swmx1Y+qaCudhErWqo/ZtS2NvBo4W2FdBU2g64KmaC3VLltVUfKELRn17RFfjCjKBueiMtH4NzmaCLBNHpjxw4mGeMoR5L37ygF7Vr6IuhZQo8ifdKni1bCtDh3WijqdBKZh9G8SEHIgtIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577260; c=relaxed/simple;
	bh=PbX0V9LaLNXYFQUVODV1fyPvEuLH8pILaAwNvK+LZ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Coa5CmU3+ELBtLrhvdeaJ9Zk8nT6+r4HEHw6rQ3HVpd+v5XP1VX9Emp0v/Cwx1FawPM4jOoZRHlQURIUcd7AhJVf6CGxUsqLPDaJNTxVfc7vXbXxu6VF85Q7/uYu7FeXqBuAfQKhDmV1lK9rP/yICfsBIe4obqE22B0MHROy0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tGWW8ftq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tGWW8ftq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9VXrk000354;
	Fri, 25 Apr 2025 10:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KqFdPecrayYnecCFk
	666EkqKL4jMfv3H7u66r4u4XhM=; b=tGWW8ftq+CzJSYlx5+7KTwJuddGMAupZB
	kwBqDknIQqXtIKnypeZ/QiUiTqRiNmCjS0Vdcwvzrv/osvR9KvfTPe0dVKC6PTgb
	fQNxelsRn3batChOPGbY4fzfP4eQ+Zlq5RZuizIQ6ekKgYMyQO5D/ZsTlG4rRdDU
	F0oP+CjvPKp+3vcAdAx+ekmT6C0xo3jlpqZf7E3nKbgAvYv5LiS0NdaaIQfwM9cb
	0nwxyScDCaGdmH37KahsEmWYXPVi7QNYXhlLYKfhdp28r9qR9PH/GNRJaI1NwSro
	ZxuSG5oMXCHxqqjkFWCA5DzEyXhsL6VPhLa/vkxxIesk9/RRsYcbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467vvktuwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8sCuU028426;
	Fri, 25 Apr 2025 10:33:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvvrma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PAXW7T53477826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:33:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E932004D;
	Fri, 25 Apr 2025 10:33:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14F120040;
	Fri, 25 Apr 2025 10:33:28 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:33:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module param
Date: Fri, 25 Apr 2025 16:03:09 +0530
Message-ID: <20250425103319.1185884-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425103319.1185884-1-nilay@linux.ibm.com>
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX5ydzEWveadDG k1TH/QRkfkNhjiVKGoywqjIMq4KlTYe3BGa5wbFePcl3Knh3bbdN//GcDJvDHfRru+pq4fBwhOY 2LixOwNg83b+4AH8YmZfPJ733Tk3scIde1+vEQmQ/A+scAWWNeGGLR4GlNgBQlLpTNAg+LbbmYt
 TZaykZAaF+R7JKNM4yo6JaZb63NiUWKsKVrB+RTzs5TK/IiidQsxJpH6xlpJQJohCVQvCfoKvic 1qeulzh0Ungs0CJcnzC83V/QbXg2ib9CqClUsjNdnBE8xdR6AU7nczYi8t6mE7+dvyx90/U4H3J XfkjG9ngVUWUunBiXUmQsZbgF821aktyjuawOCqg614YKqNHRLfk0fMADj+D34YtVZNx3IfAxg5
 6xzyHEFjU3gRuoJxWiRxgCu0xKjBhkbgcCsNVDgkYL6fqvk/zQcSlUIli/lcjVTn9Sr+w2o5
X-Proofpoint-ORIG-GUID: AIf-9ocvIS9kpQUrjQpYBBfAWaZGa-g6
X-Proofpoint-GUID: AIf-9ocvIS9kpQUrjQpYBBfAWaZGa-g6
X-Authority-Analysis: v=2.4 cv=HoF2G1TS c=1 sm=1 tr=0 ts=680b64ff cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=YAlafS6B6ijdj31roQ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250073

Currently, a multipath head disk node is not created for single-ported
NVMe adapters or private namespaces. However, creating a head node in
these cases can help transparently handle transient PCIe link failures.
Without a head node, features like delayed removal cannot be leveraged,
making it difficult to tolerate such link failures. To address this,
this commit introduces nvme_core module parameter multipath_head_always.

When this param is set to true, it forces the creation of a multipath
head node regardless NVMe disk or namespace type. So this option allows
the use of delayed removal of head node functionality even for single-
ported NVMe disks and private namespaces and thus helps transparently
handling transient PCIe link failures.

By default multipath_head_always is set to false, thus preserving the
existing behavior. Setting it to true enables improved fault tolerance
in PCIe setups. Moreover, please note that enabling this option would
also implicitly enable nvme_core.multipath.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 68318337c275..1acdbbddfe01 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,59 @@
 #include "nvme.h"
 
 bool multipath = true;
-module_param(multipath, bool, 0444);
+bool multipath_head_always;	/* default is flase */
+
+static int multipath_param_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (ret)
+		return ret;
+
+	if (multipath_head_always && !*(bool *)kp->arg) {
+		pr_err("Can't disable multipath when multipath_head_always is configured.\n");
+		*(bool *)kp->arg = true;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct kernel_param_ops multipath_param_ops = {
+	.set = multipath_param_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(multipath, &multipath_param_ops, &multipath, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static int multipath_head_always_set(const char *val,
+		const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (ret < 0)
+		return ret;
+
+	if (*(bool *)kp->arg)
+		multipath = true;
+
+	return 0;
+}
+
+static const struct kernel_param_ops multipath_head_always_param_ops = {
+	.set = multipath_head_always_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(multipath_head_always, &multipath_head_always_param_ops,
+		&multipath_head_always, 0444);
+MODULE_PARM_DESC(multipath_head_always,
+	"create multipath head node always; note that this also implicitly enables native multipath support");
+
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -681,13 +730,20 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	head->delayed_removal_secs = 0;
 
 	/*
-	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing flag
-	 * could change after a rescan.
+	 * If multipath_head_always is configured then we add a multipath head
+	 * disk node irrespective of disk is single/multi ported or namespace is
+	 * shared/private.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
-		return 0;
+	if (!multipath_head_always) {
+		/*
+		 * Add a multipath node if the subsystems supports multiple
+		 * controllers. We also do this for private namespaces as the
+		 * namespace sharing flag could change after a rescan.
+		 */
+		if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
+		    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+			return 0;
+	}
 
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
-- 
2.49.0

