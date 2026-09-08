Received: from mail-oo2-f34.google.com (mail-oo2-f34.google.com [74.125.231.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5659E338
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898139; cv=none; b=YHDXHRyuHbp6zLdGOSgYPA5CAvxiWgImw9FQzdy409ujVihvFNUrLBP5dNsmGjqmzEXzs/mGhxlMun5FWWExbbXueAUui/e75nJjZV9uy4u9Ld0cGeNHm2IV0J/ka8RXLhUe6RV57IAn9k5j+cyyqYy88z91Umgp6xPdlnTaA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898139; c=relaxed/simple;
	bh=/kMit8CUDaP2BflI6bC+09wX3fqJwv8fLnZxYfqIkgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIP66SdkEys58xAc95PWG+QDrKbLix6uQ8qohsKNaQ6lSct60k+9Vt+4Rt/Ogibr0IBuTu4NIySEQEbqO9Is9L6jzM52lbMwxln2VNc89k5eb5NXTSR40lS4YWPV6AQRatXZgN6HEKS6yHo2Nmsp4jn014qOoiSpT9WqJ+TAi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tamu.edu; spf=pass smtp.mailfrom=tamu.edu; dkim=pass (2048-bit key) header.d=tamu.edu header.i=@tamu.edu header.b=GzgtppxI; arc=none smtp.client-ip=74.125.231.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tamu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tamu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tamu.edu header.i=@tamu.edu header.b="GzgtppxI"
Received: by mail-oo2-f34.google.com with SMTP id 46e09a7af769-80032c08611so285333a34.3
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tamu.edu; s=google; t=1788898134; x=1789502934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cpZBZiNkX1boADxTuU2IVraCPujz/4cVmGXwbGYdtrg=;
        b=GzgtppxIDL/LhxXRbBfnTCRUpuvgQ9f9hlAu2dLKdN3vqY2Tk9jNIlNX11ACGrSXwQ
         FUNtmXfyRVRbo/qRL1Lxyd8sUb2mpmQzlAP3wHQbClgGDeuIZZTEPnxaogPLzaKJP44v
         kWGsvTNzbeNmPEjtf9J8Lv7Jqpt0kenHQV3zKWnylPYfDwZVajObpvUFJqGAzGTxe/2L
         M9978pleCh7C+Iw58Eh173jQPq9oIbq3KlaBbLeFP+qUVxZoKKQYwDgkyqjUEGNYlaNw
         11tXwDBn6t4e5pyM5pnPgx7DPN7AunkojkjaixANUlA1CnmqO84C0DJG8fCnq419otOn
         tvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898134; x=1789502934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpZBZiNkX1boADxTuU2IVraCPujz/4cVmGXwbGYdtrg=;
        b=XTBjPT21Pgp/gQqi1vBj2DVIvcBuDuO1MgLlBVxE7Duzar5nB7x4+LnebNpdLKLtZp
         8DYzptZc7RI7IuvejYy6FpYl6aR08sN8XCjBqfiMyYMuDOEmIbv87t20RGYU4a2pcS4U
         PVu7vCXtj5do7c0rxCjU6CTKte45kwJog7A3f97a4YM3jL/jBCiuFMuJgbBXfvuW0eb3
         Q0+xFP0ORRFvFtGKFUL/Vvg5D7xNzhPNLtwDRX4w2NFRWPvFYUYas29Krk7XnFcA+ZYA
         0vv9whEPQPcC5BkNTzNXis1S2nErYytBEuOD7/2q5QEwZ0Vrtvginr+Tfxp2j4Xo24kC
         b57Q==
X-Forwarded-Encrypted: i=1; AKwUvByxuQ3Ri9+I/eCxhvbwp41CZov+rbl7eNQxWUc+3umc8HP4LxXwSqkLAbhbdKQpNll7dbOSHX+zuNzZQg==@vger.kernel.org
X-Gm-Message-State: AFuF++nPNuILpbL5WELvjQwSHrxc/jcSoni+HHZVShQmx3BlTtFXGUoN
	cLPpnrzJ2QQIVekdayI8CcOMYlN47Pldtzw0+Nf0xFDLjhYulpG83y7JAL3/iS75JL4=
X-Gm-Gg: AYBFou0eCPPEMrGPa1cd1mBGd7LJesZnHMgX8fh9/qO2vxM0HpeWNjIl6EO+LGczjcg
	l3VO6MT49eP2suq8MEMMYFQ/fjwm8kXhr/oOLDWLSAYSBfCpHnHbDFkidwN62aa93FapNmT7QV3
	0D+4Dlg2Qk5/lgpRlRQy/bb+2cbxpe+qh6oluAyhwwUuXNYRbqxwJWD7Bsxlxq5V5lugVnE2puc
	HsCjf85ZWBT0YV92VAv1rqf2CinBlXdQprqCDOT6El2w1M9d6evpRgIT9CSN/zBcUSg8ShJbGnA
	kZF4/lTN2ZERhx8GJZVgizTbKikekszdrVJz2FSvv6FYZrxfc1yFkjk7KiVNgpOd0k2xfbj7xgV
	xCjycTEmeHPOOSGnD4zX3/9ndOIuX6hIKn9XJJkCmDJ+6svOQ8Y6+h57Pcf13nNU7zo+e/kxRtw
	eBIXpiv7i5CEElcErF/90F1widyuFfQdJFTSFXfnAlee1IpRLEFYFvXCVB2wKvIvg/YNoByqPN/
	QURvOxOYohBP7QkoKIvSKdM0kgQsz4QsEqLyHSizaic/Tq8tpSUuWf9477NpbC0b2z76xQ=
X-Received: by 2002:a05:6830:3499:b0:7f6:705b:ffe7 with SMTP id 46e09a7af769-800f1a35138mr1966540a34.14.1788898132377;
        Tue, 08 Sep 2026 13:08:52 -0700 (PDT)
Received: from fb.keuhufpvur4u1eezzhu5ttlizh.gx.internal.cloudapp.net ([20.106.51.18])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6793f5fsm17086281a34.8.2026.09.08.13.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:08:51 -0700 (PDT)
From: Qingxiao Xu <qingxiao@tamu.edu>
To: 
Cc: Qingxiao Xu <qingxiao@tamu.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rnull: fix geometry store check-then-act across lock scopes
Date: Tue,  8 Sep 2026 20:08:43 +0000
Message-ID: <20260908200845.405112-1-qingxiao@tamu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocksize/rotational/capacity/irqmode stores check powered under one
Mutex acquisition, drop the guard, then update under a second acquisition.
A concurrent power-on can create the live disk from stale geometry in
between, leaving powered==true with config != live disk.

Hold one guard for the powered check and the field update.

Signed-off-by: Qingxiao Xu <qingxiao@tamu.edu>
---
 drivers/block/rnull/configfs.rs | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 32c10c3f4..66ef91b3f 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -174,7 +174,8 @@ impl configfs::AttributeOperations<1> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
@@ -182,7 +183,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         let value = text.parse::<u32>().map_err(|_| EINVAL)?;
 
         GenDiskBuilder::validate_block_size(value)?;
-        this.data.lock().block_size = value;
+        guard.block_size = value;
         Ok(())
     }
 }
@@ -204,11 +205,12 @@ impl configfs::AttributeOperations<2> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
-        this.data.lock().rotational = kstrtobool_bytes(page)?;
+        guard.rotational = kstrtobool_bytes(page)?;
 
         Ok(())
     }
@@ -225,14 +227,15 @@ impl configfs::AttributeOperations<3> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u64>().map_err(|_| EINVAL)?;
 
-        this.data.lock().capacity_mib = value;
+        guard.capacity_mib = value;
         Ok(())
     }
 }
@@ -248,14 +251,15 @@ impl configfs::AttributeOperations<4> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u8>().map_err(|_| EINVAL)?;
 
-        this.data.lock().irq_mode = IRQMode::try_from(value)?;
+        guard.irq_mode = IRQMode::try_from(value)?;
         Ok(())
     }
 }
-- 
2.43.0

