Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1534A3D57
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467413; cv=none; b=cHi0LGJTLIvFtx74RhcjbRAs0MhnGJJqLxulRGZjY/OtU1j95dDLjQPfdHkBobdeJ5I1Y2rfsbIDlyJoLSe9MaTbruWeZ7JRWMc3EBdqS1fM4jeg0jctA797Eq0dJg6FqmoLY0/wiworoens8wTusvGVYdB6J73nw5buA5jCk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467413; c=relaxed/simple;
	bh=BpRN0E+h4206Xe8hsUbO3Z8TKNOEgNlJgNv/rQ/udFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+pHsCQKMNxTGP5d0NYf8AKhAfWyVqI4H2/DbcStwc22+TQ3enkWiB18Rf/YOAy+kgD7K3dXoQy0iPzCV/h1ev/6Okea5ldOXPI/rXT5mOYm0QmMljCwuzT9lYcRhb77y6K1uSQyJo3Q6AgkLFI3oIJQq54Rl7aHco7s67SlQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZ5Xfmok; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ5Xfmok"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c79c9f7b54so157317e0c.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467399; x=1789072199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5h3C3ueW/KtTzkUQ4MiM5kplP4HGSznat6sPB/kFpg=;
        b=rZ5Xfmok/DURfKZiJV+SRNLFsaRWx+95jdAXkOk1dl69ZKKKBm6K8vBN7B6ZdMQQM1
         YL26/F1VzK3eOpId3MGEYzjOqEUxu6YPyjroF/Qz/CVDfBiphnYIVLjq4a7rdI3Y9IzN
         VVY84q3jG0E4PP5Bj7u1YeawgETSYZM9SdPkTpKamnONVKJOO9WS9vaxQrpz6n1a0GBJ
         RSjRlKfrg+Ogc5II0rWIoVXVKUSRuOj69+mZlxIsafUTvsyqGyOTZcpW4MQNZMg0AbGh
         O0wDgJIMeWGkuSE8I2zKWpJv1qRLOSvL7lTip+o5+1rijbKx91lCc0N56i7wfteZrz8V
         GWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467399; x=1789072199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5h3C3ueW/KtTzkUQ4MiM5kplP4HGSznat6sPB/kFpg=;
        b=Otwly204nUGD9KBnBVjlypcHVOl1IW7uQCHfKt8n4525jWvpduvi/5tEq6eacdHDQo
         SpxLibDmPv3m2QfTIhnAaB3koc3OU6bHqwnh8BrLK/SmjRYk+HRkJnskVTtLpkAuLa6A
         1OjuNgk4K+VrPe4vPSl0WHzVnQG0gK9g3gFXxebrVuiohwD7ZF59aztGlmWhT5ZHqzfb
         dbmmjjvwey0maiOasRolULW95ag2GglgC3rZRTjWqUEmQlkWz3nojqExr91SCQPgqrQ/
         DQFQPjVAiSrFGgZKRaThLd4buQB5ur5P08ig5PpbnEYNFKB4ZM3oz85DA4dcUrqawM8A
         3dwA==
X-Forwarded-Encrypted: i=1; AKwUvBwLTHCzx6/lQVkJdIU6PlKBQTsOsClf8bmJcMnSVhDHYfXOoUmOaIUYMAEAK1QbrGFQ6DdGK+FxOu/E4w==@vger.kernel.org
X-Gm-Message-State: AFuF++np+rUeWLJfW39KMdMrGA2hFhmw/mUJq0oSpfskMGvledxnKORU
	apnDQI6IUV3EeuKsoEEBitXlGxfUMcy9hQQGjW680QbJZBwJNKjh1b61
X-Gm-Gg: AYBFou3usVpEmt5uKoF75tq5tv4n17YnLWXfIw3kY4XOGQlGKOzWFrYm2VN+XWHIkgd
	9I5RiOU2pPFwDFrSwNRyjeFEoZGWXikzLayJOWI5NUH0mDkoy+bJMJBFjOxWMeYoUw6rZI+RXDl
	thBxWlvdTvZ74m2E07RxXlty/Ez9fSe7s8zUnXRU33SL+5vhA+30/DzUwFifciAMw0nBSJgEOVs
	0nP2EuMmJvTs4thqyrRF4es4oRZY8A8uehY7kekrpDg5o4B/7zffo1pppUS6ZcNOOIX2GbwrQ8O
	KfQ4LRJEsLtHkFuyuMZjYXm22tqs8xSlc1KABkINopzOqlD3MjiwuyX7btrtvnK0deOe0J3H6z+
	1Yg7Zq2lI6k/QQjJ2ChFMK+++ui3LVepD/8GOKTaZOtqFAXr2oKY57DlpoTwt+kg8ifWYmqsv2f
	ctlMG1lbrdqIOar/GVyK8rEoV7opFLixMoKHc1g1hQrZ/9ZtCQHQ+PEKw5RNlIea0=
