Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E6451990;
	Thu, 30 Jul 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436215; cv=none; b=f645xmftd+Fzck4qOvobnqslt6EcUk802umxRwvXRf+byC0S4axDHASiiF7PJhKWfijAjZl0tg3ETs0VSOTkalzPWQCWTPHxYYawnpGctaHd9yEpa1E2odMmE1A36OsQlbZgQ+pd843Gqa6qhjt30O6JA7N/weddDWIjbkO6/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436215; c=relaxed/simple;
	bh=DduWvqnDmZjFl3fmXjiTE+DjHYis1RWM5pesXyBPUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+skSFZO8mn3FJiu7oGrygb2j1GAU3B2+U2fScJayr5gxlH2i0GA2qjX7Fy7Gxz5TT4bKoDxEwlbf/b7CmqU0NuJjWVI//ksQO3TUOZ1Ww9ipf4KfOE3o5HmciiAwapSL17b/Xxp42udBc+LbuM111x8MDZGWPLQgiCRcQQHwWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Em97KFLC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Em97KFLC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGlvhO3588773;
	Thu, 30 Jul 2026 18:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W+KMU/lCjW7OmH8kRywPGIsyrIplr0EKk1liwtulZ
	lI=; b=Em97KFLCzk8Kjv15TdZt6KNszPARjxNASSxrTzbq2y0yVF48RImvMM6fC
	2YpnPjDIV0ehfuIsYEUHev+jJXuSOJEW53i7tO69V8w91fdtjSh8M32u4WGM8Gbr
	8sEOGEj2UG3DvOjcjGIBlI5DSswAXejqrzJjTVH9FcGs12P4YLTKjW1Hl12ZBN4+
	NJMEmVrHO1j5l7K9vAok4Ip+4ycoPCm46/wM2/mD2/YXYsFfyVleRRkeJiINrUQ0
	70zYbrXUetSMxkjojjz3MQ+p+Fkas8WsFrfLcDz9cBkkh5t//ih16l4rFgD1H4Kl
	awycMAFyFUzKPjqVfiCBYTJP82sXQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y1amy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 18:30:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UIQIoj025072;
	Thu, 30 Jul 2026 18:30:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ycab4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 18:30:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UIU8qC20382462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 18:30:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 633FC5805D;
	Thu, 30 Jul 2026 18:30:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7405E58065;
	Thu, 30 Jul 2026 18:30:07 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 18:30:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH] block: model nowait as trylock for non-blocking queue enter
Date: Thu, 30 Jul 2026 20:30:05 +0200
Message-ID: <20260730183005.444273-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IhG03wfEO96tvD9AKiImVlbCNxCLTVdZ
X-Proofpoint-ORIG-GUID: IhG03wfEO96tvD9AKiImVlbCNxCLTVdZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEzNiBTYWx0ZWRfX5BuvPIOFyLjV
 Tm5R9dhk0UtxWOQsyWp0wvcgUxHR+y8D8cP27G3e3tMSnrLo5XJCXVbL+ptBkkq4IyTPC5TttM9
 H0EdHh2oYVlDfwPmo1zXAHGcVaZvxjk=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6b9831 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=OslsT6BENCGbL34pPIsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEzNiBTYWx0ZWRfX5bhHmkv1CGfn
 VD/p3xluniyB9LfGrhMKV6HDz2DHwL9WRR2hnVyq13LpJcPYgsjQJLXzFKCxpRSW6DpiK8IbtEG
 ygf96HyO7LYyxZlfm9DR9NwGQCu81TRygLIHbL6YlxZWjBOlz5QfjIWC5rOhu+p2FPQXeYvUdyk
 3AoDW8//D56/x2U1BnYuYYUM8Zayz2t/tXxupRnQyqud234aX/VQjUECJA7KZ/KVQIxS8xw4EL5
 UFvZIrJHPbCsDMnNaazYBynERn+1qq4pUl7Mqd74r8h0ABEhCJJLNTprHDM4bMwaulCAN73UULn
 CzOWh0D8u9tTAgsIGg4OvBLmEadAimhNrMG5GkgtlzmL3Rs5liJ9zb5nxKpf/1d8QptTQ2d5UO7
 2VUzeUR4KOxUjvnr3dlUCrJr1FEiAAjdiFAEVGNVm7cGW1JuOLW3DkD2Gas94Wcher/x9bIGUNj
 8GX71CQY4515gEhu0ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300136

blk_queue_enter() and __bio_queue_enter() annotate a successful queue
enter as a read acquisition of q->q_lockdep_map resp. q->io_lockdep_map,
so that lockdep can catch deadlocks between blk_mq_freeze_queue() and
tasks waiting to enter a frozen queue.

