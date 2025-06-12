Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF21F8908;
	Thu, 12 Jun 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708741; cv=none; b=HR1cb3c3P9GFZ1dUxDq1azyS6XP5LFXMuPl9LX3bWaM6QE4JHMZNZdqMVXYpwe62BKMB8o5JffUdp3kQgzc4G/59SfctLLhuu9coSU1q2+3ayWUXtk85CYl1SPpCC/J4uLsGpKB6ycqzk3C/nGfwR8LajGX3cFJgHNQ8Gvj8yXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708741; c=relaxed/simple;
	bh=lLuZJy5LmIhw6vczV+BjTVeE1qeR4Bfzo8mKouv0f/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuCVaq+W2yKYCjqNHkCZYBmr1HaGW05UoAvOnSEjhYgXHvhhLXtymWtB4FhsMDfi8aSlva6MsDcxXt7gM36Pvjzmve4AmAxNE42l1WhWO6pf5OD0hD2oLeLhLYX65EbGU4qAvFbqgEoUG7nuK80hYMmZHTwQyOJAsd0+BT24bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXFvz1uh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXFvz1uh"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747ef5996edso667847b3a.0;
        Wed, 11 Jun 2025 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749708738; x=1750313538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8SVDvWMO2KmJya58rTe/5tn0uw9qn8OeN6AY1Bam6A=;
        b=KXFvz1uhUMlMBnaI5YE6tsG0JA66YPgTYcOf6qLxjjXNpZMFl3DgTKK3PvGyrwu+2n
         S3ZRi6Bw7mCj91EzCeay1uRVbE0xaJ9Ji0Do4X1k7335dgu7auhV3EpylW7cIq/fleuU
         jB5bb/iJ38lQVCAq5QMzjsV+Ey5PehVVf2+a9WrOFHxs+JeeE44bKRP1SfJQwUFWv24a
         7GrnBVdXdC6QbL4pMVKVhg6626xmgWXhYTr1lSMWJIv0C/53XeeuPqtAz5Q5zp8F5saN
         Vrwq4HIOvBeT4J4bYYYgBv+f24fm478KU2pDMlBLzKij8P2KK2u7YaIYFAGMAxzznSK/
         qSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708738; x=1750313538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8SVDvWMO2KmJya58rTe/5tn0uw9qn8OeN6AY1Bam6A=;
        b=XNM2ufprh8cSFlOUJQTGG/TI3Jt0TzgUg+oyD3WEQOOJ13WCWSLzVsCNBjtrm6rh9b
         TDM/qlhNHbHNhsUoLOF2IjtS7Lem+sTKAqhfbHh+J2z+vrrdb4FPbrOFDz5VzH39Y2OD
         4AtgxkzRQdamZ6gaICSUmmnyWFka1lays86jfCGDJWY+o1fwJB3etZSZHcYCw3smbUMO
         V0x7/edRjBbzEVnE0PY2GXaB30E66KMA6jI2pYAtJBQ/m8Qr4CYxVTvmMFqSDlztb2xd
         E/97JV8F11nmjq3cRUBC+rOkkEnNnMpHnlhkXDU7LbzvIDB/q515q5L+PCvnmQBja8fL
         EDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFYvGf9aTv+7UNTgD6iuXsBSdqJHb5zAI+Hnnu+VKXVhU7B6DEmZbgg1ID5tnwicn+O0Cq6kSwBuwC4Q==@vger.kernel.org, AJvYcCVbQJueKE0tbcwku8t1zk5QOS3g/S1/351HJ5XUaDvp9PrhJS8ffyTtjlUf3HgA0OcGD9gfC6c9OTFI32rSukA1E/bn@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpqlfgZkSa+d5gfd3GxBvwv0rwJDKBFTD15nhxA1/wFEhc3QZ
	/Cprf+QlXTu+owd6G1nqJXluIF4Np85drxFCmmd9bsnJtbu1Mss7c694
