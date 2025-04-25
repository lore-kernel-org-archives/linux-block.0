Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89356215F43
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577239; cv=none; b=NR2uEWCKaCmt5d80AScohVpymkUJh63SHtKu2z+oe8J7Yf3Vl1G45g0i0TEtgQD+aaExWsDWLy+ejXyWv9D6ARtm2Yr/9Gz3qm86dx5k8IadTlaOIFGuwDPoh18wePHCugyNbl/JBaOEokcEvKypFrJG98fgUQ+xbq2q/jltKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577239; c=relaxed/simple;
	bh=EcjmjH+OlM3YO76HSKQ+OH3Y3/y9bfcJSQdE2zQMGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I63a/25VSUKTGSz+qB7wuafM/pZLcbh/CD2DHdEoqvow5FTHEiHm4U5fEvKeBzcktaGXf+YZo23gOApw03BLhZXE9kaOCt3Eh9BIji5i0ekQ7aqBFq06RxMGtgJiki0fhhCQkQw3l3ViKaaB3s/DwgvYy2SWW/qT1Hg2cO7muxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XroaAwiP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XroaAwiP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7NTq9020648;
	Fri, 25 Apr 2025 10:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O6O54bH7hkf6RUC3+
	9ePoJR5ddAuKnYf7XiGNejU4Fw=; b=XroaAwiPoSzk0IhtvUsfysNXFcINLe4ia
	WNsV7U84XCjfN18YzxqYzXLp48L9eXHcKfB7AN1Gw31w2XZGZql1N+jGkmO478Kn
	Vn+FzlSlcj2CIez5Dg02hENqociABUc/GtKJkGKiwEedoPczzuoVP77mr4kybcD+
	1DEAeY5+Gp20E6si+tWR4MZJL4i++U2PkjVCqup+gvH1OT2QWBtt9iWZZr0QOlld
	r4xitQzQG6YUJzBPmzixG08aokvCfG1D9T2PBvMf23aBEqoqcjRyLTM4TBc8KoOo
	DnlqkrZ7BoRwAgtZaAT5BkDm7cu+JKlXawivnS4rC3mMGHSqUkcFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krswsf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P87Lcp028388;
	Fri, 25 Apr 2025 10:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvvrme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PAXZ4N36241678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:33:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 777F420043;
	Fri, 25 Apr 2025 10:33:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903D720040;
	Fri, 25 Apr 2025 10:33:32 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:33:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 3/3] nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk
Date: Fri, 25 Apr 2025 16:03:10 +0530
Message-ID: <20250425103319.1185884-4-nilay@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX20c3Jt4vp6HU liSF0xPLspMZEphUWBayl1K8uxJ+dNtz9kehl5Q/CA8jtvw0mVzq1ncSJ7EaTf140Dk16NG3c8/ ifs6ibmcOS3dneqG3E3qNqitPV1zsvnCNH8ym7aPRQdenw3h4aRR4B0M46o2DEkGtGJGrv0Y7o3
 S9qZ9KHXe3K677wEGdhQcpdOaEfG/5+OPblkKUSZ7DR/AeT/8pnnO2J8I3ibkcJy5HEsJMphvLT WMcSghwrF6sP/5F5szM0fabFtP+2qsCNY/UvHkvuv6Z4J8hCfsA5Pg6HmfOJ1ZxgRCm1Ck5SzUk GhFLsxROOqLhhzb4HNR1LeRYsGxWA5gHMATJkJbQ2xYImjqD0j7ID0gCRoi30vHUwN7YfuSvg9A
 aVxoztn2OoF5vYq3XO6Z+cUdG29LHP3Q2WtHRb7PdrF4pHVNsvlNTSxMLY9QLupLnq5yOc42
X-Proofpoint-GUID: xj1OpRZtvGzQ2srTqCeXpCMdG6FjaSmt
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680b6502 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=3Nj66fidHWVfShYRhO0A:9
X-Proofpoint-ORIG-GUID: xj1OpRZtvGzQ2srTqCeXpCMdG6FjaSmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=898 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250073

In the NVMe context, the term "shutdown" has a specific technical
meaning. To avoid confusion, this commit renames the nvme_mpath_
shutdown_disk function to nvme_mpath_remove_disk to better reflect
its purpose (i.e. removing the disk from the system). However,
nvme_mpath_remove_disk was already in use, and its functionality
is related to releasing or putting the head node disk. To resolve
this naming conflict and improve clarity, the existing nvme_mpath_
remove_disk function is also renamed to nvme_mpath_put_disk.

This renaming improves code readability and better aligns function
names with their actual roles.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c | 16 ++++++++--------
 drivers/nvme/host/nvme.h      |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5755069e6974..306ac36eb812 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -664,7 +664,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -4025,7 +4025,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_lock);
 	synchronize_srcu(&ns->ctrl->srcu);
 
-	nvme_mpath_shutdown_disk(ns->head);
+	nvme_mpath_remove_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1acdbbddfe01..a392b4825dc3 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -703,15 +703,15 @@ static void nvme_remove_head_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head = container_of(to_delayed_work(work),
 			struct nvme_ns_head, remove_work);
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 	if (list_empty(&head->list)) {
 		list_del_init(&head->entry);
-		shutdown = true;
+		remove = true;
 	}
 	mutex_unlock(&head->subsys->lock);
-	if (shutdown)
+	if (remove)
 		nvme_remove_head(head);
 
 	module_put(THIS_MODULE);
@@ -1280,9 +1280,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 #endif
 }
 
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 
@@ -1301,15 +1301,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 	} else {
 		list_del_init(&head->entry);
 		if (head->disk)
-			shutdown = true;
+			remove = true;
 	}
 out:
 	mutex_unlock(&head->subsys->lock);
-	if (shutdown)
+	if (remove)
 		nvme_remove_head(head);
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_put_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 74cd569882ce..591df076522d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -963,7 +963,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
 void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
-void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_put_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_update(struct nvme_ctrl *ctrl);
@@ -972,7 +972,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
 
@@ -1020,7 +1020,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 }
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
@@ -1039,7 +1039,7 @@ static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_trace_bio_complete(struct request *req)
-- 
2.49.0

