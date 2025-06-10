Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654001ACE0C;
	Tue, 10 Jun 2025 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516543; cv=none; b=o2FDYtxAUGbiOWr90WNYTeAwH0pXiZnd5p4ZYGi1Tw2ql+7TIUCLGBlj8R1i3rj4oJoM5mZIzhCVFvZavp1A+9rq0/oIRHfDHwh7LU3ZPv9x8YIh9T/kq1Z1q+sqE0opkx+e1JcRcYbfz32q1+ZXisAB4wTykV340IHPd3IS9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516543; c=relaxed/simple;
	bh=Ls8LnjItLslINrUUsz6ervmA6XQP3j3UNRh3vdkUe88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8P8oYvg5qG86kwSLtRiZ81lP4ZBnG/WiDx4qg5X9iK77GcqztYBuP78xxX5XTFVvERQ7Bd2DhVWotXuK394fcOHfjLlRzj8MOC/+QgRugCSig8S89wsR5yozE2C6qhpifQfLCv8INjTASYjzI/qjq7sHhey1vVctywVvHJ2e+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAFYnLLG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAFYnLLG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso59675895ad.0;
        Mon, 09 Jun 2025 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516542; x=1750121342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U9Lvj+tvO4mQdCsqf9w6ZMIuKsVVLMvbnrNfMDlrxM=;
        b=LAFYnLLGoGzxh9nFHsxq8miYnQZ8JnEzsoXhaqoTdFzBRZv5f6LE3OYB/2tBw/ndWE
         FhX5aR3Q5O/ZEaEDLBFM2Sqsdm6GOjNnUHW6ctf12tSTCeax+HuxFU8WODCrA8LW44o4
         KHUnnMnpCYETI2cwtFmCCXdNuUdfJsrCEW8AzC2efu9yMFAVP+Qzo4v3xme033UhiaX3
         DXPybjhBwfMjjYijPaNQ3TMglDbw3Ebjy6wmoAMzXxCJHUhl3wOD9Vdfb2lJUnIfdIz3
         dJeGymhjGR7zCpDlwTFvSuK4PBWvvSZx+TOT9ir+4jvOkbqp5dN2oein5MBQS3ZUYP+X
         649A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516542; x=1750121342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U9Lvj+tvO4mQdCsqf9w6ZMIuKsVVLMvbnrNfMDlrxM=;
        b=C35WTWopEbbVCD0oTTGBBsVtquZL4V71PuE4qB4Gatxc8DdOs2HPyP1OoRLkYvH2vr
         fPoKs9wd3bzXx9Qc2CIhV75AZEzVWzFxWTk+zQ1Qsr8IOfRaUZPlIC5lOtD5bSeJ3za5
         u3Fu0xFgYVLroUrbDtbDtCOoNIcl9nypp0v+htEooqNdjh2J1zxksbiA/USV1Qqa8D/+
         DJ9HRjHfk5fLcIqAi2Xf6OrJvP6LixRN85RgU+wAh/+UeMlIwzbZixhQ5lVx763OSeak
         OKj4WsqxKWNxJ3BADONLduFzG6SxKZoFcENqYIRjdclQvpexFBufZQgJaZJF9SfpIf1/
         lJrA==
X-Forwarded-Encrypted: i=1; AJvYcCU+yk2ZABUoz872IcYLxtWKNt4awwSsnmqupqkGuP2DtcE/obOEdHHfjkBPkfd+jr71xyfA926C/lQXCQ==@vger.kernel.org, AJvYcCWdioXO+dobCI0bYgBgGVf+fCL21HtJ1oJvZPM60F1/LuZxTDO+C9kIATp05rOM9XZu5tMB0L8taRGWkccfwqKEqvlG@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpLwfVMlQR2rHFWlZtkbV/NzginOsX3XNFS6scMkwd4bU9JYB
	Am5Ix6n/m5buKYPwziod9mHpP6zZpUCDje0O5LkO8LN/LgOOiwJY6/n4
X-Gm-Gg: ASbGncsZFNAGOaMBCg2ts7YyhTPNT4EnqQPrvRl+Hfv0fneTg33mzZpgoLcxKYx1xEV
	wfnG0hMGsEZh3zFbiSDBMvVR8zFiV5GJawXzEzRmVOQtN2SPLkz8Q27PpbEWvdSAbgRKSDlfOLH
	KfxACmt9Mxv9yWxbJNGGiS09n3MVUJVoXfLTObmf3lBCNttpW+q6UxuVCGr0xqLcL7V6SCCMR+D
	xodmUg5KEISKcf43JK8gU9jtn6jajUZ6qsjFOCo8htIsqXooUnRw3bmMYMcdLRFhlUV3daaIawz
	cJfNFt9iG0qCG+JdziiWIQOsiWTylzHCLCPAggK8fMZmph8G+NFV34JixdAd7GF4ZXmX5aKbH2G
	sBTnXGDhiCLyyZgsm3p3sSqep+2pwEjSZZQ==
X-Google-Smtp-Source: AGHT+IEo50M6v5LdSQV1gZGT38r0BissbfraxSO9tyxQfQXBzfqhZKpqoQDGqWcVp6Fc1/Ws5FzRCg==
X-Received: by 2002:a17:902:e744:b0:234:8f5d:e3c0 with SMTP id d9443c01a7336-23601d0415fmr163354445ad.6.1749516541659;
        Mon, 09 Jun 2025 17:49:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:49:01 -0700 (PDT)
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
Subject: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop indicator in relayfs
Date: Tue, 10 Jun 2025 08:48:43 +0800
Message-Id: <20250610004844.66688-5-kerneljasonxing@gmail.com>
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

Replace internal subbuf_start in blktrace with the default policy
in relayfs.

Remove dropped field from struct blktrace. Correspondingly, call the
common helper in relay. By incrementing full_count to keep track of how
many times we encountered a full buffer issue, user space will know how
many events were lost.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/trace/blktrace.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d3083c88474e..6f0a776ddd3c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -415,9 +415,10 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct blk_trace *bt = filp->private_data;
+	size_t dropped = relay_stats(bt->rchan, RELAY_STATS_BUF_FULL);
 	char buf[16];
 
-	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+	snprintf(buf, sizeof(buf), "%lu\n", dropped);
 
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
@@ -456,23 +457,6 @@ static const struct file_operations blk_msg_fops = {
 	.llseek =	noop_llseek,
 };
 
-/*
- * Keep track of how many times we encountered a full subbuffer, to aid
- * the user space app in telling how many lost events there were.
- */
-static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
-				     void *prev_subbuf)
-{
-	struct blk_trace *bt;
-
-	if (!relay_buf_full(buf))
-		return 1;
-
-	bt = buf->chan->private_data;
-	atomic_inc(&bt->dropped);
-	return 0;
-}
-
 static int blk_remove_buf_file_callback(struct dentry *dentry)
 {
 	debugfs_remove(dentry);
@@ -491,7 +475,6 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 }
 
 static const struct rchan_callbacks blk_relay_callbacks = {
-	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
 };
@@ -580,7 +563,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	}
 
 	bt->dev = dev;
-	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-- 
2.43.5

