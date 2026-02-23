Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CC2777F3
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884083; cv=none; b=h/no/Osp8HjYVDTO/5/RQxrq9l1E+P1uevmXylB27XS2QmMT5ODqiTNvQFAPoF+6rDFSSlV+EMANO2/fxLUNc/4UODtsC6XV6/D/bU0tROpDZalpGabCkkOABKBRvv5VcAY6cpJo8L2ZJ5Z9n0CViJaCBp0Y0W+mnZzEzh0Oljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884083; c=relaxed/simple;
	bh=oLTQjEWqJNE3iA16VAIOsduSmQs67Tk7mW7l7/oauGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmYP4kSA7adPJq3O4x6Ad1zNegdvY1lgMbSGvZTGYdgdWiYzv+v/saZ0v0kDDukc3rXFfmVlkJFHKSkPvp3r38HYi7QxpN02bHsdTxq45f6OYvd6LAYvAJ7QoL2OTckrPzjXZJCmvIzPIbGuMC9SvdQ/slyoYsB6jNi6Z83g/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kJxxBx1L; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kJxxBx1L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOwBm8Z+X6qHsN1shZWr10vlktsSRb9Qk4tTjTBnCxs=;
	b=kJxxBx1LbPdCCWBnr0j/6q9bQ5JlkuDHQyMPUvlY1RBnfOJeQDLJLtRlfwnYSdKYlE/d45
	yhoVEoKvw959vGYlLBX6J2MyjkT3ZWv2xO784z7wzjfvc8R4m8sbQo6/QiWIfLXKdRrjOU
	8veQ27Z1R/YAOqswOPB90y5yH0LY5xE=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org
Subject: [PATCH 02/62] blk-ioc: Prepare for enabling thread-safety analysis
Date: Mon, 23 Feb 2026 14:00:02 -0800
Message-ID: <20260223220102.2158611-3-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

The Clang thread-safety analyzer does not support testing return values
with "< 0". Hence change the "< 0" test into "!= 0". This is fine since
the radix_tree_maybe_preload() return value is <= 0.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..0bf78aebc887 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -364,7 +364,7 @@ static struct io_cq *ioc_create_icq(struct request_queue *q)
 	if (!icq)
 		return NULL;
 
-	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
+	if (radix_tree_maybe_preload(GFP_ATOMIC) != 0) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
