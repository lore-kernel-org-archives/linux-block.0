Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB32765D7
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268318; cv=none; b=nxei17Z4+cMvFSS/jX+VPOIYbGzXWk1VIBHxHK+rGma7vfLiHxYWYzWvEYSBccIppQMWkO7c/ar3bNBfhpBP343Ad5iZZdfFE4Sbukm/2H+B5LqvSG3xKxCuUuJEWXg61H74bAhZcNoFm6YuvbwJGB1VWoGfpquhh1rLok7AEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268318; c=relaxed/simple;
	bh=AggbHlNlS2wRgnp/52kFEhrWoD5wMPtJZEBYqJ5/O0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSZcwrGWfyMol22l19yJss6tdm8t1miWh9Sdlo8AjwGT/lNBtNRmALs0QKSNUtp7VScpKhP0UV5TVKtlWFxDAsty69IoXcqnnFQKlEdwLSaH80mpe05L4w1464fOwbUmdQcOHknPzVCeehg5WdCAEGYA3hVvoBSfAGaLRpC9qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhfKd1Uk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhfKd1Uk"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c5so1055532b3a.3
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 19:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789268316; x=1789873116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkNvKOxozlLmolowDJQsMyoByil3F96EgYKhJ/Nv9Lo=;
        b=IhfKd1UkSbJeBggspUq7h1856Y4vRkph2fxUMX5fY1RctctK3b2iMz7V7r4P0+WH7g
         Fjh1upuaov+mIAS/dbIZAps0UzYW7O+/DB3kHFjFlQ2B2NSO7J11QmJ16uc3Vh5vMuBI
         Pgx9VwvzRlDePWBnP96/wyt+G/V9GTytCKCB1pMDcZRv1juSl7Q3pfNzsFT4dEva6QZb
         YrnE8QS7U6IrI0cxlRvkImLfEYtTY5h2SLiuyjF7JlujgXzVaYEExr+2456JNrkhhEqF
         W9iMWRVuydYQ8nRm4rIHqffmFL6qf41aUZmBm9gFkbhf15E75N5djv+ISX88K0/QuqmY
         VlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789268316; x=1789873116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkNvKOxozlLmolowDJQsMyoByil3F96EgYKhJ/Nv9Lo=;
        b=HXb+H2WBYB0QxY7Q5jF3k7Jq8QAULZ3YGn/zh+qU9XOOc0i+vQum7TUPqk51MTH2h5
         Uy/YMvtFRjsI+5kmMNZUsa7l6T/jnYCqgNwtbTq1tFZIn9WK64p5oKgLB2amSvo/lDbN
         FyrzyKvx82J30+PaI9E1BBG/cWsHdqIk0BZdkaGyfvM4JjEgD2ZQC7vZbV9AnOL1mIcP
         COpLx5O22wm9wK85XMUJLkzHLY9Bcxy+BmMRWajE50z3CKgmL80yQ8ndsv1ITMp9aep7
         U+ljsHRhoGcUCoJG6Z8ecXsQxVm6//juJJpQH1BweipdNakFXLihhttqA4WRyMK1khzy
         SM5g==
X-Forwarded-Encrypted: i=1; AKwUvBx5tFH33ew51/xAO10tshppgmt6LMjsHGQp/+7cC+/p0Pp1H/F6BTZSGXlwlpaGXriCq6bGX5tmQ6H10Q==@vger.kernel.org
X-Gm-Message-State: AFuF++no7nns1oZ+j+h3K+PA2aymZoSVbPDpASVux3YgNDycBLpCyR5c
	CsnX2ZOU8vCJc/pawdeNHihifohdSSbJ8BsJ61xkyWtT8PXerjU96PU=
