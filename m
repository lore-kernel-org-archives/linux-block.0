Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A2296D2C;
	Thu, 15 May 2025 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289871; cv=none; b=gGPQFkErtHAM/T5iexikeGa1xZ6A46AcTp4uXMCCzBZcOQ4rnx6oQgitaNY1KWIOpvkuqy5Qh30CwC6xcjLV77EHrreCk8fMMln19Zw5eKCnfvRNhYVOq+Cve5H68Nv6sCzM0L/oqJBQDk4hybV5ZSbZOTuV2b9Pt9YmXflJgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289871; c=relaxed/simple;
	bh=fVF9tvOdNAOtftGYvxEHtczJ/w0zOqQgnfU5XoHjCI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lx37IlywlrWJoTHJWljM7TRh+HcU3bqFpNUZ/H7wolTCS6+3342A73CMAliGA9X0WP9khnhxIxRA8TKAjnUvYU1lLe7vF80Rz9+sPa5FCaGVwtE1lTaDdBwGfX32melq7Y5Jjv5mb7KjlzjFKBm3l4Rn7yfZdeuCxFkj8P37xEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HigwBVGU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HigwBVGU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7411f65811cso600322b3a.1;
        Wed, 14 May 2025 23:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289869; x=1747894669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLUwmrh9kENQ9zhqlOgVZneNrJCj/YtnVsR+1L0ZYAY=;
        b=HigwBVGUCTS2yvZ5C0fpi3psU6IxpQzEV8wbE/2sOEsccliKR2f8TQEpx6H1ElHAkd
         iflyUFikh3K7JfdKWa6x8JZCYyDRT0+QiHeuw5pgmEIi1vQ3nDzr2Ywv7w3pBoiA/rfJ
         J2geCl6Xz64meU1WGjngh0TEGQOW/i3NrgFy0HIbdWiVlhdKNlEDtM2aWZ5LLNHaWcYg
         FVZL9M6xOHmFpaTG8rbhqo19c2aQ2KFyqm4ds/3daJILHqoj/xi/Em3gNDRlM0ycG2vJ
         hYMuEDBQPdmitASp69hvLcNatgeL+t/0zXsKA2+BsRseIj7GiBTFXla3CGwNHPbZUFh3
         ifKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289869; x=1747894669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLUwmrh9kENQ9zhqlOgVZneNrJCj/YtnVsR+1L0ZYAY=;
        b=LJB+pLH9Fw9qomzyUGlUNWw1Kh9qH5YDh99N7Ob1pZCo3zvUtf22UOiuFtr34xlbAm
         JNhFaXd5nJqtfIYT1K09BPL+BRi+C+qWtBUdmUhpvFH5TilpusJx0DYwx3negMPw/mnO
         I8hz27+tVAsjgIVrHO/y7XzDRsGdD/LykrYZZ6bChCBTIBFbDb5Qj4lB5XsJFZ1RkK20
         f3LySzLCpSiX9X9qll613mxydoJ5xQzF1Nv26v50qvjtc1XouX17QSrxlJLayac8zyOZ
         E5oqPDSY+XEuJv0Xzr47Kv+wkwP04fe7PtxF1J8RL+eYyQe1xChD3J4TPpEOCcQNHMwB
         A0dA==
X-Forwarded-Encrypted: i=1; AJvYcCWMaQp1SsTqFm9RhO6dYHLmcT8A32ZwpZ45iTEe1GE09Fgp+aJXNR9G54jbysuiB4VWtUviHjG8x8RB4w==@vger.kernel.org, AJvYcCWkpr7DtmUgo0OJSbKjCoqSMuVdFjq7hv5v9TH4EvItInQjRNm8r0Wtn8zK9nruYYoiZLwSxTREYAE2RZtnPnDGAXVj@vger.kernel.org
X-Gm-Message-State: AOJu0YwWp0hPSBfpgZSSju4KGDK/fYfWwFwIw+GCxZd0zZr083cpbBWa
	t4iRIVBJSpz72usgaQlEw4AsAT9GPPbwAEIBzLpzvVl6L/6qByJy
