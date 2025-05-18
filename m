Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5841192B75;
	Sun, 18 May 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537068; cv=none; b=rnYW2pq52MsO/scuoxkfuSD8ZxL88DJ4mdy33/ADhahleN+T0ZBKKdviincNZr1k02cTc+qIwipTKsuohTZTI9XjF/LvtYAtNYViS2J5ZakeND3jUMTElUY1mjmSAdCQ93wsSFLUReas5EVip1KIgvGT6SmVu2jhstnCbbZJf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537068; c=relaxed/simple;
	bh=1kJ1UHNHABs1nlIFGrUtvyCHodBR/IlvUCiVSwHdxks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqG41ZTxcTkR4A+LdJl/mO0v8y8WjYY8tOP2zmbgG5a8Kt54CNe63eoJjuot5JlxzgYu3u54jgHRSUlfqOE9oW/ddCVBRZtigjyXXx+QC5hxZAMwv273pnZQlIcvgqCb5qYOKd3H/DkUvLlfvSYVFCY9ZovlpIeRADVRjTrr5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3x4nHXo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3x4nHXo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c9563fd9so85460b3a.3;
        Sat, 17 May 2025 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747537066; x=1748141866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyeqCCHKc+7itzlIu19Pbt4lRppiBFn9GmLplJ9amWo=;
        b=g3x4nHXo29orP4HTiOO/ngwLWrrnZU9/HezS3jCzh32K21JKcyrjh9a6jl3zLsM1mH
         Jyuq/gLlq0Y8947PLnpJimxcCS7avsMAfDFUzcDsixtub+rJNRhi5XI0ICBXOBnkLVuA
         1jKbFXIPc02yVRw4xglLpuP7BA/YyQTX3BRUGG5d9ovOpECAYkdCon88Kx1+Ghh5kHUh
         rTQokSBMPwqGJpswuf3yTtXFJHb4mTVNmRoUMdQy9BCulBG3EIWc+fgB9iPgtQueBeOT
         3p4/S2IN+sEUpvHol6Wv+ro1J2PYd8nncm7YYVT1wDiezn+JN2KliIYwioS9tft+0KGQ
         vdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747537066; x=1748141866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyeqCCHKc+7itzlIu19Pbt4lRppiBFn9GmLplJ9amWo=;
        b=YXbkk0dpuxvEHQzu4WSs8cc5+2ptbEvIBCSogJoozsHX7g6Ce23jd4peckIXTpMHyL
         Nmo28f6YiR8Yole/sqnljF6YaelmqLg0J61+WBKhOLF/Xg+et1rnU3ll8PsLmlIgLJxk
         7b1fITi12IC0ucn1NUMZbc23ApZIkK9Kh+3btTBaUEUADCjzL3d8SAE1sQ3yRIduXEaj
         0YdDKsbL+wDerW3aRx3qBWDUsAzjv1/NQHlqjlQrolWA6fJZH8Kr9B7sqdggKCk6vYBi
         a6MKpt1XVzwB7QvD/4bx9MIUjVLXiocKMNcg5sbI1kVOSFXTcB3n7acIUPuiXMdWPx/5
         tf1A==
X-Forwarded-Encrypted: i=1; AJvYcCUvKDtKYbBORiSp+FZ8brHhMM1hayb4fLRAM8BCThVNQVB/Ii8uKO/d2wEukh1iMemtmwd03agJAKOPLB5HRZlCrPVl@vger.kernel.org, AJvYcCVnWVcSlWdPf/ObqXFdGtYXeHWK/6QrRhn487S5j5ihBEh2k/R0GKoHr9eCDvl3xhv1i2JzuMyTg0taMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDE3SxWmIl/EvFQpqjBIkPYocPyRQ2o4LDVQKhSuTCFM7ffqK
	JsBADmUS3k+t4Qb0ilGwzymWQfh6d8CY2MqXgqyOuueCDbuQNCwHr19s
X-Gm-Gg: ASbGncsaVMTkqPYS/sg75Wk7mQl4GdmDAZluDpfN4gWikg+fZ0gZuzwlhZwiL/tZXqq
	KGEEbjZx6Jo8S+KD62oydxlJPz2KhtawA+5lwsVL+Cx8821Nsjpt17XsQEHVfmOQ9M+1Eekqaa+
	rg/buOZwqFrX6HczsCDsz7zTHvdrtE1mHS95bEX2E5alJeqwOkFrDixJm1S9fJ4LavjTwiMOL8P
	Dw5GmSzVAUDhhUmSb3IDPrGNJDJX/2KLskIC+JajEjuf2L2VR+3QO49dEM6ipMKiXIa6BRXpksz
	/NaLRRUzfyCOB/skY3I9N9swUSX2atI57VTe+4m8AqtHcIZJlkuSzZeR3ICXW8zTeVY3Gkt3/ik
	l5wAwEoCqWLFrsoIQRqvDj+I3
X-Google-Smtp-Source: AGHT+IF9Q6fCrQTG6EsQtx6ga7f2/ypu3cd1qlXLLpg5MVdOx7DYMUHvKojDT/unWuO5fXvJ/o0FwQ==
X-Received: by 2002:a05:6a00:23c8:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-742acc8da94mr10258488b3a.4.1747537066146;
        Sat, 17 May 2025 19:57:46 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm3839125b3a.77.2025.05.17.19.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 19:57:45 -0700 (PDT)
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
Subject: [PATCH v3 2/4] relayfs: introduce getting relayfs statistics function
Date: Sun, 18 May 2025 10:57:32 +0800
Message-Id: <20250518025734.61479-3-kerneljasonxing@gmail.com>
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

In this version, only support getting the counter for buffer full and
implement the framework of how it works.

Users can pass certain flag to fetch what field/statistics they expect
to know. Each time it only returns one result. So do not pass multiple
flags.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
1. rename and adjust relay_stats()
2. move rbuf init out of if statement

v2
1. refactor relay_dump() and make it only return a pure size_t result
of the value that users specifies.
2. revise the commit log.
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

