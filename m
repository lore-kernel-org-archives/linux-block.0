Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596B448BA9
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662672; cv=none; b=XY3Brykc6z2/sFIRTWbOG1RF04cWm34p22Vx1GaRSX7dOT7nL/5VvY7oS801tZSEr7UJIYtv8OnNNW1jOS330dNofA54ABGclEvnTRjY4b0yv8F4t/2DGKJhGXa9zD5qNJETAiVnJsLIRPu+bMGWjbtGv6m35FZsGt4T0CLx3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662672; c=relaxed/simple;
	bh=RQ2tt0SwdsDYCJg0yeBJV/rAXuRLEZbNir4NgXWRYsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOP05dW5ZxZ/k4kRlnxTr+VbTFuvaFxjx9QIq+hL58lqqGoUsRebVpK4qPd4TosfZzFmhVkP+OYPrylQxe4bpLAAGx1c/+gzU3KJnwg+EtRi5yK28CD7KETgJzlwjeJs+9cAIYtfo+Cm5VjYC+rTqW4V36BsD+rv52isjERYEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=odknuhel; arc=none smtp.client-ip=95.215.58.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="odknuhel"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RQ2tt0SwdsDYCJg0yeBJV/rAXuRLEZbNir4NgXWRYsY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787662668; v=1; x=1788267468;
 b=odknuheldjeMHgQ3zfH0c6KfnmvWb7DTLXt86k4UzX8Wh6/T1N5+OEotuvV0Q6w6yMS/YiVZ
 uv1Nkq5TrYpYviHnEpehrGlEG6ynwQzqIANTUmxsZM84vXSoUcGt9snpCooDPZ17XYrF9uRHoUq
 cc1a9dlVWUsCDx20GzeNppDM=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 05fca96e65d45a21;
	Tue, 25 Aug 2026 12:57:48 +0000
X-Mizu-Trace-ID: 05fca96e65d45a21
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/3] loop: drop a stale reference to loop_validate_size()
Date: Tue, 25 Aug 2026 20:57:18 +0800
Message-ID: <20260825125720.181793-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825125720.181793-1-cui.tao@linux.dev>
References: <20260825125720.181793-1-cui.tao@linux.dev>
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

