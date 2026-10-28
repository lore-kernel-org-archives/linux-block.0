Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205902;
	b=K6gQNV9+HWtgCF7mmNFzoK/4QiSThNdrgxXXBHJSRUFeO6oU5PbYmRwgjSbQS+rwFXNT
	 K7fC7LY4nCLoZuIlNKX2P+EeMWuCyPSGj31JoOwdQt/hZ09PjUSu1xFOfYltekScB8p9W
	 jPcQNfI+L3SFkcFl9+I1FSuPPh7i8+6KX2d8BIfnPTVnISPkst+r2xgBEHZIM2HgWxRQ5
	 Ps6RKjrpRBoFI65Xv8aqTnBR3jzl+LV4QEDTo3xLKYj/2pyXkQdyQhFTEBWLrcK4iCBBQ
	 ZbqlxY390omA25jqPU6F+e5k62KrxbKWqzU3fsukipiMZPJNPedwQZYBjMoITzEOXvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E9KpTB8x5HT5nw/ZZZ6eI3r4YNN0MW9cCpDtFJe6bc0=;
	b=xmAV6W9/wGycZpIiHTgmFC6SrUzzZ8+LO1Z3N1sDAs7eViiKDz4zRoZ6GHmaImG5nQMv
	 PFnl0gDquZIM14i26Jv4qKvwT7uj+lUe8Igv24Aa7mOm/orRNit7cjT6NYYgj3pqhu5nQ
	 c0HYubHt4pX8sx/yNwdii+5GQcSesjhRfrW8xMroEpOEL4dvcZmlV4x06jXnfqhPazoni
	 PY3uEFn/C+98/lGaX6ZEJ/YIRxaEZBcGStDLdMbt3vjj0Rm0c7l7nHh/gg+hVvT0j1Tiq
	 Fg28vi9rNqhYXZzRtYTvcijhxfLXYSBZ7jzjwqRMd4u5sy5KLkjUKFQntn3H6xOdNCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jciNnjAi;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E03606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49E03606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jciNnjAi
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8446af403b5so751652a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205901; x=1793810701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9KpTB8x5HT5nw/ZZZ6eI3r4YNN0MW9cCpDtFJe6bc0=;
        b=jciNnjAi6kzkA37nyBU9zjDCIPfLaLdbosewBMDzaRGHsUghd+UyFvDvZhkj5g2SNV
         feacCd4pOA/8Kuy39t+D/vFdikJ5p9/+NYtC1Pg0E5bQg9/6h+lhi6kJhMIReUc+f0OX
         yAuPdAz6tj35nkagDDOyal6HbfXJbLgn2bOlvKUrByHYJZEsaYyzNpMK5galK/w/zXR6
         JHodpJzae44z1Ovu4zR6w9i8laFpYOZbq84dsxnP0+IO1JihKfcQKLn7CNai4wgROyeJ
         Mtm/nwFp8oFy4bHbBaWmmA4d514fNfqJo/JTf7AqOLaBXAlVyxw6ZD4xMGQXmFICuA0I
         zByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205901; x=1793810701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9KpTB8x5HT5nw/ZZZ6eI3r4YNN0MW9cCpDtFJe6bc0=;
        b=w2cmJ3AeFdCcmYmGXo1DZrGUkhHolN0vzqEjPkXvheuVEFl9mxMqINLFQEv9+ZTf6t
         iIU4MgQNZ6NgJM65jDG8tUymt9cmGI8dhpsKKSAjS3falJAL+ti6GkRy04hGc/rYxNgA
         MMaRdTVwpkxjNpAgPL+2o4WQc6sRzPucWPmx41kowPy9YL8uW3OXEVqkgJd1ykoacsML
         RuZzrmfXscomxQrseC4QTRjKI9/jYP3PFPDXryW2zY4JnDocot3KWdg+mmsTeS9dtGm1
         DQdKJ10kY448nydvEgjufXk3l8j89Qvze2REH33P7v77ByRDDNzBlf/HuiuG9oUfya9L
         t5Hg==
X-Gm-Message-State: AFq9FYIvYB3hrGhCiLotdyw1BtIsFY1xxibMXtANKqTggxK7OAHzCNJk
	Zm+6qa/SD/keKFdryiYJBp17VQdaaF4LZlgQpMSBdZx+ozP87+2E2HImI6ZHcc9zmmPWlLhIvQN
	1858vuzE=
X-Gm-Gg: AYBFou21mnmiv+LClPcVNjkh4GKemifW95emXKsN55U51VyBGoXFvTFJZm1d+osuQFF
	H+KYe8wLcI75I6I31YCP7LN+rLb38o69zlMAJ6bOUK7g4uqECIDs7XoKoYdhoi6Zggphyte8cMd
	tG8LMkwZ70mI39in0q9MAH+xhBey6nW4Nrvjf/tnVUILD0nYcW2Ww6D1WRYLJ2nRALCbKVCWbMr
	EzIXR9leVZyyYJ5W6x0z2FRhLoRNgEguKI8oBtk2QM0WQ9x0s0zRa99FtRAg6tNtnhPyhKyFeLd
	YvROSOz3mEqx9EpeQXGajap/1OcbdxLY9mDyUbLtlHzWXFZwziljfw7oAwMpMUZ0cwhHQ1Hhx0U
	MRVzby7t57rufM47iT8Kgm69BKrTd/+nSs3gQeWYaj1GMoT91rd5yYYMS+zeRDcDzyrXDHplBmF
	/cUjYC0ZLf2TdDxGdAaRNyeUTgE+1N6RmERC+lysjFWw1C2tqt2nEMImASU3UJlG1itOxOROP/0
	NueEK7HdGAEiMXTNittTG3WvCBuVuRcVRNTSZaYwV4beXXveAtpTokO2KFktK7oq3NQKdUIgCgs
	05sx5gShKijEzLl6hNt3yRAuRxOfN1v/KXi1Zxgd64p3YAFkoLf4j5ILKI9HgxXn/QBnEpKB/Q=
	=
X-Received: by 2002:a05:6830:719e:b0:822:b69c:fe5a with SMTP id 46e09a7af769-85ab85cb48bmr2517928a34.27.1793205901389;
        Wed, 28 Oct 2026 09:45:01 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 35/98] blktrace: remove the debugfs files before the channel
Date: Wed, 28 Oct 2026 10:41:38 -0600
Message-ID: <20261028164415.1262013-36-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blk_trace_free() closes the relay channel, which frees it, and removes
the dropped and msg files afterwards, while both of them read bt->rchan.
Remove the files first, which waits for their readers, then close the
channel.

Fixes: 7f2173894f7b ("blktrace: use rbuf->stats.full as a drop indicator in relayfs")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/trace/blktrace.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..a37857a2fbd3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -468,18 +468,17 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 {
-	relay_close(bt->rchan);
-
 	/*
 	 * If 'bt->dir' is not set, then both 'dropped' and 'msg' are created
-	 * under 'q->debugfs_dir', thus lookup and remove them.
+	 * under 'q->debugfs_dir', thus lookup and remove them. They use the
+	 * relay channel: wait for their users before it goes away.
 	 */
-	if (!bt->dir) {
-		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
-		debugfs_lookup_and_remove("msg", q->debugfs_dir);
-	} else {
-		debugfs_remove(bt->dir);
-	}
+	debugfs_lookup_and_remove("dropped", bt->dir ?: q->debugfs_dir);
+	debugfs_lookup_and_remove("msg", bt->dir ?: q->debugfs_dir);
+
+	relay_close(bt->rchan);
+	debugfs_remove(bt->dir);
+
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
-- 
2.56.0

