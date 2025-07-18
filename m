Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57912F5A5
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845587; cv=none; b=am7o2sA53xcaZtLabiwGXqQV4rm28hdPPtJz7c7eXGKjAYySCcRf2BU04aXRzuZEXmbZbGbNI8VeYOAyE8P6KMNmf2TWRKujfUvvpNFq5mKURBnrBM1dgVByVHXaqAKrcOby1NJIh5xUv0TTy7KqN8VLwsmfpp/Df79LGyE5TJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845587; c=relaxed/simple;
	bh=53i/W0JKQ8678Zp6jts3T0Mmdr8eU5F3uf94TTjFZMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SIbQBJXI0fd9YDE3EciQzUMBb8330o9/M0CLnJOa77sz+oHUSZrfw3uW4fzJVmFCxVYAwsgCRZ8aVKG3Nt25DWWHu7DvQHZkvMAT9OZ8tFUD59wRlrz3Fl22z2r90nb0S3VuDc7kz/DUD9NRVJf3NdgxXhvfehhHB6NUtb5dVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9qnwA+P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9qnwA+P"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8mRHk005793;
	Fri, 18 Jul 2025 13:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=K6gxpJ2BCUtWsmeQChr+uNGngQR3
	BlmSIS7d5NO0Qrk=; b=U9qnwA+PlTV3DHqXO3C7MrWWNoSaTR6tSMz62tZZPMaj
	tIJ9NZ5aYD+v5h5ev5GzhoMXNIiplM47tAo63QxRNmXa3BF9SXM3gVn6CgGtEDzp
	GpgHYYHTwzt6TOkZyl7yQuQU/qWo9tNOo3NjulIl5xA1wYLncMzvWeK3SpLqX75k
	IuG8/VIMRlh3o8dTU1cGLON7P2yBLtyWSaZpyQHW0p9m4vR0GYrzex4RPfyYB4tg
	gQm1yEW5UV6v+ELkQwk4JkB+Y/tCqIwEnP4LzBIDdEYDppFWiha6bpR/jLcYbMKS
	hOYrpgUtO5h3VigJXZYtpMZRgCzzsbtSHY+o7lnFAQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7h2th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 13:32:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9JEZN025979;
	Fri, 18 Jul 2025 13:32:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31q1f6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 13:32:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56IDWbIg34210524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 13:32:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 794D52004B;
	Fri, 18 Jul 2025 13:32:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76EED20040;
	Fri, 18 Jul 2025 13:32:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.48.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 13:32:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de,
        yukuai1@huaweicloud.com, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com, gjoyce@ibm.com
Subject: [PATCHv2] block: restore two stage elevator switch while running nr_hw_queue update
Date: Fri, 18 Jul 2025 19:02:09 +0530
Message-ID: <20250718133232.626418-1-nilay@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=687a4cf8 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=Upz_q7Sh43NkeWUhqaoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwMiBTYWx0ZWRfX1ZEQg/vcqE+L uMIVt1a4a+l/R2ALfVj+1T3EvA2bC1azW+ohXzInAOb/TnsB/3+jWSDuTL8HczjlQjHNXKShFFD rwKS+s5HCr0YtIuBH5PZ+bs1NJdj0mviq2M8Cv1CS3z9aXv6n2fJu1payXewLgh25iXneIn/ZMA
 VW99l7sZjmFndoJOW4DLFoyiHV+DlUIlgHzY9XcNPZp+gvuutKpvqB6AZJBMcQRS2q4URAk1yu3 O63zhIgReFBSkBlKzEFxejoeYDBZnnZsbmJHIXEnRzObmuh14UMd033L7UvJBPWnIGwakzoQtg9 LvoA5ZuQDTBTym0fAbb05eXK9Hin+KdMZb8YgqPrPv2goNb4G6aV5d0AI6sRF5isZSyE9xHUUj7
 y/Nf5qJscyzaKfUet94g42oY5483cu9WUjKDrQApdoYx6ywT4OAhtWZyeHRimSCgYCSmzWB9
