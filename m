Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459A487BE
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462190; cv=none; b=Qvxq71CASgj3pNxZHHTDUAgVK5t3lIo28A/t2WBITsudGcEwBA1p97YkqVB0ifi2du/X+nUF+sD4Rt/RgYeQnzXNgCT1U7/RW5/YPZaBdHe37TGOF4p6ibq7NJkVC8+AZYk0RCFSHpnFnNcU5CkqZzubbCdDYxHYdxuSH76xJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462190; c=relaxed/simple;
	bh=+ARibSAUIa09Ron8csmdY5E59OMiunrD4s7VdcXPQ/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gbyVy0SuigbyKe8ar3hLqNgvrEhYQbzrR+eI5Mj7VltRCv0CQqwYPmRlvvaXdNVAWv4DL3SUC6Hkgnp+DvtelU3flLXI0PSPgBYaiImkIrSHuVh6nv+3XYgm3qDuflWpzqj2BVTAmB5ZJ+/xA1+Oyn7gS0fgoiq+Nd84TiTY1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2EDupmo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2EDupmo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso1669662a91.0
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771462188; x=1772066988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ppo1bfyAgtLlWtn+l16lQWhBfdwtkmJ3DmtKQdmqlPk=;
        b=Y2EDupmorIjUOn5qOUkqYTOe5938vZw4hyb59zvB2HHEQqfY78wasg7INPQ7ezCYEB
         JJQKOph0XyExCOpOrenkCJMlwejKTPMgPgG0NgrIRKjXMiCu+zNq71ym38wg14YnVrUn
         IhU2Mv+yaJ7T/P0shsbNjHkuA9uPmNn/064OL7qhpf7NpqHhc0h7mNcAUu1Du1shcJRN
         jUjiSi00JsFnATl5alFYGZxY3CihJQks41iCjGXMIHIpLVnnQZiVtzRLxok38LmZiI3n
         sMWUUHlMXPBlf5jRHJlR0bCszjXxdf8lUKp5VN4SMOPFiKiLNaRY+yvhZ3QtFmGFgwb5
         r71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771462188; x=1772066988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ppo1bfyAgtLlWtn+l16lQWhBfdwtkmJ3DmtKQdmqlPk=;
        b=KscMVw/ocfni73eLMRfVsra80+Ql9JzkVA6IifNzMrPzJDYr5tq1x0GFzfNQg5NwyG
         SIrM/uP0xpT6CY0oOoZYMevHO8BuL9aEaPJiaZ19fl/HSHDWUkzSlcg93loZ9gVY/QX6
         xWINGBRpVPJ4YtjhuVtm9COJk49P1bkBZBffURId+o4RH31fFfRKvLgvzEfszcJ1jnYU
         0MLAp03Th/HHTfUo0RXIRc/0RNupc6+OnNoEGgIXCVFGq7L503hPqypnHZBehGUhixBv
         4QOH6uEfHvjNAzmS1nGFRNd5B/2Mo/37lh0hnDTGDfDI0wN6w7xwf7QnHQLaYqhlY3Yt
         DzXA==
X-Forwarded-Encrypted: i=1; AJvYcCU8c8lPvLvQ8QJ3mjMpBw9aV374PALQMJsW3xYxa3diVIxRcDJ4bP4c6yF/KxCaSgbP56KbetR0bAnNXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyglga78RMx97KYsKH5J03kYsOMF4zEhFj9l9DVIVTOZERZkSZH
	uxTOmSAGc721gMbT+8M/vYo6yQQQTulgf6a4JUJx6RvIfg9NFblZXpgJ6S//4EH5YGgNf26er1Z
	Q
X-Received: from pjvv7.prod.google.com ([2002:a17:90b:5887:b0:356:20f7:5344])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c3:b0:356:2872:9c5d
 with SMTP id 98e67ed59e1d1-356a7a4314emr19274707a91.24.1771462187922; Wed, 18
 Feb 2026 16:49:47 -0800 (PST)
Date: Thu, 19 Feb 2026 00:49:35 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219004940.2594201-1-morbo@google.com>
Subject: [PATCH] blkdev: Annotate struct request_queue with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Jens Axboe <axboe@kernel.dk>, Kees Cook <kees@kernel.org>, 
	Gogul Balakrishnan <bgogul@google.com>, Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The queue_hw_ctx field in struct request_queue is an array of pointers to
struct blk_mq_hw_ctx. The number of elements in this array is tracked by
the nr_hw_queues field.

The array is allocated in __blk_mq_realloc_hw_ctxs() using kcalloc_node()
with set->nr_hw_queues elements. q->nr_hw_queues is subsequently updated
to set->nr_hw_queues.

When growing the array, the new array is assigned to queue_hw_ctx before
nr_hw_queues is updated. This is safe because nr_hw_queues (the old
smaller count) is used for bounds checking, which is within the new
larger allocation.

When shrinking the array, nr_hw_queues is updated to the smaller value,
while queue_hw_ctx retains the larger allocation. This is also safe as
the count is within the allocation bounds.

Annotating queue_hw_ctx with __counted_by_ptr(nr_hw_queues) allows the
compiler (with kSAN) to verify that accesses to queue_hw_ctx are within
the valid range defined by nr_hw_queues.

This patch was generated by Gemini and reviewed by Bill Wendling.
Tested with bootup and running selftests.

Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Kees Cook <kees@kernel.org>
Cc: Gogul Balakrishnan <bgogul@google.com>
Cc: Arman Hasanzadeh <armanihm@google.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..540c2c6c9afd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -502,7 +502,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct blk_mq_hw_ctx * __rcu *queue_hw_ctx;
+	struct blk_mq_hw_ctx * __rcu *queue_hw_ctx __counted_by_ptr(nr_hw_queues);
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.43.0

