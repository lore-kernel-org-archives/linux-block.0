Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F592D12F3
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281126; cv=none; b=BLl2aOdvWF4CGz9oATT4lChwjNjZdX7RNuUBO9b9ntXENhCmNuXSf+73FUhLnQOGhMtvtAtTX3w882KnmhcU8sR6/Vb/lR2C51Q6QWT1za/YnMRKFb4Usd/k9PqT7sqQFawbXLnxaLPRcxer0dKErxzE95cqxlhD6SK01pZA0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281126; c=relaxed/simple;
	bh=H4ETr6mwXUYrX8RAIMZz7ErNDPXTHuQ7d2Pd0f6oSws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYyCpfrjdBFe1XdzXLtiXeh/1iAdZpHRBfnul4DAlJQ2PRS5HfQ+ZGQgOMcGUrLloyX4SiPItSpgg2HKsjKTXLkhwEavOozbYEUh7IlqgL6ygUwf2VSP1p4hF1ENxKUkQ+tdwY2hvKp8J3l1/MfhLk5ccPGKCjOWshlSSVbpUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opORQWCp; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opORQWCp"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1120583a12.0
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281125; x=1789885925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EIS5RKlZgBWCHN8Ol/C+0jNYOT5tZB/4WMxwPWSV000=;
        b=opORQWCp+GqyypjOmQQmAI4LmM4fcYXniQVTdF+gT2Xt8Gs0GFRHSUTOH1jFTU1/7Z
         Y/3ZHwiWR1+7PplM9mEk8DnrrCTQ5IOKId43l08IHvYrm0eoZZvLVtgEKCDYoxDmvZb3
         E+cvaFZUeMc8UoIxTZNJWWvxh5zC3q3TqctE8K5mmPYeyVQUsVceUWN2b+Jo5FKNM0go
         k3OCCc1dqIcEr970GejCQ0Uc3NmxsdpCcrKcua7T1VYzXjMN+j3uGxhaCejCPdOAPYjU
         HxRWibm1gqztYHZCSWoAaZmbzSxc10q38mvyE422zlRmdoRdWXt6yFAbC7/CgOFV9fvh
         6ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281125; x=1789885925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIS5RKlZgBWCHN8Ol/C+0jNYOT5tZB/4WMxwPWSV000=;
        b=mKjMyLNHH84bN5PBUC9rBOh8hrlDK9VtbxPhfyZVQ767XYvvPIVa1eunG5JerBsTLK
         F9GB6dweoL/VxSOknxC/gCwDXXaJ5s2Fb4YgO7qQVMj7OnVzDOFx6M5qR+JoP/ebLpsa
         F9e1NndCL3wpuGMondoBp4h2f+EfOOk0n+YhhJ+6vH+VeZTDI9pIiPWrZzwE+YpVXudK
         U2WgbkPoJjyeLK/x7OW0mnJUE2qayR7EVa5aZSMiNj0BBMME8/Ld3UwIwMdKxChZgL5l
         VcAcj2H+PFt/J1yJpPmbWbrp2xhIhn1KWUzRYrqpkMv726rKYOqo+BL7nVkmujeeyLNj
         +M/g==
X-Forwarded-Encrypted: i=1; AKwUvBxg7BEIP6kiAHuenQZ4mBcoNqVxOdDalBVG4V2hIjNBaj6NPTV6Y+xQkf6iYj6J51FZFNNQfzPBD5gVQw==@vger.kernel.org
X-Gm-Message-State: AFuF++ljorv3Ma/PxTj8edX67BMYXUK2f+diQfSrzOOKAgsROK/wtMbE
	47WPvBqClf/oYrj9hCXPNNqi4YJpUlwqeSw5xaSw086GX8Q60oOlJVQ=
