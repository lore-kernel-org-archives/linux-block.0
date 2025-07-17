Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1178C9C
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761548; cv=none; b=jatUO94bmWKfvIp389OtyVxGOzOAtKvD3gISmp3HSX8+u2sGHAxvAYGJAXqGyYWqxK9xvFpxhoFuy8WzsK7hmEa261ywUqfs6LNuZps5OQiBZXQka5wrTBA8WtTlQm98P1s4jgnSFBKU4/tiaX45uy6+ukqMQF+Z7lDYB3fqmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761548; c=relaxed/simple;
	bh=kGyXH9YakBmyGjT8dGZPkDWvh7i0qAYR3WwVLM0Z8Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nhERSp3ikUld65a6ZK+n15u+V9K5F6slZJX/ec6uj+d7Vlj7qtNeINhbP0qEVRJQqLBKHpntYY9XohfRoPFrT7uXVTtf0MFXxnmKv2C62Fh4NyVIex/GB6SD/4efJ+xPPS8Cuaf0tiqiHwes1EK6/AqLUTZXMKTHItivuZWv+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oCyVs/3C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oCyVs/3C"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8B5cn019585;
	Thu, 17 Jul 2025 14:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=X9Qaq5ENBF/sXITAM5LSXhkthrbQ
	+pMCbG6MOaMgBXc=; b=oCyVs/3C/MG6K2yFD9AOPHXQXc43oAc+qajN8a+2eIkt
	MUVfga50pCv0Wj0atX4Uur8ODVqQ/eZbftED2QMq8rTBeHWWXmmyAXdjaMIvC7KD
	yzrhBBHwcCoBviiN1EyVIcA5/YAlGsDIZ2TGPtA/ie39VsJDGs4BTmqLqFuC1h4h
	a+9IcEmnYi/Nkgpaesft0zhadTgGeWObLuW11l1U5hSOX4heGCFL+4L2xG5Uw+9B
	TalPSN0IhhO6QJkJ/0C7y2z5PepoRcM9+kvA9uVy0tdyxm0DpqZ/CP13SAq+MjWq
	9Tw90IuMBXYt/RfYbEoeyICM4mnKagW+9GrLfNKpPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh904krp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:12:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCWFNN025504;
	Thu, 17 Jul 2025 14:12:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pvksm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:12:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HEBwcF58720688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:11:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75AF520040;
	Thu, 17 Jul 2025 14:11:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0D620043;
	Thu, 17 Jul 2025 14:11:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.79.196.226])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 14:11:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de,
        yukuai1@huaweicloud.com, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com, gjoyce@ibm.com
Subject: [PATCH] block: restore two stage elevator switch while running nr_hw_queue update
Date: Thu, 17 Jul 2025 19:41:20 +0530
Message-ID: <20250717141155.473362-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2c8kqX02XngniCxoglnFgvfjnKztusdE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMSBTYWx0ZWRfXw4DbRZifEhTf 1ZHx2Z+bUB3LjQvbEpRg6SuFkoluSI60lwHVe1bo7i9jrduT8Tq0jQn+/Q9No3yyWWz20r9mfco Hepqgo/QTUOg8NVJOZIrsEfiD1RmHPl3+BjmHjNXkWSOdAN//wMF6PLg81EAPbseK+haOqGhZT/
 OpYqvRyQAPNfo5NdxFmOwUnxIOWY4H+FXN+ZNYYDggw+nUu5UaQi1YyEGx5W4khYl8KgrHhhnOV twnrnoJIFr3yYUxMjx54JTYbhLWU4NRLxGHNHScoRhUkAK91SJVk4ZdZukrvY0GLKKpzIxKZcSp f9oxNtmox0X2qLucJbXvrR+CJqtj4d82uqL8c+893IXW5j4BBLTg9E+YCYBDlkuuYUlyBPQG0aB
 rla9AkmAoIWaSYoY21pOieh2Cdv/JFzvrMUBETSKlZ9/dbVlsEiz5nQ5qxt1z2XPFRU+j2KV
