Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896539B4BF;
	Fri, 31 Jul 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482515; cv=none; b=jvhvaUajnjZqXh2Z/R/nH8uhyyvjbfYJItQv1GUY/R4pwjH2CarWtWcHFnUkStlgJCTp8MAWrdMfw4Jb5ZIGXq9jkXsX06CFN3VtpPozFCG4gikEFPi/F1c7kc/pAx00Ws8eEB1JwRmPBZCaR9kS4diEGRRcoeStmyiHd60l6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482515; c=relaxed/simple;
	bh=gJJhLbfCnlR/KviXOm2kVTHqlJdhKbalvR7rQoKaRKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltDQSGxpzKaYKmJcGdv1FXo/6IT/tqJtd52puQwjc/8ZVca75Ba8I7jSiMaulfyPorQ9yQY16T589n1KU2n+RKRorfEi8Py2ZvBGVVkUOJP9C6yztD4XZKrSz/3wcsCGv62o+bO1jdaQS1oESiHo5fgnmNOxGSdiMwQaVBLlUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MSaCIuND; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MSaCIuND"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5I1Bu950123;
	Fri, 31 Jul 2026 07:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=825oiALmHQaIgMz/qLSEp7lBfXvMZDzU9G8AqmgxY
	N8=; b=MSaCIuNDgcbYj4T5/iGRrUfCm9jyrsa8w5W2Wo0aC/LNFlbyaCxGZiwue
	CgOPxzBk96b20pXB6EAYRLalKkjyFtl+ZX9PvTCyLURpAV+xV2/VuI611E6rQmxU
	33zToA3Akfj7DXgTz6TrwEK7Zku/p43tCcxEUAb9A6hDw2vLSFQ5TdLf5ifEwpKC
	vAIBGT/xi+co8Gkuo1QqrUCfm3czUsYseTrQc6DTUs/PjWUqyY9wXz0cSoMuZ4DX
	Sz9sjt25RZGtgE6grxlLeCeQIvf83lRDSZyTThf6WBDa16CuYevbvCkgwICtlujF
	PNW1rzQh0QsbQVWTQSUsDTVnm/tlg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y3v5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:21:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7BHnZ014786;
	Fri, 31 Jul 2026 07:21:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwf2kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:21:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7LfTB16908996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:21:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95B265805C;
	Fri, 31 Jul 2026 07:21:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91B265805A;
	Fri, 31 Jul 2026 07:21:40 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:21:40 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [RFC/PATCH v2] block: model nowait as trylock for non-blocking queue enter
Date: Fri, 31 Jul 2026 09:21:37 +0200
Message-ID: <20260731072137.575604-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hqmVskA-AyqGlzPs81Tx35jlfGEzoB5Y
X-Proofpoint-ORIG-GUID: hqmVskA-AyqGlzPs81Tx35jlfGEzoB5Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX4fNf7S6NxfF0
 fG19r2cjF9X+cwN/cZdBak2bYHsUZlbksSulbA0fMnPLTUIIni4UcoRdAMFH2IzS5uervL+Gv1J
 N4hDjXY8ZDGm1wuHX1VT30M1+PNjGUw=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c4d07 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8CYI0HoqOP1y2MVoT18A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfXwAoC05ANQGkT
 Jt8fDwDIfYeSr8j9uoKxK5Qw3xOSpYJJkD7pnYYBAp5jdZzrGiuie+4ZFpW7OlZSf1zvybvRL+G
 RpFex48Dwklv779ZQtqa2wvus5lczQUZ+xqzWWHuaqMlj5rC/sxKjkCmKlwHg3e1OK0tMawU2xu
 WgEtA8nVAFhE6mJ97WcsFHQvDrbi/65n6mPiUh20VrdRoiRcf3+/dTRwLr5fziKfW5LGwUMVH0n
 2P6wwAp9a5EE6jg/T16t20lvZ64Hbvit/C5xRKnWFtiacXhJVpKqm+Lb3wXW6WXM1ny+IQhWp+/
 /i17jzos39/8be5SdEGd7aj67DZHQs7Dhw1TwStmDRantCLQ2IEIHaQTYAUcjXIpiVV2hKAi4Zt
 sy4viw4j/15Utosfg0P1ZL2uh5PP3SUAgyNU6KIcnWgUP0+ZNFXvLo0DdODC+igWvziroZq9U1Y
 /d8NJQDwI/cCYeFm31A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050

