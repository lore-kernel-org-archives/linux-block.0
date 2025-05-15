Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED77296FC8;
	Thu, 15 May 2025 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289873; cv=none; b=Hhg0UKblWGdE/J86sPKCCLC8gbhDKRGZMkXo0IjLy1ozO2Br6YBdjs09l+VKEJxSCsNmP7778HDc/4qAlNeAW90vyBfX+Pvmbs9vL9PPxQ8Q30I2TiebkUL306zZzePusFcat4jl6Bw3KtmQBvt4if+rspitfMWnLfUREBGALKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289873; c=relaxed/simple;
	bh=3oMExeT1gw8WeZ7HSm9DykoBnlRC9eN0Kpwj2JwMyOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAVh3ND8FIUM6EsnZ76PzRRK/T32Ws4fhIUV3gJprl7Es/Rzj6aFnYoAN3HGyVc3yKPuxZKarcFY10sL+1L8FpZDtUrs76wGkVsLX6mLuaITRJ4i3JS8NH2eIBIXVjWSRey7GxliupfuGUxSl60Z4WE2yviimBtQdeoC0CLPSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICfnsL5d; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICfnsL5d"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7423fadbe77so557500b3a.3;
        Wed, 14 May 2025 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289871; x=1747894671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e3hBRipY8EUqLUyHyTf6FREsyFLAWEciadhGhXzW9c=;
        b=ICfnsL5dlBuUPZf3gTVOf+JkmQ3bRj9vitWAz2SAZ5TTY7J7EEACTYHeafHxD5wj6x
         ZcjH9nfJ4BOSNU6YEkvqs2K6Cy3WuRcuiYIS4oCdvESMAZNGuiOosrsBq4kMBe3g3DtX
         ZQd6s9N+kXAQVYeURqE136cnpqLbA/GCTKeUsUoKFGOZ4Xux0YZ4ryHCcq6y34y0WJXr
         28nkW/G+7lK9IVbn2+RKghVW//EL84bMH6wyPix9X35p31c7XxJWizxY3ckJW5hKOBnA
         h9pcNxjK4Z7Swa0Jp6chUXC6yPCSLGu+hIH7ts4rKnEB94MJpQLFrGnCVGXm4EqmzcZi
         Cd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289871; x=1747894671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e3hBRipY8EUqLUyHyTf6FREsyFLAWEciadhGhXzW9c=;
        b=BJr2eN5RnKMYu7TzYYByWGSudnMwOq5NUimjiSRYtQVFMUyRXZiHCSbv5bR+WEID59
         RUAz+DakLxreVKJrVQZPjB9YMfcS/KX4AJQKdgDVyq2Zk2ilc2eM7YAOpXn/wjEFAhfF
         S4WusLpbuuKZ3Sh++4tSBZfPJu+mKhQ5mb90DLCuvYKsV+pdUgAn0wgv05Yi5+M8WglD
         Wl6Y/SXghqSsNPwVLAuJvXFTNeIAAMNgDcADK8aVbl7H8eecbq17Pfq7GhcXqON6RcWz
         16mUoIQBbYIYyJ5pkaIBzs/AHhyAzx4D+r6HH+I+TnBEaWt2XVyRityc5NS/CIpyzRJt
         JSHg==
X-Forwarded-Encrypted: i=1; AJvYcCVXn4lLWFzo+ibDtaEKPTsJJsN7+VovsSgJESeerbrv7jkE86V5IPilwV7AsYBQLMeMOqa7XC2R/1smAw==@vger.kernel.org, AJvYcCX8yyyW3TQ/nr34YB6GC610NmZEM5v66UVMyN5PbHsL92qYRaKNqeKorsep4711xTBpN6raFihzspEu/oLW8q3iidv0@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJsqWXB8zo44mHyKkDndbAmXsBpzIdNqlVDW1Ewn3o6vHMrOu
	hT3yLM91dcLzSO2JBBqopW170Nz2SUPALU1x0wy4Re3dddrL7dl1
X-Gm-Gg: ASbGnctSS3mFzf2O/7tAj9m0k7qrDPc2Jl7ixEw6Yb1uG7db8HJLinrLNWfJ9VCFrAX
	89WAl3xCa/XMa6FD7HABro8Ha345QxLCT+ScPfvLAIxWZ30GxNw+0u68iT8dEMBg2DSvOaEQjnG
	Yp5NrB8foJT43ezFzN1caAJAAdZKbJhduUtibZvi0q0UYOzm+ovwReQh/Bh2yuy3ppcRiAJNYfm
	w0Udy/MHHJi1O7qFAU57PIY1JPWdsrnqZX7jQpVLSpcNrT+9gj5UOVMpgxWiEthwN4hkJX9UWpg
	XKIGt2JY+cI7yx9tDr+pgoIBvAOVrsP9W/IwTDRR0jucUT+gMRbzo2HUOe5eCuhC5SCjxyXN/VN
	ZUkJuj8c4jJKZzdvoShHlswM=
X-Google-Smtp-Source: AGHT+IEBPiBTK3rH/fqN/zXo1ORZnDEzzvQ7bb06K7wwMKuIkd/pdo2SuDfrHuLWtY0np+GxjIE3Fw==
X-Received: by 2002:a17:902:d4cf:b0:22e:4db1:bab6 with SMTP id d9443c01a7336-231b5e51ce9mr16233345ad.7.1747289871463;
        Wed, 14 May 2025 23:17:51 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8273d93sm109242375ad.150.2025.05.14.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:17:51 -0700 (PDT)
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
Subject: [PATCH v2 3/4] blktrace: use rbuf->stats.full as a drop indicator in relayfs
Date: Thu, 15 May 2025 14:16:42 +0800
Message-Id: <20250515061643.31472-4-kerneljasonxing@gmail.com>
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

Replace internal subbuf_start in blktrace with the default policy
in relayfs.

Remove dropped field from struct blktrace. Correspondingly, call the
common helper in relay. Through incrementing full_count to keep track
of how many times we encountered a full buffer issue, it aids the user
space app in telling how many lost events appear.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
1. adjust accordingly together with patch 2.
---
 kernel/trace/blktrace.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d1a89714e805..f4c103aceacd 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -415,9 +415,10 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct blk_trace *bt = filp->private_data;
+	size_t dropped = relay_dump(bt->rchan, RELAY_DUMP_BUF_FULL);
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

