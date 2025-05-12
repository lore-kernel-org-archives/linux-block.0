Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCB20C00B;
	Mon, 12 May 2025 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018187; cv=none; b=ls+60tT6g5l5tsqf7Q1hTKCWBQadIpmtiU4+HMq735KxNWHbsxKDEwAHtjPCkBOWl+9Il9IofNIY3jb/x5wWnx2FPXyvdB/XdPkGhhJn5Xw/Ih+IxvDjZ0I3xeKrZypKypkjHLV+v8VwEEvQHRsaLdmh8kimEKMv1dc0hXB/hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018187; c=relaxed/simple;
	bh=bGoIp65pg/jPGkK8GR9O0A+GZrnrbxBDUI1wzJAXPLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YosNcZuiNULrZWpmrieN/Ur3CNy77D0v6wylaScfeTv9CUdemBylxs+BuU8VWgHsaLY0xXFws8kOP3wcZ2L81pGxkzzXW7UZ0Bc62O7ZfjHKfWvCo3y2dCzZejHDKK+JxFTEZx8KdP61KZoZ/i8W6CVI+y/IY6S2PGZbnqG4t60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1uNq7aG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1uNq7aG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73712952e1cso3749200b3a.1;
        Sun, 11 May 2025 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018185; x=1747622985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAgDSdrNCjR7M0F+IDPRCBxlQPpiR4RIsUl7gCVqBBA=;
        b=K1uNq7aGisD1Tpwy8rZH9qpb8rnjVUMoQvcYC84dDEAThOgQbfKsIDBiZGmSt95hqY
         /x2l3c/iN8oKMKuJ4HiR84EgZHFoDmdZfQbJYln86Y6ZekPqBYfRvL6BByzXL/k1lobp
         i46eSdKT1to6p5jp5V5yZ+4Shc/R5gzG8bQYZM/3qb3iwPDTuaBqiwsAKPIRS2y2EVsc
         HBX8bf5lIf5kVUltRpyMAEgS75RSpQAtDK6nhdk2RhVRG84R0ZiRoGv05alWi02+iD/5
         9FENq++astzOooPd1E3cJ2ZeGzBMbvoeVIbTQDVwojTt/t72+9ddaW5vmje4dFqJeX0g
         KM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018185; x=1747622985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAgDSdrNCjR7M0F+IDPRCBxlQPpiR4RIsUl7gCVqBBA=;
        b=I4rPj3UXna475IBJulMPPv+sqbU1mVEgs6AsrR0XhR+/62ayLgE7QL5iFisreKxUyD
         T4yA9/mcNlRAqdAcWeXdCzCYxGyKFllewnhNeajglemT21xGX1heTlFwVaAPPnnq/9Kl
         qPJjQMARMckKXnqMhk9Ootuqr/wk4NFD7ENQlzT4QTjUsufdtndTVW+kr5JidQ3PQhHv
         0uc30P4DUypPUmhHtDe5b/hoSeq5h8c07xDoWOvhhvsfF9ulz2pN56Vn7NKSTJNFW7Nm
         famHtJH8utzU2vojwBrVrGKQPn8PCXHNEClWMuYdK91tnGB6G+5UObb4kSNCrERBIaFe
         mXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGk0W0X5fsKnIdpjH0OQ6W2eF0JJqJkNYOpZktXJGZhmR2ZfrO9yHh+LBVpaknQvwrBTAWO8dlUmTpng==@vger.kernel.org, AJvYcCXF3hPa/LSL3jeLm4/yzqhbbGewvT6kuZTl9Phh0/6vZFPhxjR1VFGA2PqQmte6G8SrCkkz+ch1bB9FoZvkdPx/turZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqD965TNyPpoIk6pYTQPbnBU9QcoUfpdo/nmCtmo8mUsohYSa
	Eay5S8MxYE3QY9+HfSYo+YvH2kRniJiV0SNjFfNCmT4BEtBHRYiKE1DJN+lI
