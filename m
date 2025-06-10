Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D21A238D;
	Tue, 10 Jun 2025 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516541; cv=none; b=rl87RcWmMyqHFFxwn4DxMGV7Ubxobgq6yiPIujgzMQSj+OcJT6ooBVfYYuXwcEZ+wV1tVVwjfSJgvqYkTUBnUDIqFZ1nq/23rAazMdY6hU7xLY+qX81rOFlDIUXBsJeKo5+s0IeriTH7HHig/ONhY7r44gXRL+3rQB6tGfXfROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516541; c=relaxed/simple;
	bh=lLuZJy5LmIhw6vczV+BjTVeE1qeR4Bfzo8mKouv0f/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUrFtKFukWTgHpUlO/hhaiU1CL3UmsuIaRYsvSEFxx/H0oTzfxhkkg00xFjXKK0bgzwl7NRc+a5gpX0RvmZi9JF2/ppgxCUguvUC1mqEHfk8aFd39IgePBLxjPbjfE6tQMBQQqE/HK9t9FxV+Oo1IHA3ppOFD8mGrxyUXpSwMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9gwK1Qh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9gwK1Qh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2349f096605so58078635ad.3;
        Mon, 09 Jun 2025 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516539; x=1750121339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8SVDvWMO2KmJya58rTe/5tn0uw9qn8OeN6AY1Bam6A=;
        b=i9gwK1QhKvNoD9Na18lAe55FmYFSMooBkL63aucPTAFfCKJt2kPOXHzYtDEy0xEBlO
         Dkbr3fxnLZ32vJ5qWg2rLHSdo6JgoAj9jDdUlYbHzr+gNqczdiUtYZ1wdhBNlmLmpf5m
         klMUDMZlnNg4v/06/ZBWidE50JXIF03wuMlOMCctsMgilx/nbT06RPqwMBsU5i+rDdam
         pwnjmC5WgwbDYimYdxzKY0+UYTktfL8cGl8mEDJ2hnbtgbtF73orlmnpK2F5ZgzoGVN9
         Ey2Z9hbaUNPMQa6JxA0iBLs8/hfYa9K3sorzkilyOxH8C3u0l2hHTzMIbPbIwmtkqb8Z
         eHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516539; x=1750121339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8SVDvWMO2KmJya58rTe/5tn0uw9qn8OeN6AY1Bam6A=;
        b=FbPGBXcHi9ekZBQvxUdJMmG2SXTFLsGHP6BUe2Fc1yjErosHJObluZ7fGXrDUVumMi
         WWeKZmvual0i+2xyhO8zKyoRUtGpcVN885jGLXhJUWpoJFfMcz5L2vwLpl7sVU89M+g/
         s04UjT90bpxvCC6QMz/8gBlgQSJlu8lssMphxZ6pSgO+CKT916X7pQbM7obBovhLONy4
         OL97FetwvV1XVGDRlFzZnwEL1NR4rDRVmVoZ5oFdqQb/ipv90DZJSKUbXytjrA/Iv1pW
         S8FQPLlh2+h0fYRcUNBfFIHUzsgwToqu5URxh3iUcbDu5sUrKrTwjNK1WH1syWAr90hu
         267g==
X-Forwarded-Encrypted: i=1; AJvYcCUbgwS4nwxbhTAz9cjC6f3i7f5MpQLpM+pDB4F+mcZmTnEGU92Vtp2N/6AgpUfIauM7cCut9ZGOLMnA9UoGw8pBZU0w@vger.kernel.org, AJvYcCWxf9drbTwsFhxDVymP3Mr+S/RfS+sbZ6i1rXsD91m6tf60bDnIdcbMInB4FLpXTlKmc34YHAmvy/jfTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lPQqvzkIcivGyBRlkdW5ThRc2Wf7KpKjkUbDsftPcsJnc6ny
	/Mp14C7KQqBTVnrcwXnYqepweNfYKWtNkBU2qtI8hC52+dCRdaKW3nC3
X-Gm-Gg: ASbGncv+jO6XPwg4ZehvJO22M9Ydhggu7j6NfNrmUFOJ5jJKx0IJpDrF2VFYf4Ofz5U
	VNF31+63lqadqOrQDz6FevDKlDhGpanT0RgnynrPTauwf2gHStmiJCvODvbrPaosrTXMQGUYVKY
	bB5iN1jXmwCBGKNSLPAd5tRXPO++JiLeAmOFJllOz72NPjYnRxmcIj1wLzAkhQm4hbiZ4qMMn3d
	XYloM38aAx7cvkcUneIxOsG4K5wn07Z6hZl0h/D6HRfyYXHtd0gDtaHtt26xlXkpCnycB0CQlRg
	9A79Am/4RUtrKaISjwxFnh4lCIHvHfKPGU+lR+iUYw4w088dzoxJRxSgI4TMPi1bDdguiHWDWKL
	upFJbAeh+KqwAXjL6gq6UGcMXPE6RS2PM3w==
X-Google-Smtp-Source: AGHT+IHbZt8udGE0xv+/8ewbIApjkPoddT1BX0UcOwzQArXV7NE9hqbFiFjNI44py8pBjWJPn7V8Vw==
X-Received: by 2002:a17:903:22c7:b0:234:b123:b4ff with SMTP id d9443c01a7336-23601d08686mr202935695ad.21.1749516538976;
        Mon, 09 Jun 2025 17:48:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:48:58 -0700 (PDT)
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
Subject: [PATCH v4 3/5] relayfs: introduce getting relayfs statistics function
Date: Tue, 10 Jun 2025 08:48:42 +0800
Message-Id: <20250610004844.66688-4-kerneljasonxing@gmail.com>
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

