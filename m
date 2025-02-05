Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B71DDA32
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766725; cv=none; b=NVnb1BemPDuXd0EGy4pSNjujYU7hVHMdLA5pScREzanHGfstNQdWyN+RvX+UhHazMyoyiGAay7v7rhgYLdtZgzNXsZaFC05wOBzqiP9bNx7cn6OXOL0iXHIRJilUKDo1/RhRB8a93wbhGJ+IMsrcVl+Bh9Dz7HJOorRTMNCNZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766725; c=relaxed/simple;
	bh=ZdQN+peOjTeHn5CuWM1Yu41pJrJfF6eoJ9BdFLkw1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt+7XD3ZRfC7F1kVVRSpSeCWYfPo8vKE78wC1tlhKQ2BUb2eEIXK3I1pFa928kw4TBdQviyn0jgNmgI+kXWRopW7sw+j7fk2bX1/4yREEvcQE/h/VNtSSBqFCj9QuJvGybltE8gWI1uAzAoBdE4BhszdHed0nWHTCJfJl0m/hqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QPjOhqNK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QPjOhqNK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515EAEt6028549;
	Wed, 5 Feb 2025 14:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QXlaAZNQEoGvMHD1j
	7VyeMBv8XqJLv33SWRkC0vK2eE=; b=QPjOhqNKEstcfJfjWTi2160iKXlI/f+1u
	UIbD7pVxla64OX+JIHlDDnSqKkqSv91uZrV4S7B3mURWHxwYFjRL3g6WX5SIPaRK
	c3gMiyh8/AWqcAZob2+bwfV/vuGhBZ1DqelgpADB80gt5OSUbfi/kcrtcSav2Hdy
	wtY3T0NDYplWibwRf5uyaOD2MkP+Nr5junatOlQ+7zlVE9CVWzGFJ9uKL5RfAbpL
	aDIA93oz1nJ9JmeWIt7gcBruJ5CJqQ1XNv1xBpZBfzadPtMNHa3p25NG1gEdDczX
	I96/wZwB+s3HErxH2aLS1ThmIlKOT84UgqYC502cyg5UnAqs4srwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtwpet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515CHF3h007136;
	Wed, 5 Feb 2025 14:45:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxaysas1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515EjBYN57606644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 14:45:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C234520043;
	Wed,  5 Feb 2025 14:45:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 328AE20040;
	Wed,  5 Feb 2025 14:45:10 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.122])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 14:45:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCH 1/2] block: fix lock ordering between the queue ->sysfs_lock and freeze-lock
Date: Wed,  5 Feb 2025 20:14:47 +0530
Message-ID: <20250205144506.663819-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250205144506.663819-1-nilay@linux.ibm.com>
References: <20250205144506.663819-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qww8_CmucbhxY_u_T0dyGiG-pj6MBXMo
X-Proofpoint-ORIG-GUID: qww8_CmucbhxY_u_T0dyGiG-pj6MBXMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050114

Lockdep reports [1] have identified inconsistent lock ordering between
q->sysfs_lock and freeze-lock at several call sites in the block layer.
This patch resolves the issue by enforcing a consistent lock acquisition
order: q->sysfs_lock is always acquired before freeze-lock. This change
eliminates the observed lockdep splats caused by the inconsistent
ordering.

Additionally, while rearranging the locking order, we ensure that no new
lock ordering issues are introduced between the global CPU hotplug (cpuhp)
lock and q->sysfs_lock, as previously reported [2]. To address this,
blk_mq_add_hw_queues_cpuhp() and blk_mq_remove_hw_queues_cpuhp() are now
called outside the critical section protected by q->sysfs_lock.

Since blk_mq_add_hw_queues_cpuhp() and blk_mq_remove_hw_queues_cpuhp()
are invoked during hardware context allocation via blk_mq_realloc_hw_
ctxs(), which runs holding q->sysfs_lock, we've relocated the add/remove
cpuhp function calls to __blk_mq_update_nr_hw_queues() and blk_mq_init_
allocated_queue() after the q->sysfs_lock is released. This ensures proper
lock ordering without introducing regressions.

