Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A828F505;
	Thu, 15 May 2025 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289868; cv=none; b=mKkyIdoC9NkuRTRdYFYPmG3sFA1PVi/irEdpPkHDPf6SwWwBzsSQ1TgF+CImmjw75TDFHWLmozew/8FOhOwGP7PUKJBLgTO5rXU0RZj9pJgdEd8wt/o/R/uyAYPBrGwC3J+vJY5iiloro1aznybWdZI+oA1jLNzkfX/5HTEm4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289868; c=relaxed/simple;
	bh=uDkhdQ/vAx2/PbGIaPmEEm6uGZdGF+cJqEASXGZbMQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A80uC2nb1HlA11W09uEGU4xARolCT7CgRqYQ/4+dfA9hXCxDHcAt8AHrKotdRSqe4L2Q+F/kHmyiuceanmwma/BCw7+bBQkIUFkNSF3ti8NdbBDXMI4gyly25svr1ONL3cEHoZFcNQK0O41PRMO8OmCtjUVSJGk4BDKxVDnyAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyrpeXhP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyrpeXhP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e7e5bce38so5360805ad.1;
        Wed, 14 May 2025 23:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289866; x=1747894666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RZLOZ8gksptFkVkG04qlk3kBG1rmwyUoxt+cMI+4zw=;
        b=XyrpeXhP/83SL7DOgjRwSOAdOY1CoPcqJiQSlNwJCf0h1WHYVYV6R5r1gVzjhIDATy
         T02sFbBUPqNN/pBripAQkkMcBys/QHWxuTyZYC6M3GbRUFfd6igqYnxxtZqfeZtBpwiH
         t3iyE0iAejtbZqiynhKjBtKXCX8MhgQaHJn/dUruh9M8ApO17HrmOUVdXuaCV90xBJj+
         FyCiRcuPJf5ehONf8B0DuPZGmWE6VToeo1OExruDKMprTp6USYEem+s9SyhMwqjua8o/
         fPVEVSPh9Q63YLrZZ3+X346qiYRzI1fF/ACPljMQGPRRwPcS0vs7Pz+KvNBpxhJAbw/j
         83kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289866; x=1747894666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RZLOZ8gksptFkVkG04qlk3kBG1rmwyUoxt+cMI+4zw=;
        b=BFyGca2un0ZC4OSg7dSCebX5X8uxOvwLBia+34cbeSAUudhkHYwE5y98WkP7kZ36sD
         qbX+a57+yLh2OHjiZ8lxEIWPzUDQrSI2VCITTALsduCvgXhRUxUJONSIaADBMn+ueZiL
         m+9nwl+FI9tdmdJ4vc61uZweDCb7Fwl/KaM2ugvx4iLNmguehHI8ziB77yhRl7uTRCgt
         wfh0q2O4gzRuyBun5oeBbI5HdxU+aqtKvEKZ6xe50jWN+keqF6ZweQcc/TStBAOH9MgT
         3gkKwtB+BzOdhNmoVS8cLbKlh9Uz4UBlwWrJqS4hRcEXw7ZVamsGfg8NJcnjLuAyH4yu
         kHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLW+03QxVcKe+23nw7QtO8Lfncu3h528YqE1MDDIcHHjuf/TJWGmcJ34lBiwpO9gKm7eGv/ZtVIwE3A==@vger.kernel.org, AJvYcCVLy+9vaJuk1i5uvSWalrtU8rBegcdFr4MLh3HfjAorIuZVMw8kiZA+4kGUVjbyMc6PPgBCQLMeI2cheUg/9C98EFY/@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXCHMbrWZPg9sB6K+4yYTid8PYEbxTu7cLjg0X5zfoyt0Hj+T
	dw+OSGL6vbeLPcLV/lwAEDKaI4FtpKcSHCKgMeDcaTXnR80snITn
