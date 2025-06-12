Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778A20E034;
	Thu, 12 Jun 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708745; cv=none; b=FeYiW33Y0k9e4LEs1MT7jvSXp1/rhWU0rprc06HCOUnNd+GSrUwb73fgvCv6XojfyZ/yhvishpyIxKAx0Kj9xFkGEwCO1GCCo3L4Tn7Yc0M3l5+iZnbRts7akUvrLbLQxQsLMlB7c+v7SV38cj9cxPl5qv//ha5nY7xO0REwRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708745; c=relaxed/simple;
	bh=XT21aCq/7P6YAwPCKmY+1PKON7RZG9sndxfvvN+6Cl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJEnDAkAC0V3zOORFTdyTkM8WtIqklTF5jpaK9qidGdruygu/F6UICFjko/m/rZ8s7S/ihQVt6YG0RuYZmiKG4RFcmue22JX2k26l7CpcEb5G4E2xT0qP89cxlMmQqwml9ZxQjOjImSyh0yFTmFzAxJtKfmjJzfYSxica9BULdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9RPzszv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9RPzszv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7481600130eso833978b3a.3;
        Wed, 11 Jun 2025 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708744; x=1750313544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXR9OD2yujCvZ+wl33V69tZqfryb4aPHl7dMp9N7l2w=;
        b=c9RPzszvHWTWm1ZyNSYevDsA1ARLy0m+61WIsAC1Wtzrgv8WTOBsP5/cG7+E9W028E
         TlHXeZ7dFhrzhStejVzGIySs+v4h9dAKp6jgx6k04+7ONndL47gYNthAMiss1myP3Df+
         1Km+gVMx2CP5yLhWkp7pYoK8zn/nSdejrLOUF4Kg4BWktF0Xi9pPEPLdLwgMCpZNmjdS
         MlPsNBDivF00QQ1Oun2BUk9kofcmmUKyO7YNGTk4czmPodVPcqrvHmNHfgEioeLXiC0m
         h0qZl9d507613bZ8DLO5VlmHnGNcLUxaBrXAi95MxynjmliXdBc5HjgkvmRBwloS208M
         ISTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708744; x=1750313544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXR9OD2yujCvZ+wl33V69tZqfryb4aPHl7dMp9N7l2w=;
        b=P5KoD2SKPYqtHtTgzjK3+5zMIws1J8UmvL0sbIHoHtYe4MJPGZ/yUJ9ycF1rk94MHa
         1SfyjUYSSgXWl0PgWBVCQPNsogO+SHp1y+Lg0ZAwQqdvr4sCEDYcV/OysmrzfMRXQDOE
         VZMtLfUb1YekJwDA1t4/mcic3vq/qc3vtZ4ywzR7+ZVZgBA9APegOPUMA/plvcONBXai
         O9juDy3qADGB5vazm/5UEc50e9IDPb3srj9ZEsrlAjQjfNqX3Co04B2u0lUZuTprPcT4
         cqcbHQEqOdQ8fh1nVK2AtEkkTxK2mfg7b8OU1Eie52x1zyRaHJEeZgeW7bGVUIjBE6IV
         29Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUiXiSjh3cPpKmowQZEBoVj+fgQRSq0SParU+f3R7PFZTqGdAI3L7ruFZDlj8UqYkpY6dg3OTj8mYRN1A==@vger.kernel.org, AJvYcCVvdHH5SxSqzgbklPm5cnZyXTKESjtye7slDn7kocRlc4UnKdUXgJYwUjoF6/ylQ3fPskV2k9ej9AC8SnGYlv0m0kvo@vger.kernel.org
X-Gm-Message-State: AOJu0YytDnzq642J9T6huqkY/cpgX+zBNK2w8glStwzSqrroD/YlzL1b
	A2sAdLELD7QtQGencgMVhnddXyXMeEUrSpSzc/i/ZKV6pfEyvoBZ6JJY
X-Gm-Gg: ASbGnctTZk/DwKrJEwdo7alJLPjS8/WtcGQHTi85iraXT+rpyNUuZIaf7uBWYsWv6Vh
	6z+VA9YL6xwLDXULNxYxqtKkeqIoCWMYk5uJwDRA3SjCPovDQxNPPcYzZD3msSj8HJWkymUpSK1
	ybMmrS8PJQIzBk9CpTPrF8it0bLRTTBNNLMeeRUXmvHDgAtaWp7shk9MA5ScggjSdizYxRUaYdl
	ZWUkOWFH7030aUnabbP3ccsl7xGlJLZ0w9IqI8xitQr4pLyRSc7Kd2YhRzCWdv83FosqBxgBLAV
	oht4HvX48ISXUEaFo1weyQyqf6DEk+1rd7z/wD60rGM9NrBJiph+/Vt6Wt1uJSU8xW5kUEAovRL
	qzW85vxpO4669klT/83ygryH8
X-Google-Smtp-Source: AGHT+IFRFXfz1zMb9CmSe+W7cJXS7Efae+Vjrqm0mdRl2xjwkt5ibwvMzol7BSQ3/GyN+cpBEmn70Q==
X-Received: by 2002:a05:6a00:b95:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-7487c207d5emr2984128b3a.1.1749708743709;
        Wed, 11 Jun 2025 23:12:23 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:23 -0700 (PDT)
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
Subject: [PATCH v5 5/5] relayfs: support a counter tracking if data is too big to write
Date: Thu, 12 Jun 2025 14:12:01 +0800
Message-Id: <20250612061201.34272-6-kerneljasonxing@gmail.com>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