blk_queue_enter() and __bio_queue_enter() annotate a successful queue
enter as a read acquisition of q->q_lockdep_map resp. q->io_lockdep_map,
so that lockdep can catch deadlocks between blk_mq_freeze_queue() and
tasks waiting to enter a frozen queue.

The annotation always passes trylock == 0, even when the caller asked
for BLK_MQ_REQ_NOWAIT / REQ_NOWAIT.  Such a caller never waits for the
queue to be unfrozen, it bails out with -EAGAIN, so the backwards
dependencies recorded here describe blocking that can not happen, and
lockdep goes on to report cycles that can not happen.

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

While the lockdep splat only is about q_usage_counter(queue), do the
same fix for q_usage_counter(io).  Annotating __bio_queue_enter() alone
would not do anything there: that function is only reached once the
tryget in bio_queue_enter() has already failed, and a REQ_NOWAIT bio
then returns -EAGAIN from the retry, so practically every REQ_NOWAIT bio
is annotated by the fast path in bio_queue_enter() instead.

The value has to be normalized to 0 or 1.  lock_acquire() stores it into
a one bit wide bit field and REQ_NOWAIT is not bit 0, so passing
bio->bi_opf & REQ_NOWAIT would truncate to 0 and silently disable the
annotation.  The fast path uses the expression inline instead of a local
variable because rwsem_acquire_read() is compiled away without
CONFIG_LOCKDEP and nothing else there would use the local.

Hoisting the REQ_NOWAIT test out of the retry loop in
__bio_queue_enter() also changes when bi_opf is read, it is now read
once on entry instead of on every iteration.  That is safe, nothing in
the loop modifies bi_opf and the bio stays owned by the submitter across
the wait, but unlike the rest of this patch it is a change in generated
code and not only in lockdep annotation.

One downside is worth spelling out.  After this change nothing in the
tree records an fs_reclaim -> q_usage_counter(queue) edge any more.
blk_alloc_queue() only primes fs_reclaim -> q_usage_counter(io), and
blk_freeze_acquire_lock() skips the io map while the disk is not live,
which is exactly the situation in the scsi scan path above.  So an
allocation under a queue freeze is no longer detected for such queues.

That detection is worth something, because such an allocation is a
problem on its own.  blk_mq_freeze_queue() wraps the freeze in a NOIO
scope, i.e. allocations under a freeze are not supposed to be able to
re-enter the queue, and scsi_realloc_sdev_budget_map() allocates the
budget map inside the freeze anyway.  It only gets away with it because
the disk is not added yet, so nothing can reclaim onto that queue.  No
longer reporting it does not make it correct, it should be moved out of
the freeze window regardless of this patch.

Doing that would also silence this particular splat, but it would not
fix the annotation.  The bogus fs_reclaim -> q_usage_counter(queue)
edge would still be recorded, and it would close a cycle again with any
other lock that is taken under a queue freeze.

Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
Claude:claude-opus-5
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
v1 -> v2:
 - also annotate the fast path in bio_queue_enter().  The v1 change to
   __bio_queue_enter() did nothing for REQ_NOWAIT bios, that function is
   only reached after the fast path tryget already failed (<reviewer>)
 - normalize the value with !! there, lockdep truncates the trylock
   argument to one bit and REQ_NOWAIT is bit 21
 - reworded the description.  A NOWAIT enter can still be a node in a
   deadlock cycle while it holds the queue reference; what can not
   happen is blocking at enter time, which is what the suppressed
   backwards dependencies describe
 - describe the resulting loss of the fs_reclaim -> q_usage_counter(queue) edge


 block/blk-core.c | 11 +++++++----
 block/blk.h      |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

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
diff --git a/block/blk.h b/block/blk.h
index eaac05815cb0..ff52d0111e74 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -92,7 +92,8 @@ static inline int bio_queue_enter(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
 	if (blk_try_enter_queue(q, false)) {
-		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
+		rwsem_acquire_read(&q->io_lockdep_map, 0,
+				   !!(bio->bi_opf & REQ_NOWAIT), _RET_IP_);
 		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
 	}
-- 
2.53.0

