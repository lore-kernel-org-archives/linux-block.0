Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE11F4CAB;
	Thu, 12 Jun 2025 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708738; cv=none; b=Lci2dXd34Fkxl1CZMxNJCcXE/0Hs6nVppVsShunSgGgcyGuKKOnXrqKr+2JVdvZPNXt2RXJ0uat9PZP5L28ZVjLmYpjbr0rRWnJ4ak2HvS/qHf6JmgBte6ejImj8LgWHuquAIdswZCuq5qFRzTEOBal8V2D4xhdlrH4Q/y1F/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708738; c=relaxed/simple;
	bh=8D9sHDxASn3ic1cCmUXgPT76Pt9nEVJYxVrt6Sj17lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Crcr1TmJL8EvEkfokRDK1eSDwFhWU+CaGc+lF+G6x8tZYxfiGpJFQaxCz6D8eK+zY6fY+P94OmNUhNJm5vpAmHZ/Lr5RnVzv8k3LPTB9yqnNvCT718EMlIC6In74CYgyUIgmnbuOdDWsm2TfSzgIy1t5z4xU9fZoArTPN3226so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtHythgB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtHythgB"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so738337b3a.3;
        Wed, 11 Jun 2025 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708735; x=1750313535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/DS8UbuUDcrhCZrgQkbBuuNPk3hX4iwlMBvOBP+pxk=;
        b=FtHythgBT3TQmSt0Scfoxnh53XjuBFuOz3V9/2z2/tPf34BoVLbe7NqJV29jlTdvy3
         Z7s60YqccmyoaHx+V/eqRBiQKLQ2fyubCX1jaLB9WyseBNcfPYYhhb3paGAMLHN7AMwQ
         0+LC6wfAn4Yk5MrMsccwiTkjJmWpNqgzOZQ6HRghFBCwtFzoBGa4e0Mqz0xiW7Mh80Ko
         lOgCLjfU3GmMg1hvOtloFsZ2VE1HRHexbSDbnXCew7j+UkrLq90XBeudXq8/S58x1EyY
         lchx4F1Y4WInpMu+Fb/KtTzC3U68C6R172XwsLcJoDy10oGP7Hg870Kh5Sjn5KTlflbw
         kAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708735; x=1750313535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/DS8UbuUDcrhCZrgQkbBuuNPk3hX4iwlMBvOBP+pxk=;
        b=Z1JHuBdjMuzRkh+iawKeDJbsMy2IMgX97eRd4XtE/rn3I2vcua7Qci6+EGzOJJl8MI
         fxIl4lpQh9yF4qUiZJ9HzZvU7jMGBzVTXzXOzIF1mw5untUsq4fQFhIXuSlbuE47QCTA
         rT05FaiaN45AiEHzfx1GKvaQWpU3hPlWf/LLJe+nff2kg6EFcJpZfh2JN7eX4+tY8tai
         l9MeRvcv6jl4lJOwgdi0XMQvF+5HTUwHJFwzgEBFGp3bXOST48RMr60bPLOQvBraHhTy
         FvzAKV+Cexl/1hous9i029PTVv66Y6YgYupiAA9e88C/fFeqSXxVhFZIO0OKa97fXnj+
         NWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK0EGynsLQToFBTZfOKuH1jgdoWEaZBj3l0g+/OQjP1fsclgdSznOYkpHIegH/XWJWhoarWn5+7yIKiw==@vger.kernel.org, AJvYcCXebn+xAenx4s3kLW5nP72mrILEnGl9vC8ruTe+6z7hhmPe/J11eA4mkn1QN4p27r5C9ww6TNpXTYmvS3ndpZgTW/OX@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMkxhhftjExhAoH+G9U475tm3hXZgNiM2Xo5vrC2Oq7LhzsxV
	5ASJ7X0d+gYg4ZyEpe47fO5GwOehJ6OcqqWG70ciDiI39Y10BGt5/k4w
X-Gm-Gg: ASbGnctGT6MY34YY/POQWA8ja+Rg5rmmOLAjjnfvhurHeDcaBNOrNm5p0gHmr4V3Ftv
	H7zCkPjOGtWvQvqx6KJzn+Nr0/lXEuEIFhcD8Gs6mM8wZJEviXoZvdm4j0Ua+plhlWY39zX9nsF
	VoPyQF4rbqiRUGsx5JbkU9rkULVzTQ1bslAwjVTVceTELnQI6+1okupvqlIyKabjbg5EISluttR
	Df3SmzY13C7SVEglCOZJHFHPqtCiTa2dNI6vyxgWRmYggwVz2PzmF4YcYtgeJoBPS9AqT4l8rYT
	Re19CYhvvvr1WiOwY1vkoCWvtU2cjTifQffdj/JBf848hYOdEpigS4yeNyXzxd3rgzNt+5rT1yT
	YOhC9aczJNbbmcxfv7pJMe8XqVr2FHkJ8E3k=
X-Google-Smtp-Source: AGHT+IG2Jfl18I5N6mEiogLvMqIbfTRou5Pq0m0rgdaQaOLarhEpHk3ycC1YzveI2n05sTujW0YCnA==
X-Received: by 2002:a05:6a00:3d13:b0:748:4652:bff4 with SMTP id d2e1a72fcca58-7487e239d53mr2340033b3a.13.1749708734588;
        Wed, 11 Jun 2025 23:12:14 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:14 -0700 (PDT)
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
Subject: [PATCH v5 2/5] relayfs: support a counter tracking if per-cpu buffers is full
Date: Thu, 12 Jun 2025 14:11:58 +0800
Message-Id: <20250612061201.34272-3-kerneljasonxing@gmail.com>
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

When using relay mechanism, we often encounter the case where new data
are lost or old unconsumed data are overwritten because of slow reader.

Add 'full' field in per-cpu buffer structure to detect if the above case
is happening.  Relay has two modes: 1) non-overwrite mode, 2) overwrite
mode. So buffer being full here respectively means: 1) relayfs doesn't
intend to accept new data and then simply drop them, or 2) relayfs is
going to start over again and overwrite old unread data with new data.

Note: this counter doesn't need any explicit lock to protect from being
modified by different threads for the better performance consideration.
Writers calling __relay_write/relay_write should consider how to use
the lock and ensure it performs under the lock protection, thus it's
not necessary to add a new small lock here.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h | 9 +++++++++
 kernel/relay.c        | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e10a0fdf4325..cd77eb285a48 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -28,6 +28,14 @@
  */
 #define RELAYFS_CHANNEL_VERSION		7
 
+/*
+ * Relay buffer statistics
+ */
+struct rchan_buf_stats
+{
+	unsigned int full_count;	/* counter for buffer full */
+};
+
 /*
  * Per-cpu relay channel buffer
  */
@@ -43,6 +51,7 @@ struct rchan_buf
 	struct irq_work wakeup_work;	/* reader wakeup */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
+	struct rchan_buf_stats stats;	/* buffer stats */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
diff --git a/kernel/relay.c b/kernel/relay.c
index 94f79f52d826..eb3f630f3896 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -252,8 +252,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
 static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
 			      void *prev_subbuf)
 {
+	int full = relay_buf_full(buf);
+
+	if (full)
+		buf->stats.full_count++;
+
 	if (!buf->chan->cb->subbuf_start)
-		return !relay_buf_full(buf);
+		return !full;
 
 	return buf->chan->cb->subbuf_start(buf, subbuf,
 					   prev_subbuf);
@@ -298,6 +303,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->finalized = 0;
 	buf->data = buf->start;
 	buf->offset = 0;
+	buf->stats.full_count = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
-- 
2.43.5