X-Proofpoint-GUID: 2c8kqX02XngniCxoglnFgvfjnKztusdE
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=687904b1 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=uESu5It8aBq6gOZCsWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170121

The kmemleak reports memory leaks related to elevator resources that
were originally allocated in the ->init_hctx() method. The following
leak traces are observed after running blktests:

unreferenced object 0xffff8882e7fb9000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882e7fbb000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88819e855000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue arises while we run nr_hw_queue update,  Specifically, we first
reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and
then later invoke elevator_switch() (assuming q->elevator is not NULL).
The elevator switch code would first exit old elevator (elevator_exit)
and then switches to the new elevator. The elevator_exit loops through
each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
which releases resources allocated during ->init_hctx().

This memleak manifests when we reduce the num of h/w queues - for example,
when the initial update sets the number of queues to X, and a later update
reduces it to Y, where Y < X. In this case, we'd loose the access to old
hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
would have already released the old hctxs. As we don't now have any
reference left to the old hctxs, we don't have any way to free the
scheduler resources (which are allocate in ->init_hctx()) and kmemleak
complains about it.

This issue was caused due to the commit 596dce110b7d ("block: simplify
elevator reattachment for updating nr_hw_queues"). That change unified
the two-stage elevator teardown and reattachment into a single call that
occurs after __blk_mq_realloc_hw_ctxs() has already freed the hctxs.

This patch restores the previous two-stage elevator switch logic during
nr_hw_queues updates. First, the elevator is switched to 'none', which
ensures all scheduler resources are properly freed. Then, the hardware
contexts (hctxs) are reallocated, and the software-to-hardware queue
mappings are updated. Finally, the original elevator is reattached. This
sequence prevents loss of references to old hctxs and avoids the scheduler
resource leaks reported by kmemleak.

Reported-by : Yi Zhang <yi.zhang@redhat.com>
Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues")
Closes: https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-mq.c   | 87 +++++++++++++++++++++++++++++++++++++++++++-----
 block/blk.h      |  4 ++-
 block/elevator.c | 40 ++--------------------
 block/elevator.h | 11 ++++++
 4 files changed, 94 insertions(+), 48 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..b26cbf2a86dd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4966,6 +4966,63 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+/*
+ * Switch back to the elevator name stored in the xarray.
+ */
+static void blk_mq_elv_switch_back(struct request_queue *q,
+		struct xarray *elv_tbl)
+{
+	struct elv_change_ctx ctx = {};
+	int ret = -ENODEV;
+	char *elevator_name = xa_load(elv_tbl, q->id);
+
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
+
+	mutex_lock(&q->elevator_lock);
+	if (elevator_name && !blk_queue_dying(q) && blk_queue_registered(q)) {
+		ctx.name = elevator_name;
+
+		/* force to reattach elevator after nr_hw_queue is updated */
+		ret = elevator_switch(q, &ctx);
+	}
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue_nomemrestore(q);
+	if (!ret)
+		WARN_ON_ONCE(elevator_change_done(q, &ctx));
+}
+
+/*
+ * Stores elevator name in xarray and set current elevator to none. It uses
+ * q->id as an index to store the elevator name into the xarray.
+ */
+static int blk_mq_elv_switch_none(struct request_queue *q,
+		struct xarray *elv_tbl)
+{
+	int ret = 0;
+
+	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
+
+	/*
+	 * Accessing q->elevator without holding q->elevator_lock is safe here
+	 * because we're called from nr_hw_queue update which is protected by
+	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
+	 * switch code (which acquires the same lock in the reader context)
+	 * can't run concurrently.
+	 */
+	if (q->elevator) {
+		char *elevator_name = (char *)q->elevator->type->elevator_name;
+
+		ret = xa_insert(elv_tbl, q->id, elevator_name, GFP_KERNEL);
+		if (ret) {
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+		elevator_set_none(q);
+	}
+out:
+	return ret;
+}
+
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
@@ -4973,6 +5030,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
+	struct xarray elv_tbl;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -4984,6 +5042,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
+
+	xa_init(&elv_tbl);
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -4992,11 +5053,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue_nomemsave(q);
 
-	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
-		list_for_each_entry(q, &set->tag_list, tag_set_list)
-			blk_mq_unfreeze_queue_nomemrestore(q);
-		goto reregister;
-	}
+	/*
+	 * Switch IO scheduler to 'none', cleaning up the data associated
+	 * with the previous scheduler. We will switch back once we are done
+	 * updating the new sw to hw queue mappings.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		if (blk_mq_elv_switch_none(q, &elv_tbl))
+			goto switch_back;
+
+	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
+		goto switch_back;
 
 fallback:
 	blk_mq_update_queue_map(set);
@@ -5016,12 +5083,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		}
 		blk_mq_map_swqueue(q);
 	}
-
-	/* elv_update_nr_hw_queues() unfreeze queue for us */
+switch_back:
+	/* blk_mq_elv_switch_back() unfreezes queue for us */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		blk_mq_elv_switch_back(q, &elv_tbl);
 
-reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
@@ -5029,6 +5095,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+
+	xa_destroy(&elv_tbl);
+
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..35ec19a085fd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@
 #include "blk-crypto-internal.h"
 
 struct elevator_type;
+struct elv_change_ctx;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
 #define	BLK_MIN_SEGMENT_SIZE	4096
@@ -321,9 +322,10 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
+int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx);
+int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx);
 
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..016fe9c08c8c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -45,17 +45,6 @@
 #include "blk-wbt.h"
 #include "blk-cgroup.h"
 
