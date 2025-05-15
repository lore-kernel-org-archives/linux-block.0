Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B2297114;
	Thu, 15 May 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289876; cv=none; b=LvrnTIqwhVjPm3Rr7ahIzxUeaB+uxnqOuRPh2lfVAnjdBifLIDsR8gi8/zE2MaEFEfAOl9oH6DATWyU6U5KNAuJQUpAKDR505km5RbS/yqOm9lIrNP26WLFYyTgluLCfAa/PkFoXeNMP7YYu2PJO1OsW9x4Iu5Ubm/50hPjypnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289876; c=relaxed/simple;
	bh=flDc8bAVkxLAs44qfF6t4N4Rjx16rwxIkpiEMioxbzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9oa1Z7q1xZuSVGW7PLAF4uWVYJzMeuy/uM3nahehpE50hJeB/KgN0w+PXGN/yCyEd7nYAgFSRwJcorb8fkZpyA7HY4IFFz08F5Fzj1325/m/xp0sxR7wHB0CjcU2tfknMsLbgxSox+sQxdpVyIf/1yQIu9+rmEOak58kBDLV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNBgvy4H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNBgvy4H"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b24f986674fso542714a12.0;
        Wed, 14 May 2025 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289874; x=1747894674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1qSfFOCQ+vt0X22cZ3R8MKHE8urKkyBJ+4xu5qVxH0=;
        b=kNBgvy4HoMw1zQixl+XAAXAipvY7PKsyrcddcxPEhLdBrZU/YjQn3h4WMY6zd5cKq0
         6tcjqCw4RWFha4zDqefWCZ7iIYWIzpgQGs9gHPci4AbZdGCObUMSAo07g5aPRacLtmn2
         Uy4wglotQIZ8Z9T2UMC4KD+mpQVUpEdYKGQ9A6NnrKKLVwJPKovUv7FmOuhxQLVC6ERd
         JmhKNkylXn7RDRrWltWK5I2KdkeTdHqfMijWo46MyQ1IxMFeLNwg+Iof6slQpo5shZ/V
         Yo+P+qF3P//8Op+0NaLYsdRMyhlh++1ynmDQEpurO7av73LhP6VjOc6xny+CsCcvJjdh
         t/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289874; x=1747894674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1qSfFOCQ+vt0X22cZ3R8MKHE8urKkyBJ+4xu5qVxH0=;
        b=b0ezUAIRLLBodgVi8Yd0tjw/CzHgu1+N8WbV/MnjRGqg64/cW7AksJ9SXEId/b0pTT
         yXaGUf9aScD4aH6PZEpgnY2H/H8RmjfGT0mw9TimecBi0t8+OFBlpLGGyyKVMiFNlrRh
         2OuPGFguqr4oRBBVCyxGcghkZnZ27BTYzNiN3brOdVOXadb3y7yFIksR4P/m5Zmwkxfz
         EyEvKoWoqrWHuXOZDG0fqlrPosBtOETj4NSZk2b+k66haI+b/fDMMgOXmF/v0VpzbMMl
         yTjknkYwtZCWUwlC2yzRrOgMQp0agW8MgGai5ytKAkPV1jJ6NCMIOJULHzyUcYPW0dl/
         OHYg==
X-Forwarded-Encrypted: i=1; AJvYcCUhwWZ4O8AWlPbSC4MF/HYWAaJOxRfH8DKo+mm7SMm8UrdAau8mbqiBDVODXYFpNzFuI1xh+O0+X1tBtQ==@vger.kernel.org, AJvYcCWP9fcC6xaD7aE2asvOHSTgIhrpC3DwP0QZAkxUpFGFTReZ3yG0RjFyVKKPyCR/ufBvsK2xBfmkrpPSUbKr7FhN0Psj@vger.kernel.org
X-Gm-Message-State: AOJu0YwYx8blGGYF8XyRzliMsGeqNkyfRkNVmq29iolFvXWJT86DCjnZ
	pB5mmDlfcdDmv5Cg6ZXBqu4Xnn4z66LQY4MgzswHvdHAKaYV9pR8KOJF7g==
