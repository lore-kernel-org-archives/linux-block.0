Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106251D6DBB;
	Sun, 18 May 2025 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537074; cv=none; b=kI4eFTI6M9zNvwywvyRc+2rfIySjF2TmDGRPbIE/7viI/EyqsvZVkBx+CFO9k/ZGVRaiiUFiNsM2G5vNdr8OHEbMbLf4Szrn/T3PTS4o6Cyb1f+LP0Cfz0uGNy6j/QCxRJLyU2FjTgFqHXn7+J9EQTKc2EcLSwuXdPAlDK7+y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537074; c=relaxed/simple;
	bh=jHdreU23unpxPd3gg7hJ+y9cYVjy119RFVvEwq1sdtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lec5kHmsFT3XMoXS7PNMZMOFRK0V1c8gEvKzhzVG2TtaF4qE0XiHIor3ZHAkKYkiMB/HhNOW8WJszuaInD14PKABI/70D0KTnDFhZjAvb/6vd9963fpafoBxNFKeVF3HwAP2a4VS+OqDiyyqIhhB4x8Mt3IbxC0aGhNAdUzT70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGz6hSpM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGz6hSpM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c96af71dso197420b3a.0;
        Sat, 17 May 2025 19:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747537072; x=1748141872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vU4Sr+pGkfrx9C51qYKV6aqKFkSDEk9hkPaeHmYyJE=;
        b=EGz6hSpMY1bWvnS59X5Agq4XYuqk5BeK80rpqnhD0Yjb8AYIiMSrY1/0cCN0AO1I52
         xE81MhpezyIVNtHplC+wZJefE/f1aJWwUwIYdDxQqjeJDfZ6ACTR3QJYksyjfgCj8fnU
         aIbCyN0K0InXd59kdmfDV5XEzl1LukXC38X55J0SKhLOPs9jDmuDKV/KlhoWZ/5ijWgF
         02b7OAZGk9UzSQautvlvLNoxCN3WiUbjOpxz2kpH2A+ZG7YOuAr1b+CTDdvsXVm24On/
         KMDpiv4z7rH7ZsbqfbEqjlNY9xWMs5GBE8c0hwAoF4ky9KuLCpxhb1zKGI46fZ4gopzK
         +HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747537072; x=1748141872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vU4Sr+pGkfrx9C51qYKV6aqKFkSDEk9hkPaeHmYyJE=;
        b=DwJD/OuLJPuAwNODK1aYmyz8KZ5OIlsWQcWs/V4z/xYLmZhZUYzWHpDnYSKm3fuiBn
         +xbaxyAx9PKB7w27KzcI0Qm79TX59IDRaLLFJR32arkRuVNf8uceZNtPjj8xraoeGwVt
         QmWI+SCUUkoal8txC0+miaZfsSSdq89W7ZlvgN1FseSEamq8YYzPVOX06YSXDSv/omuc
         hyPiqCCJmY2WpzMmTVNlRwT+nf/kYMusjdKgZlA3lvbynxcAVU0iVpE9rL6mU+4IjRfs
         GVRfALNalPKi5Avm+ckt2+v3mN6wHsUjVCLyb6wa6NlREQTyMMVyZOcGAJnlfShxTYdI
         xsgg==
X-Forwarded-Encrypted: i=1; AJvYcCURd6fZLx3+bI9CUF/Xf9gtmdeVelquLSY9rgXJ0KKQaE38++4gJCRQzsDuD62o3o4l9P90uwEAcp8yFg==@vger.kernel.org, AJvYcCWLnxqkvNNKWA5cVhWhBdIVjiDSK/prAFR4LcfmNu+6Y6SR059urEQ0RklxOY/7r+ofUA96dtm4LhS4QTFRq8CjUpRj@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhOIx9fh6Dfno25UufkS/cHiAw5wBLGzcO3hg4jrjbOM1O4nv
	KdO2Y+oZGa+ieyXGRwIewCpPOVK8qEVJ4SbYoFMNtvxf9v4N5Tf7R7hy
