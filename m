Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFE26A1A4
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514732; cv=none; b=cjyGOu5d2JG6qiU6cKk3/F5zUjbYVaqUNFfLJLnn1s67iXE3IOf5H2KIVyv6Oo5QQn0qaLSuFFxhDNjkCVryDQHXmpL0hn6L9sjDz3WgFOf1VmY5aa51wXnmc/RJQAHmRYdVQvHrzouhPd3Pk2Z13zYxVJET9L2yomNGS+3I0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514732; c=relaxed/simple;
	bh=oFYhOEOL12w3FcSpAPJf6LERRl/b+dQgNC6xg7L0Xh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=hZ8DRJZlhGGr3BRdVGKWAE8WvtoZwFmi67MHuh4wKSI0eJYEijAbljUtIwoMais8l/nzd4roauSKeIwpOvTyhzf0Nq+oO1dIOtAgxvAo29oBNiMZsapBkxZWl1jJ4H1s8JNs8Jkwy7RPh5sTBX5gOMyVPO9SNvL8gIKNGPbNTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vONORgAF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vONORgAF"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260812060521euoutp010906700b9214c7840b27d8442c03ea0c~K_ax_qY360269302693euoutp01W
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 06:05:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260812060521euoutp010906700b9214c7840b27d8442c03ea0c~K_ax_qY360269302693euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786514721;
	bh=pbOrxWZDNp13hoGdsbXszOhyj8cF5o71trRQcYuklSA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vONORgAFQLuuVWpMAP/Gi0V4qSlOy2H1LFsroOm7cPjvzSlAXvfK9a0xM7bDDKFcg
	 T6N+KCPUskBEW3PVFZr6UGz8KndvFnfx025cfLlI19P/RFuU/dbYmXkMPGuVLl8WxT
	 CR8rR+obqBG4JYDFCOvVXJuGbTU3XK6m05fDacow=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa~K_axu_Hk_1761817618eucas1p1i;
	Wed, 12 Aug 2026 06:05:21 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260812060520eusmtip101d21b6b36036327959048b90bf219ae~K_axZzoor2537125371eusmtip1v;
	Wed, 12 Aug 2026 06:05:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe
	<axboe@kernel.dk>, Zqiang <qiang.zhang@linux.dev>, "Paul E . McKenney"
	<paulmck@kernel.org>
Subject: [PATCH] blk-mq: add missing call to srcu_barrier() in
 blk_mq_free_tag_set()
Date: Wed, 12 Aug 2026 08:05:08 +0200
Message-ID: <20260812060510.3220294-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa
X-EPHeader: CA
X-CMS-RootMailID: 20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa
References: <CGME20260812060521eucas1p109a53a37ed0557d06aa7a68b613352aa@eucas1p1.samsung.com>

Commit 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is
successfully deleted") added a check in cleanup_srcu_struct() if the
call to srcu_barrier() has been made before calling it, which
revealed a missing call to srcu_barrier() before calling
cleanup_srcu_struct(set->srcu). Fix this.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes the following issue observed recently in linux-next:
------------[ cut here ]------------
 WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x194/0x3d4, CPU#1: kworker/1:2/156
 Modules linked in: s5p_mfc exynos_gsc s5p_jpeg videobuf2_dma_contig v4l2_mem2mem videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc
 CPU: 1 UID: 0 PID: 156 Comm: kworker/1:2 Not tainted 7.2.0-rc3-00006-g05c3e88488ed-dirty #13430 PREEMPT
 Hardware name: Samsung Exynos (Flattened Device Tree)
 Workqueue: usb_hub_wq hub_event
 Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x6c/0x8c
  dump_stack_lvl from __warn+0x90/0x204
  __warn from warn_slowpath_fmt+0x1b4/0x1bc
  warn_slowpath_fmt from cleanup_srcu_struct+0x194/0x3d4
  cleanup_srcu_struct from blk_mq_free_tag_set+0x138/0x158
  blk_mq_free_tag_set from scsi_mq_free_tags+0x10/0x1c
  scsi_mq_free_tags from scsi_remove_host+0x14c/0x170
  scsi_remove_host from uas_disconnect+0x70/0x84
  uas_disconnect from usb_unbind_interface+0x78/0x2b4
  usb_unbind_interface from device_release_driver_internal+0x194/0x208
  device_release_driver_internal from bus_remove_device+0xf8/0x1c8
  bus_remove_device from device_del+0x138/0x3b0
  device_del from usb_disable_device+0xec/0x22c
  usb_disable_device from usb_disconnect+0xf8/0x2bc
  usb_disconnect from hub_event+0x9a8/0x1c3c
  hub_event from process_one_work+0x258/0x798
  process_one_work from worker_thread+0x1bc/0x3cc
  worker_thread from kthread+0x138/0x16c
  kthread from ret_from_fork+0x14/0x28
 Exception stack(0xf0dfdfb0 to 0xf0dfdff8)
 dfa0:                                     00000000 00000000 00000000 00000000
 dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 irq event stamp: 23097
 hardirqs last  enabled at (23109): [<c0100bf8>] __irq_svc+0xb8/0xd0
 hardirqs last disabled at (23118): [<c0100b94>] __irq_svc+0x54/0xd0
 softirqs last  enabled at (23094): [<c013ef54>] handle_softirqs+0x32c/0x58c
 softirqs last disabled at (23065): [<c013f360>] __irq_exit_rcu+0x144/0x1f0
 ---[ end trace 0000000000000000 ]---
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c850330a32b..a26a11c73ee3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4975,6 +4975,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 	srcu_barrier(&set->tags_srcu);
 	cleanup_srcu_struct(&set->tags_srcu);
 	if (set->flags & BLK_MQ_F_BLOCKING) {
+		srcu_barrier(set->srcu);
 		cleanup_srcu_struct(set->srcu);
 		kfree(set->srcu);
 	}
-- 
2.43.0

