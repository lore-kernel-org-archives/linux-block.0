Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8B1F1313;
	Thu, 12 Jun 2025 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708733; cv=none; b=JHtPn5R/219mR9f4ZvALSeD8oSOVYHjBNK4LNBA+dKI5uXzjqUR9IDYb28a+ES4jCwICKPJMWVHPqG0xStjJiPyY77K9eQbLwVjwpt4RsB7rithhnxKSDo5A1JLArHdR6P0uN4cfOX9zULZOL08c+bqZOy2w8UZrNLBahpPpqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708733; c=relaxed/simple;
	bh=9xh7nUndldLxNd1Y/R2tUXLAsPWf2AAyrqT3bm6nJ60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S50q6lSr2vEjQKCs8Fcf7f9L3d0naZg9+QsDv+b3JyQEvIV57FLR0K1W/+f1fzvoHIddvcyyOQtbp3gZscWrYCZAuO36WykC1GdYYt5YO4pdIJYxYY6cHGgEQovA0sLPPE4KMIt3Ff1fQfGseY41pYrGHhvCaoBeH6SEyp79PYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr8gLiay; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr8gLiay"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74849e33349so624229b3a.3;
        Wed, 11 Jun 2025 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708731; x=1750313531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsHcV98S/tKlZTMYxvYUoDUlnWVAAIR0HZ8eG60FU2o=;
        b=Rr8gLiayxjezzd4NaNKq6D1yBs0yJC1smotR6mcoWT4Yom9bjNZ1QyaarUV0HZeXxk
         oE7lUhEcwCsD7TfVfC40fgxCo2R++Y7gxUOR+oJdU/+4yzgpbyyYIxXIoIXIsQ9p0Q3/
         +eI3OE8mxlroSPYz93yFDn4b4/Tatbr9A7IkI1NhV263j89PLS/T8WuDDsjZa9rBK68V
         OfffYqvu5fcl/xde6LzG2hn2q0PvPCd1dypff7aGwg6GsKtz4wIrgGeFbqxFekQXiHbK
         Gpdcb0ncuyABlWZFt9qf4UJE8h4hlaART4LlWfLY8R0wYC8YKLzCFKhcEJIITtncgIcF
         TUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708731; x=1750313531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsHcV98S/tKlZTMYxvYUoDUlnWVAAIR0HZ8eG60FU2o=;
        b=G2vJDchv/py5ADa5NPZtV+bJebwAc45XxvGMHSmbMdTvsk21TJA/FcPyFaL2UKAoqi
         sstXFw0ollP+m7fzDZiPVkkddxm83vW31dapTQP5SLCeEeNKVisQ6fCz1NtPaN06Zn4A
         bXUlO+LCI6RQi6YL2lwnPfOBG9wjPj4+RSh71goO8UxREuZwq6ItrKdKXLkWs96rdLeF
         zGq1alZ9+Yh5RN/2y98A8zo1MGoQHSAjjQNGdrTWvbBwoHOP4nXnJszifc2kvqXf4eHz
         +pyp+ok5ZVCuOMVeoV6YnUvZPTyBVenWVx4M8cz4GoPUm794f6KMnOzjsA/aYAVLgO0o
         N2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLTeOViKoOjkJ1wfHg3lPPVrWgWkWvn2EplISXekFO/ko1GR7VV8j8SUXBGP+o4dZpAJqPuw6HHEzzi5Clg2rNoRA@vger.kernel.org, AJvYcCW8rB96xp/HoNqBJJTRXgsAVVE2KrJH83BhpbYw4Hgir1x7dNdMKUWPiwDfZ9Gr3Z94zw/gbH8rsOq9GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I8s6YT1ZGTkGzqcnf//czWxRldRliFYb843zjMDHODgiB8zu
	u6gph3uNSvnuYCPpW4yCLUwPbBQMgjJkKQnmPTkBmWDnW3Q8k+w9ktY/
X-Gm-Gg: ASbGnctYMlc7QnNynGWZGVg4PAwrPKq1Bf1cDX3HKBA425Uxlzm5/5PgEdb55NTirbt
	8lGwZ00rhns0F4RM15arbNgKbZFicaMvwrlBeHyzG5jFZISMukT0U8CC9sayW8p49eJRkhTDqgs
	Ao5lI3H87mInZw/Cn0FQU86WLkewj0y5sXeQzEmloK7FXekUCmtfR2rvkWTN2+OkRhrEJb6Ff7k
	20n6edX8/Q9dy5oXlJ/X4jpOBovLTVHZaYEmQqO3oZflDgp2ohjTd38qRue0rvMMMcGRLmQTiDL
	w7NH6CPY+FnKshZcQaUBSfG7l+RfYOj1kemMMkK/rHau1pSAJQv3Fe+RZcYdCKUoqVFWVDVWMJy
	quJiMhOHzt7cVcHPDU4Rr96O7
X-Google-Smtp-Source: AGHT+IEgLzNfQWKUhuG3kcUbJZUVmap+hvpKhnXBm0CDjumtITLivzxUiXGGcl+nR0PprX94OefG4A==
X-Received: by 2002:a05:6a20:9146:b0:21f:4ecc:11b7 with SMTP id adf61e73a8af0-21f86752068mr10489550637.36.1749708731549;
        Wed, 11 Jun 2025 23:12:11 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:11 -0700 (PDT)
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
Subject: [PATCH v5 1/5] relayfs: abolish prev_padding
Date: Thu, 12 Jun 2025 14:11:57 +0800
Message-Id: <20250612061201.34272-2-kerneljasonxing@gmail.com>
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

prev_padding represents the unused space of certain subbuffer. If the
content of a call of relay_write() exceeds the limit of the remainder of
this subbuffer, it will skip storing in the rest space and record the
start point as buf->prev_padding in relay_switch_subbuf(). Since the buf
is a per-cpu big buffer, the point of prev_padding as a global value for
the whole buffer instead of a single subbuffer (whose padding info is
stored in buf->padding[]) seems meaningless from the real use cases, so
we don't bother to record it any more.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

