Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9017ADF8;
	Tue, 10 Jun 2025 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516536; cv=none; b=W0P2+9/onP4i7LzASliC9sYlxgVrKuo/G4cOZADFNArEHNkT7N4K5mmgtdEPyYXYfl2n23qdjr/+9yZTcEweJZ+vLvlp9Vn/3sQNiIvpXlIpa/pyLa3O3dtpHDN4GqQSHfvEyuT8uwAWg9Eau5xhekXopSX/kUNmEvs+UDccY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516536; c=relaxed/simple;
	bh=m83ChYDphIvMWiIyXq9sa+8QWHJy01xoOGhhU7wPztQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FblFY0orSSRLYpbnPljVBPM8LQaUFvLd8N6dvy5c2g0+8rOrXyxiJjXaQuGsgHqky+7eBZoe9/LSuwIho1BpqKg97wyIvWu6YVH1P2jkYAy6zaejfOarMzUZowtTT7y5LwCLqz33AEY/0y0n2vPk60NJgwmXdp/wGE97xaY0SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6G7+6ka; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6G7+6ka"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3121aed2435so5263447a91.2;
        Mon, 09 Jun 2025 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516534; x=1750121334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry/7AlIiaDB3vtHSBPeBsB1ODjnLd26f1hKrzHBSB+k=;
        b=j6G7+6kaOKVPUx3jRirIoh6W7h3Oy1YFMhTuHKDNyJH7fHX46gHZji4x/xKpYAegGr
         CVr/hEL3SpZB9XmkYC3Gx1g+x1SW6ahiAFlJiZHY1R4RAgWKVZwUXXRfmdyV9f97sTka
         N6+T7PTELWkA3JZZ5hQeR8prJU2WJU2i5Mu+H+mYmhr8FBTzQx3MPrsVgRbSioO/6N6R
         ar/K4prT9om/z7R2OPDq+9bYkrm83vkLfxcQKYdW35n9VSIf7poXSN4O4PNcWxzf8nJH
         LI8axw5blxvxYiajn1xdjpVDjELNzHOz/5A4wndzG0hXvQr/N0ysJyHOfTxx8RN2LaJj
         nTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516534; x=1750121334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry/7AlIiaDB3vtHSBPeBsB1ODjnLd26f1hKrzHBSB+k=;
        b=Tqap5G4le5HblRG3pw8fAZaBaPVO9Zd1iAHBy+ZrfAQItHyvhzGviyCUncoQuTVrSE
         7g9Qp5GBBPT2qTKsSageUz5kQodNrqbLPkitl6zk8I0jHUCCSlOnsMawm7sm2HjIQ5KQ
         +XAa5u+0UqJbUMwP21GWLtSbmoeeGsF5lF/QgYNAS4m/oGIzbwsPZ1rHvLzX9cGtvWOM
         VIfMtY8ihYBUoQlCNhfiTjDCD1CbWexVYrRarKWkfIzajGdXE77OD+hRKOMCo0tLMzIZ
         8KNzC42K3l3kgnVWYIDNf6+DI9NyRxf+Tw3KdMRUTwk4UGACL3E07EecIL8R5JF8O+8X
         I/0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBQNOURPv2aTW+yHWz59E1f6BlXyh5f4CItJhGE3n9ESNmwPpMCwc79abr9zVectAiBluK3ZzVfr7ET4WsvS4rw/pj@vger.kernel.org, AJvYcCWxh7rDJFnA7Rlvn5P0ymYQPTxUbR8kb0fZV89t34B5qalvS5i1aRbmaZrgpEFmkqVVGhgAAV9kOxrlRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6910PIlMI9vXpj0Qgo1tfVYbwBQSvMxUwHQ7Jb7IWib6KEN97
	o9q4io2Smo31oQz/VbhQ7caBDzxo/fjXiBBulcpx1qeclAx0MImy6f0V
X-Gm-Gg: ASbGncv5ZO+2B8VvHUa7XhRh2ol5Sq4JquA2982R93CAEnwgjqNzD3Rq623fXgwtymx
	tuR3FeFHipjv+8oj0RV5/rlyy63BJAhA5o8VV9q8LF3AGbqyx7AF5+GyDR2obSAV8KCNYHB+mIG
	QASFd5tb9piHkRn6EWPHSdcsMOBqEa7r8M2WiIexmmIm+rOfbsLPbYwzFf8RaqOZYAitHx8/1Bo
	2tjAAs7eZRB1opdXQ0MBwFEO6pHdoNcO95HTO8ncEb2JzuzGxiTkz5YkUPzWG0I59TiXsg1AW3V
	S7zV40tfExE1vfynJGyX55WWvh83cN6KEgEgR0W7M/0wwpoEyZyuWabov1jLDhaTs3a+xSSZWVs
	72WwW/x2G6a4TPdcJ1xkgZqQmQXVP6x5KiQ==
X-Google-Smtp-Source: AGHT+IHM23NtT/zldAxnNLeRnUkRsj1IbqsQcQYgL5XdhDq0xOQfh3ZdXRgncglA5ZJsyQ+Nfu3a9g==
X-Received: by 2002:a17:90b:4a43:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-313a115bea7mr985852a91.0.1749516534168;
        Mon, 09 Jun 2025 17:48:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:48:53 -0700 (PDT)
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
Subject: [PATCH v4 1/5] relayfs: abolish prev_padding
Date: Tue, 10 Jun 2025 08:48:40 +0800
Message-Id: <20250610004844.66688-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250610004844.66688-1-kerneljasonxing@gmail.com>
References: <20250610004844.66688-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

