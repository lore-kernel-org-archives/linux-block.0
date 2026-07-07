Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C172618
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426941; cv=none; b=bblc+vm0TzAjKJJ2jZ4yoCBdevmz8UMZFG2UHftfK6W7WePEEIvr7UXA59RAxS1Y4FiRNTcrgf8GyP3A6W7uHZQcJjN+/7lmwsGV3i7NzedaDv9vTjwZlZAVARC+vqDPhYepSbPbDHFqXP2PWviaeGGEPzs8LjdxjQHAVMv+N1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426941; c=relaxed/simple;
	bh=G4KdD+lIcM+dhzydeWP0uxzjUzCoAG3SeAuTgjH9GZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e814xhWBbOV/kGTOoSXKr265wpTDuJVf1neQ6kmXlxXx+XAtCJxmWQK3ZM5XxPRiQNuWdIRouF1XnEiW7rjXGppC0vErEmRm09wBYgRcGNSSjxyAoA1D5fUN1So7q8B7zNcfU0JrUkEaG5OPcObsSCr0xyGpxt3rSnUBTwHeKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L8nJ+k/e; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L8nJ+k/e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783426928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sVWv41bmiFthdKDzNFxWXKqef1mAKb1CpuWBKlIUeDs=;
	b=L8nJ+k/eVf8eejzLCr+sG4XaUIx6T0dxA9VZHZmqHzGVhlxmGzI6ii+a+S1kWeKPzbYcLa
	FJePqpD1vC5gedSAGzbeeG2C7lvOfFWPm6XteHTqOuVGzuANh185b9pd+jLCYcmfz0FV3x
	nIuyC2L44hMuuOL0FFYUPP6vLjdduLg=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] blk-ioprio: fix stale prio_policy kernel-doc
Date: Tue,  7 Jul 2026 20:21:55 +0800
Message-ID: <20260707122155.1696613-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

Fix two stale kernel-doc entries in blk-ioprio. The
POLICY_PROMOTE_TO_RT comment should describe promotion from
non-IOPRIO_CLASS_RT classes, and @prio_policy stores enum prio_policy
values rather than IOPRIO_CLASS_* values.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 block/blk-ioprio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fa8bca35062..a94c50233d90 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -23,7 +23,8 @@
 /**
  * enum prio_policy - I/O priority class policy.
  * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
- * @POLICY_PROMOTE_TO_RT: modify no-IOPRIO_CLASS_RT to IOPRIO_CLASS_RT.
+ * @POLICY_PROMOTE_TO_RT: promote non-IOPRIO_CLASS_RT classes to
+ *		IOPRIO_CLASS_RT.
  * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
  *		IOPRIO_CLASS_BE.
  * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
@@ -52,7 +53,7 @@ static struct blkcg_policy ioprio_policy;
 /**
  * struct ioprio_blkcg - Per cgroup data.
  * @cpd: blkcg_policy_data structure.
- * @prio_policy: One of the IOPRIO_CLASS_* values. See also <linux/ioprio.h>.
+ * @prio_policy: One of the POLICY_* values defined by enum prio_policy.
  */
 struct ioprio_blkcg {
 	struct blkcg_policy_data cpd;
-- 
2.43.0

