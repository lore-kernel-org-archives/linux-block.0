Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F2470116
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296126; cv=none; b=B4Ggu5wow8J+QhQpV9XbseJcB/X0Nc25vZrhBAedMeZ5bdPkVJS/bSmRpDChKbPBX/J4tqdaXJoUFKCGDO66HLDwcp03ozphRGGZi5WAgUcx2m+AniZ1ZJlszEBUZ/1FoVxZobHpCHWAmkKpkPo7HsMlgNUE/iat5Iho+TR3Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296126; c=relaxed/simple;
	bh=3twLCOUVctvgm+7HXE5YvCiR9KmGS4GbaF3cOWVcIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtcGbgbN+MAi9xDqj6+699kw2ZPi7thx85CBZukDz0yZfYc78pou0/Y9mVH/eG3v5OnE1WE50pR/SSkvJmHJGJBKjSfzFMy2JczzZLLFFgxJyZj7r/zTkTySks5G1r5+ln6lWlV34aEOz8WOlUc/kcslwvolbFPjnIG2SQhtgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=G7RLSNBO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="G7RLSNBO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so368639a91.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791296123; x=1791900923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=G7RLSNBOyl7q6oJ5DCDgFc20nYvj+MuWuWqvWLXjPvhI+jQ9v4a4BfNd0oJ6nOlB5a
         dWKMPgiBndfBGXUcoFeXreslawCRgRRPu7c2oNc776W47h3FYjxmyQLfLcwkHQ5ZqIZy
         rxVHW3ZiaBwUDiCmz/pJamWSiNcdLBVabaW49ZgnXrgZtosyZ7jyHRQQwX2qxfla/4LF
         PXrNib9ED3+y1w7ZxBHPFECdCiZXYFHzKk4iRMJHw3H3mdlJj+j5IR891OWhUm7MYfUq
         OmhAcfw66GqiZ5haQwMFYnB73gEVTehC6XPdxE6sLg52kbCmtdO9Ii7QH2U8ZlxWgs8Z
         DAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296123; x=1791900923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5d+qEg9Unyo+IXTg1hjwRDAAFeW42uTSWnzee3KFft8=;
        b=AJKjz8lMM1duV9l8wayrfktlzgoYFweBMLUhtsqcoGE7jEzUOi4VSn4RP03gIjs2kr
         MgXieghYYrl9U4nu3xM5CF8eRUwv49VKmLGtRGACglscPWiKYysIiLsE5Ud5QOqotsyf
         i4TGlMxtXk1VfdC2w+23zcJDMP4DcIOeNirbkeM79F+mTeRICYsYkfqTRydIYiBbT5sr
         3kOz+IQ5EaL2uGZkHRnysC7I7oo/bVZkophjRb1Cwko2wjMNIzhU8JM4O5SuAoFiOekE
         xeRr6NKkfJMG8yuxv+ExXD9jku5hAaW4y2hKLiRZQSkybpsz4lPvXHo9nyfS0z+IbGp0
         1QEw==
X-Forwarded-Encrypted: i=1; AKwUvBwoNW9uOICaBG5qIZcwZco5TMQDhKikOhPnOEyZIdNZzFN4Gsk8UqY1IPENV7Z6ZIGMXH5aBKrWCnmNbg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7YuqdlgYJa04PBcJvVj4ZGiRMZPo+kEwAzDGh4SKEuEwxyb+R
	Hd0so14gqicEGHYrawXYIxgN8US+b26NmX3jex4aPHqpDSvw86f+NbnSqesAse0DHbE=