The annotation always passes trylock == 0, even when the caller asked
for BLK_MQ_REQ_NOWAIT / REQ_NOWAIT.  Such a caller never waits for the
queue to be unfrozen, it bails out with -EAGAIN, so it can not take part
in a deadlock cycle.  Recording a full backwards dependency for it makes
lockdep report cycles that can not happen.

Here is a real life example on s390x:

WARNING: possible circular locking dependency detected
7.2.0-20260729.rc5.git5.98379cf6109c.300.fc44.s390x+debug #1 Not tainted

kswapd0/235 is trying to acquire lock:
0000014323281478 (&q->q_usage_counter(queue)#24){++++}-{0:0}, at: blk_mq_alloc_request+0x1b4/0x200
but task is already holding lock:
00000249ca69e528 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x552/0xc60
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #2 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x150/0x3f0
       __fs_reclaim_acquire+0x44/0x50
       fs_reclaim_acquire+0xbe/0x100
       __kmalloc_noprof+0xda/0x7d0
       pcpu_alloc_chunk+0x30/0x170
       pcpu_create_chunk+0x22/0x120
       pcpu_alloc_noprof+0xcf2/0xd70
       do_kmem_cache_create+0xce/0x500
       __kmem_cache_create_args+0x33c/0x480
       kmem_cache_create_usercopy.constprop.0+0x44/0x68
       skb_init+0x7c/0x90
       sock_init+0x3c/0x108
       do_one_initcall+0x82/0x3b0
       do_initcalls+0x14c/0x170
       kernel_init_freeable+0x226/0x2a0
       kernel_init+0x2e/0x188
       __ret_from_fork+0x4c/0x340
       ret_from_fork+0xa/0x30
-> #1 (pcpu_alloc_mutex){+.+.}-{3:3}:
       lock_acquire+0x150/0x3f0
       __mutex_lock+0xba/0xdc0
       _mutex_lock_killable+0x36/0x50
       pcpu_alloc_noprof+0x882/0xd70
       sbitmap_init_node+0x11c/0x240
       scsi_realloc_sdev_budget_map+0xee/0x1e0
       scsi_add_lun+0x538/0x730
       scsi_probe_and_add_lun+0x1a8/0x4d0
       scsi_report_lun_scan+0x352/0x3f0
       __scsi_scan_target+0x104/0x250
       scsi_scan_target+0xe4/0x100
       fc_scsi_scan_rport+0xc2/0xd0 [scsi_transport_fc]
       process_one_work+0x2ba/0x800
       worker_thread+0x21a/0x400
       kthread+0x164/0x190
       __ret_from_fork+0x4c/0x340
       ret_from_fork+0xa/0x30
-> #0 (&q->q_usage_counter(queue)#24){++++}-{0:0}:
       check_prev_add+0x160/0xf40
       __lock_acquire+0x12aa/0x15a0
       lock_acquire+0x150/0x3f0
       blk_queue_enter+0xee/0x2d0
       blk_mq_alloc_request+0x1b4/0x200
       multipath_clone_and_map+0xb6/0x260 [dm_multipath]
       map_request+0x62/0x230
       dm_mq_queue_rq+0xc4/0x260
       blk_mq_dispatch_rq_list+0x19c/0x540
       __blk_mq_do_dispatch_sched+0x3ce/0x3e0
       __blk_mq_sched_dispatch_requests+0x198/0x1e0
       blk_mq_sched_dispatch_requests+0x3c/0x90
       blk_mq_run_hw_queue+0x1a4/0x2c0
       blk_mq_dispatch_list+0x222/0x4a0
       blk_mq_flush_plug_list+0x7c/0x1d0
       __blk_flush_plug+0x128/0x180
       blk_finish_plug+0x42/0x60
       shrink_lruvec+0x252/0x410
       shrink_node_memcgs+0x202/0x290
       shrink_node+0xa0/0x410
       balance_pgdat+0x4cc/0xc60
       kswapd+0x148/0x2c0
       kthread+0x164/0x190
       __ret_from_fork+0x4c/0x340
       ret_from_fork+0xa/0x30
other info that might help us debug this:
Chain exists of:
  &q->q_usage_counter(queue)#24 --> pcpu_alloc_mutex --> fs_reclaim
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
			       lock(pcpu_alloc_mutex);
			       lock(fs_reclaim);
  rlock(&q->q_usage_counter(queue)#24);
 *** DEADLOCK ***
2 locks held by kswapd0/235:
 #0: 00000249ca69e528 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x552/0xc60
 #1: 00000249ca64a568 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x160/0x2c0
stack backtrace:
CPU: 10 UID: 0 PID: 235 Comm: kswapd0 Not tainted 7.2.0-20260729.rc5.git5.98379cf6109c.300.fc44.s390x+debug #1 PREEMPT
Hardware name: IBM 3906 M04 701 (LPAR)
Call Trace:
 [<00000249c86a0e3e>] dump_stack_lvl+0xae/0x108
 [<00000249c87aaf24>] print_circular_bug+0x1a4/0x230
 [<00000249c87ab13c>] check_noncircular+0x18c/0x1b0
 [<00000249c87ac510>] check_prev_add+0x160/0xf40
 [<00000249c87b008a>] __lock_acquire+0x12aa/0x15a0
 [<00000249c87b04d0>] lock_acquire+0x150/0x3f0
 [<00000249c90fdc3e>] blk_queue_enter+0xee/0x2d0
 [<00000249c910de84>] blk_mq_alloc_request+0x1b4/0x200
 [<0000024948754336>] multipath_clone_and_map+0xb6/0x260 [dm_multipath]
 [<00000249c943c3a2>] map_request+0x62/0x230
 [<00000249c943c634>] dm_mq_queue_rq+0xc4/0x260
 [<00000249c911527c>] blk_mq_dispatch_rq_list+0x19c/0x540
 [<00000249c911dc5e>] __blk_mq_do_dispatch_sched+0x3ce/0x3e0
 [<00000249c911e1e8>] __blk_mq_sched_dispatch_requests+0x198/0x1e0
 [<00000249c911e28c>] blk_mq_sched_dispatch_requests+0x3c/0x90
 [<00000249c910fe34>] blk_mq_run_hw_queue+0x1a4/0x2c0
 [<00000249c91148e2>] blk_mq_dispatch_list+0x222/0x4a0
 [<00000249c911569c>] blk_mq_flush_plug_list+0x7c/0x1d0
 [<00000249c90ff948>] __blk_flush_plug+0x128/0x180
 [<00000249c90ffc42>] blk_finish_plug+0x42/0x60
 [<00000249c8a48522>] shrink_lruvec+0x252/0x410
 [<00000249c8a488e2>] shrink_node_memcgs+0x202/0x290
 [<00000249c8a48d70>] shrink_node+0xa0/0x410
 [<00000249c8a4a94c>] balance_pgdat+0x4cc/0xc60
 [<00000249c8a4b228>] kswapd+0x148/0x2c0
 [<00000249c8737f64>] kthread+0x164/0x190
 [<00000249c86a47bc>] __ret_from_fork+0x4c/0x340
 [<00000249c9837aca>] ret_from_fork+0xa/0x30
INFO: lockdep is turned off.

  Chain exists of:
    &q->q_usage_counter(queue)#24 --> pcpu_alloc_mutex --> fs_reclaim

Here the fs_reclaim -> q_usage_counter(queue) edge comes from

  kswapd -> blk_finish_plug -> ... -> dm_mq_queue_rq
         -> multipath_clone_and_map
         -> blk_mq_alloc_request(BLK_MQ_REQ_NOWAIT)

and the q_usage_counter(queue) -> pcpu_alloc_mutex edge from
scsi_realloc_sdev_budget_map(), which allocates the budget map percpu
alloc hint while the queue is frozen.

kswapd can not deadlock there, it just gets -EAGAIN and requeues,
but the splat still turns lockdep off for the rest of the boot.
Tell lockdep that a NOWAIT enter is a trylock.

While the lockdep splat only is about q_usage_counter(queue), do
the same fix for q_usage_counter(io).

Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
Assisted-by: claude
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 block/blk-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e..e5db54596e3d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -347,9 +347,10 @@ bool blk_queue_start_drain(struct request_queue *q)
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
 	const bool pm = flags & BLK_MQ_REQ_PM;
+	const bool nowait = flags & BLK_MQ_REQ_NOWAIT;
 
 	while (!blk_try_enter_queue(q, pm)) {
-		if (flags & BLK_MQ_REQ_NOWAIT)
+		if (nowait)
 			return -EAGAIN;
 
 		/*
@@ -368,17 +369,19 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 			return -ENODEV;
 	}
 
-	rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&q->q_lockdep_map, 0, nowait, _RET_IP_);
 	rwsem_release(&q->q_lockdep_map, _RET_IP_);
 	return 0;
 }
 
 int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 {
+	const bool nowait = bio->bi_opf & REQ_NOWAIT;
+
 	while (!blk_try_enter_queue(q, false)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-		if (bio->bi_opf & REQ_NOWAIT) {
+		if (nowait) {
 			if (test_bit(GD_DEAD, &disk->state))
 				goto dead;
 			bio_wouldblock_error(bio);
@@ -401,7 +404,7 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 			goto dead;
 	}
 
-	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&q->io_lockdep_map, 0, nowait, _RET_IP_);
 	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
-- 
2.53.0

