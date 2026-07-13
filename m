Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3849352025;
	Mon, 13 Jul 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966465; cv=none; b=CtSa8qQ/hGEZHDVictsiArF2mLvdSFaqsYc+ZVkpDfCjwSoM+wVjsqxsEgfr1+2WlouDBKkkOW73shiAmXn1aLvIt8JT2mVw6qhsotCf1lms5AX/iQ9+XAsokVD1HO7h4IlUbWAxtUfIxv+wwK/u1EaBxqs2wMlMW1wDsLHZxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966465; c=relaxed/simple;
	bh=nn+Z6KL+keKbEbLRxCnesY4nwWqAbp7YLR5U1Ka35sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEUcldWa/KF/gfkb9536z/U9+4uluynDtRkDh5PioUkeU+wOqRKRGYs9hsrao7H+4JeLwm0cx2hmhNI//ngDeIYwtiySFT9UkXZlcFtKbg7+AqH7meFk3PDlqb861n6r2EseU1dGRb0IR8DB7poXzXdmJ7l5gD5ikjVmPlbxfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YR4tf3C7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YR4tf3C7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFElL12836908;
	Mon, 13 Jul 2026 18:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ib8oTRtJu+Uw00q+/2QIHXGlDWOmlDmF4U9us2ZAk
	f4=; b=YR4tf3C7tw9yMCP08SHgVdGD9HASdOEMRO73pYHhzVroAu6I8ONMttbYY
	5CQ/sI4wry5KbZefTK0c1lI+fzFbml7bP6qxrfrEH7f69RXIm8JEUnuRWKdg6SVD
	Z5ejtFEZlXAM8s7Mk81NfzUlG17y74BLRoDx8GFMXiTnUm6FE3Ti8I/3WSeId+x5
	YSahrNMU4CzA6ANsPRgQsWFpVkIaZUSoOa33H4zs2qoF2VerNz2SBb/2TvbsSOKv
	x5gQD4MWU514J5HhW20DtQOwDXbaMO3Lum5nNA9sYTlCmOyiCzoMeUgbbXcgNQgm
	uF9JLTWSITnRSdYpBAL+ZzduSIvPA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxa5gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:14:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DI4bhJ025236;
	Mon, 13 Jul 2026 18:14:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg6tbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:14:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DIE9lR61866298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 18:14:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6479C58059;
	Mon, 13 Jul 2026 18:14:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BAD058058;
	Mon, 13 Jul 2026 18:14:07 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 18:14:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christian Borntraeger <borntraeger@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH] nbd: reclassify u->iolock of AF_UNIX sockets
Date: Mon, 13 Jul 2026 20:14:01 +0200
Message-ID: <20260713181401.11088-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6uxkQ33To0WVK5_6aRofFdnsoU9dSSHn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfX6+LBYnkESiXH
 L5MkI0iBIi+YtBBKHY+eoi99j7ctUgXAlgH2kye+7INpKFhPkvwXPWWL70MFKamWAeKmqBM9GjI
 6Pvb2ZLOqt44ZBSbzkKcQ1TiNS4u50k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4OSBTYWx0ZWRfX64JqkOqwOvvu
 JxfsE7La5gObDIdbrXocjXxX8Rm7z4cS40A0j3D0uZ6KZJXnCcqx8OrwaI7FUr4GSYNNq9H0bSV
 Nvf+aBTVi/DxLLzv+gWzbovBCDa7l48GtEPrkp8hxSa/q67GbwxoYPEOiCiqQU3qVDOxgHULfFE
 XZ/3Y4I8GxLhDDvMwv7Ux5JW5ab4QXsIAiaBV41onLjoZ0wIjZqcKvDc/c4gkcB/6m/A3Y4dAOT
 8VHBUkAGlPg9oOoK6W8tKWUmeTXM1PgTiQGFpcVIzGDM9UMIEXFEPoQRlCwX3NQlqyiNpsLbh2q
 bNO9hEJWrnIRmLEY+Rd02QTiRKCdimB5usLBZVaH1z13s5SZa30siyOpqdDIe3XmxnAkbZzLs6M
 fcMggdYJc1GwHzIcQtvMgPc3vebEVqVNLKbvH1kUbQeDITEOblOXaOQsv6e6a5EiLb1jbPLkZiT
 nFjFu7r9cGCkf5AzhtA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a552af3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eFKCDKUJ0DAL2EaXrSoA:9
