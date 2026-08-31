Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764703E1CE5
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175316; cv=none; b=Nz3N4xmyyp5BVDM4XQbi7aHe5X9ANLeuBxTc0gTp5THjR2OveoQruTz+KhqWdL3nBpRqoooeNsl12UJvm36KqDLDLdaASIpIobD6ks4SZLnwgvbL9fmER5Bqcm3Azgnj1V3Gvn77IJqWdMPJ8i7Go5Gd5e3m2D75wC/7WRJeDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175316; c=relaxed/simple;
	bh=dnJ6yhAA65QUkp/vrh0buvFAyDZYKHJ0lqGkUYotTSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S1LtY5UHRysFyZIFEKtbXIUCebdnUs1+APVFgreKeyTVUJYDAJKNsyPx//ZtZqHxCVZHFdnKKlCsLLpq2oDHgZKmjidV1IDsXqMHF9oKPt+IGD1OB3NV3saQ0LcJsOob7LiO/bjA22ri5FD/2mhBRWJ+SRerfd+JNopal9UfADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYRPk0b78zKHMhX
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:20:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AAD73407B5
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAuPYJVqZo_vAA--.44034S4;
	Mon, 31 Aug 2026 19:08:00 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2 0/4] block/mq-deadline: add prio_enable switch and harden prio_aging_expire
Date: Mon, 31 Aug 2026 19:01:40 +0800
Message-Id: <20260831110144.2648156-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAuPYJVqZo_vAA--.44034S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXryfAF1xCFy3Gr15uryUJrb_yoW5Ww4xpr
	Z5WFWYyFWkX3WIg3yxAF43Zw1rJw4xJrW7Jr1kKryUC3Z8Crs7ZFyrtFn0gFy7AFn3K3Za
	grn2qa4kGryYqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

v2 diff vs v1:
1. Rejects zero and negative prio_aging_expire values with -EINVAL.
2. Introduce a per-queue prio_enable boolean sysfs attribute to disable
io priority.
3. Adds a module parameter prio_enable to disable io priority.
4. Documents both prio_enable and prio_aging_expire in
Documentation/block/deadline-iosched.rst.

This series adds a way to disable I/O priority (RT/BE/IDLE) distinction
in the mq-deadline scheduler and hardens the prio_aging_expire tunable
to prevent priority inversion.

Since mq-deadline introduced support for I/O priorities, processes
without an explicit I/O priority are bound to their scheduling priority.
Many applications do not care about I/O priorities and have no way to
disable the distinction, which adds overhead and can cause unexpected
latency behaviour.  This series gives operators a per-queue sysfs
switch (and a module parameter default) to opt out of the RT/BE/IDLE
classification entirely.

Patch 1 rejects zero and negative prio_aging_expire values with
-EINVAL.  A value of zero does not disable I/O priority; instead the
priority aging path in dd_dispatch_prio_aged_requests() is invoked with
"now - 0 == now", which dispatches best-effort and idle requests ahead
of pending real-time requests -- a classic priority inversion.

Patch 2 adds a per-queue prio_enable boolean sysfs attribute.  When
disabled, every request is filed in the best-effort bucket and the
priority aging path is bypassed.  The sysfs store drains in-flight I/O
through queue freeze and quiesce (the same sequence used by
elevator_switch()) to avoid priority inversion while toggling at
runtime.  As requests may now be filed in a bucket that does not match
their ioprio, dd_start_request(), dd_request_merged() and
dd_merged_requests() are updated to look up the per-priority bucket
from rq->elv.priv[0] instead of recomputing it from the request ioprio;
the now-unused dd_rq_ioclass() helper is removed.

Patch 3 adds a module parameter prio_enable so the default can be
overridden at load time (mq_deadline.prio_enable=0 on the kernel
command line or modprobe mq_deadline prio_enable=0), letting systems
opt out of I/O priority from boot without writing to sysfs after every
queue creation.

Patch 4 documents both prio_enable and prio_aging_expire in
Documentation/block/deadline-iosched.rst.

Ye Bin (4):
  block/mq-deadline: reject zero prio_aging_expire
  block/mq-deadline: add prio_enable switch for I/O priority control
  block/mq-deadline: add module parameter for prio_enable
  docs: block: document prio_enable and prio_aging_expire in
    deadline-iosched

 Documentation/block/deadline-iosched.rst |  32 +++++
 block/mq-deadline.c                      | 148 ++++++++++++++++++-----
 2 files changed, 151 insertions(+), 29 deletions(-)

-- 
2.34.1

