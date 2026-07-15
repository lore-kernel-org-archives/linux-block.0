Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F7197A7D
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100831; cv=none; b=tSpSJZVOw8+54r0unegMRv7QhdiRBIvdCFlQXLzKTbyt8dTy032D5TsEtqsAj85osc52VzTCrS2cZZJipzxjUM2K5kSgNOcCkStnQF1wnUys8IkjtauqfRz25wpSgBXXut/fcN/lpRSozK+XGXEKEYm5vMq+9YY4nbV+5sGu2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100831; c=relaxed/simple;
	bh=5F/vshi/yzZDp+ADgbCUp3pvuzTR4hXfOrL3e07gh1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ho3SNG1yewVTLbbE/Loycl46QNYu8iVGFO48S4oX/Ti2Gk2xN+ifwSjIKH9K5gic7o+kJKIcyJo9FsfTpPx6Lu2rwhBZaZ5aur7KMNBfOGqJez4qfsrDJeRvIuFRfyZuod3NzkAEgxBzV8xqHXNj35MGScGvMSwak+nL0nnCDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H52QWTob; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H52QWTob"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784100827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IixjavARVv2WYF/Eqb7VBcZj0F3t/yo1sFZrDReOITI=;
	b=H52QWTob4nKRw14dM3F4NT6g251wGpWrshD3EywnGxAxq8xthqXlIkutg5RQ3/OGTzML8y
	4IUg7kZj33HEMfCQA6sDrxU2eE9vdL62DkptZq1xRPd/rYytRLlWi49fFBtkudGOdaSAMS
	s9F66VCstt5JBcoOuOCV4YU9RrwBZb8=
From: Jackie Liu <liu.yun@linux.dev>
To: xboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: show operation in error injection rules
Date: Wed, 15 Jul 2026 15:33:41 +0800
Message-ID: <20260715073341.95129-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Rules listed through the error_injection debugfs file omit the block
operation they match.  As a result, rules that differ only in operation
are indistinguishable even though op is mandatory when adding a rule.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/error-injection.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/error-injection.c b/block/error-injection.c
index cfb83138960c..e14bc4b723ef 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -276,9 +276,10 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
-		seq_printf(s, "%llu:%llu status=%s,chance=%u",
-			inj->start, inj->end,
-			blk_status_to_tag(inj->status), inj->chance);
+		seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u",
+			   inj->start, inj->end,
+			   blk_op_str(inj->op),
+			   blk_status_to_tag(inj->status), inj->chance);
 		seq_putc(s, '\n');
 	}
 	rcu_read_unlock();
-- 
2.54.0

