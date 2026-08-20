Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A83D47B3
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219850; cv=none; b=aV8Hvre2FMAbzyDZ75Hae6OIo5/k4DsY3SIlKS+1nxzcYvjpzh0QYxmLn2rh13TNFGICGaNuy2/KTfpGJhx5H+ROlyp5dKxdhOm5vb6kRvcghNAg8kqEpJkTmalasGkBjF943qKnzYsTqakr/0WsfgsOLeFkPzSmbOAyes6dUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219850; c=relaxed/simple;
	bh=Ue1KeQSz2mteuNE2tqZ3FqrKfVxgfsdrVc3CXv7GmXU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X+FaRYNvZvS8tSQFkrj4CWfz/tvIhYnc2IUsTn+8VT+vHvCVAGgQJBsGVe96CXDj4stjQuOBJWaQd0G6CsYhtgPs2eRw+n0LC/fFDdmxwf5yGoEABosI2BUFmTne+uA7Pbbt+lVT8l7eZzdauPFYtWQ91uSUKsqJJK59aKYxCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAnhPkxJ; arc=none smtp.client-ip=91.218.175.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAnhPkxJ"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ue1KeQSz2mteuNE2tqZ3FqrKfVxgfsdrVc3CXv7GmXU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787219843; v=1; x=1787824643;
 b=EAnhPkxJ/H6RlKHkRBvoN2uMEC5dZap2X0JF4Vn0RVkQxSPLx9rBF4qKaoojfTlDbhGtHNGF
 GdmQacIHu85Y8zKOkHsE95/ogDIslWeqTH7CmPu0UomrZx392oTcBI9IPTqSQnikrhe6QnvW7sE
 w/Ydqb665iU1ge7uaY88OsxQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: from MSCND1355B05.fareast.nevint.com (117.128.58.94)
	by smtp.migadu.com with ESMTPS id e23a4276c28904d2;
	Thu, 20 Aug 2026 09:57:23 +0000
X-Mizu-Trace-ID: e23a4276c28904d2
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: axboe@kernel.dk,
	tom.leiming@gmail.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] blk-mq: Fix missed srcu_barrier() calls before cleanup_srcu_struct()
Date: Thu, 20 Aug 2026 17:57:16 +0800
Message-Id: <20260820095716.21528-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

In blk_mq_alloc_tag_set(), if blk_mq_alloc_set_map_and_rqs() fails
after some hardware queues have already been allocated, its unwind
path frees the partially allocated maps and tags through invoke the
blk_mq_free_map_and_rqs()->blk_mq_free_tags(), which issues call_srcu()
against set->tags_srcu. control then returns to blk_mq_alloc_tag_set()
and falls through to the out_cleanup_tags_srcu label, which calls
cleanup_srcu_struct() directly.

Calling cleanup_srcu_struct() while call_srcu() callbacks are still
outstanding is illegal, it triggers a WARN and tears down the
srcu_struct while the pending blk_mq_free_tags_callback() still
references it, leading to a use-after-free.

The normal teardown path in blk_mq_free_tag_set() already guards
against this by calling srcu_barrier() before cleanup_srcu_struct(),
but the error path in blk_mq_alloc_tag_set() was missing the same
barrier. this commit therefore also add srcu_barrier(&set->tags_srcu)
call so that all outstanding SRCU callbacks complete before the
srcu_struct is destroyed.

Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c850330a32b..59cd629b37d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4924,6 +4924,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	}
 	kfree(set->tags);
 	set->tags = NULL;
+	srcu_barrier(&set->tags_srcu);
 out_cleanup_tags_srcu:
 	cleanup_srcu_struct(&set->tags_srcu);
 out_cleanup_srcu:
-- 
2.17.1