X-Gm-Gg: ASbGncv8kkZeo3J7MP95BcfHkGe4lFTIjNkT/s+9ztPPHvZ6n63YCBlceTvfdI59Tbl
	naq3xeiJ3LZlZgLddchmn2ReaC4IjNSsSYD99SIzcJxCtQZ5B4wOEc98qda457tB5WSQcEn104G
	yzB2KwAc8YFh3xp1j9NX260KSjvLCEsu5o7rx4nZdOtZKuAFbot9AhivT4T318QEgZsvlk4jW3f
	XzxGgKGRpbHx15jcCRFLxT/4VR39aR+aKOpWeOfqicrr4laT85CPULDRB6fiq6RVCeR7pOnqaR2
	hyn98MdzzBOKaXdCji7ABCT91d5tZ5UqYEZ/AvmkLzw4lOTBem9MpySSwmhhBilH8pfzFb7U2Ui
	N66b7bdDPhyv3q47hok+GXx09
X-Google-Smtp-Source: AGHT+IEdA/XaGXVJ1TggGwRhVXhGhTQvFoZsmFrIJGc8b+YF6Bcjc/vW/PMdiDFJx/cIotl6KA7eaw==
X-Received: by 2002:a05:6a21:998f:b0:21f:86f1:e2dd with SMTP id adf61e73a8af0-21f977b5827mr3426388637.11.1749708737615;
        Wed, 11 Jun 2025 23:12:17 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087a7e8sm631486b3a.25.2025.06.11.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:12:17 -0700 (PDT)
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
Subject: [PATCH v5 3/5] relayfs: introduce getting relayfs statistics function
Date: Thu, 12 Jun 2025 14:11:59 +0800
Message-Id: <20250612061201.34272-4-kerneljasonxing@gmail.com>
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

In this version, only support getting the counter for buffer full and
implement the framework of how it works.

Users can pass certain flag to fetch what field/statistics they expect
to know. Each time it only returns one result. So do not pass multiple
flags.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h |  7 +++++++
 kernel/relay.c        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index cd77eb285a48..5310967f9d74 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -31,6 +31,12 @@
 /*
  * Relay buffer statistics
  */
+enum {
+	RELAY_STATS_BUF_FULL = (1 << 0),
+
+	RELAY_STATS_LAST = RELAY_STATS_BUF_FULL,
+};
+
 struct rchan_buf_stats
 {
 	unsigned int full_count;	/* counter for buffer full */
@@ -167,6 +173,7 @@ struct rchan *relay_open(const char *base_filename,
 			 void *private_data);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
+size_t relay_stats(struct rchan *chan, int flags);
 extern void relay_subbufs_consumed(struct rchan *chan,
 				   unsigned int cpu,
 				   size_t consumed);
diff --git a/kernel/relay.c b/kernel/relay.c
index eb3f630f3896..fd70d0e03216 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -701,6 +701,36 @@ void relay_flush(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_flush);
 
+/**
+ *	relay_stats - get channel buffer statistics
+ *	@chan: the channel
+ *	@flags: select particular information to get
+ *
+ *	Returns the count of certain field that caller specifies.
+ */
+size_t relay_stats(struct rchan *chan, int flags)
+{
+	unsigned int i, count = 0;
+	struct rchan_buf *rbuf;
+
+	if (!chan || flags > RELAY_STATS_LAST)
+		return 0;
+
+	if (chan->is_global) {
+		rbuf = *per_cpu_ptr(chan->buf, 0);
+		if (flags & RELAY_STATS_BUF_FULL)
+			count = rbuf->stats.full_count;
+	} else {
+		for_each_online_cpu(i) {
+			rbuf = *per_cpu_ptr(chan->buf, i);
+			if (rbuf && flags & RELAY_STATS_BUF_FULL)
+				count += rbuf->stats.full_count;
+		}
+	}
+
+	return count;
+}
+
 /**
  *	relay_file_open - open file op for relay files
  *	@inode: the inode
-- 
2.43.5

