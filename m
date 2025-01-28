Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C451A2622
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074895; cv=none; b=i3/INsqOcunLBi6EOxKevTAELthfJWoNbfsBLtwqTBgvB1jjp8EddnD0sgipPnOnBHYkTf2FkTWu/IdbXsSDeRFo5zh/g3j5yuIxoIEpfaoofpKdHrUK7hIj/jhqYmc4lxohc3w6ue+Zjox6sYTfZF29fV+MJwDj+7gz7G/9jjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074895; c=relaxed/simple;
	bh=Pl5HTkbnU93XMy1npnwLKuRA5Rw5enFQZO6uvO+xJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaHBYYwNNx/z+t7QJw9dafNHC3fgTSylmRanU+sVp9aWCICCLb6exN4s7kA53+SAwoR/dE6QBZ2XELUDMkqbEcUhaOAXd8j0tcij/HxIVwCHVfZaaDnsIDzTEheHvh660xPa2IqPQqQmHquja1XFHdqu7p/X95Uu3QtVppefT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MRkY4xve; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MRkY4xve"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDB6TX011073;
	Tue, 28 Jan 2025 14:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3KDosyvZYVd53Uqs2
	wY62e0XXe3kgHqoy+kkmPIDcpU=; b=MRkY4xve1+Vg3pxlDG8bB/mul7JSkw2/W
	7yoq+aPixUJE9iUL8/5oFahRurPfMMcNu0HnBfSMrtVCkx407aRlptPlRavjOMXG
	BQDUIjmvIj9rAlSim6bmnvRCofCa6naCgHjtszvBfxJhI3omvxjcx+4yhwxlPFyE
	IkIR6MudXbgfk3bGjonrjRtag7Fmldxe+/3En0xGm8j+8iHRI3lGAvgD1HlUSWw1
	Ci09gy0I/Hrqdfl1nLdVkuF1gk5fKIcKCiGDWobIz0b2J9WzYU2pMrsg3xRkwbcN
	q6rZelSistC9xmDj36hngo40S2xz879q8W/5BI/2t1q8ljxDVVS7A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9u9wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAeULd022172;
	Tue, 28 Jan 2025 14:34:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjkcx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SEYhcN53215498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 14:34:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2206A200A7;
	Tue, 28 Jan 2025 14:34:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D549C200A8;
	Tue, 28 Jan 2025 14:34:41 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.95.231])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 14:34:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 2/2] block: fix nr_hw_queue update racing with disk addition/removal
Date: Tue, 28 Jan 2025 20:04:14 +0530
Message-ID: <20250128143436.874357-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128143436.874357-1-nilay@linux.ibm.com>
References: <20250128143436.874357-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dMOjqT1QqhGdmNDrP85oMwH-ih4FnxEz
X-Proofpoint-GUID: dMOjqT1QqhGdmNDrP85oMwH-ih4FnxEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=993 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280108

The nr_hw_queue update could potentially race with disk addtion/removal
while registering/unregistering hctx sysfs files. The __blk_mq_update_
nr_hw_queues() runs with q->tag_list_lock held and so to avoid it racing
with disk addition/removal we should acquire q->tag_list_lock while
registering/unregistering hctx sysfs files.

With this patch, blk_mq_sysfs_register() (called during disk addition)
and blk_mq_sysfs_unregister() (called during disk removal) now runs
with q->tag_list_lock held so that it avoids racing with __blk_mq_update
_nr_hw_queues().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq-sysfs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 6113328abd70..3feeeccf8a99 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -225,25 +225,25 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 
 	ret = kobject_add(q->mq_kobj, &disk_to_dev(disk)->kobj, "mq");
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
+	mutex_lock(&q->tag_set->tag_list_lock);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
-			goto unreg;
+			goto out_unreg;
 	}
+	mutex_unlock(&q->tag_set->tag_list_lock);
+	return 0;
 
-
-out:
-	return ret;
-
-unreg:
+out_unreg:
 	queue_for_each_hw_ctx(q, hctx, j) {
 		if (j < i)
 			blk_mq_unregister_hctx(hctx);
 	}
+	mutex_unlock(&q->tag_set->tag_list_lock);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
@@ -256,9 +256,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-
+	mutex_lock(&q->tag_set->tag_list_lock);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
+	mutex_unlock(&q->tag_set->tag_list_lock);
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
-- 
2.47.1

