Received: from mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FB3F4DD4
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170607; cv=none; b=rikXYtNtcWOxJ++frPz91siUUpVtfc/bBjGfHo8J/prrJMRmzqvxBAg7g8D7x7EGY+jCi0fnVnl25J8uBqIVRq1O8upwvVV053taOzocHwtd/Q6kfNlPqIVlqjxkqroSr+VgRIXwzCMvljG0Gmi3VCqfaqsfdmGZBt23gamSRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170607; c=relaxed/simple;
	bh=RiIRS3AGgKPweaTKmH4xu7DiGkDeBMPjRujDGqmDXTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBIPqSX8dmVLUTSuA0dDFQuaYmWVT570/hxhrpMgBx+eASw++Jlf2WND3ARUF1rdmXs0mGXRxqFWrwt+C5LFIfM6LZdP5eUwmkyctV5G2/HuFTxb3nS9X603J2wdGA2Hf2jjqbMejhod00BoQCUOrhdNDf4QUwCeYwSHW4w3sDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WvW+57Sg; arc=none smtp.client-ip=95.215.58.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WvW+57Sg"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RiIRS3AGgKPweaTKmH4xu7DiGkDeBMPjRujDGqmDXTs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788170603; v=1; x=1788775403;
 b=WvW+57SgegAA9+J38VQFz1ilQ50662cD4G+BqmL4tLfOVeh8G5XxsAsDUDjiz6vv9dfwyhzE
 iL3QGqVIIQ6mAi/dZ9M9k73z2gCxaYgMGoaLSCkZE4bJKM5KiWQrmenW7xQakndxC5KZ+8QDdOr
 ml0mDUtraLM/q6+qFA9ewlSo=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 61d31954bccd392a;
	Mon, 31 Aug 2026 10:03:23 +0000
X-Mizu-Trace-ID: 61d31954bccd392a
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: bvanassche@acm.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/3] loop: drop a stale reference to loop_validate_size()
Date: Mon, 31 Aug 2026 18:03:03 +0800
Message-ID: <20260831100305.695116-2-cui.tao@linux.dev>
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

The kerneldoc of loop_set_size() points readers at loop_validate_size(),
which does not exist in the tree.  Drop the reference.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..68a9cc7aeb13 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -212,9 +212,6 @@ static inline void loop_update_dio(struct loop_device *lo)
  * loop_set_size() - sets device size and notifies userspace
  * @lo: struct loop_device to set the size for
  * @size: new size of the loop device
- *
- * Callers must validate that the size passed into this function fits into
- * a sector_t, eg using loop_validate_size()
  */
 static void loop_set_size(struct loop_device *lo, loff_t size)
 {
-- 
2.43.0