X-Gm-Gg: AYBFou2kQmG6AQfffW5Bv8xeKunFtp95hm0gTpeC1d4Av2f5gysrkz5tdJQatoXcEqW
	kgUFSXO+M8JIlfbxkNUfUzbjyePLZsXQSvzRHhyJw+9pwSK4pB50kpHAYLfMt0uB5EZ0uPTf4sb
	S4DzV9Yj9dbWhurY0rhtqHoSYfCkGayhx/5/bd11nPlhYoTCA2IylGfEZqk/UXWG9ZvHb/2QrUv
	La5W+T0+auAoAd/xQwykeZv2mSznX5WTu88I0y83q16mKO4i5KderN5I7lweTm0Q2zOe0/lq3SV
	8GeGag7ezVvQSFD41D+yvnGU9gNCmd+kV5lZjx5V2eBi5k6T3jdZ764dgbwO5Hb9s55X1jWLEjG
	332/yCH+gcI19nssagwv3z5eTni9Yr4WyB4N8UUZwiAjCSpIMgHiZ7oKBjNN8vFKCVTvwKgtxkC
	Ya/xGqXO8eyg4chATZRy6ofYdI9hqX75pr+qI7YIr+7w9JFdH+j22MNf5xlfs6BmvGRz9Y6hvze
	IcIknRQFFhKae5dPc5wQctEUg==
X-Received: by 2002:a05:6a21:6f88:b0:398:8870:b58f with SMTP id adf61e73a8af0-3daed319787mr20832624637.14.1789268316064;
        Sat, 12 Sep 2026 19:58:36 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c657156bsm3022673a12.21.2026.09.12.19.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 19:58:35 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f179b16e13624138b0f1@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH] blktrace: build the synthesized v1 record from the entry's own layout
Date: Sun, 13 Sep 2026 11:58:27 +0900
Message-ID: <20260913025827.457116-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_synthesize_old_trace() emits a classic blk_io_trace for the
binary trace_pipe output by copying 32 bytes from the ring buffer entry's
sector onward into a struct blk_io_trace. It reads them at blk_io_trace2
offsets, and the two layouts diverge after bytes: v2 has a 32-bit pid at
28 and a 64-bit action at 32, where v1 has a 32-bit action at 28 and pid
at 32. On a v2 entry every field from action on lands one slot off, so a
consumer reads the pid as the action, the device as the cpu, and the cpu
as error and pdu_len.

The PDU comes from the wrong offset as well. The copy ends at v2 offset
48 + pdu_len while the PDU starts at 64, and the emitted pdu_len is taken
from the v2 cpu, so it reads 0 while extra bytes were appended and the
consumer resynchronizes on the wrong boundary.

The entry is not always a v2 record. __blk_add_trace() reserves
sizeof(struct blk_io_trace) when the trace was set up by BLKTRACESETUP,
and on such an entry the 32-byte copy is correct. pdu_len is still read
at v2 offset 50 though, past the end of a 48-byte entry, and drives an
unbounded copy that desynchronizes the stream. That is what syzbot hit.

Take the layout from iter->ent_size, which is the only discriminator the
entry carries -- magic and sequence are the ftrace header, not a version
stamp. Assign the v1 fields from their counterparts in that layout and
append the PDU from the end of it, bounded by the entry size.

  BUG: KASAN: slab-out-of-bounds in seq_buf_putmem+0x124/0x180
  Read of size 1352 at addr ffff8880295bdb98 by task syz.2.2551/19243
   seq_buf_putmem+0x124/0x180 lib/seq_buf.c:241
   blk_trace_synthesize_old_trace kernel/trace/blktrace.c:1780 [inline]
   blk_trace_event_print_binary+0x130/0x1b0 kernel/trace/blktrace.c:1788
   tracing_read_pipe+0x568/0xb50 kernel/trace/trace.c:5444
   vfs_read+0x213/0xa80 fs/read_write.c:572

Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
Reported-by: syzbot+f179b16e13624138b0f1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f179b16e13624138b0f1
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
QEMU x86_64, KASAN, virtio disk, base 5225b8eec4c9. Binary stream read from
trace_pipe with options/bin set, decoded at v1 offsets.

