Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8014367B99
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926308; cv=none; b=DMjn3KI4KIbFFyeF5TeTD1qt4+W37dgUqnyeq/6DopFvy2hw+7xtOcYLSdDQnTPkLvUzC9LrtZK+gEd7ODQA4bINi6F/l9yIfU20hHyWQOTyXP1ucw9r+L6nHHSWUwtqF2SCpTrilW7IYSXg9mRdcT+9O4lFnk1HUMVH7Y+mM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926308; c=relaxed/simple;
	bh=h4Bj3etGDj0GIB8HC28Rwa4TG/npCb4dHP7ESrZyZc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARncH8BSnZlDi6ppXbRsghU9erv5dVsYqIQhm8CaH8S+jxqrDI/UbjiwCz8uJh90ARS5q47cly0CeBNsXsAhG0RAoQCbp6WAgz1exphiAw0bgNbO8iJvLhclMhe0sxt530uv6sxWmHVQoSk2WWILY1XnEWnwowdmSgBfP7FmQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2g5QQbzYQtl0
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E79A740539
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S4;
	Mon, 13 Jul 2026 15:04:56 +0800 (CST)
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
	yangerkun@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v3 0/6] nbd: eliminate queue freeze/unfreeze overhead in connection setup
Date: Mon, 13 Jul 2026 14:56:38 +0800
Message-ID: <20260713065644.1637594-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxArWfArW8AF4fGry8Xwb_yoW8GFy8pr
	WfGF9xKw10qFW7Xrn3Zw48G345Xws5AwnxKF17J348uF1Yya4vvFyI93y5G3y7Jr93ua1j
	qa45tFykCa4UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
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

v2->v3:
1. Stop using xarray, and protect it by rejecting late NBD_SET_SOCKS
2. Eliminate freeze in nbd_set_size when device setup
3. Add module parameter to eliminate freeze for pre-created device

v1->v2:
1. Rewrite cover letter
2. Eliminate freeze call from blk_mq_update_nr_hw_queues in
   nbd_start_device for netlink path


[1]. https://github.com/e2b-dev/e2b

Long Li (1):
  nbd: simplify find_fallback() by removing redundant logic

Yang Erkun (5):
  nbd: disallow NBD_SET_SOCK on an active device
  nbd: remove queue freeze in nbd_add_socket
  nbd: set nr_hw_queues at device creation to skip queue freeze
  nbd: skip queue freeze when setting size at device startup
  nbd: add nr_hw_queues module parameter for pre-created devices

 drivers/block/nbd.c | 119 ++++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 43 deletions(-)

-- 
2.52.0

