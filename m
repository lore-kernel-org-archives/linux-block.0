Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F732ED43
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655249; cv=none; b=cJ5SICFJX99+8pxOAoyRMxzSSk0K1sWxsSf2OX4zuWcntK1UoENfPNDcygbSH5Dc5AuioyJCh96AxrdOEQ8oAaE26tl8ghga0uvtx/R1Qw6ySpUDGldhCwzYxPRD+OnTf0qPEYUZ80amvkdyLoTkl2GNNGdNlem+54ArrovezOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655249; c=relaxed/simple;
	bh=wn1m+br1TBOR784BJGjVu5s+038ns3FcvJsywelK95E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAa4NPlmVYECHfg1I/n40T68uHSQzzQ/ozxS07znzAnDfMAmQhcXOByIkMRV0RYurzBQknGbD/WnJ1IITjZLogfiaP7EnRzOgmHqRm3cC4NVOXTamr2vZWQdP87ICDCModkr1vyIU7GW2oIYm6o6p4VaPPMu051XhWnngE89eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZBg5v8V; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZBg5v8V"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233c155a42so779360c88.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 18:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769655241; x=1770260041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTjwIP2vgqxu7fxZeJC7bZQdu9aLDDe/pDZwtRq1Pfs=;
        b=XZBg5v8VL41X7mxNImL2N4JDtGrh5qYc4zGOQ+eAgVr1UzH0J8QLsRftVeHecvW0+Q
         9Ao0a6t3uS25AOk+5GjYjjcBvrfRLsmTDMe+whRDkuefBCRid9zm4haAzDIUWNypZ7Jh
         R23+Z5wie3pq+bAp/8YBvjLQjD5ZlyIeqPhjHHSd2DTmoD1JfLzd9NUsjW6K+0ovvdj+
         Sb3wmjA4XSNWhiwFH9pNmhKYf4raNGLaYU+QfulUwhOUNvFzIWlXDk0KX7BdrSzgS5fU
         HoYSgoxMQZ9ctKU9SjBDGdS8UoVJjklsg/iVWc+c38DhmIrgVanfdDSBQ+M+Ked72ZI0
         jxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655241; x=1770260041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTjwIP2vgqxu7fxZeJC7bZQdu9aLDDe/pDZwtRq1Pfs=;
        b=WkKIUPZLddMbtPCajY2egWX8YPWM7j7MDmoV+A6lS8bSmh2vgWR8GdJKYB7hi84Jfu
         gcVwndkp7KInrI+1an8e1cv6WXhjcIBFguZa464zvIhp56OsT2JyX3vhzfzccEkTdPBy
         H6G+WIIxGAmJK1ucRj4w2IfDWA8qU+COBNaJblRaeUMcHt2nra0Yi5dVtaGtxPbFXd+L
         z5o4f+N8mVGNI9nD60AlCPC3X65LNvJ3a+4XNc8TfVi+pXhvPtxD/I8csJCSRqyE15jn
         I3qlNxFCLTx8vEczHf4I64llG98Y7OEV+iZ1d2YAV1tkpNJ5bRV9PvtfZ0hNNOmOsz5G
         cNjA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dp11wejJ8lmunzPXONyZ9klDSUJCYvgLvLZdQy4Kgyt6rQueDUpcTJfbYacM3IKwwnL5QscfCrL/Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xApBRbbRJnkiimMiPtLvms8DZxx1Fp6yN3QSnb8lCmxZJp+N
	3tqRWkp9jc+1v629+pg/AsC4pg9e2nlLRYPoNmmYRaXxlXBv7rhxQJ/d
X-Gm-Gg: AZuq6aKYLPXc8zu2j+9h1MYZSss0wiAvvX58HPNaGXf+NApTGd3MEVhmWoUmegTKduf
	+8nS9rVTA3CA1WmuK9QJ5k6yKVjUeRxSSUCh+ZTQJU4IFAuz7/neAoC0hSW0S7IiV1xZj9p/71L
	RbHsPrujf1ZRUHGs1G2jl2XfMg2h9m1CeKL0lySNa3R96kVS/LpSsBhePRMGIbIIrM7/TDeWTBP
	CJUuuz5nwcY9GsHvhTsyxxzt3UcekHtKR6CMx6p2YUyPoLH8z7jGyNhih4BGMikw9jInl2IZbxo
	NXnja9GDe/2OieVW7f08uc/eiSGakm1MMpWRyeGEjQH+X7hbszvbS92n+KHovbEfSGbjYsBM6b3
	4X9S4qphLq4NABh679mQRSqao5P9DkFOeRwkHXnJQYwlpjFDiRLCwtrzvYuZmN77oevxw9lC3xB
	M3Km1yAER3OZd826VOx/kipBwPKwbSJufpBu1scwb1o5XHNjGp7t4WzfR8FSVvKzrhlOSxiapj
X-Received: by 2002:a05:7022:4399:b0:119:e56b:98b8 with SMTP id a92af1059eb24-124a00b1ae1mr3452454c88.31.1769655241339;
        Wed, 28 Jan 2026 18:54:01 -0800 (PST)
Received: from jason-hall-A520-B.. ([2600:8800:41a0:8000:4e1:6e5f:e09f:d45a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9df97d0sm4850753c88.13.2026.01.28.18.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:54:00 -0800 (PST)
From: Jason Hall <jason.kei.hall@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: lossin@kernel.org,
	boqun.feng@gmail.com,
	aliceryhl@google.com,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jason Hall <jason.kei.hall@gmail.com>
Subject: [PATCH] rust: block: use pin_init::zeroed
Date: Wed, 28 Jan 2026 19:53:55 -0700
Message-ID: <20260129025355.1066511-1-jason.kei.hall@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual unsafe zeroing of block structures with the safe
pin_init::zeroed() helper.

Signed-off-by: Jason Hall <jason.kei.hall@gmail.com>
---
 rust/kernel/block/mq/gen_disk.rs | 4 +---
 rust/kernel/block/mq/tag_set.rs  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 1ce815c8cdab..649c3d9b1ff9 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -106,9 +106,7 @@ pub fn build<T: Operations>(
             // SAFETY: T::QueueData was created by the call to `into_foreign()` above
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
-
-        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
-        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
+        let mut lim: bindings::queue_limits = pin_init::zeroed();
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c3cf56d52bee..dae9df408a86 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -38,9 +38,7 @@ pub fn new(
         num_tags: u32,
         num_maps: u32,
     ) -> impl PinInit<Self, error::Error> {
-        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
-        // all are allowed to be 0.
-        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
+        let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
-- 
2.43.0

