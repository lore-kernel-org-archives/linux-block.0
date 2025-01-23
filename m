Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB5147C96
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654102; cv=none; b=sV698byppcoXogJlo3X7V1PABi5mF1S+HG/azw3jwwd1Zf/pvGkvrCiAadI/S9agiusa4YSXrdBhJHBD6eD4zZck9UTM2YNXeigDq2pSG8b5LxYU/Npd+fqgdn7jBR8Kbmwdh9PTsHOsvzo0bdKsKmgJoixd8y/4TNnRVhvDIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654102; c=relaxed/simple;
	bh=QCQgz/70b0vJabb6Uryn4w0YVzfnZeWR85O7X+jEKKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALpgQqABAPoH8Nbehl5IfPfUv+vDu0LM16H90VspDIhX5si516Bw21MpJlpyKfWbcWAcADX5sJuCLF/fWVQWeolAGp6bYQYwYVxdRCWJIiDmdPr6t0STKbHXYSqNT5FDY7Ecn3+P+Doy4JpwsGSyXewtOHJtZXkGvYAPpB5z584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H06zkWyg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H06zkWyg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NG9BcW028047;
	Thu, 23 Jan 2025 17:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/AEigYSPbDAGZ7cm2
	eHMsKSt6OJVhppQ+s9wRD7bh20=; b=H06zkWygo+Ul+4y4WaQvSIMQMHw1+ZOZF
	pfj9YAhCowdJNoYrFWrFnZgg7luQEsxg6te4LAAZakwt0RQRU/PV/77tJTNg5q21
	HwWOFxo4v3dTmFv9gGMskPnPu0/gGSpuY6XyxjjAf5dR/YXjAAMptm9AJ7852ijh
	ncIFOcPZiiM3lXDUtCtG9KVjTCu55gNyP7IVmfobYNwI5QLmrSGA2HWy1P5SsIf9
	tR1UPuE4/7sQp39gZE/2BeSAmMfCQ0m0VtEl1uOR+SgJI/LkbY+7WRHB9jmpbdtq
	yGlTrclJBUoS/6cs2SVd1chzsH51JJRJqzw7dlgp11+y+jfPZUsww==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bhfpjvdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:41:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NF4VXK022378;
	Thu, 23 Jan 2025 17:41:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kehgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:41:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHfU2X56885558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:41:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92F920043;
	Thu, 23 Jan 2025 17:41:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51D3E20040;
	Thu, 23 Jan 2025 17:41:29 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.46.6])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:41:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 2/2] block: fix nr_hw_queue update racing with disk addition/removal
Date: Thu, 23 Jan 2025 23:10:24 +0530
Message-ID: <20250123174124.24554-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123174124.24554-1-nilay@linux.ibm.com>
References: <20250123174124.24554-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ufaSCIUDi2czDKVvJBJOBOp4ZIFD_Rkd
X-Proofpoint-ORIG-GUID: ufaSCIUDi2czDKVvJBJOBOp4ZIFD_Rkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=971
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

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
 block/blk-mq-sysfs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 6113328abd70..2b9df2b73bf6 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -229,22 +229,31 @@ int blk_mq_sysfs_register(struct gendisk *disk)
 
 	kobject_uevent(q->mq_kobj, KOBJ_ADD);
 
+	mutex_lock(&q->tag_set->tag_list_lock);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&q->tag_set->tag_list_lock);
 			goto unreg;
+		}
 	}
 
+	mutex_unlock(&q->tag_set->tag_list_lock);
 
 out:
 	return ret;
 
 unreg:
+	mutex_lock(&q->tag_set->tag_list_lock);
+
 	queue_for_each_hw_ctx(q, hctx, j) {
 		if (j < i)
 			blk_mq_unregister_hctx(hctx);
 	}
 
+	mutex_unlock(&q->tag_set->tag_list_lock);
+
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
 	return ret;
@@ -256,10 +265,13 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
+	mutex_lock(&q->tag_set->tag_list_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
+	mutex_unlock(&q->tag_set->tag_list_lock);
+
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
 }
-- 
2.47.1

