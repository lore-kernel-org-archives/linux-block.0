Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F7184F
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539171; cv=none; b=A4PsKk0NwVqGxFtmOTFudqoBzv/C/UoEENWqc9u38zIN9oNQNOKxsLubwv4ksJAPSTlCbm6i/FkV7vYAOkC0K3vPNaRFDIKptV5jiFbzE0+/AD1pqC7E1HngEYGcop9BtoBnO9IRvbFVtngvBRtK/0zjEZUHLDbDUs7LrxihiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539171; c=relaxed/simple;
	bh=6uXk53ffMEXSqfM8Lgrt67zEhNoEgDPh4osi4pl29BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdEVucqetzhqXeBFpqC4xxkIWn96rXdLh4G8o7USKhV98P5iLy31eIB8Yu+XW7/Ms7Cr6944VbCh6XHJyPCjYkEsUC3xC9UHSSjNKd0cpM4k68yvnO4p9TofciNMlmjHf4XMlv37PuN+bPSvMOdIDtIwGgFgrDL9e8SJnGiHHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Enc6rz4Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Enc6rz4Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KKck75014318;
	Fri, 21 Mar 2025 06:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kEZReUn8iW86eqv9z
	0e1AoceSNe86I6uX8mBfUCW6kk=; b=Enc6rz4Zc0UMQpPAzgV+C96n2zJb5EqCc
	IFR3P1uDB8gA13jON15F9t89r2vznbWGRi6T9qpBwwR9sTPZkUVfmWGlFdPP2Ey5
	qsZBB5lAYBWCjTvxCAPhQ1Xr6R+xru5FMNMYSYP/aJ2G4FAOBJrcgwF/HG/KXtJl
	OpYvNf2dwsDySyV/FOQfOSwfvJ4WKNKQWK2vMG3f1rnOZMs3sO1cDUqQmUk+x3k6
	nSqUmIuZKrh05CfNgxDATz8r1eFrbbEmXKedXIh5N7OWuYpFGcXi0/+tycu4ch0C
	inwNVSzrrQ+H8o/Utdl+qxxz1XG82eTU/QSdXOvBN4Au+BABLrpjA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gt80sya1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L467FA020369;
	Fri, 21 Mar 2025 06:39:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmm160-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52L6dEFq51184108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 06:39:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0F6520049;
	Fri, 21 Mar 2025 06:39:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CD6920040;
	Fri, 21 Mar 2025 06:39:10 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.43])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 06:39:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Date: Fri, 21 Mar 2025 12:07:23 +0530
Message-ID: <20250321063901.747605-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321063901.747605-1-nilay@linux.ibm.com>
References: <20250321063901.747605-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MPpH-PoQyhbRUlLARVTXzlqudwqheCb4
X-Proofpoint-GUID: MPpH-PoQyhbRUlLARVTXzlqudwqheCb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503210045

Remove the multipath module parameter from nvme-core and make native
NVMe multipath support explicit. Since we now always create a multipath
head disk node, even for single-port NVMe disks, when CONFIG_NVME_
MULTIPATH is enabled, this module parameter is no longer needed to
toggle the behavior.

Users who prefer non-native multipath must disable CONFIG_NVME_MULTIPATH
at compile time.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      | 18 +++++++-----------
 drivers/nvme/host/multipath.c | 17 ++---------------
 drivers/nvme/host/nvme.h      |  1 -
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e798809a8325..50c170425141 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3823,14 +3823,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 					info->nsid);
 			goto out_put_ns_head;
 		}
-
-		if (!multipath) {
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
-		}
+#ifndef CONFIG_NVME_MULTIPATH
+		dev_warn(ctrl->device,
+			"Found shared namespace %d, but multipathing not supported.\n",
+			info->nsid);
+		dev_warn_once(ctrl->device,
+			"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
+#endif
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
@@ -3929,9 +3928,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 			ctrl->instance, ns->head->instance);
 		disk->flags |= GENHD_FL_HIDDEN;
-	} else if (multipath) {
-		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
-			ns->head->instance);
 	} else {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0f54889bd483..84211f64d178 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -9,11 +9,6 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
-bool multipath = true;
-module_param(multipath, bool, 0444);
-MODULE_PARM_DESC(multipath,
-	"turn on native support for multiple controllers per subsystem");
-
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -671,14 +666,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_shutdown_sec = 0;
 
-	/*
-	 * A head disk node is always created for all types of NVMe disks
-	 * (single-ported and multi-ported), unless the multipath module
-	 * parameter is explicitly set to false.
-	 */
-	if (!multipath)
-		return 0;
-
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
@@ -1262,8 +1249,8 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	size_t ana_log_size;
 	int error = 0;
 
-	/* check if multipath is enabled and we have the capability */
-	if (!multipath || !ctrl->subsys ||
+	/* check if controller has ANA capability */
+	if (!ctrl->subsys ||
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4375357b8cd7..fba686b91976 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -997,7 +997,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 	return disk->fops == &nvme_ns_head_ops;
 }
 #else
-#define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return false;
-- 
2.47.1