X-Gm-Gg: AYBFou0/z+4bYy7cVt+H/IFXlT9hkhaVD6DeOrU8xV/RZUHJ8et+IHCoTdDrPkZF+CV
	NeSfvPhgsLMgORyHJU3TWo0e/rdR6ymDh6nuLvj1WwqoXvgIB1OB86j4F77sk1r9ZMVA6J0YbiU
	+GvbkmBu82693WyYqqoKZru/90AOUyR3m+uWuhWKYhrKaO2QweM+19rOy1Q3GXrvOk2EQLEn3eu
	xmX+LnNLwGJu0cBpWxXyo8khQtR4MAfhncopNXhp5RTagnrgCQf9zAfUgoPq818nwnZMvIlzSgx
	OmalfWDMJrycKC2HQVwGtpdjiYuvPFxXtCP9n5ZGGn/tx38oQ/xiVWdEtFpH1bnCsbUuHbGnB6q
	/GtXXKdhBHvxdaPxKddZUXQIBPw4T30AasEO2MrTs7UBtd0k0Am2o5woyf8+cVNUDuB2Q0J2XsS
	6tlWS3U/udkxH+l5oynwA1Ir8SGGC1d5YFy0cnPkdWNRylLcXAvz2nHTHNZbO+99UnaNlQucZ9F
	XAlzxrG++KbM6gQdwrpibRc8tMNuTEwYgfK
X-Received: by 2002:a05:6a21:7314:b0:3da:ec28:2cc9 with SMTP id adf61e73a8af0-3daed3b990cmr22208557637.23.1789281124737;
        Sat, 12 Sep 2026 23:32:04 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6585f94sm3247894a12.25.2026.09.12.23.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:32:04 -0700 (PDT)
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
Subject: [PATCH v2] blktrace: fix the field offsets of the synthesized v1 record
Date: Sun, 13 Sep 2026 15:31:55 +0900
Message-ID: <20260913063155.708520-1-donggeunyoo.kernel@gmail.com>
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
end of the v2 record, bounded by the entry size.

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

v2:
 - Drop the iter->ent_size test v1 used to tell a v1 entry from a v2
   one. It cannot: a 48-byte v1 record carrying a 16-byte BLK_TA_REMAP
   PDU is also 64 bytes, so a v1 entry took the v2 arm and came out with
   every field from action on shifted and the PDU dropped. Caught by
   sashiko-bot, <20260913031030.E85191F000FF@smtp.kernel.org>.
 - Depend on the patch above instead, so no v1 entry reaches this
   function.
 - Drop the syzbot Reported-by/Closes. That report is the unbounded copy
   driven by pdu_len read past the end of a 48-byte entry, and his patch
   is what closes it; this one fixes the field offsets, a separate
   defect on the same line.
v1: https://lore.kernel.org/all/20260913025827.457116-1-donggeunyoo.kernel@gmail.com/

QEMU x86_64, origin/master 2f0c1cf72f46 plus his patch, one config and
one initramfs across all three arms. BLKTRACESETUP on a partitioned
virtio disk, blk tracer with options/bin, and a partition read for a
BLK_TA_REMAP with a 16-byte PDU. Binary stream decoded at v1 offsets:

  mainline    action 0x0811000f, pid 0x75, device 0x0fe00010, pdu_len 16
              and the correct PDU, then 8 bytes too many, so the next
              record's magic no longer lands on a boundary.
  v1 of this  action 0x75 -- the pid -- pid 0x0811000f, device 0, cpu
              0x00100000, error 0xd00f, pdu_len 0, PDU dropped. In sync,
              wrong.
  this patch  action 0x0811000f, pid 0x75, device 0x0fe00010, pdu_len
              16, the correct PDU, next record on the boundary.

Not exercised: the syzbot splat. iter->ent points into a ring buffer
sub-buffer page, so KASAN sees an over-read only when it crosses the
page end; 120 rounds over varying buffer sizes did not land it.
 kernel/trace/blktrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ae010969c144..875c04d86c93 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1728,17 +1728,24 @@ static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 
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
+		.pdu_len  = min_t(size_t, t->pdu_len,
+				  iter->ent_size - sizeof(*t)),
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

