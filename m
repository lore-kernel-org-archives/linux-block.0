Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5B3093D8
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294185; cv=none; b=QvFxMEkP6nUZgY0pGTcwTnmJTkvNckxPmWr8BDLkO0kC7xbJPZhJERv5jZy450ts+7WuN3tH3qw0K2eywHPqSKh0sfw/tGQLwRr8eWRS2p2g4KlsAQfv52+VOh37KWfU2aVJY2rDTR6yMdaV/XDGkwwq8S6IJjJA7vT1jqb3zIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294185; c=relaxed/simple;
	bh=rWX9tLpT439ZkUyU5JSklqfAGi1B5jDjnnNFwOI59c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgUKg5u1SzVxMRuzbbbm7/Rsm7PU41WP2mNRg7sGw1lv8xAJAkX1MaMqzN+hZdAc+R1GCoap5Y15XKSCLftSgp6lABOu/CmEFibhIFUTVXv1OWljPu1ubi2Z9ST9Z2BRpG0lMdDCdLhUA+0emjfT4nggDfpHQP3ktM4fhwIFgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIvIZw+5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIvIZw+5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4888375f735so72934295e9.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294182; x=1776898982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VuW0UHujS7FYKmPWpTwO67/jv+KNY8d1Yrmd7Hq3jdo=;
        b=sIvIZw+5260+Nk6NO/l1sAoyvgrd8aLdLDqs5Sf0DM/Sh9Cwi73V/79jztVQr7UVHw
         sMZ2SDhtY9mCHerX/zuh46+vDdyIM2uWmB/dH7GYPiWLJo4axG+SG3NSoD/APi+TOGnW
         wlcGUBJMhpkkSPCwravVbSZnaq/O246JU1fid9CAkU1F5TNsLx3tFgG9Eq7FZNKexrUe
         xUWXCdlIzTaDHBv5vpCCYnxmGXGMCbJQdFzrs+K2j0gRrVmotj4sQo17eyWDvdFxay5d
         Gicad8fB7YqapSTQqZ9lMRK++Dz13kx9lxcIKrhzssA3/F3cxvz6PBKfPA2L9xEoPTDQ
         R3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294182; x=1776898982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuW0UHujS7FYKmPWpTwO67/jv+KNY8d1Yrmd7Hq3jdo=;
        b=m1HqC4X+jPdXwYvSbBYab5uHOcDhr7ofi6k0/7JspSj0cFSIcDR8RTUwU32yCHD6jb
         3fgq8jgDGupKoIJBATGA7gW7yNs45Ujq7s/fYJHYjMsQrjbewmrZReCA3LXV6beIAa6X
         NWaE01Uk/0gHb2eB+ZeyfUFkNU1A2H0s/3TLeSVBcyv3mgbfNFThSOEHGGqzUs5qqrei
         6AGnP46IWvWzbbad2/QIklQieZolgyQ7rMrqCUZwy3/IUA8M03acmlQvgJI0VujmGNkO
         Pl3BnxKjS6R7Kh59tW/Gne+F53VDMen6sor1CbgaEhYjhOM/FfLDMJCRfTDW07j/MeBl
         qTgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8m6xT7EhF6TG4bn32ARcY/lIEEDBOMD4tyaiO3hYvW66GOFJKwDMC4/yx8xFJIAyngZQB/lm+4M7e5/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrTqKqnr/IA7h2omwwPCge+9vvo0gI+eXpFKvxXJzzbMSmN1F
	6sXGnwuosjxJ6nusCzoe/JRnAyEbvpBDRMi/SajL8D3E6tBmTPEV87QGDYfAjcAt0NpUgEic
X-Gm-Gg: AeBDievgYUc4F7hmS7vGiD6hl+UTc8Vrd76sLbQlKF07lhad/fod0GrZTzWM2psQ/2U
	EFu854V4tV9y5MVUx2ZvWzwgVHJQaiERh12gErqlbHV3QEgx3xRSkDWhxUH6ZsgU1f87IwQZyBY
	iB3yqBowDRxZhHEOd74ru9r8K7/vTIQmzefU1DyNJuHj80VAZDHsWp5ppHsEk4RkmdBl4PmTKlX
	+n9ma8NzRElc29OaqldK5qWacxzApLEAJbJJ5hNWdMHzOzAHQTOu1U4Y4PkX6kiCTL+KOdwixXx
	E5kXxY2B0uemV374QMgp1YVrunIvg0ZIYN/daj4U5AR83yYoxG5Z1U0j1hqRuyTYPdRrUgI0Dx1
	j9HgQfTOOnbrAzVc3yA+PqdmTcTABsJZVP26Som4tPi2IweDcPFbqEzspXtBvQZxP8bYqXR2elB
	B/a3zY8+CgqgNBqv4g0yzIAmiL4pQo8YdcpxZJhK8l89cYaGuuci4c
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb0 with SMTP id 5b1f17b1804b1-488d6889a3fmr324983535e9.27.1776294182042;
        Wed, 15 Apr 2026 16:03:02 -0700 (PDT)
Received: from fedora ([216.131.111.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827145sm5809155e9.13.2026.04.15.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:03:01 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3] ublk: use unchecked copy helpers for bio page data
Date: Thu, 16 Apr 2026 07:02:46 +0800
Message-ID: <20260415230246.808176-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

Bio pages may originate from slab caches that lack a usercopy region
(e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
check_copy_size() which rejects these slab pages, triggering a
kernel BUG in usercopy_abort().

This is a false positive: the data is ordinary block I/O content —
the same data the loop driver writes to its backing file via
vfs_iter_write().  The bvec length is always trusted, so the size
check in check_copy_size() is not needed either.

Switch to _copy_to_iter()/_copy_from_iter() which skip the
check_copy_size() wrapper while the underlying copy_to_user()
remains unchanged.

Acked-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- rebase & add acked-by tag
V2:
	- update commit log (Caleb Sander Mateos)

 drivers/block/ublk_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 603a98a30989..ef8a0705e68b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1319,10 +1319,18 @@ static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
 
 	len = bv->bv_len - *offset;
 	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	/*
+	 * Bio pages may originate from slab caches without a usercopy region
+	 * (e.g. jbd2 frozen metadata buffers).  This is the same data that
+	 * the loop driver writes to its backing file — no exposure risk.
+	 * The bvec length is always trusted, so the size check in
+	 * check_copy_size() is not needed either.  Use the unchecked
+	 * helpers to avoid false positives on slab pages.
+	 */
 	if (dir == ITER_DEST)
-		copied = copy_to_iter(bv_buf, len, uiter);
+		copied = _copy_to_iter(bv_buf, len, uiter);
 	else
-		copied = copy_from_iter(bv_buf, len, uiter);
+		copied = _copy_from_iter(bv_buf, len, uiter);
 
 	kunmap_local(bv_buf);
 
-- 
2.53.0

