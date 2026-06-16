Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3F37B00E
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619378; cv=none; b=TWQrENjnpJfuEdzFQoLK5GeZLRRFPNnI2UWrGT31GKNQLWtnc5nZjm8tfeF6mq8doHN4Xog0Q5/3xzqdprJSw/7L1K+Y5hHTtNf3mTPrsZyJGswPZTQi3da5An4aTKNaDsjI1u1q1MJG8i79EbjO/dbdoU5mSLgjVGGDSb9GVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619378; c=relaxed/simple;
	bh=MVCtyfAmHP+tCWl4X6qpjB0hvAOfROEwoYvmoMY6LH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg4gcCR+h9mtwS18C+7+yOVOH6Nfj5O5F5K0GWnVf9pA4c/vkCh68GTI8MtHB9v3e4nOjXJiGhoAZwA5gkIqYfPDjsc/K3NSvteu5geJIfp/W9c+Fv+3GsvMO+77EWFk5qdyPWVzDbrmiU9qgpA/mFmk25krNwC4W41yCgHUKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6MOoDND; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6MOoDND"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781619374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d8yIEBEDqcbYiBBajCXV/8Pg50pBSzJlMnixHKyM4M=;
	b=O6MOoDNDZkEuBsP+7cYr3hYdGYlsVhvrID+NOnEHElhFRtKVUTC8XfrLxMHthascKFRO4F
	v3td8v0R79f6nnQtdCMmOlQhR95VlzwGp22nzqH78OuoecpRhurJq4LqmGPexizjJ5JPc8
	b21nIgj4uBmTdBpOIQwgKubE8wM3YKY=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
Date: Tue, 16 Jun 2026 07:15:17 -0700
Message-ID: <20260616141604.328820-2-usama.arif@linux.dev>
In-Reply-To: <20260616141604.328820-1-usama.arif@linux.dev>
References: <20260616141604.328820-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PF_BLOCK_TS is only set in blk_time_get_ns() when current->plug is
non-NULL, and blk_finish_plug() clears it via __blk_flush_plug()
before NULLing the plug pointer.  copy_process() breaks the
invariant by inheriting PF_BLOCK_TS from the parent while resetting
the child's plug to NULL.

Clear PF_BLOCK_TS alongside that assignment so callers can rely on
"PF_BLOCK_TS set implies current->plug != NULL" and dereference
current->plug unguarded.

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 892a95214c54..13e38e89a1f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,6 +2338,7 @@ __latent_entropy struct task_struct *copy_process(
 
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
+	p->flags &= ~PF_BLOCK_TS;
 #endif
 	futex_init_task(p);
 
-- 
2.53.0-Meta

