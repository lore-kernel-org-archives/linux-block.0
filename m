Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F5284690
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259060; cv=none; b=UsMof6ja2SETTH96/uJTs9HdF2g7/p5h4tDE+s9viPyLzV1DLJ6NU4bpbZNydVcAQj7RneTXTc7LyHK/+zzcimL+2PX1z1aWbhC39Mv7d/22cjMMMj5fuQ5IzIFU+0EDY5v5iPgOl3m65jf4mEc93Ij1Cka0kJEzE0UBEnrscCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259060; c=relaxed/simple;
	bh=AKFO+6kMRIf999SHyvoUrdjxxCfFmmXdHeh9Zljcz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJQ4HqLVNcWscPQzpknc5oEqKwliT+b7TgBtX0l+ht14u0/4SsCP5cEH/fKCdDgL77VqgsJqKi8Y4Ey66/SZ4c+VszSz39GRCtSU5dy8vaWyhiBOaYgkDjSTyn7SgQ8S+yyG8cNkJWuU6TBNKpy101Jf9rLFLZ5IqpSUKvlu8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=A/TeS+UP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="A/TeS+UP"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso87243b3a.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791259056; x=1791863856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=A/TeS+UPM7Hf6RVDsa6bMDIVInNY/OFvGiGMCyc/V8mzMOsZMJNDZhLqy7nhZ8jJ51
         cse1/L0bshLdtxVk0IG11eJSwm6VuMaM28U2klq0L9gR60tarieqrqZ6f2YhzjZ64gF/
         smYqw6yQ9U++fGglI6kxfBy+Vc/xNwbV39CwR/HiVuTiYt7fdbnvbuSjHcSXwSkgGmG6
         fd6J7ltLV6jarhA8c6M56S2D7oIe5zzyRID6LLQMWxU/fEZK5jWFaGIcIQ1umZNqyPlk
         zUT03frKTf5Q1V/xepxwYE8Lu53Ln2gAiusd5GjabK34jsZpZq56MjhNCbQFLvcNfvgk
         FHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791259056; x=1791863856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIg2j8cR5l8EWHD0aFToxc23c2wafCfRdD264dRHKCg=;
        b=B222IO8lrrXZimQZxaEG2Pmt+1A7td5AZBonKBefYOXWxp64NzYr1NrTJS2B2mNlJy
         q4UYQSfnPpoj9QS0aJhOTqBONdyyS7DMPVBf4yHLNmeBqduWj5wk37LAb1I/aFAaMKBK
         5BRhSA2RbQ2hZBxX/Lw58/w2TV/rLlPVyzzAFG55RMgD9eSuyaTrUtCUSW2FMZ6g27la
         Q8EHzB2p0Mh/RtJcNpxABOQBNcn/1jL+/1FGDjF52npbBvP6PDZHF/wQk7qOkGLFTlz/
         1C4SGhInoC+VxKxUL7/BAbfrzHYTfiRIAj6x99R6ErjbC7D/H+3+Lp2Qb0IRtYmzZDSV
         gNsw==
X-Forwarded-Encrypted: i=1; AKwUvBx2GtOeaLfNka7MxXVd7p4QgvM4Z4oVy3nTY9NlcJPIvJHJJieR4qRnP2SqmBcbl/xfYoQMLolJ/vc+KA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK4aGDC5LlDexZy8bi8p3R1u6etEwwqwM/WF08QBO3WyK3qN8V2
	qVEH9nDv0F6KLcuivwkE00PpNTGecCGqz32FcoFZC8nAE2/p2RBHQBfqJQujaPUfofQ=
X-Gm-Gg: AYBFou2avQqg5a1/xx8oEJfdFJfItRAR4TQ4ZGWeDqqPXA2Eg7J7T3M+EQB23dxeKmN
	NPiJFN87dZNi7mqjzDQZXhJ2OUncY46163CLPKyJ58RMiTmDmWgIiLHsnxdwyEz71iODIV1yRcY
	NofGtJndbv7GftC8W5MO8eUi7sy7HyUh97OkEZZE3me925ovX1aRNp4RHzHC2Cied01MACbxCWm
	5Qh0DqSfmBvzHB3ypbagG7vsqrfNjuYnG9AMmssAXrsJ37j1fJ4y8EDLb6uqvCDwTfiseRNbXDh
	SAcaSjJ55vnjrZoLYNJ0ODQ+O5XvhpKLHrQxwPUH9DTdzycVICwfIkSDRKTLt68O6A0RpPWJIdB
	VebLVqnMAGs+9BB0NPa6TM6MSb5rXl4SYmKx9kGQk2dfEd3uu2acHfEORA3JMoybUFLLXzwJBGG
	tPVtZE1pW/UqcvuSwOPVrgnm+WjIXnKj5yd9VIaPndFLACgnzyTp4nWcZ9/neUY34V9wPnBbdye
	RbjwQyW3ACWhH7Cv4rRRg==
X-Received: by 2002:a17:90b:3d43:b0:3a0:7591:ad7a with SMTP id 98e67ed59e1d1-3a8726b57a2mr111120a91.5.1791259055781;
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853e66d7fsm2543601a91.5.2026.10.05.20.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 20:57:35 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 12:57:13 +0900
Message-ID: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The upper bound
(e >= c->bm_bits) is only checked in the branch taken for a set-bits
(toggle) run, so a clear run advances s with no check at all.  A peer can
make s run past the bitmap with a single run; it is stored in
c->bit_offset unvalidated, recv_bm_rle_bits() returns "not done"
(s != c->bm_bits), and receive_bitmap() goes on to the next packet.

The following plain P_BITMAP packet computes c->bm_words - c->word_offset,
which underflows once word_offset is past bm_words, and drbd_bm_merge_lel()
turns the result into an out-of-range word offset.  drbd_bm_merge_lel()
only WARN_ON()s that and proceeds into bm_word_to_page_idx(), which
BUG_ON()s on the out-of-range page index.  A malicious or buggy peer can
thus panic the node with a crafted bitmap during the bitmap exchange.

Reject a decoded offset that is past the bitmap.  s == c->bm_bits is the
normal end-of-bitmap signal and must still be accepted, so bound with '>'.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..b3da2bcb646a7 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4559,6 +4559,11 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		have += bits;
 	}
 
+	if (s > c->bm_bits) {
+		drbd_err(peer_device, "bitmap overflow (s:%lu) while decoding bm RLE packet\n", s);
+		return -EIO;
+	}
+
 	c->bit_offset = s;
 	bm_xfer_ctx_bit_to_word_offset(c);
 
-- 
2.43.0

