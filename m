Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7446C4D2
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788377; cv=none; b=DnTe6+nwKrbW+G+SWSRTGAj/PIF3wjH/ewX4puAOTAmoGR/bMGmHFk/au7rQxpvCmCef3WpXrsQEchsMBWMCTsVmTQaAcHqrflyFKD0i1YLlUPL4GMn5PBkw1BbG3iDmhatG38UFb7L2rUedgyKxNUUZJMeS2OqC6Z1UJ5S5jEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788377; c=relaxed/simple;
	bh=//7eSrSROQ1S6s3fnZBiYbUSuvFg2wwvGxVMRZPYtGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiVQXi2w0VQS6hhiAKTiJIgFBwHxNDt93XLgpPXIEawProDgE+2IDrb+mHmRRjqZ8MJNBTRReLhagm6+KGP5zR/ORyJYR66ZmsmPBR0CbxkeZisSYe/YW+KtcTXfCE0qCD5GDgQ9gOPAKUrD7BaLGhOTc4NU4a3k4LaVQlVhP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PKCeVc8F; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PKCeVc8F"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c255a6e63c0so41611366b.3
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788788373; x=1789393173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdM378QxLre0SWIJr0HaM8kMGhNtJLC5f+4nD7MVyXk=;
        b=PKCeVc8FKvA1tykp9xrVr0zTPnxeaGxjYXaj4gAMTCOfKuw0U0QuBqzwhlJ8Hmc38/
         iHnwZS686jA/5Z13DXcLjgJF6XKWodFzJTv0+vCgoNQdsu4+06fhz/Y9c9OB9naF81p3
         cMax+s0eTDoRQ5EPOLzKwkMQtp2+L8IlsRb71Qzf7WR+0RrdMXZ7aJ5ryl8cJreINcEh
         tr0G7pxarE7qBVZhqdkx2MtzWPjLxaoLgl1eIb5Laes0lS/JgVMhhHrEEJVaHUVIvSqr
         uIBAj7FeWAfvfpz9SiRiAfIa66sndW7xMSO5gkg4XurCgNyAE0+u/raejWGtvo/9yUMT
         aRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788373; x=1789393173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdM378QxLre0SWIJr0HaM8kMGhNtJLC5f+4nD7MVyXk=;
        b=UU3fKkIchcKKAc6vuwfVyrmuygA1QP9snGZal9ctGjBeOKM/0owbF4ZlDcCNel+OR+
         /tX1AZfdBTTBTLHuxTm+mipTTrfO/Vqt3VPr81hOMeRrApQv/SlkXU8g1VLmPrGUZJCG
         AmsI0b8YXAKVCqdNuuLdTsvEEUrZW5qf9Ak4UkYWE25f0iAbxPoAXy2D4zc0P3zwgVxr
         fuBI4A++I9oaJHy4xKA/yeXc/TRcAS74+5phoYcwkcwDJNDao8Gt5nrcgVn46xpui3Nr
         YQ8AHwQS1qrqPIWsKv4cEQBubQOB8itbMnmNMWj0NyUk5AgEWWnhCn9N5woEU2E+llP1
         rQyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQ4g5jKevDFw+TvbBL6Tfy0ePqnouKFUf6k2bJEcq2e4QZf+kGWUJ9G74/5hHDyuh1xenXraK086mgYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kGLYDoAx3H0RgCcHSVkWrZOirqwMi0US6/ezlhKM1XmpbQCt15
	jw2S0v0dLXk7FyKDygVRKmtRhRv7ezxMeE7f8Lnq9n5TvEC+Q71XQnf84T2QhaQAXSg=
X-Gm-Gg: AYBFou2iYeaQH9eQvZTxIZnCHOaLDssiW0N4n8sP8MBQlCxLwpKaD82iuhbsjeFDExW
	Kh1Z5UzxZWcaSiUQTX0Yf5FPqz11yBqDYMOddf52DvCndzqpTwu3yYgnjdxIXTPXezWr/4VnfBC
	yCb01WVE06Jc/Upkvgrf7NCMhhZkDaKbTwAAmpjr+mKimK0nSycUTmjlu/FqUbdcddACaTe6xrX
	2/MnSeAbj70vHd+M/3GpQ7lP/F/gLkqb3b09cKIFlQGcW1s9doKgTIQtxcHMeEVKlhGbnj37LhM
	EQtfYnaB0iPt5raeRdRlvF5C8+X77ciNJ2wjOte3XVn9jSBrpIjsuqilY/Lyd6QBimMCekvVjTf
	Kvvs4EiLiRxvB5rryvh2Xaitk30rYWEIEHrib7ClJIVtq/afezg4bzVhMom4p+wNXkPyy7yqluP
	/KkRjApgRq3WSBjdXvkLjUJ7vPrmCFoR+janzzANmMM6t6SdCDISwed/NJFomxD0kUAFYZVebqW
	qE1dPPGOxiMLLHQ0bW0GlT89HtAdLwA17A=
X-Received: by 2002:a17:907:7209:b0:c16:604a:b2bd with SMTP id a640c23a62f3a-c261277db4fmr745784866b.3.1788788372780;
        Mon, 07 Sep 2026 06:39:32 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262c770678sm314301866b.53.2026.09.07.06.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:39:32 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: Nilay Shroff <nilay@linux.ibm.com>,
	abd.masalkhi@gmail.com
Cc: linux-raid <linux-raid@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	tom.leiming@gmail.com,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 1/6] block: add queue_limits_start_update_trylock()
Date: Mon,  7 Sep 2026 15:39:24 +0200
Message-ID: <20260907133929.1081540-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907133929.1081540-1-jinpu.wang@ionos.com>
References: <20260907133929.1081540-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Some callers must not wait for q->limits_lock, because they hold
something the current holder waits for.  md is one: its
check_sb_changes() runs with reconfig_mutex held, while a
queue_attr_store() holding limits_lock waits in blk_mq_freeze_queue()
for I/O that can be waiting for a superblock update needing that mutex.

Add a trylock variant of queue_limits_start_update() for them.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 include/linux/blkdev.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..b75e85291e29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1101,6 +1101,32 @@ queue_limits_start_update(struct request_queue *q)
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
+
+/**
+ * queue_limits_start_update_trylock - try to start an atomic update of queue
+ *	limits
+ * @q:		queue to update
+ * @lim:	returns a snapshot of the current limits on success
+ *
+ * Like queue_limits_start_update(), but fails instead of waiting when another
+ * update is in flight.  For callers that must not block on q->limits_lock
+ * because they hold something its current owner is waiting for.
+ *
+ * Context: process context.
+ */
+static inline bool
+queue_limits_start_update_trylock(struct request_queue *q,
+				  struct queue_limits *lim)
+	__cond_acquires(true, &q->limits_lock)
+{
+	if (!mutex_trylock(&q->limits_lock))
+		return false;
+
+	*lim = q->limits;
+
+	return true;
+}
+
 int queue_limits_commit_update_frozen(struct request_queue *q,
 		struct queue_limits *lim) __releases(&q->limits_lock);
 int queue_limits_commit_update(struct request_queue *q,
-- 
2.43.0

