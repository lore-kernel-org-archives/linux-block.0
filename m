Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA70353A96
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373796; cv=none; b=NVrr2nSKGY2jUndN717f55Ysg8ErrCFte7Teg6e0ew/tuY0fF7BmjIxhTUzSz4RCAojXD1FXNv1EUqDBPJq3jQVEvOGSiIzsj1TrovHKhAFS2SqovntUK2ZMiI4Bnpip9Y5eB6O75W+bGKJbspmWGNH1RbPwubtQNVUxrGFJQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373796; c=relaxed/simple;
	bh=o9qpaE7/vg1SGW222sr/SyHvEnrVZsI94A60eDUfPBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4HG1qVSuH2hJmlEOYRYhyoM4Ccv4aFRwxHoAZ24zqK004euuprLLvZ1v6wl23nIxiPCfvr5rvodaux2dsiyy+RlM8h58Ji8d8N/PRC+7CAMzEMpqiC2Mv8QI9GqVhbR732od6IhMKT3z6W6+fIz04DBqoXQPmXtuc4dwX25eA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QWxGSM2Q; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QWxGSM2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=//
	yXt4CJPBBjakfiDnI05+pxK396g9uaqO0wD0/wGDw=; b=QWxGSM2QKhddrHtUXu
	GjVlfMN2AddEpMLswc2eOBbammhJfCx0oikB5Zx+2kBjVeMCCJaQWMUurb8uMJSX
	CgqfdFAZtts7tJSVNtkfLGuT7J5Id71HV3qL4aHrLJVl3xu2iW3l+6i6x3inAFJT
	zPg5HcY54DOPtJu2M+xcpwXtk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3hJo4pGpqNlSGKQ--.42512S2;
	Thu, 30 Jul 2026 09:09:13 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2 0/2] ublk: fix auto buf reg ordering around uring_cmd
Date: Thu, 30 Jul 2026 09:09:08 +0800
Message-Id: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3hJo4pGpqNlSGKQ--.42512S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrGry7Jw4xWw15XrWrZrb_yoWkWrg_uF
	Z5tFWDJw4DG3W5Ca42k3W5Aryvkw4UuF17WayftayxtrZ3Jr13Kr1kJw4UXr15uFW0yr90
	kF1UCanYqw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8go7tUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRls-GpqpDnPaAAA3y

Two UBLK_F_AUTO_BUF_REG ordering fixes.

Patch 1: invalid auto_buf in sqe->addr can fail after ublk_fill_io_cmd()
has already set UBLK_IO_FLAG_ACTIVE. Split validate/apply so the check
has no side effects, then take the uring_cmd and store the validated
buffer.

Patch 2: batch commit wrote the new auto_buf into io->buf before
ublk_clear_auto_buf_reg(), so unregister could target the new index and
leave the old registered buffer behind. Clear first, then update
io->buf.

Changes in v2:
- patch 1: validate before __ublk_fetch()/fill; apply is infallible
  (per Caleb's review)
- add patch 2 for the batch commit clear/store order

Tested: 
ublk selftests generic_08/09, batch_01..03, stress_08;
liburing uring_cmd_ublk.t

v1: https://lore.kernel.org/linux-block/20260724100327.43482-1-yangxiuwei@kylinos.cn/

Yang Xiuwei (2):
  ublk: validate auto buf reg before taking uring_cmd
  ublk: clear auto buf reg before updating io->buf in batch commit

 drivers/block/ublk_drv.c | 76 +++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

-- 
2.25.1