X-Proofpoint-GUID: KTUAAAonkP_OWXkHyPTJPcr40uUeIUVG
X-Proofpoint-ORIG-GUID: KTUAAAonkP_OWXkHyPTJPcr40uUeIUVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180102

The kmemleak reports memory leaks related to elevator resources that
were originally allocated in the ->init_hctx() method. The following
leak traces are observed after running blktests:

unreferenced object 0xffff8881b82f7400 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881b82f6000 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881b82f5800 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70

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
Changes from v1:
    - Updated commit message with kmemleak trace generated using null-blk
      (Yi Zhang)
    - The elevator module could be removed while nr_hw_queue update is
      running, so protect elevator switch using elevator_get() and 
      elevator_put() (Ming Lei)
    - Invoke elv_update_nr_hw_queues() from blk_mq_elv_switch_back() and 
      that way avoid elevator code restructuring in a patch which fixes
      a regression. (Ming Lei)

---
 block/blk-mq.c   | 86 +++++++++++++++++++++++++++++++++++++++++++-----
 block/blk.h      |  2 +-
 block/elevator.c |  6 ++--
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..fa25d6d36790 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4966,6 +4966,62 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+/*
+ * Switch back to the elevator type stored in the xarray.
+ */
+static void blk_mq_elv_switch_back(struct request_queue *q,
+		struct xarray *elv_tbl)
+{
+	struct elevator_type *e = xa_load(elv_tbl, q->id);
+
+	/* The elv_update_nr_hw_queues unfreezes the queue. */
+	elv_update_nr_hw_queues(q, e);
+
+	/* Drop the reference acquired in blk_mq_elv_switch_none. */
+	if (e)
+		elevator_put(e);
+}
+
+/*
+ * Stores elevator type in xarray and set current elevator to none. It uses
+ * q->id as an index to store the elevator type into the xarray.
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
+
+		ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
+		if (ret) {
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+		/*
+		 * Before we switch elevator to 'none', take a reference to
+		 * the elevator module so that while nr_hw_queue update is
+		 * running, no one can remove elevator module. We'd put the
+		 * reference to elevator module later when we switch back
+		 * elevator.
+		 */
+		__elevator_get(q->elevator->type);
+
+		elevator_set_none(q);
+	}
+out:
+	return ret;
+}
+
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
@@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
 	int i;
+	struct xarray elv_tbl;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -4984,6 +5041,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	memflags = memalloc_noio_save();
+
+	xa_init(&elv_tbl);
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
 		blk_mq_sysfs_unregister_hctxs(q);
@@ -4992,11 +5052,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
@@ -5016,12 +5082,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		}
 		blk_mq_map_swqueue(q);
 	}
-
-	/* elv_update_nr_hw_queues() unfreeze queue for us */
+switch_back:
+	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		elv_update_nr_hw_queues(q);
+		blk_mq_elv_switch_back(q, &elv_tbl);
 
-reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
@@ -5029,6 +5094,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_remove_hw_queues_cpuhp(q);
 		blk_mq_add_hw_queues_cpuhp(q);
 	}
+
+	xa_destroy(&elv_tbl);
+
 	memalloc_noio_restore(memflags);
 
 	/* Free the excess tags when nr_hw_queues shrink. */
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe656..fae7653a941f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 
 bool blk_insert_flush(struct request *rq);
 
-void elv_update_nr_hw_queues(struct request_queue *q);
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
 void elevator_set_default(struct request_queue *q);
 void elevator_set_none(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..83d0bfb90a03 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -689,7 +689,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
  * The I/O scheduler depends on the number of hardware queues, this forces a
  * reattachment when nr_hw_queues changes.
  */
-void elv_update_nr_hw_queues(struct request_queue *q)
+void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
 {
 	struct elv_change_ctx ctx = {};
 	int ret = -ENODEV;
@@ -697,8 +697,8 @@ void elv_update_nr_hw_queues(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 
 	mutex_lock(&q->elevator_lock);
-	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
-		ctx.name = q->elevator->type->elevator_name;
+	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
+		ctx.name = e->elevator_name;
 
 		/* force to reattach elevator after nr_hw_queue is updated */
 		ret = elevator_switch(q, &ctx);
-- 
2.50.1

