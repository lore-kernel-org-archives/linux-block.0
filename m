Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651624C079;
	Mon, 12 May 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018193; cv=none; b=Dlvy4GE3yW31g6j7o7VwWdPCRb7qLmG85rOfwv92WYzvLn6I+vGZ5H/Vqj49o1jhfxmrUi71q6w7Kaa4+C69519ufRk3GEZlOdScgC7ggPTlR2TI5cPBIm4SRcgrFXQMMOUJNjJ63bHM6UMuJbT9knkU2FgFLMhF4D+OmHqyzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018193; c=relaxed/simple;
	bh=jt8mz/LIeqRGvCoOHtTSkpLfQQkOGg13bmuG1diMBwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBpzHS27OdR7wUb3pAIurPzuC7Qz0XeDNhtDzT8H31SWwctkKj58RuwBmrlPRzrcsv0Ev8JI/+SNLDnJYSqrUNGx/ixBnDoxrk3fNWUgZw+7eyS7Ob6jksyy4ZZXwNCXvWXG8zXNLCob7dAmqIH/F6lctFALj8KQ3IoSFxpufzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9t1w7tR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9t1w7tR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30abb2d5663so3847010a91.2;
        Sun, 11 May 2025 19:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018191; x=1747622991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN9dQhzLwM+Yz6+OcH81L0tELj+gC9AsU7SNrehA9n0=;
        b=k9t1w7tRrfEqbdK8RlVBbczf2m0E1jFCs7goZIbcOWMQblRHllxMm3wGfDmWJX2hXD
         l4kgvMECZSSDs97/clQ/n9+FaeTyfpLVMqnd7Mc8s1+ENj7qZEmfPnBaLmaYsoa67A4U
         pMC8pcjJLq5p2Zl0dVJ1tvkGOV1WEEYOBAT8FxVYOF496S2rGoMc1MEn/H6G0zNgiy2o
         oK960dgkkgXIgWLLg2RNbDlJycRkhmbfEmWhimolK+5V58yO0Z1LSrQ/bo0z9v6PcJQT
         70WNd/gv6WLOS2Pxq8ad+xXUr8npsbLcgJ5SWHeJ7o5lyY4F1OdUsqMWYzdJKJiqGy6d
         Q6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018191; x=1747622991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN9dQhzLwM+Yz6+OcH81L0tELj+gC9AsU7SNrehA9n0=;
        b=g3tmdLLi44yRwV0B0TevU/3bzY5uaNF9dEQlTf5gEqUWzEubwt/VhoHgbxDMwXQjR6
         6T6aAke+IZmKat42pBCcPXIvYqJT9cDypdgg2dfkVxFZpJoivuzxpKj7Rm1gBG0uBYVJ
         4IAZNzBwJFxk6LSV0m3nV8BupsoG4PfkMmtntT4SETs7Kx0n/JwueWHLD51KhpOfWPOj
         jeSyEuzSFDpcq0iN8hOXTJeId9vZ0rFBtw/hCSTu1UanPIiHB6dvVrvI1EqPjHQPvMpS
         lz1bFR1p33SCa6UIRudnxCmZiVl4Dy5bZ9Yub1f+u9/ny7Z29iV/9LwbKewYbyptifHJ
         IWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDhXPlxAWoVsu95ZiXC3BQEQff+Wc+x38tvEIGoB1H8wkZdBIccGhFQN0rJ+G0AW5p/7Ofnbnvp+Uh+g==@vger.kernel.org, AJvYcCXqXRK7ITZop+dyy4qJ+OE4ZeWAghAfsr1ZKvZuoI3CQcw/JLQ5UF4WeGyg5vhZV/ok9AzFq+W2cvsyvp6L/lCS1Cqx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UJFynV1b80NznwyHBw8Mx4G2VHkCJ1TExtuPrHq6TWGzDyBH
	otQuqJBv6q3V/1m7cDmLMT+aP0gGW+colzYzhCGcpyKb1srnjTb8
X-Gm-Gg: ASbGncvKuPA4fXtkrzRXTEhRYAyvVtFUg8ZkZTlszTl5I6faYbbPK8Am6otioVpnmoB
	NSVEvwFEEdIoFbYsUPqy0yDLc1DeLw9KQ2hbSnG0YOjrmQooSl93xTQh0LOAJEW62Sw8rupYNXH
	sH7fYTLFfbFuPplCL8N/isd5DdQpI6Y7FU/YHJ0CoH6vs3drowlzRVW/PQMEPkSs7IMT7DmqH2k
	mrKqnRv9WyJMnBPJmbgyPzq0VbSsH2VtgE/oPvXfBr8JI2mSo3UbQFzLYm40ANXP9D27j8zQh4j
	M1DaNwTR5knl7JWYQOOwSk/B+zTTdzPVe4uVkgVzrMPCm2qIu3f8gJPzTpCnUcx+xroWtH4x9ZE
	6sDdbbDIGeNFJdUKYGXdGwro=
X-Google-Smtp-Source: AGHT+IEIEObMTQTvXSOyvDjt/MLwZV0MY84O4o1a9TA0eyEKAH8W6OJsN+rRuimiKIw7u+busrns6g==
X-Received: by 2002:a17:90b:28ce:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-30c3b91025amr22737353a91.0.1747018191041;
        Sun, 11 May 2025 19:49:51 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:50 -0700 (PDT)
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
Subject: [PATCH v1 3/5] blktrace: use rbuf->stats.full as a drop indicator in relayfs
Date: Mon, 12 May 2025 10:49:33 +0800
Message-Id: <20250512024935.64704-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250512024935.64704-1-kerneljasonxing@gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Replace internal subbuf_start with the default policy in relayfs.

Remove dropped field from struct blk_trace. Correspondingly, use per-cpu
buffer mechanism to replace atomic operation. Through incrementing
full counter to keep track of how many times we encountered a full
subbuffer, it aids the user space app in telling how many lost events
there were.

Sum up all the fields gathered from all cpus when application is reading.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/trace/blktrace.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d1a89714e805..09d42c40ac9f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -415,9 +415,9 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct blk_trace *bt = filp->private_data;
-	char buf[16];
+	char buf[RELAY_DUMP_BUF_MAX_LEN];
 
-	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+	relay_dump(bt->rchan, buf, RELAY_DUMP_BUF_MAX_LEN, RELAY_DUMP_BUF_FULL);
 
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
@@ -456,23 +456,6 @@ static const struct file_operations blk_msg_fops = {
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
@@ -491,7 +474,6 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 }
 
 static const struct rchan_callbacks blk_relay_callbacks = {
-	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
 };
@@ -580,7 +562,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	}
 
 	bt->dev = dev;
-	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-- 
2.43.5

