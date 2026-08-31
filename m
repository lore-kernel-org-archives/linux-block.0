Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EA3F8EDE
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170616; cv=none; b=bQdyk1zUvtBo4o6Bp1P9BwCd/1Xi67Ypbew9Atbld/DOFq1MA+3HTWtkLoTlgVdHZj5VZcey68ib3ktWXnOzxK5TVkphZ7Z6i7MyU9ccwHQOEMLf39i3hcIZT6tk9XQkbAGG6n9mQ0cPSEXRQivTLPbGliQ5xrC0RLXymfidyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170616; c=relaxed/simple;
	bh=msNGKfPbz9m7HBz/I4U/FvBOAiAK0b9KMdY0WUWTEno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F82p2Tlb6AenAFDgmY+pPRtDqYMk0pvsCKd7vfFisxzX8HjajwzQ5Xth71udozEFF/Aq+21BYhsU6xCdTGTAv6jHX+suqLhPzLYFrxr3W5uBgw4GcGYdnFX9DejszCoulbBrybIjGQZRi+6CQIhXxIujg2GVQdRVjBWTCVyCxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PtyF82ot; arc=none smtp.client-ip=91.218.175.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PtyF82ot"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=msNGKfPbz9m7HBz/I4U/FvBOAiAK0b9KMdY0WUWTEno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788170613; v=1; x=1788775413;
 b=PtyF82otjKNHqNaQPOx4ZrFIr2SQW4tEecUMhWpJJDrtdVl7ebp5zBmKJ8S7ls9LLt0ZlD0a
 lOylvJY9wFSTTdQACFT3IPj3+AciXWWys7wu+8GzdVE8T3DiWAk2nHh32Kd/T2vPHFgzjEMnbgP
 Evs9I4B7UJWjiyVL8Cn2asHA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8182e1c89fcaaebb;
	Mon, 31 Aug 2026 10:03:33 +0000
X-Mizu-Trace-ID: 8182e1c89fcaaebb
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: bvanassche@acm.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 3/3] loop: drop the unused argument of lo_req_flush()
Date: Mon, 31 Aug 2026 18:03:05 +0800
Message-ID: <20260831100305.695116-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831100305.695116-1-cui.tao@linux.dev>
References: <20260831100305.695116-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

lo_req_flush() never uses its request argument.  Drop it.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 126f42580632..1aff40963b40 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -270,7 +270,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	return ret;
 }
 
-static int lo_req_flush(struct loop_device *lo, struct request *rq)
+static int lo_req_flush(struct loop_device *lo)
 {
 	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
@@ -411,7 +411,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
-		return lo_req_flush(lo, rq);
+		return lo_req_flush(lo);
 	case REQ_OP_WRITE_ZEROES:
 		/*
 		 * If the caller doesn't want deallocation, call zeroout to
-- 
2.43.0

