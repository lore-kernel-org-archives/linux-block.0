Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5051F4CAB;
	Thu, 12 Jun 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708742; cv=none; b=hLB4tY/0gvnyma9oq6c3bTDCsdsgaWX0XB0ENzJjhaq1e/3N3LBZyaJ/3CavISgegFEACHVjtwALUY+8XQ4fkEngVGuATFHFeDTe6uAZvyRYt2WCpKNACagcZumMYgNFjCUDhmT1sTRmqs5RWMT3wseKRjrv61UqSliHRCVBp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708742; c=relaxed/simple;
	bh=9vmq+cY8WfP96FmqEMCfBBplc9rVJ7lBf9uxqjl832c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZK9sg86mKjB69cQ+KGA6Z9/HfcmkC24C8C+Emg5I8lFkOH+0odKSooLLrnepf/sygRi7U01ZFZ4qimWPX/L1uzmzbkK9XHCktelOOmL7tP6yVwSgcNy/vSAEGqTBpzUj50uT9bXjkdtY+9L96KE5tiMh6K5TK3+tw/6J4OXbbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1tQi4UT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1tQi4UT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so606047b3a.3;
        Wed, 11 Jun 2025 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708741; x=1750313541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwfgiRZ/gDrHIkeKaCtubEASF324Y/N74+a30GI4VTw=;
        b=M1tQi4UTTBCeJ1g+2h4XGFHYyL8+0k/WKC/X2jKgW0pzgXUFQkWXSMUtt0VB7iDO6q
         g/UWZqFZYMCLWDyu3Lh/8nDiH+VYEWj+3SRyaH8NfxsFP6SJ3OaZKM3HGpVhTFNbMg2c
         ZZVn0EgKA4jmtlqR28BWiWwrJdbb5ctGSVfzh+p0AyB5346tP/9/GGLWhhZrQw+AvLbX
         SUS6WYmrEJtrjmwqaj8SGLwZupsWtO4PgMdAU8t6fdQXt+FWc6JnYC8FiIOscCg1y0YE
         /tNlmdZfQMKMFEsGrQKWNAqHbKnyrP+aXSt1idZ8UmXJf0o/ZSpFUFN3Iw77xKt5MUI2
         JHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708741; x=1750313541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwfgiRZ/gDrHIkeKaCtubEASF324Y/N74+a30GI4VTw=;
        b=aYBY0FYDPmQLIaJh1yCRZES/wKoZaKKC5JE+A+D81Ahwv8Lijk6Ey+BJ8d2e/7JIb+
         qE8HeSKZKhL+a/mIibjCuNRMUAklO/SQFKL52KeWbfY7hCgr55gnQJQUborMTpZAsnF7
         Jns2q0oPaasWUv1o0+yC75fyY1fnS9CRo8J3gTdKb9fNn/lZ1M4AfPDhOrcI+kAlieOZ
         CcVEARA9yAKohpYx35a0s7GIVtl2pReqjx0MEf/br+870VhgoRpNLApXOz8fUWqGuNCK
         ly0/lBd/uB6cdcptKmlMCVjlGQ4zZ/MTo18iXEyafJ+6NUBa2QcjSoQkAfZMeOLmDYpA
         6HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZegXBtjeiz8OQhUXzngf/AiwcAMZf4z/sPpKAABzp+F2Kwl9XasbkcwBgL+Fri0dd8poFUx0zPzXc0n/BhA6LhdHL@vger.kernel.org, AJvYcCWqPTmS+NUlTNIMmAmkO58ZtHrvEsWqwmic8NCP1/E2/BJP2rEvDW9r9lEWVZGpZPnhRDx7k4Qy5aeBAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Q1yiPOqZUDDB4XcR5BaJdRzcrX6+kIGTOSopN33T7JK+T1E0
	a9kjYwISV8riwruZcxdravPOUzT5MhoJidk50hrTk9Uyu1y86pAcqAnu
X-Gm-Gg: ASbGncsCgQnT6DI1yqyKQKtkEXOa+uJmeRtQ5fb/ygLaPmiqldUpH9rODaNAis4S+ib
	bB9gXL7Jo8giR5SQbs6rz4tJR7ZpXDnpd+HGK5o7g5WJgBM0SvM6qorNTeLatY/LX2aVQGycX1e
	Q0VYY/73mLt6jPfxTw0QpruI/hOgeGUpstU8f2NWJH0sBQEpZnu57xceOmmXfBzuXXRUYtGk6cn
	Z2DReFqfFMIzUZBHvofvyTVFfLYK/oOLV+eYJ73oWtijWdVtNRSSKYjH31MjB2C1d9nMMv/warH
	o+RWJNav3xIrEgIIlOFnueTTW/NbrgmGDqBnRPgIou4xcILzSG9s8VT2/Ano08IcUsrO7LX2EVt
	/Q2MY+A/wYbuVVtYN9lYTc9Fh
X-Google-Smtp-Source: AGHT+IHW2qL+8w2LrASQ3rKwMp9H5GP+8KhRmin6EdrqDdZQq8jryXGwPhSjqf6oihMgpvDBO1fENg==
X-Received: by 2002:a05:6a00:3925:b0:736:d297:164 with SMTP id d2e1a72fcca58-7487e0b1b93mr2438063b3a.1.1749708740671;
        Wed, 11 Jun 2025 23:12:20 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH v5 4/5] blktrace: use rbuf->stats.full as a drop indicator in relayfs
Date: Thu, 12 Jun 2025 14:12:00 +0800
Message-Id: <20250612061201.34272-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250612061201.34272-1-kerneljasonxing@gmail.com>
References: <20250612061201.34272-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Replace internal subbuf_start in blktrace with the default policy
in relayfs.

Remove dropped field from struct blktrace. Correspondingly, call the
common helper in relay. By incrementing full_count to keep track of how
many times we encountered a full buffer issue, user space will know how
many events were lost.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/trace/blktrace.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d3083c88474e..5401b9006135 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -415,9 +415,10 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct blk_trace *bt = filp->private_data;
+	size_t dropped = relay_stats(bt->rchan, RELAY_STATS_BUF_FULL);
 	char buf[16];
 
-	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+	snprintf(buf, sizeof(buf), "%zu\n", dropped);
 
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
@@ -456,23 +457,6 @@ static const struct file_operations blk_msg_fops = {
 	.llseek =	noop_llseek,
 };
 
-/*
- * Keep track of how many times we encountered a full subbuffer, to aid
- * the user space app in telling how many lost events there were.
- */
-static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
-				     void *prev_subbuf)
-{
-	struct blk_trace *bt;
-
-	if (!relay_buf_full(buf))
-		return 1;
-
-	bt = buf->chan->private_data;
-	atomic_inc(&bt->dropped);
-	return 0;
-}
-
 static int blk_remove_buf_file_callback(struct dentry *dentry)
 {
 	debugfs_remove(dentry);
@@ -491,7 +475,6 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 }
 
 static const struct rchan_callbacks blk_relay_callbacks = {
-	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
 };
@@ -580,7 +563,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	}
 
 	bt->dev = dev;
-	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-- 
2.43.5

