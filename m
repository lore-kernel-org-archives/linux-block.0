Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C51C5F14;
	Sun, 18 May 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537071; cv=none; b=Nw8XrqsdgNNK8VqjYG26SYx6NOaWclEl/GdGm/LZuUJKlZT4eOhv/ckYw8MMqCgCip4LQ8UxX8vTn/7q+fdRtG5c+k3xzryZuqnvUUGdIQT1g0N7EzNu6K3EzXIfW3yWEeBbrw355ZUD+txfNtAf4/cirlHtOdED1+4AgGtyy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537071; c=relaxed/simple;
	bh=X8uh0Zg5uTDSDkQUDoBBrT2fLBmGCj1K1lr/2t6IFrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJG0rqkcCkhsFEyyF6ui6HrZl8cXUBjCKp9GDN21ddd5uH1tebETRw7Msue0c0Zd3TUwahisTLFyFh/wY5tnnv1KI3FqWT/UqMHu7tmvuQvaFiY8uxKZZjX3IxtxjquzI5Gd+M/pAewtoP0tqYNR1ZeNCtpnT8ACKwkz92DN+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUIpSdt5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUIpSdt5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso463507b3a.3;
        Sat, 17 May 2025 19:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747537069; x=1748141869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReN2Wu8H7BsHSEK2bE84uS7ls8fGyo5p5xA7a+of5tU=;
        b=UUIpSdt5ITqdHZZfFf4kTKveqGd1rrvClQmuPTWwEhlyvftrWB5Y9f/ZnY/Od0+8Cr
         MT8hED/W0L06yaIeTkSCRe/1NMjafP7wkm0hZlHMncCvtJlO4yp1Jg8m6UWMquwd4foI
         1+QQg/korKtikCah+Q7icXwKQ/2I4mBV1Xvrl8lVveAhm7XVBKwQzIef2+kdD4aSR3HL
         A0mZALdQFakzQhjrzzFMKsvIMbmbUAf6p9TOh1Bg2xqDGBzQsKd7AUvaTY/U6F0kY3JK
         CdvO2xBCy5mwVciRJMuXiE8UPMWMKaqQXfrYaWfjXHjBmJEcU9jelPkffP4KpjTvPPYf
         4Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747537069; x=1748141869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReN2Wu8H7BsHSEK2bE84uS7ls8fGyo5p5xA7a+of5tU=;
        b=Y2ezmCGWWH3rclJF5cJsknVkmJFcq/EGhnD5jf02YvQqk069bzo61XpGp+C+NiKNs1
         BVvbd8EduWS1OZzuZOktrjmbkSaJqZUlBXPPIaOIGux5RnAf2MoUY3MzMLznIwP7vbWw
         1QcvZErhGsgGR13h951PZqSNa+UQ2EpulJ5OUz2519DHTNyMDX8s3+5wZf1p5gT7bmwl
         nNnps1/wJtVcLzEDd9pU5eD86a7+5KjTZG6faBLZNlxqa7/bDXY6bNWMiFwjlBUjzrck
         4qpy8W1mlS5dKHzumQJUNb/5zaiVxZV6gbqi72iISCvyPAZRd3m5H1qH8asmLfNIb2YK
         dsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUYTQt0lpk4OiC34TTVjS/cpye89z9l0Ou2wToHVlYLhd14wGfqqKkncvu5cdKKhbceR0R0umdKCzqbJQ==@vger.kernel.org, AJvYcCWgvWW2mVWRr4kkL0rq1O94v5twNuFoBTbS+BYmRcXuzOgqCuEUEkzXvcFB7uEF+Eng439XlO9FjqNSGrjXW7HjS0HX@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6iNexnAY2SE0M/n8gDbcyX9iZ98v49zx09yVH/Ga32hpqFDm
	mIN7+1v7BvmDpVqKBCCLkPxHTOpLtbGxrCXpjhYuJ2xAL6fvXghmH+k4
X-Gm-Gg: ASbGncv72JnZ5uFLmrxaOm2kUGI5vnVfMfyjEjjd5JkoGQu3wVr8kEaju9kT02i9KjC
	dJYc6IXQdyqmyckIgJNotn1PNGaFlpVe9GoALF6UOLsVm90Gm9nvLwmdvWZKmIFCB5eOlAEiO1l
	sStB6VmVXyiwz10ZQG7yGVreyxJ6amsslOH5LSe5jvBo2WnfPb6UgtON/k3ncHkMq0T2VQHr5lD
	v4f+1+72DFkVUqqHXsfAKkAIIgpYbhaf1m5kaB4hUeMdxbQR+GWpkK3+DI9brsTBC/jU6D1uzSC
	RkZRwvfXYhqQmBRVMYlikrk0UpR+k/9SGbqM4u6hMfSkUz26NTvTNYtPN1XEhZpE+Pl+UPinBlD
	wHWVofyGVtEGaoA==
X-Google-Smtp-Source: AGHT+IGxK/S8VKqGutUmMUS+T3ae2T98n5SFs9tufSTRsqnPViuSqhoA6g5rKwyFnY8/wNZs3Lw4Qw==
X-Received: by 2002:aa7:888e:0:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-742a97cdf96mr10429328b3a.9.1747537069126;
        Sat, 17 May 2025 19:57:49 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm3839125b3a.77.2025.05.17.19.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 19:57:48 -0700 (PDT)
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
Subject: [PATCH v3 3/4] blktrace: use rbuf->stats.full as a drop indicator in relayfs
Date: Sun, 18 May 2025 10:57:33 +0800
Message-Id: <20250518025734.61479-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250518025734.61479-1-kerneljasonxing@gmail.com>
References: <20250518025734.61479-1-kerneljasonxing@gmail.com>
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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
1. add Jens tag
2. refine the commit log

v2
1. adjust accordingly together with patch 2.
---
 kernel/trace/blktrace.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d1a89714e805..545e6063f451 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -415,9 +415,10 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct blk_trace *bt = filp->private_data;
+	size_t dropped = relay_stats(bt->rchan, RELAY_STATS_BUF_FULL);
 	char buf[16];
 
-	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+	snprintf(buf, sizeof(buf), "%lu\n", dropped);
 
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