X-Gm-Gg: ASbGncvYwcRYoSzErzBhOEEWmeguzVyDzMpIsXDzTf1NQfkxBR8UsbRvzJymx0GX5T2
	BBZYpR4r7ZlUcfQVO08Cg7G0ec/ZYKQzOE3sYW/SG04f12WVDrwRpxUY/4NZ1XUJbOIeGgkS+DM
	tZy8kLRej+9HOEG0ypnceYsK+iWe2Evl252hnFe3eS5Bcdijid1TPhcWLV/LQJaU4Prx88HzaK7
	gRV4IWdm0qQehFeoIdAQAuLW2AcJc12jz97cMwHUa/orqdx0qdzSqI1UKKsYhIJIAmPAjpU2T8O
	2QhR77BZoauBZyZVqwTsSi8V3x6K4ZNtViFN+wIUGEXs9XBnoF2aCFhoZxmOb4NF690sXPgm0Th
	yARXPXUuwBBIB6Xipt00l3WQ=
X-Google-Smtp-Source: AGHT+IGotq1woTGuzHASAbYOqJ7eI1JTvqlZIx9xW8hyq6CJIY1BrZyOlwm2ZX9hltb8cQgNv76j2g==
X-Received: by 2002:a17:903:40c5:b0:229:1619:ab58 with SMTP id d9443c01a7336-231b601cc7dmr20234415ad.43.1747289868684;
        Wed, 14 May 2025 23:17:48 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8273d93sm109242375ad.150.2025.05.14.23.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:17:48 -0700 (PDT)
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
Subject: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics function
Date: Thu, 15 May 2025 14:16:41 +0800
Message-Id: <20250515061643.31472-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250515061643.31472-1-kerneljasonxing@gmail.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this version, only support dumping the counter for buffer full and
implement the framework of how it works.

Users can pass certain flag to fetch what field/statistics they expect
to know. Each time it only returns one result. So do not pass multiple
flags.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
1. refactor relay_dump() and make it only return a pure size_t result
of the value that users specifies.
2. revise the commit log.
---
 include/linux/relay.h |  7 +++++++
 kernel/relay.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index ce7a1b396872..3fb285716e34 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -31,6 +31,12 @@
 /*
  * Relay buffer statistics dump
  */
+enum {
+	RELAY_DUMP_BUF_FULL = (1 << 0),
+
+	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
+};
+
 struct rchan_buf_stats
 {
 	unsigned int full_count;	/* counter for buffer full */
@@ -167,6 +173,7 @@ struct rchan *relay_open(const char *base_filename,
 			 void *private_data);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
+extern size_t relay_dump(struct rchan *chan, int flags);
 extern void relay_subbufs_consumed(struct rchan *chan,
 				   unsigned int cpu,
 				   size_t consumed);
diff --git a/kernel/relay.c b/kernel/relay.c
index eb3f630f3896..f47fc750e559 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -701,6 +701,37 @@ void relay_flush(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_flush);
 
+/**
+ *	relay_dump - dump channel buffer statistics
+ *	@chan: the channel
+ *	@flags: select particular information to dump
+ *
+ *	Returns the count of certain field that caller specifies.
+ */
+size_t relay_dump(struct rchan *chan, int flags)
+{
+	unsigned int i, count = 0;
+	struct rchan_buf *rbuf;
+
+	if (!chan || flags > RELAY_DUMP_LAST)
+		return 0;
+
+	if (chan->is_global) {
+		rbuf = *per_cpu_ptr(chan->buf, 0);
+		if (flags & RELAY_DUMP_BUF_FULL)
+			count = rbuf->stats.full_count;
+	} else {
+		for_each_online_cpu(i) {
+			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
+				if (flags & RELAY_DUMP_BUF_FULL)
+					count += rbuf->stats.full_count;
+		}
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(relay_dump);
+
 /**
  *	relay_file_open - open file op for relay files
  *	@inode: the inode
-- 
2.43.5

