Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0C1A6813
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426821; cv=none; b=Xc9s5PLMQFgXL5FiCo87pIbC+SVdRJbtWJ7p4ajccy3+7qm/H3xID8OcQRO/Pm4Erh9E6kpwc8NNCUDW9YMSX1GM2Mwok4Ao5+1RbBtZi3i4MCT1FMT9SYYw/MuyYEhkOH82kFrJZ0xeUK1iZdbmOl4A1Ar0NKwde3Yo7RSxdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426821; c=relaxed/simple;
	bh=ifezPFhGYoNelcOH3U1dZjQJ8V5gn6WUNNA1XA2or/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlU21YpBN3B2Qt0eki4IBaxRrvzZ/dEV9MWv2LVL3XC7dlcp3ql96fjpyTLrCoKLhF5YYHAw92+/euUsl2AEeELGwVci1Wm3DlYMZhYHQpVkQNazasLi/LiKxS6RAhzrlLk8ynZeuW4G9Y62jpjiJZNOzmdLqkHhErmKmCvrKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XT0LIpps; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XT0LIpps"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783426808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rhN5MH8GOIFz4l874l9YvZDUXe6m9ixfJ0EPwOGOECY=;
	b=XT0LIppscPK6ayPZ5DxgxRB4EyNwzKkrSmAeCVD7h0GamxeTv4ZvCaLK5SNBz0+ds0UeKG
	znR9f+vhXffaJcEY/rlZYAFQyLXVmgsI5DO9VOwIReNTseT9q20cCSS9jS1Vce3+d8HS5T
	103ZZowqSbA/OregFeDnA1wb1RihUUw=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] blk-cgroup: fix blkg_rwstat_recursive_sum() locking kernel-doc
Date: Tue,  7 Jul 2026 20:19:47 +0800
Message-ID: <20260707121947.1679701-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

blkg_rwstat_recursive_sum() now runs under RCU read-side protection: it
warns if the RCU read lock is not held and no longer relies on the queue
lock for online tests. Update the kernel-doc to match the code.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 block/blk-cgroup-rwstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index aae910713814..20cbcbe064ac 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -88,8 +88,8 @@ EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
  * @sum: blkg_rwstat_sample structure containing the results
  *
  * Collect the blkg_rwstat specified by @blkg, @pol and @off and all its
- * online descendants and their aux counts.  The caller must be holding the
- * queue lock for online tests.
+ * online descendants and their aux counts.  The caller must hold the
+ * RCU read lock.
  *
  * If @pol is NULL, blkg_rwstat is at @off bytes into @blkg; otherwise, it
  * is at @off bytes into @blkg's blkg_policy_data of the policy.
-- 
2.43.0

