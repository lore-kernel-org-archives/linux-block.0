Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF924A06C;
	Mon, 12 May 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018190; cv=none; b=j34/BA5e8Y3as1xgj5Z68EkJAlZPVtaMPaok8kdsuVTTPkLf+Gm5fAUOPCp5+/mrNoKJOp9zQrhMw2OQwuBfkoAsnKJ+lmbNfUzqyR5AyKnMilVditCVhXT8p1Zh0fm7vjq0WxwX514OWR1OQ9P7QTsKcW5vvWNuNLIKs4iRG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018190; c=relaxed/simple;
	bh=fA6uYb+HYMswsWxeRu8N7UkfiZFXVi5+QE26hPaat58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Msqa7aLz+CyPAGs8/b5G4ghjq0kEOtIQRX+6JEnuXfTicBd8xHDg4MrdBRfcHIQqSyYX22VG4fe5iBePySPWdoUTFptijQv3AG8grnPV/Ik+yWf0xdQeoxvt1iUSMt82mBrb1x9c7CxOQfkl0R1mzFMR74gRuJsmtpxpTpgoVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOcmQFaT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOcmQFaT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30ac268a8e0so3715411a91.0;
        Sun, 11 May 2025 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018188; x=1747622988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdC7+50ea9TIOTR9LDnaVPHr54N1c7Zvh2HZXjranp0=;
        b=JOcmQFaT8AjWg2Okq4lpaPkjm9H2UIcBrPlYHPT2DeRL8i5YMGgGOMmg5UxTvQSssT
         dqeRWrqbdT9xzPw/dicpQZwSAjafILZ8J44kHRq7nEJT/srxl9DcIeL9kQ7TexyGEkIx
         2DEckOy3vJAw4ubk+kmweBytoxdl65MHhFVc/8x7uY+L/eIHlm/XAjTpqYA7jlxDgh5I
         47D8Q1tTZr7n7SjAUkN8tkeW5xFxaMcBOs+a5dTzU+VOGAbN85bcwovC2gUpg2wVOzlm
         NpiyhrekR2bf/7RvyzRSYho82Lklet0KQ7+JnjBt/IJjHTJ9fVAv0ro8KyzNRPneDA4z
         heqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018188; x=1747622988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdC7+50ea9TIOTR9LDnaVPHr54N1c7Zvh2HZXjranp0=;
        b=oM/vCQjmhlAA12NvB+YARmKL0lZIL7Ag2dM3DLIzYVLW3uOIJG9veDOiIXa8q1iHc8
         bMrfB79rw10I7471CBf0Ywvkuf6rBjE2rdvCojx3eXLg/Q5YydtdgwBjiXNqQ/yVW+W9
         k9bOWRSRnMNXP4VErIN3JqECEZsf4RPKY/R7Vi+xC2GKJzwRyJPtNycxRRXk0zjiJDWl
         Y18F6blffA29qkyi9wgb+4xyJmRO3ylCSu4wQCCDkBj4//HPmgcQ/QzkgLrtgh1qaDO/
         /JgdMLyb/hUl8sG8FxAm2vZeaX8s7/fbz5hWhv4GICtP2Nplsh1YkhwY2Dd1dtJXNtd1
         rrcw==
X-Forwarded-Encrypted: i=1; AJvYcCUY/+v3e5m+NE2NMgwMkZoCrLrHUD/YuHW0lvIiKZCwmDK+48+XznBT+ib7KbU/LsfutqreoCZN/l+IDA==@vger.kernel.org, AJvYcCWh9i93CARbjzRVztl7SHvkiRbiVbzWaiPKCeKCmlfpvccb5PYr5AGo8eaBgxaIicgPIlSEzxDSt8eImx8A5DxUC3Rm@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbnOGxeJvEPdfI48+9prsurYSv1ZVyhi5PAMSz+MYhwZxLn3M
	jJVgOleclRcvJk2tQvJrgmw5b7UOTH8/wr/SbrOa5I6YMYZi7D+7
