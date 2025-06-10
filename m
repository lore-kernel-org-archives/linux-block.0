Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C881CDFCE;
	Tue, 10 Jun 2025 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516546; cv=none; b=Hx5TjbNRjKxFrR5v2Jj+uS0QgAo+SBmocgGRsqUvFocpsvPddDVz3rbY0H8b9dMrASaO6l5GKCYVY/ADLRYLRlDPYRcgxWT4maZPe1R4MXzlk41dE8SkaliGvb0Opfk6zxzHurw/DgJMbdxHmL2qN0sOVYzTFswfbhCcBNcNmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516546; c=relaxed/simple;
	bh=XT21aCq/7P6YAwPCKmY+1PKON7RZG9sndxfvvN+6Cl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcdfHYKK5Cn5U2Zeh1OR7lmjz4jKW4p5F/qwXBZrcLWH1MViEQiUFrERwSiVXm9QPXSoPC6y9312+CNBspwtp2+e5eevlWqJYbGOlwLwvcVm48YUpJ1bBXH2kqStuZhR2gQKW0ui/fR64yo97UYwtmWWWPEF9DwqCd2Slf52FgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJd9GcHh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJd9GcHh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2352400344aso42091605ad.2;
        Mon, 09 Jun 2025 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516544; x=1750121344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXR9OD2yujCvZ+wl33V69tZqfryb4aPHl7dMp9N7l2w=;
        b=KJd9GcHhNdm1GqmlrHObqqoPi64zY2klZ3K6U51VYmuuAt/b//YhIfk9cqx/9c26kt
         TNthUGMpu/xdEZy7RujzbTZT/KaA3MRGqYF6je3DqTai3bxs713+Axk71JI71TzXAArS
         qyiEOnNFKle2vqb5R+HyyVnJlsl0wfC24Ju2dmxOxsEHb4YybyLbyLC31yf9ixxd3jTO
         Xo0Bnm6QQlKO6TTJGropohNZUupW/vP2JObFwhb5P1bqg7ubNOG5mmheOtAfxDwUwqWF
         jU0ZKrjFrqtUebPEZxl07OA1ftsrMGHeoFroOtA7hwxB1Y1oAELakJkHZdNB3IGCqD/a
         XJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516544; x=1750121344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXR9OD2yujCvZ+wl33V69tZqfryb4aPHl7dMp9N7l2w=;
        b=hKcPs+A4bueCnmQNaFkquUB4DY2q33jwuea6Zeq4ymvZoZ1o1HVWGMCGxvTZS9S1Tz
         YsslWZfvTGFFtEFfKS3Sy4jhFtLzJWNtVtyXU/SGu7FntFZbgwh4/353dQxNR0MRbdhG
         7SsIdaFawODUj+BGaN37zKDMhvtn8D89IvDsmi8XKgkqOu3RG2Y72LSq+B/3Jg/cVTng
         JS8/drGOJD17uRzKs4+i1oL/3YaWf3983sYK0YbQoEiZQiawVveNPRyDsWeN3oZCjBKu
         ORkRQKEs4DKMoT+6LkWQ/P6VmASKwxLNNmAT47bS6Z4eJzAir+/cRwHy2otf6Kt9tl0M
         0Ulw==
X-Forwarded-Encrypted: i=1; AJvYcCUNf+cVrMlWLZUDDiWjtl10lZ92XmW/1kHZ8VWe9xu0W90pREXbTsy9BKUHqWj1UAAtpZJNnb9zvIf0415lTwMwjRMH@vger.kernel.org, AJvYcCXJPFm0xGLSkz5MovVmXFkW711BpYYo4X7ufJNuio9i7SioW/8ZsgHj/QM4l1iqEl2t3D1hjaHFqQxvlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIdwPwyMaVlTrScpqN+4ghDjRv3MRl6GZ0+dkiSmJRVpNdbYE
	rw0QSSk0bJg6E+ny62PO+shqfgFzSPgjdfMG8sR1Y3CCdIphaGCxWlfl
X-Gm-Gg: ASbGncv7bAff7Ehz7wPwdNE16Ui7pTiI6VqmhNxalwQ1RGfWeEizLgel1tOktfNrEnn
	OqelV7g28ZlgfxjACyzbk0NgT1HDbPtBLQh2PLB1EXnvJiAkbREW4uZBC/HdOX4vqopqZBiu7lB
	L8atK7CE5/nSIH06Ges1nW+M4u/CCy1kVmGaB5gKLuFOcvxRibxPvYZsIOw6tn/uNbLTHnalRlj
	L9wb0ZHqoIestRC/4XUfZGpYhfe/u+/fVp2YiXEmzNBG/dwWCQWYXPaXl6ctaFgmYPVHjsA6cUm
	g6DbHnWvy5amsVRO+WW9/k6KRUhS8rNEXI28Ehe6Q6dQIqbPiFKI4od+skxG5lwvxr0NwldKHbG
	lpFCD8crKdc3IStEdgYA45b9bS3uL9Uuw0g==
X-Google-Smtp-Source: AGHT+IEoS2Por4ETOAkEPpz2Graj9iyaZRSNt4Xyb0p6VMbRRYiPv4YbAPHhi91Tr9IOHJB0+kXkfw==
X-Received: by 2002:a17:903:987:b0:234:c8cf:a0e6 with SMTP id d9443c01a7336-23601d16b78mr236909555ad.24.1749516544453;
        Mon, 09 Jun 2025 17:49:04 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:49:04 -0700 (PDT)
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
Subject: [PATCH v4 5/5] relayfs: support a counter tracking if data is too big to write
Date: Tue, 10 Jun 2025 08:48:44 +0800
Message-Id: <20250610004844.66688-6-kerneljasonxing@gmail.com>
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
relay_stats() as they want.

Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h |  5 +++--
 kernel/relay.c        | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 5310967f9d74..6772a7075840 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -33,13 +33,15 @@
  */
 enum {
 	RELAY_STATS_BUF_FULL = (1 << 0),
+	RELAY_STATS_WRT_BIG = (1 << 1),
 
-	RELAY_STATS_LAST = RELAY_STATS_BUF_FULL,
+	RELAY_STATS_LAST = RELAY_STATS_WRT_BIG,
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
index fd70d0e03216..bcc889dc0970 100644
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
@@ -720,11 +716,17 @@ size_t relay_stats(struct rchan *chan, int flags)
 		rbuf = *per_cpu_ptr(chan->buf, 0);
 		if (flags & RELAY_STATS_BUF_FULL)
 			count = rbuf->stats.full_count;
+		else if (flags & RELAY_STATS_WRT_BIG)
+			count = rbuf->stats.big_count;
 	} else {
 		for_each_online_cpu(i) {
 			rbuf = *per_cpu_ptr(chan->buf, i);
-			if (rbuf && flags & RELAY_STATS_BUF_FULL)
-				count += rbuf->stats.full_count;
+			if (rbuf) {
+				if (flags & RELAY_STATS_BUF_FULL)
+					count += rbuf->stats.full_count;
+				else if (flags & RELAY_STATS_WRT_BIG)
+					count += rbuf->stats.big_count;
+			}
 		}
 	}
 
-- 
2.43.5