prev_padding represents the unused space of certain subbuffer. If the
content of a call of relay_write() exceeds the limit of the remainder of
this subbuffer, it will skip storing in the rest space and record the
start point as buf->prev_padding in relay_switch_subbuf(). Since the buf
is a per-cpu big buffer, the point of prev_padding as a global value for
the whole buffer instead of a single subbuffer (whose padding info is
stored in buf->padding[]) seems meaningless from the real use cases, so
we don't bother to record it any more.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c |  3 +--
 drivers/net/wwan/iosm/iosm_ipc_trace.c     |  3 +--
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  2 +-
 include/linux/relay.h                      |  5 +----
 kernel/relay.c                             | 14 ++++++++------
 kernel/trace/blktrace.c                    |  2 +-
 6 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
index e8a04e476c57..09a64f224c49 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
@@ -220,8 +220,7 @@ static int guc_action_control_log(struct intel_guc *guc, bool enable,
  */
 static int subbuf_start_callback(struct rchan_buf *buf,
 				 void *subbuf,
-				 void *prev_subbuf,
-				 size_t prev_padding)
+				 void *prev_subbuf)
 {
 	/*
 	 * Use no-overwrite mode by default, where relay will stop accepting
diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.c b/drivers/net/wwan/iosm/iosm_ipc_trace.c
index eeecfa3d10c5..9656254c1c6c 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_trace.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_trace.c
@@ -51,8 +51,7 @@ static int ipc_trace_remove_buf_file_handler(struct dentry *dentry)
 }
 
 static int ipc_trace_subbuf_start_handler(struct rchan_buf *buf, void *subbuf,
-					  void *prev_subbuf,
-					  size_t prev_padding)
+					  void *prev_subbuf)
 {
 	if (relay_buf_full(buf)) {
 		pr_err_ratelimited("Relay_buf full dropping traces");
diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
index 4ed8b4e29bf1..f16d3b01302c 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
@@ -33,7 +33,7 @@ static int t7xx_trace_remove_buf_file_handler(struct dentry *dentry)
 }
 
 static int t7xx_trace_subbuf_start_handler(struct rchan_buf *buf, void *subbuf,
-					   void *prev_subbuf, size_t prev_padding)
+					   void *prev_subbuf)
 {
 	if (relay_buf_full(buf)) {
 		pr_err_ratelimited("Relay_buf full dropping traces");
diff --git a/include/linux/relay.h b/include/linux/relay.h
index b3224111d074..e10a0fdf4325 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -47,7 +47,6 @@ struct rchan_buf
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
 	size_t *padding;		/* padding counts per sub-buffer */
-	size_t prev_padding;		/* temporary variable */
 	size_t bytes_consumed;		/* bytes consumed in cur read subbuf */
 	size_t early_bytes;		/* bytes consumed before VFS inited */
 	unsigned int cpu;		/* this buf's cpu */
@@ -84,7 +83,6 @@ struct rchan_callbacks
 	 * @buf: the channel buffer containing the new sub-buffer
 	 * @subbuf: the start of the new sub-buffer
 	 * @prev_subbuf: the start of the previous sub-buffer
-	 * @prev_padding: unused space at the end of previous sub-buffer
 	 *
 	 * The client should return 1 to continue logging, 0 to stop
 	 * logging.
@@ -100,8 +98,7 @@ struct rchan_callbacks
 	 */
 	int (*subbuf_start) (struct rchan_buf *buf,
 			     void *subbuf,
-			     void *prev_subbuf,
-			     size_t prev_padding);
+			     void *prev_subbuf);
 
 	/*
 	 * create_buf_file - create file to represent a relay channel buffer
diff --git a/kernel/relay.c b/kernel/relay.c
index c0c93a04d4ce..94f79f52d826 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -250,13 +250,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
  */
 
 static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
-			      void *prev_subbuf, size_t prev_padding)
+			      void *prev_subbuf)
 {
 	if (!buf->chan->cb->subbuf_start)
 		return !relay_buf_full(buf);
 
 	return buf->chan->cb->subbuf_start(buf, subbuf,
-					   prev_subbuf, prev_padding);
+					   prev_subbuf);
 }
 
 /**
@@ -302,7 +302,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
 
-	relay_subbuf_start(buf, buf->data, NULL, 0);
+	relay_subbuf_start(buf, buf->data, NULL);
 }
 
 /**
@@ -555,9 +555,11 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 		goto toobig;
 
 	if (buf->offset != buf->chan->subbuf_size + 1) {
-		buf->prev_padding = buf->chan->subbuf_size - buf->offset;
+		size_t prev_padding;
+
+		prev_padding = buf->chan->subbuf_size - buf->offset;
 		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
-		buf->padding[old_subbuf] = buf->prev_padding;
+		buf->padding[old_subbuf] = prev_padding;
 		buf->subbufs_produced++;
 		if (buf->dentry)
 			d_inode(buf->dentry)->i_size +=
@@ -582,7 +584,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 	new_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 	new = buf->start + new_subbuf * buf->chan->subbuf_size;
 	buf->offset = 0;
-	if (!relay_subbuf_start(buf, new, old, buf->prev_padding)) {
+	if (!relay_subbuf_start(buf, new, old)) {
 		buf->offset = buf->chan->subbuf_size + 1;
 		return 0;
 	}
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3f6a7bdc6edf..d3083c88474e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -461,7 +461,7 @@ static const struct file_operations blk_msg_fops = {
  * the user space app in telling how many lost events there were.
  */
 static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
-				     void *prev_subbuf, size_t prev_padding)
+				     void *prev_subbuf)
 {
 	struct blk_trace *bt;
 
-- 
2.43.5