X-Gm-Gg: ASbGncv5jg97dzcOPKf6Qz0qC/rfQpYMu6vsqbE0SWkvrxBfTpkFlt+iV47wjOYHysU
	oQJ0Vmhgle1NrHr4PuIZEYAbfgJXpcOAV+MZA7SrvZqUim/636lygc5HJUumq3n08E+Tnm1QXbG
	n+Dgucpfj3DXh8xsoHgi23DOJ5eDrl237QaLsmjFPRNuT/Emns3WEAD7CMZdQ3S6n2ng6+0I8Kg
	TrsNIqFUrgFFuDOi/SmPxkvp3yNFgQzFHRy0E92Qd+Zz3lxEho6XRoMqmeuAVwQzMnBzZ/PmD+6
	8oFie9ZOoS/YwKqkSPloDby4X6/Thf8Zts5y8NrVpzpA5s3n1I7VLOyXsq/Ow4u8fLjRjvoUNjr
	aepk4Qm1pbXVruvDlaV8iQaM=
X-Google-Smtp-Source: AGHT+IF2pD/3WNehgQKRqb0NRE5telzzjqJbi/MWknVHnDbyv7BiB1CTonFFm41CEv+bBKH2hbbQGQ==
X-Received: by 2002:a05:6a20:7fa4:b0:1f5:8622:5ecb with SMTP id adf61e73a8af0-215abc17ab1mr19142427637.34.1747018185136;
        Sun, 11 May 2025 19:49:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:44 -0700 (PDT)
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
Subject: [PATCH v1 1/5] relayfs: support a counter tracking if per-cpu buffers is full
Date: Mon, 12 May 2025 10:49:31 +0800
Message-Id: <20250512024935.64704-2-kerneljasonxing@gmail.com>
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

Add 'full' field in per-cpu buffer structure to detect if the buffer is
full, which means: 1) relayfs doesn't intend to accept new data in
non-overwrite mode that is also by default, or 2) relayfs is going to
start over again and overwrite old unread data when kernel module has
its own subbuf_start callback to support overwrite mode. This counter
works for both overwrite and non-overwrite modes.

This counter doesn't have any explicit lock to protect from being
modified by different threads at the same time for the better
performance consideration. In terms of the atomic operation, it's not
introduced for incrementing the counter like blktrace because side
effect may arise when multiple threads access the counter simultaneously
on the machine equipped with many cpus, say, more than 200. As we can
see in relay_write() and __relay_write(), the writer at the beginning
should consider how to use the lock for the whole write process, thus
it's not necessary to add another lock to make sure the counter is
accurate.

Using 'pahole --hex -C rchan_buf vmlinux' so you can see this field just
fits into one 4-byte hole in the cacheline 2.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h | 9 +++++++++
 kernel/relay.c        | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index f80b0eb1e905..022cf11e5a92 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -28,6 +28,14 @@
  */
 #define RELAYFS_CHANNEL_VERSION		7
 
+/*
+ * Relay buffer error statistics dump
+ */
+struct rchan_buf_error_stats
+{
+	unsigned int full;		/* counter for buffer full */
+};
+
 /*
  * Per-cpu relay channel buffer
  */
@@ -43,6 +51,7 @@ struct rchan_buf
 	struct irq_work wakeup_work;	/* reader wakeup */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
+	struct rchan_buf_error_stats stats; /* error stats */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
diff --git a/kernel/relay.c b/kernel/relay.c
index 5aeb9226e238..b5db4aa60da1 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -252,8 +252,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
 static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
 			      void *prev_subbuf)
 {
+	int buf_full = relay_buf_full(buf);
+
+	if (buf_full)
+		buf->stats.full++;
+
 	if (!buf->chan->cb->subbuf_start)
-		return !relay_buf_full(buf);
+		return !buf_full;
 
 	return buf->chan->cb->subbuf_start(buf, subbuf,
 					   prev_subbuf);
@@ -298,6 +303,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->finalized = 0;
 	buf->data = buf->start;
 	buf->offset = 0;
+	buf->stats.full = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
-- 
2.43.5