v2 entry, via /sys/block/vda/trace/enable. Unpatched, offset 28 holds the pid
and 32 the action; device, cpu, error and pdu_len are each one slot off.
Patched, every field is in place: action 0x08110001 at 28, pid at 32, device
0x0fd00000 at 36, cpu at 40, error and pdu_len 0.

v1 entry, via a BLKTRACESETUP helper -- the only path that sets
bt->version = 1. Unpatched, the 48-byte record is right and eight bytes are
then appended behind it, so the next record's magic no longer lands on a
record boundary and the stream never recovers. Patched, the record is
byte-identical and the 64-byte cadence holds across the capture.

PDU-carrying entry, via BLK_TA_REMAP from reading a partition. Unpatched, the
record says pdu_len 0 and then appends 16 bytes taken from v2 offset 48, the
error/pdu_len/pad trailer, so the reader resynchronizes 16 bytes late.
Patched, pdu_len is 16 and the bytes are the blk_io_trace_remap:
device_from 0x0fd00001, device_to 0x0fd00000, sector_from 0.

Not exercised: the splat itself. iter->ent points into a ring buffer
sub-buffer page, so KASAN sees the over-read only when it crosses the page
end -- the entry has to sit about a kilobyte short of the tail and be
followed by an event with a large time delta. 120 rounds over varying buffer
sizes did not land it. The over-read is visible without KASAN in the v1 arm
above: those eight appended bytes are out-of-bounds data.

__blk_add_trace() reserving a v1-sized entry at all is a separate defect,
fixed by Adriano Cordova's "blktrace: always record ftrace events as
blk_io_trace2", <20260903202932.156278-1-adrianox@gmail.com>. It cites a
different syzbot report, but removing the short entry closes this one as
well. Once it lands every entry takes the first arm, so the branch can come
out; the field assignment is the fix and stays either way. Until then the
second arm is what keeps this function from reading past a 48-byte entry.
 kernel/trace/blktrace.c | 48 +++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..455d761ff84e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1768,17 +1768,47 @@ static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 
 static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
+	const struct blk_io_trace2 *t2 = te_blk_io_trace(iter->ent);
+	const struct blk_io_trace *t1 = (const struct blk_io_trace *)iter->ent;
 	struct trace_seq *s = &iter->seq;
-	struct blk_io_trace2 *t = (struct blk_io_trace2 *)iter->ent;
-	const int offset = offsetof(struct blk_io_trace2, sector);
-	struct blk_io_trace old = {
-		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
-		.time     = iter->ts,
-	};
+	struct blk_io_trace old;
+	const void *pdu;
+
+	if (iter->ent_size >= sizeof(*t2)) {
+		old = (struct blk_io_trace) {
+			.sector   = t2->sector,
+			.bytes    = t2->bytes,
+			.action   = lower_32_bits(t2->action),
+			.pid      = t2->pid,
+			.device   = t2->device,
+			.cpu      = t2->cpu,
+			.error    = t2->error,
+			.pdu_len  = min_t(size_t, t2->pdu_len,
+					  iter->ent_size - sizeof(*t2)),
+		};
+		pdu = t2 + 1;
+	} else if (iter->ent_size >= sizeof(*t1)) {
+		old = (struct blk_io_trace) {
+			.sector   = t1->sector,
+			.bytes    = t1->bytes,
+			.action   = t1->action,
+			.pid      = t1->pid,
+			.device   = t1->device,
+			.cpu      = t1->cpu,
+			.error    = t1->error,
+			.pdu_len  = min_t(size_t, t1->pdu_len,
+					  iter->ent_size - sizeof(*t1)),
+		};
+		pdu = t1 + 1;
+	} else {
+		return;
+	}
+
+	old.magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION;
+	old.time = iter->ts;
 
-	trace_seq_putmem(s, &old, offset);
-	trace_seq_putmem(s, &t->sector,
-			 sizeof(old) - offset + t->pdu_len);
+	trace_seq_putmem(s, &old, sizeof(old));
+	trace_seq_putmem(s, pdu, old.pdu_len);
 }
 
 static enum print_line_t
-- 
2.53.0