X-Proofpoint-ORIG-GUID: FHedTtH8BxPuYxKI5ukViOqpUFR_Epxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130189

From: Christian Borntraeger <borntraeger@kernel.org>

in our CI we do get the following when unloading the nbd module.

[  120.008698] block nbd0: NBD_DISCONNECT
[  120.009078] block nbd0: Disconnected due to user request.
[  120.009413] block nbd0: shutting down sockets

[  120.269755] ======================================================
[  120.269757] WARNING: possible circular locking dependency detected
[  120.269759] 7.2.0-rc2-00005-g3e3aa6da87d3 #117 Not tainted
[  120.269761] ------------------------------------------------------
[  120.269762] modprobe/8168 is trying to acquire lock:
[  120.269764] 000001e67da57138 (set->srcu){.+.?}-{0:0}, at: __synchronize_srcu+0x36/0x210
[  120.269775]
               but task is already holding lock:
[  120.269776] 000001bf63462d90 (&q->elevator_lock){+.+.}-{3:3}, at: elevator_change+0xac/0x1d0
[  120.269784] which lock already depends on the new lock.

[  120.269786] the existing dependency chain (in reverse order) is:
[  120.269788]
               -> #5 (&q->elevator_lock){+.+.}-{3:3}:
[  120.269792]        lock_acquire+0x150/0x3f0
[  120.269795]        __mutex_lock+0xba/0xdc0
[  120.269799]        mutex_lock_nested+0x32/0x40
[  120.269802]        elevator_change+0xac/0x1d0
[  120.269804]        elv_iosched_store+0x194/0x1e0
[  120.269807]        kernfs_fop_write_iter+0x18c/0x270
[  120.269810]        vfs_write+0x23c/0x380
[  120.269813]        ksys_write+0x88/0x120
[  120.269816]        __do_syscall+0x170/0x750
[  120.269818]        system_call+0x72/0x90
[  120.269821]
               -> #4 (&q->q_usage_counter(io)#18){++++}-{0:0}:
[  120.269871]        lock_acquire+0x150/0x3f0
[  120.269873]        blk_alloc_queue+0x2fe/0x340
[  120.269876]        blk_mq_alloc_queue+0x6c/0xe0
[  120.269879]        __blk_mq_alloc_disk+0x2a/0x80
[  120.269881]        dasd_gendisk_alloc+0xd4/0x200
[  120.269885]        dasd_state_known_to_basic+0x34/0x1f0
[  120.269890]        dasd_change_state+0x28a/0x570
[  120.269892]        dasd_set_target_state+0x76/0xf0
[  120.269895]        dasd_generic_set_online+0xc8/0x2c0
[  120.269897]        ccw_device_set_online+0xc6/0x550
[  120.269901]        online_store+0xd2/0x270
[  120.269904]        kernfs_fop_write_iter+0x18c/0x270
[  120.269906]        vfs_write+0x23c/0x380
[  120.269909]        ksys_write+0x88/0x120
[  120.269912]        __do_syscall+0x170/0x750
[  120.269914]        system_call+0x72/0x90
[  120.269916]
               -> #3 (fs_reclaim){+.+.}-{0:0}:
[  120.269920]        lock_acquire+0x150/0x3f0
[  120.269922]        __fs_reclaim_acquire+0x44/0x50
[  120.269925]        fs_reclaim_acquire+0xbe/0x100
[  120.269927]        kmem_cache_alloc_noprof+0x6c/0x6d0
[  120.269931]        alloc_empty_file+0x58/0x150
[  120.269933]        dentry_open+0x3c/0xa0
[  120.269935]        pidfs_alloc_file+0xba/0x130
[  120.269940]        pidfd_prepare+0x8c/0xf0
[  120.269945]        scm_recv_unix+0xb0/0x130
[  120.269949]        __unix_dgram_recvmsg+0x2aa/0x430
[  120.269954]        sock_recvmsg+0x70/0xd0
[  120.269956]        ____sys_recvmsg+0x8a/0x190
[  120.269958]        ___sys_recvmsg+0x88/0xd0
[  120.269960]        __sys_recvmsg+0x76/0xd0
[  120.269962]        __do_sys_socketcall+0x40a/0x460
[  120.269964]        __do_syscall+0x170/0x750
[  120.269967]        system_call+0x72/0x90
[  120.269969]
               -> #2 (&u->iolock){+.+.}-{3:3}:
