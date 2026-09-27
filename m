Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27782384CEE
	for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505947; cv=none; b=E/gtvnnY/A24onNz2i2h6u6s1QdqFKVIsLF9BXOGquFGLuVdzZh1JogmYtQ3/sFtrOnjB5iAQzM3Ym8/z8G3OZ2S/UVYdaIfHB2zciI3iVdUWHIAh7Cx1kGd1dle9wa5XJZcpIWhTAgJz6faie6PIYoIjLVIBbSv9Ky2iwcTkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505947; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jynXZgOvyHr1JJZpq6FoTGT74DLk2BzeqnjZvleHSJ9n4QwlXR27Ox2oEPsHjmRTx2jAmYq8mQbdnhSVoTRTJarBqKp0gQZ6NJTgjfPvQRO/2vQXAVbRfRDTPe2NnSyYuodwXhDS2zwInrUhBu55Tv2vRJsJLQx5405kVgvFmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqskYMRb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqskYMRb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so16879475e9.3
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505938; x=1791110738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=OqskYMRbZd61iQb9qDsr+rsuQD+5SZWdBQ+TQZbfvMOpNhcR9mDjA4ODiE10gIehEi
         Af/ocXLrPkzxENkzhYM41nxZ3Iy0Q3FSuBRE3Gw1WX7BSedLjdJ3P6a7pOBM130CBZkr
         Gk58OMXL5Q3Tru8M3/WJWKONUZbDSHKl6l3zvx6SWnJezL4VOUCQs8Et1bVc6VNLLTqB
         BTEj3puiTw+d+t4mOYGJ2pV+vCZBaILbXj5MExVYBEZkBFAazfOQ/Q6GAH+ZKT765BeE
         unGk/I37xeT8mVqzRCqKZ/WFQrd6qnILADAO1gjMI2l3pPIzRsPiVLloUsvOA0q6FZkh
         bHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505938; x=1791110738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=ib003Vn0tGQg+0WjPZRsE3g1oUURPZPBjMdIT0T7Z7xu2EEtmsXJtcBsOYHZ8pXapN
         cX1Roj7qnhd+4gOY+wJ2Bzfh7EVncfmh/eTMq4ezuOTL756fIYKPzUvOkJM6E5kPxrZ0
         zLMLHqDtFWZHQR/FsytpG+lwu9UNduFM48aHPnZV2aQA5g2VMZ/O77SSouJgzaUAwtOf
         ZGf/dwVsuKAbjZf2kXaxQ8D+XCe0JQykTOq2k90uRooLcrv1lXZElxTl76mhXhzJEMz1
         BjbM2u1V3LwT1tjPO6aLPhUzfDQRe+xs5qsw0QwtXYVe8eDnVYig64ryKveruWHtN/X9
         KE1w==
X-Forwarded-Encrypted: i=1; AKwUvBzEEumNYG6APlVrrn+ObToHWU5Wio6MQQL2ZTjIPx976Gx24lDuQ3CdnfwkSbVbpeIXQ4FGSq8nHEGSdw==@vger.kernel.org
X-Gm-Message-State: AFuF++lboRGX2L1F1fpM9TVpPSu1iEtvIyH0nu5kWLj9ytOSui+WDmZg
	Y1K0qKk5+slRsyc+Pa0O/OwzEoJ65ZZZysVSZszzYZfvlzilVIil6YzD
X-Gm-Gg: AYBFou384wyiHDtjRXFiCfNIt3533TmGvsKiLKWGZkILC/Ew3rH+mTDt3K6XGDSRs4W
	hP0vvRPVRFZPAo4FcwZAnmU+lN5xLVNA0CNehevB6PIkY8szBdko9zh57err9c6mITTFAHzbQI0
	UA60FoEn4Bzlx/TJuZQHL1DLok64t2EnFzwJw9hMB3sQJoD445PE72BG0PVDqMzE+d3TLPGTWE6
	im45el3+w7QXCE26L+mf/YkSKPPXbBFmiKyRqmgEg2k4Ke3LGe253UaU3EZTsza/2aeendIneM1
	0LJ9wWM+EKc2iZCLFKUlvpf1AUTJRzkcmc2XY1jmoRyOS888vieRjEGnI+q2J9RCDd6zPcO63FJ
	U4V4V23GaWJFtPrT/AWsB62yOCTfc1k2imBQdtG1OmMz2Wl0soJpk2GX/ZJmt0961FduW9fhiN0
	paw1W1nr7ObPkgH91fp7vTUvQizhG8I+oucWUkRuskqBvhHPzzRTngB/a//sMI1rpHlAR3MS3bP
	qViJmyTQdldYpI9NonSQx1pkDN2wLuBWkj7iFKpOAh3E7vFJ9lJ4Jib7qdhWX6xXLNUnl5FWHZn
	9Q==
X-Received: by 2002:a05:600d:6502:10b0:49e:7cfc:a9b7 with SMTP id 5b1f17b1804b1-49fe67bc27amr127421625e9.18.1790505937936;
        Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001915fc2sm46005195e9.14.2026.09.27.03.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:45:37 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] rust: sync: lock: use DropGuard
Date: Sun, 27 Sep 2026 13:45:28 +0300
Message-ID: <20260927104528.103881-5-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the ScopeGuard usage in the Rust locking implementation with
DropGuard.

The guard preserves the existing scope-exit cleanup behavior while using
the DropGuard API from the Rust kernel memory module.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/sync/lock.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 10b6b5e9b024..15f9cbe76c8d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,8 +7,9 @@
 
 use super::LockClassKey;
 use crate::{
+    mem::DropGuard,
     str::{CStr, CStrExt as _},
-    types::{NotThreadSafe, Opaque, ScopeGuard},
+    types::{NotThreadSafe, Opaque},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use pin_init::{pin_data, pin_init, PinInit, Wrapper};
@@ -242,7 +243,7 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
-        let _relock = ScopeGuard::new(||
+        let _relock = DropGuard::new((), |_|
                 // SAFETY: The lock was just unlocked above and is being relocked now.
                 unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
-- 
2.43.0