X-Gm-Gg: ASbGncvTCEzmajx2B+q08wHhdSX1u8FRGmBO3qXJJ5D7n4VB0gD7z8euVIey4Z4M6Co
	OqK/GjENEmN77EkdMmIwpwp9MW996rx3iwHf/qcbIzvo7+/7S6Tz/hlGUP2zIv+kYhW3MfPbRHC
	60+CICkwy/eh4SLghdoyeq2ucY/xPzGQadW8utMvWQtEWjk+rlNE6/PSuAqS3MCNyYUUlQD2MMJ
	nMfAekJx88WddiOCjpMQoJbiFjErqYrCmC2kTT1y6CqU/PUwodpV2jFB7b1f6T/lcOFnriAnLCQ
	kMYtCHLY4uSqnlAgzHiwdIWWYv/gDfuVzCYIlkF7CyM3wry5c0dL5wV7PDXIigVDY5VnKQ0GFLB
	eQuist5oofLgCN0CoF3VKm8k=
X-Google-Smtp-Source: AGHT+IHEKe4Oqr1X9qygACDyoYOsImdnyOQ4k1ePcozQKHquIP8n2jF0IGlTDys4dHqYqrRhMi7T+g==
X-Received: by 2002:a17:902:d58c:b0:215:a56f:1e50 with SMTP id d9443c01a7336-231b39834bcmr38269855ad.8.1747289874263;
        Wed, 14 May 2025 23:17:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8273d93sm109242375ad.150.2025.05.14.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:17:53 -0700 (PDT)
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
Subject: [PATCH v2 4/4] relayfs: support a counter tracking if data is too big to write
Date: Thu, 15 May 2025 14:16:43 +0800
Message-Id: <20250515061643.31472-5-kerneljasonxing@gmail.com>
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

It really doesn't matter if the user/admin knows what the last too
big value is. Record how many times this case is triggered would be
helpful.

Solve the existing issue where relay_reset() doesn't restore
the value.

Store the counter in the per-cpu buffer structure instead of the global
buffer structure. It also solves the racy condition which is likely
to happen when a few of per-cpu buffers encounter the too big data case
and then access the global field last_toobig without lock protection.

Remove the printk in relay_close() since kernel module can directly call
relay_dump() as they want.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h |  5 +++--
 kernel/relay.c        | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 3fb285716e34..08c1888c9c1a 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -33,13 +33,15 @@
  */
 enum {
 	RELAY_DUMP_BUF_FULL = (1 << 0),
+	RELAY_DUMP_WRT_BIG = (1 << 1),
 
-	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
+	RELAY_DUMP_LAST = RELAY_DUMP_WRT_BIG,
 };
 
 struct rchan_buf_stats
 {
 	unsigned int full_count;	/* counter for buffer full */
+	unsigned int big_count;		/* counter for too big to write */
 };
 
 /*
@@ -79,7 +81,6 @@ struct rchan
 	const struct rchan_callbacks *cb; /* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
-	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
diff --git a/kernel/relay.c b/kernel/relay.c
index f47fc750e559..f4d1dcac164a 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -304,6 +304,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 	buf->data = buf->start;
 	buf->offset = 0;
 	buf->stats.full_count = 0;
+	buf->stats.big_count = 0;
 
 	for (i = 0; i < buf->chan->n_subbufs; i++)
 		buf->padding[i] = 0;
@@ -603,7 +604,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 	return length;
 
 toobig:
-	buf->chan->last_toobig = length;
+	buf->stats.big_count++;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(relay_switch_subbuf);
@@ -663,11 +664,6 @@ void relay_close(struct rchan *chan)
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
@@ -720,11 +716,15 @@ size_t relay_dump(struct rchan *chan, int flags)
 		rbuf = *per_cpu_ptr(chan->buf, 0);
 		if (flags & RELAY_DUMP_BUF_FULL)
 			count = rbuf->stats.full_count;
+		else if (flags & RELAY_DUMP_WRT_BIG)
+			count = rbuf->stats.big_count;
 	} else {
 		for_each_online_cpu(i) {
 			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
 				if (flags & RELAY_DUMP_BUF_FULL)
 					count += rbuf->stats.full_count;
+				else if (flags & RELAY_DUMP_WRT_BIG)
+					count += rbuf->stats.big_count;
 		}
 	}
 
-- 
2.43.5

