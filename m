Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFE24E01D;
	Mon, 12 May 2025 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018196; cv=none; b=b4Re2t6J0JmmgNc5CdcrvvHTd8tn69xLYeovE4j/Y1h5bRUGpqcWBOeUnd0GZKwJZbzRIKASU970rft+lbb6c+anLFQZeyYkIOTSX00sBv/jnRDxVbmk9E9NUDGwuu7Sbf2sbNWIDh8UWoi+VZm6R3FnQBPYcQG4vvc4/Hll4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018196; c=relaxed/simple;
	bh=O1EXH+l1ID26lSZ86I0mvDbHzUMWrsHZJtxcXeDMpqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1mnrsJ5VZdKGqYHOrGRkr/0nv0lYVwt7NszogDz9icGo1Oc0MpHaig2u8+DsB0uVR9Ok6e25N63mfT9As5GlG16Qw/pO7LWYU1ty6B+Mk2hcPfRxATn1I+cT/iYnpZFpEF9kIzAOK5vhNlM+7wlcieg3AX5ftvnRm7dvIu0fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZyDICHj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZyDICHj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30c47918d84so2375773a91.3;
        Sun, 11 May 2025 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018194; x=1747622994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS6PUiD9waxM/dvO4DQO9mPdxsKh+3Ov1Y+KBYunw0A=;
        b=BZyDICHjo6OdEFUkyX5ONX8uBvL55TVW+EW1v3/tUlWPnwSHXx9jhgg3zpD/CdS87y
         Mwt4k5hDhwH+r6ghdu/d+a1axgVkjJFCEbIowDJM2zlWBfgy9qirbRtaIavjg5Qi9fQe
         h1ykjJyRja5vxJfyWIK4ZbpNhbnZwKJ13rv8Pq+lZhWCWmsigSKPILOpGoasti+M0Hfe
         UvMLqaFlBVvqKDtaP7ZatdrqC0DAQhIOGPFv91CUBTyoRXU7wYvTaL5Njd3En8/fGH7s
         TCg7mepVRe+HuyxiaMwRpbbdomluhiAif6fKmphvhc1HThFqSNzCI6PdmAeJmQJ7ja8P
         avrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018194; x=1747622994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS6PUiD9waxM/dvO4DQO9mPdxsKh+3Ov1Y+KBYunw0A=;
        b=Udv8QSh5fMrMO6HGVy45DvQjAOjRId3+26WmCLOJAmbO5m1U+MkHeHL7YWOfuS7Jxh
         PhSzH99BaKZgklnL69xyeUWXOwsMHSNLJfbc3J/6dgzsZDGhXGg3prpKxjc8JW5c0Qd/
         r2PYL/kJBFkjrn72QQlsEegzLoCg1/EoS1r23am0zhqcruXTZpyFTJtzn7ny0WJN1PBs
         9RUDksIpCVwLBY1PZK0qBpihuXcWrL1DMhoPeLuFApJExWEMryoQSAHXKPzt8aJO0kjr
         3ifcovC8vH//2BVtLdphpYl8feBARAVC9RZQ1GCnEmP3q1GTUIwKpSvuEjx6e0Q/E5TG
         sYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0b4wNFwSj3mdiY6BFxG9kmuv+DCKLpFVEmDTlG5Sn6YBu9g2zrQ0og7XxWJUYq/Jg6VgPmrBm7ut5ng==@vger.kernel.org, AJvYcCXhr2BEL3FyfLH1Cm2ErBLB2cTJ9zm5uztJJAud/x9rCLuW/ilplXmGubHDhvgQOKfH51h4fz4oHWekMj5D1u+JeG8D@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TCfNi8pwXtzqjtGz5zDGg1LWmuv6FwcJDzRlJ0jLHp+nqHhr
	jnHQ66yN77NBjLPM7l5azDouk0LH2JMKpCGIxVDDCMMsKjKZYfqB
