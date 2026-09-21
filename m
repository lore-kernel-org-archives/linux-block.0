Received: from mta1.migadu.com (out-136.mta1.migadu.com [95.215.58.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA4339389
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961754; cv=none; b=Iw6LJmp2/ca352eNJzxJHclYJTQ0EIvfH/RmeUuFMtBraFUAmIoyUv9JvIBo2IfGmpKs6RrtsDQs8m4m9uJ/FZMc4NJAh1PsZQMLzpx9brTl3+sXh1P8UtCwzYlyIdgtActB5HfvVC5aFcPotc+pN3Vk/EWmXQQmAaAcMv1d3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961754; c=relaxed/simple;
	bh=v0HiealU7885g0c3g+4B6E2DHNlEcOC9YbJ131S/PB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuK9A21puHuvl8mc+lxSsQ3hWljSIJT5dmy7Bwvi1N02+1GNwkVFqegDiF8J2PQ+/T4HTEG4fV7GOByRn5tPBhrwOiSd9lZ6Yl0epOifPk7gdfqr9MJMPUDXVhDVdoF3Wv8h7j2sJescuaGv/B+Zqt33GJw4TPWX15AkxNZA7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9jqXlu3; arc=none smtp.client-ip=95.215.58.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9jqXlu3"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v0HiealU7885g0c3g+4B6E2DHNlEcOC9YbJ131S/PB0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789961749; v=1; x=1790566549;
 b=g9jqXlu3rvhX+iwml4Je+I12xJjNktC18AxYcerH4EcSCMOKOfdNZl6FRv9+h6zDq+8Mvrdo
 PWvoOWHb7khbBubbqpZbuDpCrX7dKfpZO2UO76XmZKmbhaCdYLngImK67cddg+c6godc9TsjW5u
 Tb49Or0rKS1kZrkkOzEdnLdU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9725d05abe37e048;
	Mon, 21 Sep 2026 03:35:49 +0000
X-Mizu-Trace-ID: 9725d05abe37e048
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 4/4] blk-iocost: fix stale comment in ioc_rqos_throttle()
Date: Mon, 21 Sep 2026 11:34:53 +0800
Message-ID: <20260921033453.1912971-5-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921033453.1912971-1-cui.tao@linux.dev>
References: <20260921033453.1912971-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The comment says that priority-inversion IOs are "punted to
@ioc->aux_iocg", but no aux_iocg field ever existed in struct ioc.
The comment was introduced already stale by commit da437b95db83
("blk-iocost: grab ioc->lock for debt handling").  Update it to
describe the current use_debt / iocg->abs_vdebt mechanism.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ec10028249fb..7475a4f79b97 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2751,10 +2751,11 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 
 	/*
 	 * We're over budget. This can be handled in two ways. IOs which may
-	 * cause priority inversions are punted to @ioc->aux_iocg and charged as
-	 * debt. Otherwise, the issuer is blocked on @iocg->waitq. Debt handling
-	 * requires @ioc->lock, waitq handling @iocg->waitq.lock. Determine
-	 * whether debt handling is needed and acquire locks accordingly.
+	 * cause priority inversions are issued regardless and charged against
+	 * @iocg->abs_vdebt as debt. Otherwise, the issuer is blocked on
+	 * @iocg->waitq. Debt handling requires @ioc->lock, waitq handling
+	 * @iocg->waitq.lock. Determine whether debt handling is needed and
+	 * acquire locks accordingly.
 	 */
 	use_debt = bio_issue_as_root_blkg(bio) || fatal_signal_pending(current);
 	ioc_locked = use_debt || READ_ONCE(iocg->abs_vdebt);
-- 
2.43.0