X-Received: by 2002:a05:6102:5487:b0:77a:2268:9fdb with SMTP id ada2fe7eead31-78a4a995f6cmr108164137.7.1788467398516;
        Thu, 03 Sep 2026 13:29:58 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ed7018fsm253962241.6.2026.09.03.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:29:58 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+4dfd96209d744263a972@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] blktrace: always record ftrace events as blk_io_trace2
Date: Thu,  3 Sep 2026 16:29:32 -0400
Message-ID: <20260903202932.156278-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace ring buffer always uses the v2 (blk_io_trace2) format, but
__blk_add_trace() switched the reserve size and record format on
bt->version. That field only describes the relay/classic blktrace record
format and must not change what goes into the ftrace buffer: the ftrace
readers (print_one_line() and friends) unconditionally parse blk_io_trace2.

The BLKTRACESETUP ioctl sets bt->version to 1. With the blk tracer also
enabled, __blk_add_trace() recorded a 48-byte v1 event into the ftrace
ring buffer, but the reader parses the 64-byte v2 layout, so pdu_start()
points 16 bytes past the PDU and blk_log_remap() reads out of bounds - a
use-after-free when the ring buffer page is resized concurrently.

Always use the v2 format in the blk_tracer path, and initialize
bt->version to 2 in blk_trace_setup_queue() so the sysfs-enabled path no
longer leaves it uninitialized.

Fixes: e48886b9d668 ("blktrace: for ftrace use correct trace format ver")
Reported-by: syzbot+4dfd96209d744263a972@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4dfd96209d744263a972
Tested-by: syzbot+4dfd96209d744263a972@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 kernel/trace/blktrace.c | 74 +++++++++++------------------------------
 1 file changed, 20 insertions(+), 54 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..ae010969c144 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -385,66 +385,26 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-		switch (bt->version) {
-		case 1:
-			trace_len = sizeof(struct blk_io_trace);
-			break;
-		case 2:
-		default:
-			/*
-			 * ftrace always uses v2 (blk_io_trace2) format.
-			 *
-			 * For sysfs-enabled tracing path (enabled via
-			 * /sys/block/DEV/trace/enable), blk_trace_setup_queue()
-			 * never initializes bt->version, leaving it 0 from
-			 * kzalloc(). We must handle version==0 safely here.
-			 *
-			 * Fall through to default to ensure we never hit the
-			 * old bug where default set trace_len=0, causing
-			 * buffer underflow and memory corruption.
-			 *
-			 * Always use v2 format for ftrace and normalize
-			 * bt->version to 2 when uninitialized.
-			 */
-			trace_len = sizeof(struct blk_io_trace2);
-			if (bt->version == 0)
-				bt->version = 2;
-			break;
-		}
-		trace_len += pdu_len + cgid_len;
+		/*
+		 * The ftrace ring buffer always uses the v2 (blk_io_trace2)
+		 * format; the ftrace readers parse only that. bt->version
+		 * describes just the relay/classic blktrace record format.
+		 * Recording a v1-sized event here would shift pdu_start() 16
+		 * bytes past the PDU and make blk_log_remap() read past the
+		 * event (a use-after-free on concurrent buffer resize), and v1
+		 * cannot represent the newer 64-bit zone actions anyway.
+		 */
+		trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
 			return;
 
 		tracing_record_cmdline(current);
-		switch (bt->version) {
-		case 1:
-			record_blktrace_event(ring_buffer_event_data(event),
-					      pid, cpu, sector, bytes,
-					      what, bt->dev, error, cgid, cgid_len,
-					      pdu_data, pdu_len);
-			break;
-		case 2:
-		default:
-			/*
-			 * Use v2 recording function (record_blktrace_event2)
-			 * which writes blk_io_trace2 structure with correct
-			 * field layout:
-			 *   - 32-bit pid at offset 28
-			 *   - 64-bit action at offset 32
-			 *
-			 * Fall through to default handles version==0 case
-			 * (from sysfs path), ensuring we always use correct
-			 * v2 recording function to match the v2 buffer
-			 * allocated above.
-			 */
-			record_blktrace_event2(ring_buffer_event_data(event),
-					       pid, cpu, sector, bytes,
-					       what, bt->dev, error, cgid, cgid_len,
-					       pdu_data, pdu_len);
-			break;
-		}
+		record_blktrace_event2(ring_buffer_event_data(event),
+				       pid, cpu, sector, bytes,
+				       what, bt->dev, error, cgid, cgid_len,
+				       pdu_data, pdu_len);
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
@@ -1913,6 +1873,12 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
 	bt->dev = bdev->bd_dev;
 	bt->act_mask = (u16)-1;
+	/*
+	 * This sysfs-enabled path feeds the ftrace blk tracer, which always
+	 * uses the v2 (blk_io_trace2) format. Initialize the version so it is
+	 * never left dangling as 0 for future consumers.
+	 */
+	bt->version = 2;
 
 	blk_trace_setup_lba(bt, bdev);
 
-- 
2.51.0