X-Gm-Gg: ASbGncvg2YVzyZpCvDowivmLCeyb2FaqeGjcfAyN6efoEosD/uRsgdbW9WXh/kEApRv
	+FLBMRQJxsVttvP67P086qJW0lCsbIaCbhi9WDDEZPME4/XUXHFTJf/pzbFk0Hl1WRbz/mzFfrP
	4F6YXn+znmrVUiVYdZp6wuhiakRNuEPWvOOho6vz7Eu9wqWxXzmJtcuSK/wYKpG7ujzzNealB/y
	pqM1KUDz2XsRAZk3iG7hqkMuAhMtJNc2FzbisMYb8rwmoadlwuh3WUaU+paGUvzxiCBycHrn/6p
	5xv6PvQlcJw/If2zfz/RLf5lIOJon85AjFxizb0jHWlRlUDJps/AIqGKD3vECOT7e8ywmlkGZnS
	q3iCSmSluLHYNbptsr4ym55U=
X-Google-Smtp-Source: AGHT+IGA0zyFbcpHHaKTnaWWOHklp6y67rFn7VGo74DPABBPXABJMpelZJxIekOVWdWin2jO2bcjgA==
X-Received: by 2002:a17:90b:35d0:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-30c3d65cc3cmr16994555a91.35.1747018194025;
        Sun, 11 May 2025 19:49:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:53 -0700 (PDT)
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
Subject: [PATCH v1 4/5] relayfs: support a counter tracking if data is too big to write
Date: Mon, 12 May 2025 10:49:34 +0800
Message-Id: <20250512024935.64704-5-kerneljasonxing@gmail.com>
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

It doesn't really matter to let the user/admin know what the last too
big value is. Just record how many times this case is triggered.

Also solve the issue where relay_reset() doesn't restore the value.

Store the counter in the per-cpu buffer structure instead of the global
buffer structure. It also solves the previous racy condition because
in terms of the global structure, it is likely to happen when a few of
per-cpu buffers encounter the too big data case.

Remove the printk in relay_close() since kernel module can directly call
relay_dump() as they want.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h |  5 +++--
 kernel/relay.c        | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 7a442c4cbead..0f5f6ff17824 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -33,8 +33,9 @@
  */
 enum {
 	RELAY_DUMP_BUF_FULL = (1 << 0),
+	RELAY_DUMP_WRT_BIG = (1 << 1),
 
-	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
+	RELAY_DUMP_LAST = RELAY_DUMP_WRT_BIG,
 	RELAY_DUMP_MASK = (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
 };
 
@@ -43,6 +44,7 @@ enum {
 struct rchan_buf_error_stats
 {
 	unsigned int full;		/* counter for buffer full */
+	unsigned int big;		/* counter for too big to write */
 };
 
 /*
@@ -82,7 +84,6 @@ struct rchan
 	const struct rchan_callbacks *cb; /* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
-	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
diff --git a/kernel/relay.c b/kernel/relay.c
index 0e675a77285c..27f7e701724f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -304,6 +304,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->data = buf->start;
 	buf->offset = 0;
 	buf->stats.full = 0;
+	buf->stats.big = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
@@ -712,7 +713,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 	return length;
 
 toobig:
-	buf->chan->last_toobig = length;
+	buf->stats.big++;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(relay_switch_subbuf);
@@ -772,11 +773,6 @@ void relay_close(struct rchan *chan)
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
@@ -819,7 +815,7 @@ EXPORT_SYMBOL_GPL(relay_flush);
  */
 void relay_dump(struct rchan *chan, char *buf, int len, int flags)
 {
-	unsigned int i, full_counter = 0;
+	unsigned int i, full_counter = 0, big_counter = 0;
 	struct rchan_buf *rbuf;
 	int offset = 0;
 
@@ -832,15 +828,22 @@ void relay_dump(struct rchan *chan, char *buf, int len, int flags)
 	if (chan->is_global) {
 		rbuf = *per_cpu_ptr(chan->buf, 0);
 		full_counter = rbuf->stats.full;
+		big_counter = rbuf->stats.big;
 	} else {
 		for_each_possible_cpu(i) {
-			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
+			if ((rbuf = *per_cpu_ptr(chan->buf, i))) {
 				full_counter += rbuf->stats.full;
+				big_counter += rbuf->stats.big;
+			}
+		}
 	}
 
 	if (flags & RELAY_DUMP_BUF_FULL)
 		offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);
 
+	if (flags & RELAY_DUMP_WRT_BIG)
+		offset += snprintf(buf, sizeof(unsigned int), "%u", big_counter);
+
 	snprintf(buf + offset, 1, "\n");
 }
 EXPORT_SYMBOL_GPL(relay_dump);
-- 
2.43.5

