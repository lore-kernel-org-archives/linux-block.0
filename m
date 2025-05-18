Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9817A5BE;
	Sun, 18 May 2025 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537065; cv=none; b=LuI6KXCSqEzO/iTT0zxV98ghk2xxNxLh2mDCx8YU4LcesVd+oWkzwHUswoD3ZnTIHnoaUzIj+7UOo7AGRn+EjUZs9xcOAONq7MFaHl/9NlDGlhX8Fan8DwFxqLYvKDKJjUQr36Rv2BG/ZJxTU1Xq3vWHJCdHGvIbWBsDIFRs3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537065; c=relaxed/simple;
	bh=x/yNgCNWUnNi4QxxQnWLyHVdJE5osLHq+NVVnvH5Qrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQ1pxdq18ggCjPDKTSkIQmhv/ZQke5cXFIAfUeTW0D+1RR3P9Mrl43W82EuLyUSGNCu75j2hXpBOGkzjSASUyFa5Er4wO0+GuqdBvD0u/oqB+ffJTZ048hgPlvA7oWxg/jZ4bfTcw0IwUbuJcpehHBfq3IRLCG3hQxPaTp0w1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxYWf/cr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxYWf/cr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742b0840d98so1324443b3a.1;
        Sat, 17 May 2025 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747537063; x=1748141863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkS/0rkXLOaw+LmHSHXJ8oekQ6TKOUhZ9qJA7LVDy4k=;
        b=jxYWf/crSPtAiQS2/alzee7Z3A7aaiFQvH/F7XO6c9DDoG19MJ/1KE5cK3eA6J31ds
         liOQGZyRzrjycTgdhf8jJZP1hNSPY+VODHR3DTAdE/yKJ6P+4whi0CYisO4WnajRIAAC
         HiFfwNMHk92SvUtYAt1Pg7gXWrNc/PWbAzFQHK5GL7qVDMLNgOBaSWC675Ckujotc5C6
         RazDsljd/L66VXZ0m1xP2F3/V+dhVH4N/hjAp/UEg/hL4Pdn1lw2BW8ebNi8FZgzWlA3
         PQcD33wxdUDq6z3fbRxSH5UdIN+Vo+oWOY80AUFzTLr8Boe2/ALSw0RSDLvpPh3JpMPy
         Zw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747537063; x=1748141863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkS/0rkXLOaw+LmHSHXJ8oekQ6TKOUhZ9qJA7LVDy4k=;
        b=cLEZTavF+fMZY+Oy5TZDN0131alngXoEcLqVnIg9gKY+CjFXI+USZ7rxuEwK4Nw4c6
         DTeEF6H47KEEIiKhybe3XQGFOsuAwfOz/JJStG0KulS/Unvto5V4jujC0DYo8MV4S1ZD
         cLtwvDOYVH6XQF2uHmgibR7Kfo4xdgHY6BToy9Hmnn1/aCVliCeQRdygf/PKb397RuGG
         GplRf+Tab5dSdvNkRCkXxluBwOspvNvcSEw1GgxgCGrRDChFyvwtn6YnKwPSNiBaASRM
         YgHfQPMti0nDcCUOoWyJkljW+rDgSp1sy1uEbNXz00G/RnSCGJWcthpJJq4lNUUvkYDs
         bwXg==
X-Forwarded-Encrypted: i=1; AJvYcCUVxD0n+4+g6eticAVIoemuRjbzKsQ0RNyzen7jJrFasUph+NWC2pfp2dy3Rer0oIyJEg8OJO4eKmAv8r9/bBY9zGuj@vger.kernel.org, AJvYcCVkKlUG45Ri27pq22er36UCWInI59LDBXRnyurBXFLPmy5YjL9wFu7VhMOSVTimQyutTy4hLxgJhETEWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvu+QkiZ06cm+S8MpiJPm3IJU4juX2WMShFwG98bX+d32gUxH
	O9xvccHszWQQSMCzsqtCUNjU91Po8sqfH98pZKbg3ke9tw3b5VL9ZHI3
X-Gm-Gg: ASbGnctD1+6PrR7D8IXTfQ85EP9BjSHtIM3sjK1B3vnrJJ9xaKBldfZ5ZFDQIvhdAKI
	JLZOJPNXWg8Oytv/qPl2iUq7PayYSZVm/Kbh1GIPghd5tUdRVFrJQYfheun3pmknvk0ksKtqAQL
	oR+SDHo7RYwy0hXmFq3WQCstHuzeia9Rj68wJFFrx8GUk8dZC4B2HmxiV3tRghZMy8niCPuctG3
	4OoZz9uJesL/lx8Cf7QNZHKfcF3LiznswnPQy/NL95nUTSVjjbb9FjTNuj9bPhUsrLbJmrlXRr3
	FKbY4jjKlu6Jb6HpjY3wshqoB98KFVK9VrA/cNkJw1h6KR2AjP0OEOyjcKka9QZFpLCgw/B/9gF
	nVCc6fXfIAuvPTg==
X-Google-Smtp-Source: AGHT+IGY+CFJp8Nz4VVshTWZ+tQGtrf4MK7Ndrbz7N0cgLHSm1Jud78aylefVvTZs3ghFYMlN0p6tA==
X-Received: by 2002:a05:6a00:3c83:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-742acd72449mr10822476b3a.20.1747537063222;
        Sat, 17 May 2025 19:57:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm3839125b3a.77.2025.05.17.19.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 19:57:42 -0700 (PDT)
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
Subject: [PATCH v3 1/4] relayfs: support a counter tracking if per-cpu buffers is full
Date: Sun, 18 May 2025 10:57:31 +0800
Message-Id: <20250518025734.61479-2-kerneljasonxing@gmail.com>
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
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
1. add Jens reviewed-by tag

v2
1. rename full member
2. revise the commit log
I still chose to keep struct rchan_buf_stats to help later patches
implementing relay_dump() to dump more statistics from buffer. It means
more fields can/will be added. But I have to say, I have no strong favor
on this kind of organization. If you don't like it, I will remove in the
next re-spin :)
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

