Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1735E1D5
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290163; cv=none; b=b+tpsTSMa6r5jo3k4t8HxiuZGiVBSdofblrjZRAiGmYNPln+YoFvQzp5/1fyYRqIKm1uBHEO+CRl0MmBV/FvEq8ZOZpMOXXyQu1dwmGug9IdptGJJm+3spXcQ9aEmGlDv6lbSGl0MsPmHh/NZjaXsIxzvsfBve7M63A7o8uLMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290163; c=relaxed/simple;
	bh=JkrUHzTm2jW7khHbM99EuDPTNWDcljhw3EFcnkkw0fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfXexFlcVyyUQzOhrlTIw2h2hNEzLpBlS53twmmfVFWaLQfU5CPETyVFxQKpxR1bk1E+OLvXiq4cR/BLQPqG1iuhg54LXIBbK9KMwX6xUcnT9p3c66Ij1ZGZEhAQwvYYqANRrCn/V1RJtdUdl+FTZzzc5CKOHglN9IEkMiwHBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvccRwFO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvccRwFO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so1805275a12.2
        for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789290161; x=1789894961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJPTyTqu2TRVdmgNC7HgINfF2pPJkmCQHX4itENndTE=;
        b=fvccRwFOMmxYK6LwwE96O4Kr8RC/339fJCXgAXwTeKwuF+Q1x0H8USWGTy10wGzqmW
         FNvj2mubzPz7xeFrbrm+5hQ5WOKTErlgYNv+efGfg7d6aRFW6HC6scwSD4wZ73L5zxhu
         cCGFeSSpJVnit2Xiu841phhstteNUALslLpEhEXZZRJfABwvA9m4iDhlvJJuzK9TV9qr
         S5dYheTDwjBophLUBKGFHVAqDkt7fYWhkqJ6mUs9yVo/iHUOMsIXCPGprstwOdJD3VHj
         JOXSxllrbUc9agxOStNHA15tv8PBMMtLMRRagiaZAGytwJfVFRnkGw2HJwYbUXXcbC70
         ABzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789290161; x=1789894961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJPTyTqu2TRVdmgNC7HgINfF2pPJkmCQHX4itENndTE=;
        b=av688R+l/Q1Q1jtmt0UM6jTh3FkwBfx3W7+EsB5vW4KylZF8lbXQVk0PrT13XacTML
         9MtH86JxNNR5Vn/pDwb9rXa5+BT179Dx3TgbiUrBp4Jv63WATQ7bfguP014Oh27LwZnu
         VxEozddFNwXmCIAxF6Z8K4FLZaCPb9zsUlVzxV2fbWEnZm3fQiKGgtILA15exkpuihVb
         d6dabVflBunVg/mKjaUjXTMnAirnFnB/DOU0djgYVDtEufgUj+4zmIuZ6qBMqYdVe1Op
         Er/RRvI0hSb1Ux4gc2fvD5+sJ8mz5cMP/TyWeBRvQiMoR5u1fr3b6c630lF6W5Xob1Vk
         sxlA==
X-Forwarded-Encrypted: i=1; AKwUvByZTxDGZkJ3tv98pJmta9bxXGqMlxQi+UiatX0wO+q29DVQgBusYbys4DZhGnm6rwSeJpxfwbyXmeDGCw==@vger.kernel.org
X-Gm-Message-State: AFuF++ko/WORYZvQkqS/+Y68h0J3lGwKd8y4hb++Hty5hchGc/nX29Et
	GBhRhr35GMhmFj2kun+jPf+x0Rs9II12o74U0T7n+GQd0o2cio0gifU=
X-Gm-Gg: AYBFou30lr1i2R1W96L2AVXZsEREANv44sOzRkuWGVMPCGkYMvtCisK3B5lSESov/5P
	jNUawJVP9TSXb800Sh1INl4ZCquI5arLNFM5p8BG7n+jApl5NT7XaN6ShMhiXxYYjvgGLydBwf8
	Cb8m0vDMxuRvzZiaq8EK8249l30Fo4uafdKB12AuOoUw6cMdnrdqpZzTkru1cmL5gJZXPnYFAsI
	+HZnDH9KIG5p1ioKyU1xQ6f6UNTVjl0XlIybvqkCCbU3GVS108T/sDhFxYrN+BvAFdCA29Hf7+D
	QKyFXr1jU+oBnX+s3YPseW69dooA8HAxZ/1dwjH5SWIV+bMLJu1jDPJXDaG4+kk3a8cgK8tKdMi
	ghnN9zxlzv526nDbEqZbgAyEn5Hwwd+FJ4IO8TKynxj4D82UaNrtLpE5+AY8MOq9r1g/Jvq84gr
	SMGVQW4PsxHD5oc1DczdzwdK0PYBjR/RDNgLrk+Q31hTl4gLJNqQSi5p9n92Af93lYQyLowXUkE
	mhAP6YH90DmSiu+vOhVvBlceg==
X-Received: by 2002:a17:90b:4b83:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-39d9bd67a22mr20972507a91.8.1789290160872;
        Sun, 13 Sep 2026 02:02:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95092c06sm14711702a91.4.2026.09.13.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 02:02:40 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Adriano Cordova <adrianox@gmail.com>,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v3] blktrace: fix the field offsets of the synthesized v1 record
