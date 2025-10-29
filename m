Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBC21B9C0;
	Wed, 29 Oct 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761717491; cv=none; b=eV8eeuht+eqiOXSoR7jo0Qas1tO6hJrshGjxFSu4I719BMykGlaupklkXAq301+8RlqyNhpOW4+P6TPu05AI9391rOmqWEK9ncpMPobYCCTMOfBrr7ZV8o1RcI9f9LWsUTiMuUbcZ8XzM/zVzePQxYaIRlP3FiTvyvdEh9cs6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761717491; c=relaxed/simple;
	bh=PvaNzg2PawLCRKAGirpG+KsuJhqkQUcC8Wz2W13iKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3z+lYwfFrZd7HL1MLZ9gBtMFRADsXQkPSz0/fUJd4cZSFi1OSBtv7O0xi1OxPFHoeNqjYYfoyCiv1/vxe3iN6N9ivcNacDQENHO7dTUTuFv7BKgGSn0C0WyZq0w4itSInlWeUsUmWjZwJW+BlIY5AI5HPOiStSfp8qjTTIFdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xcKNk1Np; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xcKNk1Np"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QzzCZncUQnIaPLu0ekXLHsZdboy2NAkwJwmWlaN6LLY=; b=xcKNk1NpIckCMffDyxlxiK9/5t
	wFdPyygakLcE6r2w2B4Scc9t+ekcFcjAt521wOVamTcqXNbtgHySDZZkru2oISlGE3N77GLFhwgto
	hDHhCr4vbxOS8fwQK/RoxZNua/1zn2hwT96flK9WvY06vIq818QlbMeHx8dceowiUeR17EJMhs14r
	FeytQ6CfV1h6lMKKY/GhbsZSQOvoEFTUe/EuBqLkVlqjR+FRbvdSzUudi7Y1+UXb1a9v+VI9LAxHV
	YsN3dhCESwroE3a2FiLcH4b0KrPdbryp9c3ZRAa6pvybsLVOtE+cOQQn3mv/8678Fjrj0b0+Jkx5u
	Z7tWou/Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDzCB-0000000HOaJ-2LLb;
	Wed, 29 Oct 2025 05:58:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-stat: convert struct blk_stat_callback to kernel-doc
Date: Tue, 28 Oct 2025 22:58:07 -0700
Message-ID: <20251029055807.141835-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of struct blk_stat_callback documentation is already in kernel-doc
format. Convert the remaining struct members to kernel-doc to avoid
kernel-doc warnings:

Warning: block/blk-stat.h:62 struct member 'list' not described
 in 'blk_stat_callback'
Warning: block/blk-stat.h:62 struct member 'timer_fn' not described
 in 'blk_stat_callback'
Warning: block/blk-stat.h:62 struct member 'rcu' not described
 in 'blk_stat_callback'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-stat.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-next-20251029.orig/block/blk-stat.h
+++ linux-next-20251029/block/blk-stat.h
@@ -17,7 +17,7 @@
  * timer fires, @cpu_stat is flushed to @stat and @timer_fn is invoked.
  */
 struct blk_stat_callback {
-	/*
+	/**
 	 * @list: RCU list of callbacks for a &struct request_queue.
 	 */
 	struct list_head list;
@@ -50,7 +50,7 @@ struct blk_stat_callback {
 	struct blk_rq_stat *stat;
 
 	/**
-	 * @fn: Callback function.
+	 * @timer_fn: Callback function.
 	 */
 	void (*timer_fn)(struct blk_stat_callback *);
 
@@ -59,6 +59,9 @@ struct blk_stat_callback {
 	 */
 	void *data;
 
+	/**
+	 * @rcu: rcu list head
+	 */
 	struct rcu_head rcu;
 };
 