[1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/
[2] https://lore.kernel.org/all/20241206082202.949142-1-ming.lei@redhat.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c   | 49 ++++++++++++++++++++++++++++++++----------------
 block/elevator.c |  9 +++++++++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..87200539b3cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4467,7 +4467,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	unsigned long i, j;
 
 	/* protect against switching io scheduler  */
-	mutex_lock(&q->sysfs_lock);
+	lockdep_assert_held(&q->sysfs_lock);
+
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4500,13 +4501,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
-	mutex_unlock(&q->sysfs_lock);
-
-	/* unregister cpuhp callbacks for exited hctxs */
-	blk_mq_remove_hw_queues_cpuhp(q);
-
-	/* register cpuhp for new initialized hctxs */
-	blk_mq_add_hw_queues_cpuhp(q);
 }
 
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
@@ -4532,10 +4526,19 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
+	mutex_lock(&q->sysfs_lock);
 	blk_mq_realloc_hw_ctxs(set, q);
+	mutex_unlock(&q->sysfs_lock);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
+	/*
+	 * Register cpuhp for new initialized hctxs and ensure that the cpuhp
+	 * registration happens outside of q->sysfs_lock to avoid any lock
+	 * ordering issue between q->sysfs_lock and global cpuhp lock.
+	 */
+	blk_mq_add_hw_queues_cpuhp(q);
+
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
@@ -4934,12 +4937,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 		return false;
 
 	/* q->elevator needs protection from ->sysfs_lock */
-	mutex_lock(&q->sysfs_lock);
+	lockdep_assert_held(&q->sysfs_lock);
 
 	/* the check has to be done with holding sysfs_lock */
 	if (!q->elevator) {
 		kfree(qe);
-		goto unlock;
+		goto out;
 	}
 
 	INIT_LIST_HEAD(&qe->node);
@@ -4949,8 +4952,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
-unlock:
-	mutex_unlock(&q->sysfs_lock);
+out:
 
 	return true;
 }
@@ -4973,6 +4975,8 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	struct blk_mq_qe_pair *qe;
 	struct elevator_type *t;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	qe = blk_lookup_qe_pair(head, q);
 	if (!qe)
 		return;
@@ -4980,11 +4984,9 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	list_del(&qe->node);
 	kfree(qe);
 
-	mutex_lock(&q->sysfs_lock);
 	elevator_switch(q, t);
 	/* drop the reference acquired in blk_mq_elv_switch_none */
 	elevator_put(t);
-	mutex_unlock(&q->sysfs_lock);
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
@@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		mutex_lock(&q->sysfs_lock);
 		blk_mq_freeze_queue_nomemsave(q);
+	}
 
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
@@ -5055,8 +5059,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_elv_switch_back(&head, q);
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		mutex_unlock(&q->sysfs_lock);
+
+		/*
+		 * Unregister cpuhp callbacks for exited hctxs and register
+		 * cpuhp for new initialized hctxs. Ensure that unregister/
+		 * register cpuhp is called outside of q->sysfs_lock to avoid
+		 * lock ordering issue between q->sysfs_lock and  global cpuhp
+		 * lock.
+		 */
+		blk_mq_remove_hw_queues_cpuhp(q);
+		blk_mq_add_hw_queues_cpuhp(q);
+
 		blk_mq_unfreeze_queue_nomemrestore(q);
+	}
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/elevator.c b/block/elevator.c
index cd2ce4921601..596eb5c0219f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -725,7 +725,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	int ret;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
+
+	/*
+	 * The elevator change/switch code expects that the q->sysfs_lock
+	 * is held while we update the iosched to protect against the
+	 * simultaneous hctx update.
+	 */
+	mutex_lock(&disk->queue->sysfs_lock);
 	ret = elevator_change(disk->queue, strstrip(elevator_name));
+	mutex_unlock(&disk->queue->sysfs_lock);
+
 	if (!ret)
 		return count;
 	return ret;
-- 
2.47.1

