Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6A2E62A6
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191744; cv=none; b=EmZvfof1choez3gKIH6MxGBAafzryE7yhrwmpRBtUnXPndtn/219o04ScSefC99bDqVnaIxMz4u+TbDiiDTyRwOo+nHifnGADjOjtxv31JSCGQ8Cs+6/BFGnG8Tf51gprpCnsmMd4aHvsq+Omu+tKXGEeWg/g8eAHXzSwy/jqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191744; c=relaxed/simple;
	bh=m4/HEsjzRVMA9PrBZUA/gwdzJd9e6NfBnu2ioWZSPXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=le39H6vHISXAMX1McqYQJqqGyXVZ5GASU2Dpj145SzMXl8O3wSKonKyYkPVliNDZ41H0KhHxDYwPJmOPfT47YLQcfIlexng5KBwi/Hi1KpQP1ssz5PiH5TmU13WHEAmUbHlQ//RjQVVzdTVR0FZlle0D8Er1IJ7BJpN7ZaXZQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQshTt+p; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQshTt+p"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so4650634a91.3
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765191742; x=1765796542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y25sxzLf3UaqkFDz7vHvLALkanlrIWjH313YVRrfLVE=;
        b=SQshTt+pvNMl/moulEYhSCjnjHHS2SAyAic6zBC4ArPlSrCbLaLM24bclaeVun3bQY
         P6JPHKmYwLux9T2K3rZJE220UzNpeFDjEHu5LDeQ5jruYCNiTz4iQ70oCnBJSp69mztx
         W2BjtEQHsZSU7YwUcGTfm1o7bu0P7z5CcqhEBTiASC8sy4iOrAPH0TZylevrUDPKGCM5
         bGzXQMs9Upocbd6bSC43W6RH0ffqwPCni+/+Rd5SqcqQls+1dd3Gz+1akX8qt1TZcueP
         5Zw7kHmlYQ/L2aiCTapCVl6yHCtFVDfTPjpbETQMqmvtyzV8Fj8zK0acRVHwfqAY94HW
         n0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765191742; x=1765796542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y25sxzLf3UaqkFDz7vHvLALkanlrIWjH313YVRrfLVE=;
        b=grsaet+XgmSQlGRwK1hgENGNIh/A+xF4bguA+ANBBzaV/JhjpqE3WtvFqigK0OROlg
         e0gezndt0WufqDD04Jz0IXeduTrGnX6DhpePUeuR141IDsBqFbPj1bI7BrOHjICf3wDP
         MYetBxPKb+iQQ5VYTtsB3gliO1gi+9Dn5I2H70srKAA5M0i7IyXLfe02xtaZdO96AuRJ
         otvuVm3K2BGtXfn9pv7+zsIwCedcZ8Y3hqZlRXU7leoo3d0R7DBjJyf/NcW+SQIH+9p0
         ft1Ev5PdCq/Z386YQ9D5+yzraV8gdsh2QvsYwS9YuHim0wdqssqr4JrsMI5LCmlsGeiS
         APnw==
X-Gm-Message-State: AOJu0YzZY4eG4YF7K3azlrh4N2XNK7DZ2nH7TM5MkbSkZvK8bips+1Lr
	rHsjUxwNcMdWfP/Ic9nX4KYuGUBc9qDIRj4aduv6wGr7H6XVVr7FT11M
X-Gm-Gg: ASbGncsCId+WoelnJnySjvZe6iaRFaGXJf5Dkce2y3Y5GTgtXULWw5KyUBSG+VpoIdd
	L5iuFyUOI8wHZHM24CPoPqkR3fiwXTR0vofvxa3P+asdx7+XwJddv5yETIbTf1iNVqi5ltruvai
	1HFeGDGC6j/QbUHFRrppdmDwA2bPyXt/K9grmJVZv5sZqPPbUq2q+1ZKVC7/Eeo5rQjO98ARQi7
	C+G2yBh9H5nIIfEb16mcFS0jhmI1voG+CuaymWQiaV0jLLgQF4naGCkBqRyeqwGdgOQ0ZvEEgog
	OHrJEs4ZpewXZTKu1GpUtUJgrfXEgiaQ2SV2aFUncVi39kiGJAtqvWzL7uxM24JtEEmCz6tMJ9g
	VKs6ABVlqNvjBi2LSwNQrTWw89IxQ72UeBDj14DxFEXrnyisUCIdeSTGvGjpW50EZKoWVaLYZvX
	p+AhK93BAIkZfIi1WnbtpApteKz5hxq2NqwFXjuk4J8g==
X-Google-Smtp-Source: AGHT+IEcuA0J0H0H1jXo7XCs3GcxRvdxUlnRJcoMYsOP6cy+T62nA7NW5hwRiI860Cklk2poO81tGw==
X-Received: by 2002:a17:90b:5588:b0:341:2141:d809 with SMTP id 98e67ed59e1d1-349a25bdefamr5621722a91.26.1765191741964;
        Mon, 08 Dec 2025 03:02:21 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349de99226esm3888102a91.13.2025.12.08.03.02.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Dec 2025 03:02:21 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] mq-deadline: the dd->dispatch queue follows a FIFO policy
Date: Mon,  8 Dec 2025 19:02:13 +0800
Message-ID: <20251208110213.92884-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

In the initial implementation, the 'list_add(&rq->queuelist, ...' statement
added to the dd_insert_request function was designed to differentiate
priorities among various IO-requests within the same linked list. For
example, 'Commit 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the
deadline IO scheduler")', introduced this 'list_add' operation to ensure
that requests with the at_head flag would always be dispatched before
requests without the REQ_TYPE_FS flag.

Since 'Commit 7687b38ae470 ("bfq/mq-deadline: remove redundant check for
passthrough request")', removed blk_rq_is_passthrough, the dd->dispatch
list now contains only requests with the at_head flag. In this context,
all at_head requests should be treated as having equal priority, and a
first-in-first-out (FIFO) policy better aligns with the current situation.
Therefore, replacing list_add with list_add_tail is more appropriate.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e3719093aec..dcd7f4f1ecd2 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -661,7 +661,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	trace_block_rq_insert(rq);
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
-		list_add(&rq->queuelist, &dd->dispatch);
+		list_add_tail(&rq->queuelist, &dd->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
-- 
2.50.1 (Apple Git-155)