X-Gm-Gg: ASbGncs6aG30PDyLaGmHV9cJqWh6DBGrMPytMfNU8RrB1cuzo1Enui5mKtmpW2lAXOc
	lXCnXopr3R4VLSfftE9x9l8V50h1wFApNzRtrcz/TSX4yJmL4S0wejbkH3j/8x3z4GhDgAkvICK
	yU+Va1UTsZZbdWmadFcPoy5TQf6gNXF5Kz2fjwQUeKFVDlYq4zAc6H4RlZ97kjpysgzW39iWxGS
	F3v0Tg5HgtuhRMpJ2UOQQbGGtO+GW4vWPC99bR0x6gBv/jeWeLK5oieF1xKLs7LKB8MR4kMYs3f
	mflcjVIGMf1uR+b/6PKDoO71saErAk8po3faMnQBMiuFIfrjyDsJKWHfQNTw2T8YZoCd3rWY6bH
	pv2UHhtGLDwZ9C2KvVRr01hw=
X-Google-Smtp-Source: AGHT+IFNWJurSt0Mj07t8pLKz0vCE/rtZKXXhoqh9jxa2NXOqdlxtIwC92o4H6pBvBlMveleP3Bnsg==
X-Received: by 2002:a17:902:d1cd:b0:22e:6c96:ebd8 with SMTP id d9443c01a7336-231980bbecemr68671505ad.11.1747289865817;
        Wed, 14 May 2025 23:17:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8273d93sm109242375ad.150.2025.05.14.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:17:45 -0700 (PDT)
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
Subject: [PATCH v2 1/4] relayfs: support a counter tracking if per-cpu buffers is full
Date: Thu, 15 May 2025 14:16:40 +0800
Message-Id: <20250515061643.31472-2-kerneljasonxing@gmail.com>
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

When using relay mechanism, we often encounter the case where new data
are lost or old unconsumed data are overwritten because of slow reader.

Add 'full' field in per-cpu buffer structure to detect if the above case
is happening.  Relay has two modes: 1) non-overwrite mode, 2) overwrite
mode. So buffer being full here respectively means: 1) relayfs doesn't
intend to accept new data and then simply drop them, or 2) relayfs is
going to start over again and overwrite old unread data with new data.

Note: this counter doesn't need any explicit lock to protect from being
modified by different threads for the better performance consideration.
Writers calling __relay_write/relay_write should consider how to use
the lock and ensure it performs under the lock protection, thus it's
not necessary to add a new small lock here.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
1. rename full member
2. revise the commit log
I still chose to keep struct rchan_buf_stats to help later patches
implementing relay_dump() to dump more statistics from buffer. It means
more fields can/will be added. But I have to say, I have no strong favor
on this kind of organization. If you don't like it, I will remove in the
next re-spin :)
---
 include/linux/relay.h | 9 +++++++++
 kernel/relay.c        | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e10a0fdf4325..ce7a1b396872 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -28,6 +28,14 @@
  */
 #define RELAYFS_CHANNEL_VERSION		7
 
+/*
+ * Relay buffer statistics dump
+ */
+struct rchan_buf_stats
+{
+	unsigned int full_count;	/* counter for buffer full */
+};
+
 /*
  * Per-cpu relay channel buffer
  */
@@ -43,6 +51,7 @@ struct rchan_buf
 	struct irq_work wakeup_work;	/* reader wakeup */
 	struct dentry *dentry;		/* channel file dentry */
 	struct kref kref;		/* channel buffer refcount */
+	struct rchan_buf_stats stats;	/* buffer stats */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
 	unsigned int finalized;		/* buffer has been finalized */
diff --git a/kernel/relay.c b/kernel/relay.c
index 94f79f52d826..eb3f630f3896 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -252,8 +252,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
 static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
 			      void *prev_subbuf)
 {
+	int full = relay_buf_full(buf);
+
+	if (full)
+		buf->stats.full_count++;
+
 	if (!buf->chan->cb->subbuf_start)
-		return !relay_buf_full(buf);
+		return !full;
 
 	return buf->chan->cb->subbuf_start(buf, subbuf,
 					   prev_subbuf);
@@ -298,6 +303,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->finalized = 0;
 	buf->data = buf->start;
 	buf->offset = 0;
+	buf->stats.full_count = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
-- 
2.43.5

