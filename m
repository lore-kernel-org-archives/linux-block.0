Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1529B0
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025282; cv=none; b=asuiRaeScAAeZQdvNlAuBSzOUNsp+ryZUi7NiqoHSHpU04DtB2MX89jwE3VpTX93PIlu9xr5u3bRpa3SC8yS625LIMcLGFoyCjhxz5e+2DLG0wxQU6rZdqBxpwtHYjQAaVjGZCLSKGRhvhvYNmrFE1HqVsRic+JnxTxVGmxVs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025282; c=relaxed/simple;
	bh=3AnDR3AYg20yqsfD4czMf7hJStOa9Ir2jaFYmNGc9uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQIITjTHJN77H+0GNpStKzlqeEaj9H1jsQSbyXAP26LkrWeHssvGo8/HHQdZy5+keviRgtnvyzV81sB+5XEHWOY7X2Uy01VRuecy0sQIovzmWQ4PRTvtvMl5f/pdpQJaNK/snHRqVgUSkNg6UvDqhu0C+yd3csEHNHfH6+MxuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G33d85GE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G33d85GE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752025278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uqQVt0wyfVqq3y6gBqNEbXHFMKJa4BNu9oLVJGNIfx4=;
	b=G33d85GEQlsUkETmYbBq8uz/bgqFKiHkpxj1WVAzoGA2OUhQVRqXBrxC+bGoXDfeJ7UMlc
	od58mXoAJjEJ9iPouAjNBXsZOkx7IU9dZTzKZx3ZUSWlofLqHvs9FTQapDCTUJteZp0DPK
	kMNIQ1sNMDnJPWuaE132TUYFBFmguTw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-GnZYrOLNOTGhCohSxwn-3w-1; Tue,
 08 Jul 2025 21:41:17 -0400
X-MC-Unique: GnZYrOLNOTGhCohSxwn-3w-1
X-Mimecast-MFC-AGG-ID: GnZYrOLNOTGhCohSxwn-3w_1752025276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EDF01800368;
	Wed,  9 Jul 2025 01:41:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48ADD195608F;
	Wed,  9 Jul 2025 01:41:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com,
	Yu Kuai <yukuai3@huawei.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nbd: fix lockdep deadlock warning
Date: Wed,  9 Jul 2025 09:41:09 +0800
Message-ID: <20250709014109.2292837-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

nbd grabs device lock nbd->config_lock for updating nr_hw_queues, this
ways cause the following lock dependency:

-> #2 (&disk->open_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       __del_gendisk+0x132/0xac6 block/genhd.c:706
       del_gendisk+0xf6/0x19a block/genhd.c:819
       nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
       nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
       process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
       process_scheduled_works kernel/workqueue.c:3321 [inline]
       worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
       kthread+0x39c/0x7d4 kernel/kthread.c:464
       ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
       ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327

-> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
       blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
       nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
       nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
       genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
       genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0xcc/0x160 net/socket.c:727
       ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
       ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
       __sys_sendmsg+0x188/0x246 net/socket.c:2652
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
       syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
       do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

-> #0 (&nbd->config_lock){+.+.}-{4:4}:
       check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
       mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
       refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
       nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
       nbd_release+0x94/0x15c drivers/block/nbd.c:1735
       blkdev_put_whole+0xac/0xee block/bdev.c:721
       bdev_release+0x3fe/0x600 block/bdev.c:1144
       blkdev_release+0x1a/0x26 block/fops.c:684
       __fput+0x382/0xa8c fs/file_table.c:465
       ____fput+0x1c/0x26 fs/file_table.c:493
       task_work_run+0x16a/0x25e kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
       exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
       do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
       handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

Also it isn't necessary to require nbd->config_lock, because
blk_mq_update_nr_hw_queues() does grab tagset lock for sync everything.

Fixes the issue by releasing ->config_lock & retry in case of concurrent
updating nr_hw_queues.

Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating nr_hw_queues")
Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@google.com
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/nbd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7bdc7eb808ea..136640e4c866 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1473,7 +1473,15 @@ static int nbd_start_device(struct nbd_device *nbd)
 		return -EINVAL;
 	}
 
-	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
+retry:
+	mutex_unlock(&nbd->config_lock);
+	blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
+	mutex_lock(&nbd->config_lock);
+
+	/* if another code path updated nr_hw_queues, retry until succeed */
+	if (num_connections != config->num_connections)
+		goto retry;
+
 	nbd->pid = task_pid_nr(current);
 
 	nbd_parse_flags(nbd);
-- 
2.47.0