X-Gm-Gg: ASbGncsbBLvzDUTkp9OE9RlDfnuoEEL0RkHWnlZGGOiOWNNF1KAOzgjrQVTI7nHlm7c
	+wn+qQAasbPsKbndf73UWbYQpyD5aS2W+ZPs8pYQxoZ3B7AWYm6hMt/CBJEUL8Xqi8T8wUoO1Iu
	GXTdY3lTtOSbz0IHbOVmjqevv4mfLMjCAW/Rp3uOP4wCs1SKNEG/sXWCA814yq1m69AcAj5lBY0
	2rviJb1YmRvInA3GxnjeBLzskDVt3LI1N0BJQn2Taa1Y/k2WGfg4u0JkClrAaigLNRVAO+2yWLG
	4Ll9xbHeZ+/C7zpCUphgq7bt4KLxXuapxzZXIyX82eM0nNmqc9jyMrOwN8dwoyVlnVKaCMiLxHv
	dduKLhCZiOKvXuBDW5BWKK8Ki
X-Google-Smtp-Source: AGHT+IGUQH8LwhYK34w8KV7MdQjmYkBEIL6bnxJsYCy5lfgUa3mn82yqd5Y4xATXMSybiMIJ9dcqvQ==
X-Received: by 2002:a05:6a00:3023:b0:742:9e9b:a244 with SMTP id d2e1a72fcca58-742a98fb012mr13764332b3a.24.1747537072178;
        Sat, 17 May 2025 19:57:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm3839125b3a.77.2025.05.17.19.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 19:57:51 -0700 (PDT)
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
Subject: [PATCH v3 4/4] relayfs: support a counter tracking if data is too big to write
Date: Sun, 18 May 2025 10:57:34 +0800
Message-Id: <20250518025734.61479-5-kerneljasonxing@gmail.com>
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

It really doesn't matter if the user/admin knows what the last too
big value is. Record how many times this case is triggered would be
helpful.

Solve the existing issue where relay_reset() doesn't restore
the value.

Store the counter in the per-cpu buffer structure instead of the global
buffer structure. It also solves the racy condition which is likely
to happen when a few of per-cpu buffers encounter the too big data case
and then access the global field last_toobig without lock protection.

Remove the printk in relay_close() since kernel module can directly call
relay_stats() as they want.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h |  5 +++--
 kernel/relay.c        | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 5310967f9d74..6772a7075840 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -33,13 +33,15 @@
  */
 enum {
 	RELAY_STATS_BUF_FULL = (1 << 0),
+	RELAY_STATS_WRT_BIG = (1 << 1),
 
-	RELAY_STATS_LAST = RELAY_STATS_BUF_FULL,
+	RELAY_STATS_LAST = RELAY_STATS_WRT_BIG,
 };
 
 struct rchan_buf_stats
 {
 	unsigned int full_count;	/* counter for buffer full */
+	unsigned int big_count;		/* counter for too big to write */
 };
 
 /*
@@ -79,7 +81,6 @@ struct rchan
 	const struct rchan_callbacks *cb; /* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
-	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
diff --git a/kernel/relay.c b/kernel/relay.c
index fd70d0e03216..bcc889dc0970 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -304,6 +304,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->data = buf->start;
 	buf->offset = 0;
 	buf->stats.full_count = 0;
+	buf->stats.big_count = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
@@ -603,7 +604,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 	return length;
 
 toobig:
-	buf->chan->last_toobig = length;
+	buf->stats.big_count++;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(relay_switch_subbuf);
@@ -663,11 +664,6 @@ void relay_close(struct rchan *chan)
 			if ((buf = *per_cpu_ptr(chan->buf, i)))
 				relay_close_buf(buf);
 
-	if (chan->last_toobig)
-		printk(KERN_WARNING "relay: one or more items not logged "
-		       "[item size (%zd) > sub-buffer size (%zd)]\n",
-		       chan->last_toobig, chan->subbuf_size);
-
 	list_del(&chan->list);
 	kref_put(&chan->kref, relay_destroy_channel);
 	mutex_unlock(&relay_channels_mutex);
@@ -720,11 +716,17 @@ size_t relay_stats(struct rchan *chan, int flags)
 		rbuf = *per_cpu_ptr(chan->buf, 0);
 		if (flags & RELAY_STATS_BUF_FULL)
 			count = rbuf->stats.full_count;
+		else if (flags & RELAY_STATS_WRT_BIG)
+			count = rbuf->stats.big_count;
 	} else {
 		for_each_online_cpu(i) {
 			rbuf = *per_cpu_ptr(chan->buf, i);
-			if (rbuf && flags & RELAY_STATS_BUF_FULL)
-				count += rbuf->stats.full_count;
+			if (rbuf) {
+				if (flags & RELAY_STATS_BUF_FULL)
+					count += rbuf->stats.full_count;
+				else if (flags & RELAY_STATS_WRT_BIG)
+					count += rbuf->stats.big_count;
+			}
 		}
 	}
 
-- 
2.43.5