X-Gm-Gg: ASbGncvetXEUIAszPta5bCdzn1l1D18r+QPlJSRsne6FZ18ppGxzwVm6sDnKRY5hm8C
	GyCLACtRqUp9pY1/POD4pEYjlc9Axfj3h2LwF9xH+R+CqRGZJs9yTEUbINocKsn9GT/VaM/KOv/
	KlfaJzr+X2JokhfubLheytWiQ7DBQ/1/KG1djEQxJoKERHm4mrfU2zjKivszvHJpQ69wmctuj5G
	wc9s5bjhw6eHiRsJKv2eOJezFgzoCvoU6f++sJ1F5H3f3W5VWTf97nsP2f3Mc8OPW6T4Lrni67O
	px+DJmWcSOeJ7GQXVyIjrI88M8tbwvzxdsuNDH6AX11BLe73NB26Ow6IiTSFpFEJ+NruQPZQ4B8
	1OiyQFAC5M+0qkJPRP5HYbSw=
X-Google-Smtp-Source: AGHT+IEuCbE/fWTwMzhtQWYiP9Xt6EE1kBOowFD1v8jevbAVJQTUuOfx3NVHBGeE0t+E+flU9XvkTg==
X-Received: by 2002:a17:90b:3805:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-30c3fc08554mr15488424a91.9.1747018188092;
        Sun, 11 May 2025 19:49:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:47 -0700 (PDT)
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
Subject: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
Date: Mon, 12 May 2025 10:49:32 +0800
Message-Id: <20250512024935.64704-3-kerneljasonxing@gmail.com>
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

In this version, only support dumping the counter for buffer full and
implement the framework of how it works. Users MUST pass a valid @buf
with a valid @len that is required to be larger than RELAY_DUMP_BUF_MAX_LEN
to acquire which information indicated by @flags to dump.

RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
choose to dump all the values.

Users can use this buffer to do whatever they expect in their own kernel
module, say, print to console/dmesg or write them into the relay buffer.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h | 10 ++++++++++
 kernel/relay.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 022cf11e5a92..7a442c4cbead 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -31,6 +31,15 @@
 /*
  * Relay buffer error statistics dump
  */
+enum {
+	RELAY_DUMP_BUF_FULL = (1 << 0),
+
+	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
+	RELAY_DUMP_MASK = (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
+};
+
+#define RELAY_DUMP_BUF_MAX_LEN 32
+
 struct rchan_buf_error_stats
 {
 	unsigned int full;		/* counter for buffer full */
@@ -170,6 +179,7 @@ extern int relay_late_setup_files(struct rchan *chan,
 				  struct dentry *parent);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
+extern void relay_dump(struct rchan *chan, char *buf, int len, int flags);
 extern void relay_subbufs_consumed(struct rchan *chan,
 				   unsigned int cpu,
 				   size_t consumed);
diff --git a/kernel/relay.c b/kernel/relay.c
index b5db4aa60da1..0e675a77285c 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -810,6 +810,41 @@ void relay_flush(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_flush);
 
+/**
+ *	relay_dump - dump statistics of the specified channel buffer
+ *	@chan: the channel
+ *	@buf: buf to store statistics
+ *	@len: len of buf to check
+ *	@flags: select particular information to dump
+ */
+void relay_dump(struct rchan *chan, char *buf, int len, int flags)
+{
+	unsigned int i, full_counter = 0;
+	struct rchan_buf *rbuf;
+	int offset = 0;
+
+	if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
+		return;
+
+	if (len < RELAY_DUMP_BUF_MAX_LEN)
+		return;
+
+	if (chan->is_global) {
+		rbuf = *per_cpu_ptr(chan->buf, 0);
+		full_counter = rbuf->stats.full;
+	} else {
+		for_each_possible_cpu(i) {
+			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
+				full_counter += rbuf->stats.full;
+	}
+
+	if (flags & RELAY_DUMP_BUF_FULL)
+		offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);
+
+	snprintf(buf + offset, 1, "\n");
+}
+EXPORT_SYMBOL_GPL(relay_dump);
+
 /**
  *	relay_file_open - open file op for relay files
  *	@inode: the inode
-- 
2.43.5