X-Gm-Gg: AYBFou0hoHdOxk21C7p+ncV10AM9OYoSNsCzON5QpAlB+IWpLbBXLoONmXT2yOYhAVo
	OhAUOQR9vy46rqdc8KIPexCGxHrspa5zRTwp0xx9p6+HxFVTGquoph6g5lkJXJGSo70ONGdwQnm
	oCm+O5ylPVMe7LqLiVdjnAnGnKPCeA9O9sxoEVGoVgtMU/gNlHO4aMfooOjayLBf3h2WpXxTr/y
	CORdlVZ8Ahy9qwvc82YtQw5y1KJVAnCJCmmN5VoNnORBoLj9W3VDssDkuMt3SR1UiAyxC/gjS78
	4Ru4yrBY4dUqkibR/ai76XFriuvyE3w8+4g9Nk0GeqwoKWdJ9Qt6Tuy4hfSL3JtwzBNV7ix01lZ
	jIL9XFzf5sa190Hi0uzcEvhDkQyI9tht5g3WisM/jxUvaLH87sEAdiSpvgVM6gAR9KDUZlq+MMH
	IOpHZVqRfbVw+6wPGhhv2buv6gGNca2dF64ZNs0WaonpniTEh3mCyKs8osycBKZKEUUrYe4ILAo
	mhOhKQkLt0Imd55UaEMGw==
X-Received: by 2002:a17:90b:4b04:b0:3a8:5543:5572 with SMTP id 98e67ed59e1d1-3a872551602mr689793a91.1.1791296123414;
        Tue, 06 Oct 2026 07:15:23 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:a229:268f:9226:1ba3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm5917618a91.2.2026.10.06.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:22 -0700 (PDT)
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
Subject: [PATCH v2] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Tue,  6 Oct 2026 23:15:07 +0900
Message-ID: <20261006141509.521128-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_bm_rle_bits() decodes a run-length-encoded bitmap from the peer and
accumulates the bit position s across the runs.  The bound was only
applied where bits are actually set: a clear run advanced s with no check
at all, so a peer could leave c->bit_offset past the end of the bitmap
once the bitstream ran out mid-sequence.  receive_bitmap() then carries
that offset into the next packet, where the plain-bitmap path computes
c->bm_words - c->word_offset, underflows it, and hands the result to
drbd_bm_merge_lel(), which only WARN_ON()s an out-of-range word offset
before reaching bm_word_to_page_idx() and its BUG_ON().

Check each run against the remaining bitmap before advancing s.  A single
VLI code decodes to a run length of up to about 2^56, so checking after
the loop would leave s free to move far out of range (and in principle to
wrap) in the middle of the sequence; bounding every run instead keeps
s <= c->bm_bits as an invariant, which also means c->bm_bits - s cannot
underflow.  The set-run bound becomes redundant once that holds --
e >= c->bm_bits is exactly rl > c->bm_bits - s -- so drop it rather than
leave a check that can no longer fire.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Suggested-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: per Philipp Reisner's review -- check each run before advancing s so
    s stays <= c->bm_bits throughout (a single VLI run can be ~2^56),
    instead of only after the loop.  The set-run bound is then redundant
    and is dropped.
v1: https://lore.kernel.org/all/20261006034333.351130-1-yhlee@isslab.korea.ac.kr/

 drivers/block/drbd/drbd_receiver.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a85..1febb5e089cc1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4529,12 +4529,19 @@ recv_bm_rle_bits(struct drbd_peer_device *peer_device,
 		if (bits <= 0)
 			return -EIO;
 
+		/*
+		 * A single run can be up to about 2^56, so check it before
+		 * advancing s: that keeps s <= c->bm_bits throughout and
+		 * leaves no way for s to wrap in the middle of the loop.
+		 */
+		if (rl > c->bm_bits - s) {
+			drbd_err(peer_device, "bitmap overflow (s:%lu rl:%llu) while decoding bm RLE packet\n",
+				 s, (unsigned long long)rl);
+			return -EIO;
+		}
+
 		if (toggle) {
 			e = s + rl -1;
-			if (e >= c->bm_bits) {
-				drbd_err(peer_device, "bitmap overflow (e:%lu) while decoding bm RLE packet\n", e);
-				return -EIO;
-			}
 			_drbd_bm_set_bits(peer_device->device, s, e);
 		}
 
-- 
2.43.0

