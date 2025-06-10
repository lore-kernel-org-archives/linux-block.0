Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D819924D;
	Tue, 10 Jun 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516538; cv=none; b=rASo00OCyhXY3Gwss6IF+cOZ7x2kfsHVSiDGEnP4uhY63PxFIMocxL03mSZZgzrajca+l+Kdp2vARMJWPLWRhTVp/CE7kYCbroWlIMo+jVOXqx3jFZbp+iHv+EdkZ86XGxGLyLZl8Lxv61D9uX6Vtji4aMO4bFnzqEQWao0G5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516538; c=relaxed/simple;
	bh=8D9sHDxASn3ic1cCmUXgPT76Pt9nEVJYxVrt6Sj17lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxgANb48QjvRY9Zp6TnG4XiMNSgdZmPssPbNB6b2uDeaMNaYkmxi1TAoxE59SWDue3WHE0psKhSShtZGhJGLM4TWKeqTEmSu2M2sqmySK4RKLhBQbrD2dT4JUlvHScOmN/HjDm4bIWekhfExCatlEdergeqyrehy2+/a/w38BCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFQ4QIGL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFQ4QIGL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2350b1b9129so31310065ad.0;
        Mon, 09 Jun 2025 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516536; x=1750121336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/DS8UbuUDcrhCZrgQkbBuuNPk3hX4iwlMBvOBP+pxk=;
        b=AFQ4QIGLbQMJD+sSSN1QhdSaF/sx2OSMpZ7JP9vMKbXA7kGJVcvkyhMqRwktNTa2rZ
         G6rrmOy03UJbCQZCKRPUDmhWoy5HDhEJ/Aw6xX5B/qqQMBsRMCy4rehTGfXe82Gl3WeB
         h724t7OEsyvJYvP8Mp2SBt8xwVVvOrbfSDW+2Th+qsQZ3ZlqDHEhDcS3cyGcYgaacgQt
         Wo6+xhnWH4DLio9HCi6y9gKUvbYzdpjfsuQMbglsNTB+0EfVuIcF6/gfFucgt+9Qd5c9
         0fcuyCLuj/liDxOH88vyGPk4MFX9kpKXvTW6N2kWLKGhcbBW5DA+aKwtEhH9AUnDW752
         yK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516536; x=1750121336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/DS8UbuUDcrhCZrgQkbBuuNPk3hX4iwlMBvOBP+pxk=;
        b=gMwQptMVC9/UVIpQyULdf8hqJ2bkksQx+tRJw5MA36rNBkidrBvuW4uEUrDNSqQHZR
         N25GK/qB3kfK+b828xZfPWb0+neQgOPVTKdQyQITDBcDahdvQYSrmEh5MuCOFSVV+eKo
         9Pufv1dJ3HfmzlSDP6INJ5c8e76BpX3imps3eqdewYPIZhd93N77xlMz4lPpODIBS0j+
         vxBSXjRlbMeudoaNuXFmxKGHgKgFOioxNnG8JRxM33lpOmzQGhhIS9nyI/eArtEQxP6B
         OiDgyBMEjlllknEnuo8NwfaLPPwJoes9n9+GQ0NGDs3k+w0GGvspJXPE6yzr311OPtUw
         dpzQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUo7e+OsDi8IXZWckhpZVqdlWmokeqTPA6KOtwQNEIAbip61S5Cnckn5BkQ3+mSD7yBG7a/NCbfB72xIonP5sv+Yd@vger.kernel.org, AJvYcCWsUmNR6vyBZZCRVecAmrNdf3m45mJUL33muVrEjRNgfXfZg/G9RkQXTDAyppQTz0AHxzAdj+o9q2j+Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxguP2K69psdV8Sw1El59JdgdWWPxyy/fpW6D2C59ORga8gwgq6
	F65tjU0Rv6r+A65nzabeHbdZ+Ne0a1USuUVOE/XQVuAXXyqHfj8m+LBAU5nIeuGultM=
X-Gm-Gg: ASbGncvMzH/I7dhkDxfWoJJBgb7LdUdsdKF6QEluNCoR5mvB+DKYeBhcVew2/GHSttO
	u4+TWpacKS0cGxzIWqtTz6/NpSTwfYfY1FKk/xVI6Am6rR9Wl0Puna7o2uKwh8UOtjZBXG1VGlP
	oG2zXXFgQYUxYNPE/aeKaJxpvJdYeeXJADCqSmEambai+I93DOTFluNkA37H2AJ3rIEqZVx7S9l
	+/Uxkw0elE+FlT3rNxE1fgET3RKOvcHVFis6CQorZgwgkM4BQCvXTGkAgZD8v6a5ZjDYHg1t4K6
	867e4Szh1/dtwK5jwsEPzyk69qxILSfS1W9Sb1sEMlqa6Wi635tyPtzoDHrFFAFwL1Ykj7HqN3j
	ei4bqmKYE4CL7Y0R8kHE1BCEPuk8S0BfzWA==
X-Google-Smtp-Source: AGHT+IEI90AJQVBPhXxZDUC9WO3Cy5M5cPcif0X/2cLg9crT3KTCqAx9YZ/OWHoetyWfYavi0sbGfA==
X-Received: by 2002:a17:902:f54b:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-23601dccb4emr190398595ad.50.1749516536578;
        Mon, 09 Jun 2025 17:48:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm60713845ad.122.2025.06.09.17.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:48:56 -0700 (PDT)
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
Subject: [PATCH v4 2/5] relayfs: support a counter tracking if per-cpu buffers is full
Date: Tue, 10 Jun 2025 08:48:41 +0800
Message-Id: <20250610004844.66688-3-kerneljasonxing@gmail.com>
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h | 9 +++++++++
 kernel/relay.c        | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index e10a0fdf4325..cd77eb285a48 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -28,6 +28,14 @@
  */
 #define RELAYFS_CHANNEL_VERSION		7
 
+/*
+ * Relay buffer statistics
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

