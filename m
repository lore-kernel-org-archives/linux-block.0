Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EF289358
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219794; cv=none; b=g35/rJzIRD3zd9LjQePbpKdvaHW9oOQW3wP+wNMgM4Vaq9VFAIv3YSLJShxhNtd1Qn4sxBlX0LDhPDKjXlKcoDs9hjzNTrbqIr4e+eE9Gy+vX0V29zOUpoICAabqhxUaCXKVyf7Jb3/akUEDla7TC33YqfXFNG+5grcFU255ESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219794; c=relaxed/simple;
	bh=1/lyPlxddxFwCTtEUoa7LEZYzd6wn2XLrkGfrRCvWyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1cs1KOvB3TYi/kpBdd4oHKNp/WwCmIN3miGSaO5XnPbN/MpZdm5DkO7O0ZxSPMcC3oCnRXRp6ruYtk19n9P7IfrUvjhsIZlJopph+f64aI6PnD7CPAPZChnlO1cbQBCWrUOHqgKMe8dH3I127O0+6hMujFuOSsCO2htb7KW8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t5/rGItE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t5/rGItE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pKIirhZG6Orhy59/Pl1cSjxD9TWKCAKuobCm9D13wXA=; b=t5/rGItELT7sVvkC2724B5rmxL
	HvbjZvkUO7i9r453TuqKl/rDQGzMVesbxm+2EU3A/RXvjDvd5yabVWFDLWWejsrVhqxDcdBKzVCIJ
	0FhbYljTc5sZBAyGG8hGm4wjRL99ZonCs8mpn9YtUAWkBYcZGXPY9FH0l3oxNZ+Y4A6oyiSCGPlbM
	n3SpwSK1e6tjx/zZFRr23H81hJBbHWOj0oBqDWnV1uAxHQELfVlKRP3dQG33visNtwgWirpB56knu
	iMdPqaCzT/kbq6ugwQiqF7kbTojdkSgrFAu3eqmx5PiaOquUqdQe+JmmxMA/ujq9j9yQgDqUJFWIm
	yAOtYOYA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrrB9-00000005z70-3VjF;
	Mon, 16 Feb 2026 05:29:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blk-stat: convert struct blk_stat_callback to kernel-doc
Date: Sun, 15 Feb 2026 21:29:51 -0800
Message-ID: <20260216052951.2744415-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
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
Warning: block/blk-stat.h:133 No description found for return value of
 'blk_stat_is_active'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v2: add one Reviewed-by: tag
  - rebase
  - fix one more warning

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-stat.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- linux-next-20260213.orig/block/blk-stat.h
+++ linux-next-20260213/block/blk-stat.h
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
 
@@ -126,6 +129,8 @@ void blk_stat_free_callback(struct blk_s
  * blk_stat_is_active() - Check if a block statistics callback is currently
  * gathering statistics.
  * @cb: The callback.
+ *
+ * Returns: %true iff the callback is active.
  */
 static inline bool blk_stat_is_active(struct blk_stat_callback *cb)
 {
