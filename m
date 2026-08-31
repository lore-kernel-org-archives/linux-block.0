Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F933E638E
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175309; cv=none; b=ozwwnjEqT3FJvvpz7E6xAMZiKCFPqzxpmhyhiZt7xxGqHCheHaT7/umT4lGqTtWj6sT3PXhwSb2zQ13iRX4nTeJqvZoQt94+/ZmWNpaHoZgSGjhWmigNSXrem1AjHOFGtqCViS1l7mqJBj/ycfAMtm8deqo0ul3q5TnzkXpD+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175309; c=relaxed/simple;
	bh=MyLBcPM7j/sNcO0Ph90aaQQ0HIIj8JMUQx6NIzfatmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1pJZ/qaKosz2LjeSale4y4YSAZApglcGcWIbcKrUIjkWJobrgtCiN1McIZ/CXZauuLpNliYUQV5o+3/IFyc45EvHn1uYNEYDT15W50rZOV5reyYZilQiAf49NbwSLH9MWA2sUG8Ei6hyqvpqigRH/M8i1zQwj4XUjfjXmDM4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hYRPs3Ff5zYQv99
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:21:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EB453407C4
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAuPYJVqZo_vAA--.44034S8;
	Mon, 31 Aug 2026 19:08:00 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2 4/4] docs: block: document prio_enable and prio_aging_expire in deadline-iosched
Date: Mon, 31 Aug 2026 19:01:44 +0800
Message-Id: <20260831110144.2648156-5-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831110144.2648156-1-yebin@huaweicloud.com>
References: <20260831110144.2648156-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAuPYJVqZo_vAA--.44034S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuF47uF4fGFWxZFy8Aw13Jwb_yoW5trW5p3
	93XFWSvF1kXa4xt34xJw47Xr1Fy397ZFW7Jr97t348t3Z8Zwn2vFnakr4F9F9rC3y8Aa4a
	qr48t34kGr15Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07j5nYwUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

The mq-deadline scheduler exposes two sysfs tunables, prio_enable and
prio_aging_expire, that control its I/O priority (RT/BE/IDLE) support,
but neither was described in the deadline-iosched documentation.

Add sections covering:

  - prio_enable: enables/disables RT/BE/IDLE distinction; when disabled
    all requests fall into the best-effort bucket and the priority aging
    path is bypassed.  Switching the value drains in-flight I/O (queue
    freeze and quiesce) to avoid priority inversion during the transition.
    Also available as a module parameter.

  - prio_aging_expire: the time after which a waiting best-effort or idle
    request may be dispatched despite pending real-time requests, to
    prevent indefinite starvation.  Defaults to 10000 ms; only effective
    when prio_enable is on and at least two priority buckets are
    populated.  Zero and negative values are rejected with -EINVAL to
    avoid the "now - 0 == now" priority inversion.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/block/deadline-iosched.rst | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/block/deadline-iosched.rst b/Documentation/block/deadline-iosched.rst
index 9f5c5a4c370e..ffa88cbf2951 100644
--- a/Documentation/block/deadline-iosched.rst
+++ b/Documentation/block/deadline-iosched.rst
@@ -69,4 +69,36 @@ that comes at basically 0 cost we leave that on. We simply disable the
 rbtree front sector lookup when the io scheduler merge function is called.
 
 
+prio_enable	(bool)
+----------------------
+
+Whether to enable I/O priority support that distinguishes real-time (RT),
+best-effort (BE) and idle requests.  When enabled (the default), requests are
+filed into separate per-priority buckets and dispatched in priority order: lower
+priority requests are deferred while any higher priority requests are pending,
+subject to the prio_aging_expire aging mechanism described below.  When disabled,
+every request is filed in the best-effort bucket, the priority aging path is
+bypassed, and the scheduler dispatches from that single bucket.  This lets
+systems that do not want RT/BE/IDLE distinction opt out of the extra overhead.
+Switching the value drains all in-flight I/O (queue freeze and quiesce) to avoid
+priority inversion during the transition.  This parameter can also be set at
+module load time via the prio_enable module parameter.
+
+
+prio_aging_expire	(in ms)
+------------------------------
+
+To prevent lower priority requests from being starved indefinitely by a steady
+stream of higher priority requests, the deadline scheduler ages pending
+requests.  prio_aging_expire is the time after which a best-effort or idle
+request that has been waiting longer than this threshold may be dispatched even
+though real-time requests are still pending.  The default is 10000 ms (10 s).
+
+This parameter only takes effect when prio_enable is enabled and there are
+requests queued in at least two distinct priority buckets.  The value must be
+positive: zero or negative values are rejected with -EINVAL, since a value of
+zero would dispatch best-effort and idle requests ahead of pending real-time
+requests through "now - 0 == now", a classic priority inversion.
+
+
 Nov 11 2002, Jens Axboe <jens.axboe@oracle.com>
-- 
2.34.1