[  120.269973]        lock_acquire+0x150/0x3f0
[  120.269975]        __mutex_lock+0xba/0xdc0
[  120.269978]        mutex_lock_nested+0x32/0x40
[  120.269981]        unix_stream_read_generic+0x11e/0xa60
[  120.269985]        unix_stream_recvmsg+0xae/0xc0
[  120.269988]        sock_recvmsg+0x70/0xd0
[  120.269990]        __sock_xmit+0xf0/0x1b0 [nbd]
[  120.269997]        nbd_handle_reply+0x284/0x770 [nbd]
[  120.270001]        recv_work+0x10c/0x290 [nbd]
[  120.270004]        process_one_work+0x2ba/0x800
[  120.270009]        worker_thread+0x21a/0x400
[  120.270012]        kthread+0x164/0x190
[  120.270016]        __ret_from_fork+0x4c/0x340
[  120.270020]        ret_from_fork+0xa/0x30
[  120.270022]
               -> #1 (&cmd->lock){+.+.}-{3:3}:
[  120.270026]        lock_acquire+0x150/0x3f0
[  120.270028]        __mutex_lock+0xba/0xdc0
[  120.270031]        mutex_lock_nested+0x32/0x40
[  120.270034]        nbd_queue_rq+0x38/0x70 [nbd]
[  120.270037]        blk_mq_dispatch_rq_list+0x19c/0x540
[  120.270040]        __blk_mq_do_dispatch_sched+0x3ce/0x3e0
[  120.270043]        __blk_mq_sched_dispatch_requests+0x198/0x1e0
[  120.270046]        blk_mq_sched_dispatch_requests+0x3c/0x90
[  120.270049]        blk_mq_run_work_fn+0x9e/0x180
[  120.270052]        process_one_work+0x2ba/0x800
[  120.270055]        worker_thread+0x21a/0x400
[  120.270058]        kthread+0x164/0x190
[  120.270060]        __ret_from_fork+0x4c/0x340
[  120.270063]        ret_from_fork+0xa/0x30
[  120.270065]
               -> #0 (set->srcu){.+.?}-{0:0}:
[  120.270069]        check_prev_add+0x160/0xf40
[  120.270073]        __lock_acquire+0x12aa/0x15a0
[  120.270075]        lock_sync+0xf4/0x190
[  120.270077]        __synchronize_srcu+0x5c/0x210
[  120.270080]        elevator_switch+0x190/0x340
[  120.270082]        elevator_change+0x152/0x1d0
[  120.270084]        elevator_set_none+0x44/0x90
[  120.270087]        blk_unregister_queue+0xd4/0x130
[  120.270090]        __del_gendisk+0x172/0x3c0
[  120.270093]        del_gendisk+0x86/0xb0
[  120.270096]        nbd_dev_remove+0x30/0x90 [nbd]
[  120.270100]        nbd_cleanup+0x11a/0x3a8 [nbd]
[  120.270104]        __do_sys_delete_module+0x18e/0x340
[  120.270107]        __do_syscall+0x170/0x750
[  120.270110]        system_call+0x72/0x90
[  120.270112]
               other info that might help us debug this:

[  120.270114] Chain exists of:
                 set->srcu --> &q->q_usage_counter(io)#18 --> &q->elevator_lock

[  120.270120]  Possible unsafe locking scenario:

[  120.270121]        CPU0                    CPU1
[  120.270122]        ----                    ----
[  120.270124]   lock(&q->elevator_lock);
[  120.270126]                                lock(&q->q_usage_counter(io)#18);
[  120.270129]                                lock(&q->elevator_lock);
[  120.270132]   sync(set->srcu);
[  120.270134]
                *** DEADLOCK ***

[  120.270136] 2 locks held by modprobe/8168:
[  120.270138]  #0: 000001bf44ce11e0 (&set->update_nr_hwq_lock){++++}-{3:3}, at: del_gendisk+0x76/0xb0
[  120.270145]  #1: 000001bf63462d90 (&q->elevator_lock){+.+.}-{3:3}, at: elevator_change+0xac/0x1d0
[  120.270152]
               stack backtrace:
[  120.270155] CPU: 48 UID: 0 PID: 8168 Comm: modprobe Not tainted 7.2.0-rc2-00005-g3e3aa6da87d3 #117 PREEMPT
[  120.270157] Hardware name: IBM 9175 ME1 701 (LPAR)
[  120.270158] Call Trace:
[  120.270158]  [<000002c7d1164dde>] dump_stack_lvl+0xae/0x108
[  120.270160]  [<000002c7d126e5b4>] print_circular_bug+0x1a4/0x230
[  120.270163]  [<000002c7d126e7cc>] check_noncircular+0x18c/0x1b0
[  120.270165]  [<000002c7d126fb80>] check_prev_add+0x160/0xf40
[  120.270167]  [<000002c7d12736fa>] __lock_acquire+0x12aa/0x15a0
[  120.270168]  [<000002c7d1275ce4>] lock_sync+0xf4/0x190
[  120.270169]  [<000002c7d129c8fc>] __synchronize_srcu+0x5c/0x210
[  120.270171]  [<000002c7d1bb4790>] elevator_switch+0x190/0x340
[  120.270173]  [<000002c7d1bb4a92>] elevator_change+0x152/0x1d0
[  120.270174]  [<000002c7d1bb53c4>] elevator_set_none+0x44/0x90
[  120.270176]  [<000002c7d1bbee84>] blk_unregister_queue+0xd4/0x130
[  120.270177]  [<000002c7d1bdff42>] __del_gendisk+0x172/0x3c0
[  120.270179]  [<000002c7d1be0216>] del_gendisk+0x86/0xb0
[  120.270182]  [<000002c751b2adc0>] nbd_dev_remove+0x30/0x90 [nbd]
[  120.270185]  [<000002c751b30d72>] nbd_cleanup+0x11a/0x3a8 [nbd]
[  120.270189]  [<000002c7d12c72ce>] __do_sys_delete_module+0x18e/0x340
[  120.270191]  [<000002c7d22dc170>] __do_syscall+0x170/0x750
[  120.270192]  [<000002c7d22f0db2>] system_call+0x72/0x90
[  120.270194] INFO: lockdep is turned off.

this seems to be a false positive.

Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep
circular dependency") already reclassifies sk_lock and slock of
sockets handed to nbd, including AF_UNIX ones, precisely to keep
lockdep from reporting.
That is not sufficient for AF_UNIX: the unix stream/dgram recvmsg and
sendmsg paths do not serialize on sk_lock but on unix_sk(sk)->iolock,
and that mutex keeps the generic "&u->iolock" class shared by every
AF_UNIX socket in the system.

Teach lockdep about the lock instances to avoid this report.
This gets rid of the lockdep warning.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/block/nbd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..a811e431b47a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <net/af_unix.h>
 #include <net/sock.h>
 #include <linux/net.h>
 #include <linux/kthread.h>
@@ -1241,6 +1242,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key nbd_key[3];
 static struct lock_class_key nbd_slock_key[3];
+static struct lock_class_key nbd_unix_iolock_key;
 
 static void nbd_reclassify_socket(struct socket *sock)
 {
@@ -1267,6 +1269,17 @@ static void nbd_reclassify_socket(struct socket *sock)
 					      &nbd_slock_key[2],
 					      "sk_lock-AF_UNIX-NBD",
 					      &nbd_key[2]);
+		/*
+		 * The AF_UNIX stream recvmsg/sendmsg paths serialize on
+		 * u->iolock, not sk_lock, so it must be reclassified as
+		 * well.  A held mutex cannot be reclassified; skip it in
+		 * that case, as sock_allow_reclassification() does for
+		 * sk_lock.
+		 */
+		if (!mutex_is_locked(&unix_sk(sk)->iolock))
+			lockdep_set_class_and_name(&unix_sk(sk)->iolock,
+						   &nbd_unix_iolock_key,
+						   "&u->iolock-NBD");
 		break;
 	}
 }
-- 
2.53.0