Date: Sun, 13 Sep 2026 18:02:32 +0900
Message-ID: <20260913090232.715798-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_synthesize_old_trace() emits a classic blk_io_trace for the
binary trace_pipe output by copying 32 bytes from the ring buffer
entry's sector onward into a struct blk_io_trace. The entry is a
blk_io_trace2, and the two layouts diverge after bytes: v2 has a 32-bit
pid at 28 and a 64-bit action at 32, where v1 has a 32-bit action at 28
and pid at 32. Every field from action on lands one slot off, so a
consumer reads the pid as the action, the device as the cpu, and the cpu
as error and pdu_len.

The PDU comes from the wrong offset as well. The copy ends at v2 offset
48 + pdu_len while the PDU starts at 64, so for any event carrying one
-- BLK_TA_REMAP, SPLIT, UNPLUG_*, DRV_DATA, BLK_TN_MESSAGE -- the bytes
appended are the error, pdu_len and pad trailer rather than the PDU.

Assign each v1 field from its v2 counterpart and append the PDU from the
end of the v2 record.

This applies on top of Adriano Cordova's "blktrace: always record ftrace
events as blk_io_trace2", <20260903202932.156278-1-adrianox@gmail.com>,
and needs it. Without that patch __blk_add_trace() still reserves a
48-byte v1 entry when the trace was set up by BLKTRACESETUP, and nothing
in the entry says which layout it has: magic and sequence are the ftrace
trace_entry header and neither writer fills them, and the two sizes
overlap, because a v1 record carrying a 16-byte BLK_TA_REMAP PDU is also
64 bytes. Removing the short entry is what makes reading the v2 layout
unconditionally correct.

Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
Link: https://lore.kernel.org/all/20260903202932.156278-1-adrianox@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Note: this applies on top of Adriano Cordova's "blktrace: always record
ftrace events as blk_io_trace2" and is not correct without it -- please
apply it after his.

  https://lore.kernel.org/all/20260903202932.156278-1-adrianox@gmail.com/

v3:
 - Drop the min_t() bound on pdu_len. Both TRACE_BLK producers reserve
   sizeof(struct blk_io_trace2) + pdu_len + cgid_len, so the entry is
   always at least sizeof(*t) + t->pdu_len and the bound never clamps.
   sashiko-bot read it as an integer underflow,
   <20260913064414.01DF31F00893@smtp.kernel.org>; that needs an entry
   smaller than 64 bytes, which the patch above removes.
v2:
 - Drop the iter->ent_size test v1 used to tell a v1 entry from a v2 one.
   It cannot: a 48-byte v1 record carrying a 16-byte BLK_TA_REMAP PDU is
   also 64 bytes. Caught by sashiko-bot,
   <20260913031030.E85191F000FF@smtp.kernel.org>.
 - Drop the syzbot Reported-by/Closes. That report is the unbounded copy
   on a 48-byte entry, which the patch above closes, not this one.
v2: https://lore.kernel.org/all/20260913063155.708520-1-donggeunyoo.kernel@gmail.com/
v1: https://lore.kernel.org/all/20260913025827.457116-1-donggeunyoo.kernel@gmail.com/

QEMU x86_64, origin/master 2f0c1cf72f46 plus the patch above, one config
and one initramfs across all arms. BLKTRACESETUP on a partitioned virtio
disk, blk tracer with options/bin, and a partition read for a
BLK_TA_REMAP with a 16-byte PDU. Decoded at v1 offsets:

  patched     action 0x0811000f, pid 0x75, device 0x0fe00010, pdu_len 16,
              PDU device_from 0x0fe00011 device_to 0x0fe00010
              sector_from 0, next record on the boundary. Byte-identical
              between v2 and v3, stable over four boots.
  unpatched   the same fields, correct, then extra bytes appended: that
              length is read at v2 offset 50, which on a v1 entry is
              inside the PDU, so it is garbage. 8 bytes in one boot; the
              first record in the stream varies between boots, so the
              overrun is not a fixed size.

Not exercised: the syzbot splat. iter->ent points into a ring buffer
sub-buffer page, so KASAN sees an over-read only when it crosses the page
end; 120 rounds over varying buffer sizes did not land it.
 kernel/trace/blktrace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ae010969c144..89d7b707daff 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1728,17 +1728,23 @@ static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 
 static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
+	const struct blk_io_trace2 *t = te_blk_io_trace(iter->ent);
 	struct trace_seq *s = &iter->seq;
-	struct blk_io_trace2 *t = (struct blk_io_trace2 *)iter->ent;
-	const int offset = offsetof(struct blk_io_trace2, sector);
 	struct blk_io_trace old = {
 		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
 		.time     = iter->ts,
+		.sector   = t->sector,
+		.bytes    = t->bytes,
+		.action   = lower_32_bits(t->action),
+		.pid      = t->pid,
+		.device   = t->device,
+		.cpu      = t->cpu,
+		.error    = t->error,
+		.pdu_len  = t->pdu_len,
 	};
 
-	trace_seq_putmem(s, &old, offset);
-	trace_seq_putmem(s, &t->sector,
-			 sizeof(old) - offset + t->pdu_len);
+	trace_seq_putmem(s, &old, sizeof(old));
+	trace_seq_putmem(s, t + 1, old.pdu_len);
 }
 
 static enum print_line_t
-- 
2.53.0

