Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE973E1CFD
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913698; cv=none; b=hWfZ6W9YlXAMcOAby6s892c+7sOEshqtpcZvEzKoAqku4gW3aQi/Nz41uXkcXUqOQkngQM9wQnW8HuYxzxzu9L6KcgJYshxPHkMctAx8Z0aOullj4fl/fN/u0+Q+bsTzOqtZ5oepPrlhnEeMtgDyWC6fI17WmpAqSfyEYeWkCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913698; c=relaxed/simple;
	bh=rxaUZG1zPr3tUgRZLC8Pl7ossMn7Ht+HLyzZXQe1r7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojtJWQYksskYdbg9NB5r4DbArR8vcd8nnilvUKMwEuE4k1HdFyGzrCJ51auCH5p3X5Oeq8ZBuHs4EYVbKgnvwzDfg9v/r6kbMUJQVwbGtmeIu4EmSrwfWOe/m2cMGItg5hszAWW2GsF7l+KegGy8Nr8SwY3bpg+ZavE3zCxDZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFM122qJgzYQv2Q
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:07:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0FDF840570
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 15:08:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBXR0ZW4XJqGly6BA--.6211S4;
	Wed, 05 Aug 2026 15:08:10 +0800 (CST)
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
Subject: [PATCH v7 0/8] nbd: eliminate queue freeze/unfreeze overhead in connection setup
Date: Wed,  5 Aug 2026 14:58:35 +0800
Message-ID: <20260805065843.3332859-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXR0ZW4XJqGly6BA--.6211S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxArW3Xry7ArWruFy8Xwb_yoW8Zry3pF
	WfKFy3Kr40qFW3XFsxZw18Ww1Yqw4kAr9xGF17J340yF1Yka4vgFWI9w1Fy3y7Ar9I9w12
	9a1jqrZ7uayj9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU12-e5UUUUU==
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

v6->v7:
1. fix patch 3(sorry again for mistake in v6)

v5->v6:
1. patch 3, reset stale FEAT*, not only write cache
2. patch 5, using the way Kuai advise to skip freeze
3. patch 6, adopt kuai's suggestion
4. patch 8, rename nr_hw_queues and add some comments

v4->v5:
1. add patch 3 to reset write cache on disconnect
2. fix ("nbd: factor out a nbd_genl_foreach_sock")

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

Yang Erkun (7):
  nbd: disallow NBD_SET_SOCK on an active device
  nbd: clear queue limits on disconnect
  nbd: remove queue freeze in nbd_add_socket
  nbd: skip queue freeze when setting size at device startup
  nbd: factor out a nbd_genl_foreach_sock
  nbd: remove queue freeze for newly created nbd from netlink path
  nbd: add pre_defined_connections module parameter for pre-created
    devices

 drivers/block/nbd.c | 255 +++++++++++++++++++++++---------------------
 1 file changed, 136 insertions(+), 119 deletions(-)

-- 
2.52.0

