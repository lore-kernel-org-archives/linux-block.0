Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23839182C
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060428; cv=none; b=G6H6LObcvBuXzjPCOLEXFDyhfDx5uebjuO0cpW5pPkl76T1OB3NBaV61MhEsF4PKpb2ZGEqU+YZ5aix1nGowko7a7Gx929jh3ot1g3Wx0uD0hMAtW4jN+Bn8UL4ABqJGSpJYByLcSnBdCdROO43ZClOproTnW6nyELz85KAe0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060428; c=relaxed/simple;
	bh=8xJ3Bno2f7K9RyTiCHfv8Hum/iKEj0okL/CRt1vRS8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=apmTAcqCTy3kC+OHPBkN5+2WKf+XmXsk4GUupRGMUmAr0Sn+4RxIQZJrragJCSsRosnLdC4vOaRZvtjstS6h6wrO0lCgcVWweTT9ejtBiR5dpbkByc6Kwp0a+2cS/ttnSgDtuIR2TmsgMnKqbTxHm3I1AMNG4wff2ehwDBzWzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWKTOkvf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWKTOkvf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f206f2b54so483440b3a.0
        for <linux-block@vger.kernel.org>; Sun, 12 Apr 2026 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776060427; x=1776665227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xGYynR6r25XFEHisSmxEo6/BK/p866fHi4Bq8os+Ow=;
        b=dWKTOkvftAgFgXuedeSkqCOT966YRFqCpWPskIeGZiS8pRbJmA1VIzaA8hkM7dD73y
         ahq9hfu4EJRUUwWR/bx5BVEZZOqug3+GljzsRm7nKb+v8PVUnO3gZEnlbAylc9bs2ZjR
         4GCvnOIxKEBphfQK+p7+LAx+oPeTb/j5FXRrag+mf8xpBlGz1GLeKeK7LeIamIVhluRJ
         8kBx0BrR8EAKrZJiyUm8WWgmhkz7/gP3SxJkYLd/wJF4lo/ssPvREZgnHYFkk07wZfoK
         YzXHAsRu+KRyUPBWh1lMYxEW3ZowR3pRLKbLqD0WA8opnLRB2I2Gos86gTbkXLkKe8/e
         GUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776060427; x=1776665227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xGYynR6r25XFEHisSmxEo6/BK/p866fHi4Bq8os+Ow=;
        b=IUoo7Q3cGktFaEfof/cMOO8Hzkmxni9lgbDCVRau4fei3XjwWJ7Hfbz+RUAgvMiWWr
         tPxaQFHnBXzIRyXAq+rWslJNyC6b2p76XJjIt1FWWbXF7F0ABb3DdtbZEJOumN6QAOer
         GO/4q0+PbxoKgJTCQvMLhRc1lM1vnyhxDCz0rG/39taORsaPKJGV3TAc94N8nXA5Or99
         H5yzeNOk4/P+V/SAIi/KLW4GcKr7HT/fsB1xW2TVGj1uhl45ytrpLfnD94cQI5q0twqE
         VsL/F6jpYwrTx5AjRk2YSNKg6XJClmRxkgazCNhqSsADOkZcP4ldLwlgP1prdz4mKISb
         EBZQ==
X-Gm-Message-State: AOJu0YyfvVDjpGpz0A1j/uH4TDUxyS4GcZKcYenyb8sEdRZJYcPxyNdz
	PHwuHhId3L8VXIb+bgqhH8x7SjMK0PwhWLDmuNFNyPVIlJaspb9gwMiL