-/* Holding context data for changing elevator */
-struct elv_change_ctx {
-	const char *name;
-	bool no_uevent;
-
-	/* for unregistering old elevator */
-	struct elevator_queue *old;
-	/* for registering new elevator */
-	struct elevator_queue *new;
-};
-
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
@@ -570,7 +559,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
  * If switching fails, we are most likely running out of memory and not able
  * to restore the old io scheduler, so leaving the io scheduler being none.
  */
-static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
+int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	struct elevator_type *new_e = NULL;
 	int ret = 0;
@@ -631,8 +620,7 @@ static void elv_exit_and_release(struct request_queue *q)
 		kobject_put(&e->kobj);
 }
 
-static int elevator_change_done(struct request_queue *q,
-				struct elv_change_ctx *ctx)
+int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	int ret = 0;
 
@@ -685,30 +673,6 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	return ret;
 }
 
-/*
- * The I/O scheduler depends on the number of hardware queues, this forces a
- * reattachment when nr_hw_queues changes.
- */
-void elv_update_nr_hw_queues(struct request_queue *q)
-{
-	struct elv_change_ctx ctx = {};
-	int ret = -ENODEV;
-
-	WARN_ON_ONCE(q->mq_freeze_depth == 0);
-
-	mutex_lock(&q->elevator_lock);
-	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
-		ctx.name = q->elevator->type->elevator_name;
-
-		/* force to reattach elevator after nr_hw_queue is updated */
-		ret = elevator_switch(q, &ctx);
-	}
-	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue_nomemrestore(q);
-	if (!ret)
-		WARN_ON_ONCE(elevator_change_done(q, &ctx));
-}
-
 /*
  * Use the default elevator settings. If the chosen elevator initialization
  * fails, fall back to the "none" elevator (no elevator).
diff --git a/block/elevator.h b/block/elevator.h
index a07ce773a38f..440b6e766848 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -85,6 +85,17 @@ struct elevator_type
 	struct list_head list;
 };
 
+/* Holding context data for changing elevator */
+struct elv_change_ctx {
+	const char *name;
+	bool no_uevent;
+
+	/* for unregistering old elevator */
+	struct elevator_queue *old;
+	/* for registering new elevator */
+	struct elevator_queue *new;
+};
+
 static inline bool elevator_tryget(struct elevator_type *e)
 {
 	return try_module_get(e->elevator_owner);
-- 
2.50.1

