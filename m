Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88A377EC5
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138979; cv=none; b=pN12fedDb9VMP0eNZ7Vf5nR54InQ34DVyS/XNMeqDD1WvnzAVUKcOP5v6E4WeZOAcib0mZL7AQkKrl5nRRwB5kbNsxJqv6qJLc+DGCnAqQ5WDWRQQ/ZVbkViKCxPq2umZmNecipcs4uKqLj3bMj7Wo6Qo2In+zWKgUwINXm+pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138979; c=relaxed/simple;
	bh=ni4Z1g635yUszeLUlrgHplfbZ+5pJjWFsMvhiUyr7HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba4jK05L3yr0idrfbQ1erN8X1y350JceoDaFwxK+vKPEQYqppGJa5rIVh9dgKqc79rulWragxm+RPayJjAefaA3m915rQ23kevLp/vnQwFHFgzh41w26WDA6Wz62w5fCqgGb6MPSTKGZy5zpIU/e5TCYQieHvE4yImwfrOR8z0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7rVx5kFBzYQtvl
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:55:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 13AAE40579
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:56:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkUbD2dqjEJ1AA--.26468S4;
	Mon, 27 Jul 2026 15:56:14 +0800 (CST)
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
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v4 0/7] nbd: eliminate queue freeze/unfreeze overhead in connection setup
Date: Mon, 27 Jul 2026 15:47:11 +0800
Message-ID: <20260727074718.414868-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkUbD2dqjEJ1AA--.26468S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxAF15Zw1kWF1kurW7Arb_yoW8Xw15pr
	WSgFy3Kr10qFW3ZrsxZw4UG34Yqw4kCrnxKF17J3409r1Yka4vqFyxurWFyrW7Ar9I9w4j
	9a15trZ7Ca4j9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
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
overhead that currently occurs during nbd connection setup(nbd provide
ondemand and was using in AI sandbox e2b[1] to mount and attach rootfs).
Each freeze cycle will introduce a RCU grace which was significant
with multi-core system.

time nbd-client --name myexport --connections 96 127.0.0.1 1234

After this patchset:
real    0m0.090s
user    0m0.004s
sys     0m0.018s

Without this patchset:
real    0m2.195s
user    0m0.005s
sys     0m0.022s

v3->v4:

1. factor out nbd_genl_foreach_sock to cleanup duplicated code
2. rewrite some commit message to make what's going more clearly

v2->v3:
1. Stop using xarray, and protect it by rejecting late NBD_SET_SOCKS
2. Eliminate freeze in nbd_set_size when device setup
3. Add module parameter to eliminate freeze for pre-created device

v1->v2:
1. Rewrite cover letter
2. Eliminate freeze call from blk_mq_update_nr_hw_queues in
   nbd_start_device for netlink path


Long Li (1):
  nbd: simplify find_fallback() by removing redundant logic

Yang Erkun (6):
  nbd: disallow NBD_SET_SOCK on an active device
  nbd: remove queue freeze in nbd_add_socket
  nbd: skip queue freeze when setting size at device startup
  nbd: factor out a nbd_genl_foreach_sock
  nbd: remove queue freeze for newly created nbd from netlink path
  nbd: add nr_hw_queues module parameter for pre-created devices

 drivers/block/nbd.c | 228 +++++++++++++++++++++++---------------------
 1 file changed, 121 insertions(+), 107 deletions(-)

-- 
2.52.0