X-Gm-Gg: AeBDieuzyjNeLYPvoWiiKujfRLayq9iOMkK0LSzfaDYQazeTdPEcvW72fHV7VpwRq5D
	LhqMjWRhXy1Yc3y3qcpGPUu6vx7V2U+mPsZMv7uQWPmXNHMCkT5sC51vKGhIEPLwpZADjSTqwou
	3hY8dh4Vu4rhZA0OqPKXiXxhsX+q7YuVHN4K7wEYZNFCC+XNVqrnwG4gRRxmHYCJOQHG5on//Lk
	1xbbyZF4TR7yWKfRk5iHCLGUko+Ba1DNsa900JLn6H26EPzg3Cd/VYgvp+9YjTbVxK+1ZKrUvMg
	N6uvBqMb2h9/Cs376ezD7z0Uhb6td1RznDMn6xdUKiFd6GzIEHRJhMQhhLDT/fAOyng4LD9uNGq
	0MHyi0UvNmoPQdQwt1BSp65QuK/csObY7zAFaJ6ekj56hnyHa45gugFZT638y7vd4UFqGtLiZU7
	a3DKCidT3/ZvfGiShAxIEsu+OLlM/NFnTKmEXQYg==
X-Received: by 2002:a05:6a00:1d96:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-82f0c2dc498mr12541247b3a.49.1776060426545;
        Sun, 12 Apr 2026 23:07:06 -0700 (PDT)
Received: from manakaao.dns.podman ([104.28.211.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm12531053b3a.48.2026.04.12.23.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:07:06 -0700 (PDT)
From: Wang Haoran <haoranwangsec@gmail.com>
To: viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>
Subject: [PATCH] iov_iter: use kmemdup_array for dup_iter to harden against overflow
Date: Mon, 13 Apr 2026 14:06:55 +0800
Message-ID: <20260413060655.1139141-1-haoranwangsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While auditing the Linux 7.0-rc2 kernel, I identified a potential security
vulnerability in the iov_iter framework's memory allocation logic.

The dup_iter() function, which is exported via EXPORT_SYMBOL, currently
uses kmemdup() with a raw multiplication to allocate the duplicate iovec array:

new->iov = kmemdup(from->iov, nr_segs * sizeof(struct iovec), gfp);

The hazard here is that dup_iter() relies on a primitive multiplication without
any integrated overflow check. Since nr_segs is often derived from user-space
input, this line is vulnerable to integer overflow (on 32-bit systems or
via type narrowing), potentially leading to a small allocation followed by a
large out-of-bounds memory copy. Furthermore, it allows for unbounded memory
allocations, as the function lacks intrinsic knowledge of safe limits.

On the 7.0-rc2 branch, several high-impact callchains still rely on this
exported function:

drivers/usb/gadget/function/f_fs.c:
The ffs_epfile_read_iter() path demonstrates why relying on dup_iter() is
dangerous: it performs allocation based on user input before verifying driver
state. This confirms that dup_iter() must be hardened internally as it cannot
assume pre-validated input.

drivers/usb/gadget/legacy/inode.c:
The ep_read_iter() path illustrates how dup_iter()’s lack of boundary awareness
compounds resource risks. When combined with other allocations, it creates
a multiplier effect for kernel memory pressure.

This patch replaces kmemdup() with kmemdup_array(), which utilizes
check_mul_overflow() to ensure the allocation size is calculated safely,
hardening dup_iter() against malicious or malformed inputs from its callers

Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 lib/iov_iter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a63c7fba..63aa8b6e3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1224,13 +1224,13 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
 	if (iov_iter_is_bvec(new))
-		return new->bvec = kmemdup(new->bvec,
-				    new->nr_segs * sizeof(struct bio_vec),
+		return new->bvec = kmemdup_array(new->bvec,
+				    new->nr_segs, sizeof(struct bio_vec),
 				    flags);
 	else if (iov_iter_is_kvec(new) || iter_is_iovec(new))
 		/* iovec and kvec have identical layout */
-		return new->__iov = kmemdup(new->__iov,
-				   new->nr_segs * sizeof(struct iovec),
+		return new->__iov = kmemdup_array(new->__iov,
+				   new->nr_segs, sizeof(struct iovec),
 				   flags);
 	return NULL;
 }
-- 
2.43.0

