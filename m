Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D5386C03
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377538; cv=none; b=NPAXajZ3KSb5qTfK9Pb7exk6RuBU6OpntmrpbDZhaWc2mHYA/yAH4ddPr7WlCbaq444aP96/NfkO46qLdEPaU3CavUd+BOhm/+hwhGLUpJf4vwtlG7iI82PIlNtocvmTnvBaUPvHv2UnDGyKi3EaPp1kALQy7F44GUBbAS4YCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377538; c=relaxed/simple;
	bh=BKFnwH/ZhfNkFqLMz0rG6tNDsqnF6i+hMzYIEK/hmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNGf3HxdnowYKVd/A192Vs1bDYeDF9KMjzsmr0KhsyoVbcM/OD17mN67DacDapaeajhQCPEdro1rn8QCEDNUEuXQ+1Q2eJMhRJXodeTRYTvln7Pxl5ioQNnFZt6Lk/07xvwb3TDk2jMBc7uo0Tc4UIKuDu2imSbxKVHaNTwG3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gmCFj1DMHzKHMRp
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:51:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 351394056F
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:52:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3rYIw7DxqlmUxDA--.39891S4;
	Thu, 25 Jun 2026 16:52:06 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v2 0/5] nbd: eliminate queue freeze/unfreeze overhead in connection setup
Date: Thu, 25 Jun 2026 16:44:53 +0800
Message-ID: <20260625084458.4171890-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3rYIw7DxqlmUxDA--.39891S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxWF45Cr13XF1fArW7XFb_yoW8Kr1UpF
	WfGa9xCw1vqr4xW39xAa1xG343Jrs5Ca4agw1xGr1UZw15uF1vqrySkF42kFy5AFZ7ua1j
	v3WUtr4kCFWY9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUOmiiUUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

This series eliminates the blk_mq_freeze_queue()/unfreeze_queue()
overhead that currently occurs during nbd connection setup.  On
multi-core systems, each freeze cycle involves waiting for percpu_ref
to drain, and blk_mq_update_nr_hw_queues() further adds RCU grace
period waits (synchronize_rcu/srcu for elevator switch, kfree_rcu on
the old hctx array).  These delays are significant when nbd devices
must come online quickly.

The series proceeds in three stages:

1. Cleanups that simplify the sock management code and remove dead
   logic (patches 1-3).

2. A structural change that replaces the krealloc-based socks pointer
   array with an xarray (patch 2), which is the key prerequisite for
   removing the queue freeze from nbd_add_socket().  With xarray,
   concurrent readers via xa_load() never observe a partially
   initialized socket, and xa_store() is safe under RCU without
   freezing the queue.

3. Two patches that target the remaining freeze/unfreeze points:
   - Patch 4 removes the freeze from nbd_add_socket(), since the
     xarray no longer requires it.  This alone reduces connection
     setup time from ~4.5s to ~0.26s with 256 connections (-C 256).
   - Patch 5 (new) targets nbd_start_device(), which still calls
     blk_mq_update_nr_hw_queues() when nr_hw_queues differs from
     num_connections.  For devices created via the netlink connect
     path, the connection count is known upfront from NBD_ATTR_SOCKETS,
     so we can set nr_hw_queues correctly at device creation time and
     skip the runtime update entirely.

The ioctl path (NBD_SET_SOCK + NBD_DO_IT) remains fully functional:
pre-created devices with nbds_max>0 default to nr_hw_queues=1, and
nbd_start_device() still calls blk_mq_update_nr_hw_queues() when the
hardware queue count needs adjustment.

v1->v2:
1. rewrite cover letter
2. add patch 5

Long Li (4):
  nbd: simplify find_fallback() by removing redundant logic
  nbd: replace socks pointer array with xarray
  nbd: remove redundant num_connections boundary checks
  nbd: remove queue freeze in nbd_add_socket

Yang Erkun (1):
  nbd: set nr_hw_queues at device creation to skip queue freeze

 drivers/block/nbd.c | 236 ++++++++++++++++++++++++++------------------
 1 file changed, 139 insertions(+), 97 deletions(-)

-- 
2.52.0

