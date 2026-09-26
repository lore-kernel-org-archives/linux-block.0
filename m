Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EA38398D
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444019; cv=none; b=uAkA/ksV1VLTAiwrITN4gLtoAN9TgkQbMJpVmreH63fivsTbYppGtQ0BwKpJP5Ze0a8K6zxxyLoNnBdhD/QHMYsfZs3X5qs9jKRa+CRRe9o4/vclR0zvrHxdTG9F7Tah7707s4lKeMkUxlafiKD22BxaZG5jPnHXK90qocbKUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444019; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGeMNpHWxNG5TVGwcWLQAzBEEpysoCWLmxaklUXXDibgU8dkH65LiSfP9w7XklPv+4JdOkq3zWuwKAZYXRndDWQWp29Rkvm4KWT8yOBDnD2jXgoli/qHzfATFCZP2aOJCo8o7GrLPCCLFJ3JFldnBaxsCprwfKtPQeIUtpVA/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivEIc817; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivEIc817"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so1141942f8f.1
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444007; x=1791048807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=ivEIc817Nrhsx8H6zckRL3AMyp6wCnxfhrQkSLJcJgRgU6q/awHL2kbs/H9giNSkOn
         aqGAH4w/Kx67BixNnZU4ahXzYlJMZqYoZPxeg+H8oUvBlqR7TUVXI0s1UDp2u5lPSTuO
         3nAEvmF4uS9+QBd8RikJZylI5a1BnuBDLbeQDIXQb/UECTjKXl0DQGRb4IUbcADjNoA1
         Rtyz3FSA19TWzoRT23diGMqKBZqsbbHStqhvA1YLvUC5oiAIucjsqh9OAelSVsRYRqhH
         XaaI2x+fRMZOUGqpbqLZLfqqB7VJzyqN8fRFqtCcLJJcvkgRmEzh9IKo12LA+D1jxk8f
         ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444007; x=1791048807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=ptw0vfkcekEvsluwDiYUZDztD+nF7ZRoTWz2QKdBxVYxuvtxFHoECSBnzvpTQ6P+E1
         McPFi0kYefwSs0Bwf+aimAZSI2vk1J4ZzNC1DvLUfr8+RpAuZ1vr7d71IqPbBR5k403R
         wp3T4a3GqR86QqxwCeYgw/4GLEZWpRoXF6uyOpJC6J5yLP7q2mnKrP2B74vClmnMy32M
         9hqxFLXR4poFq+zvufq63bRHR133uFvxcvPzLSPgQ32K6oRFoc5Xeh8TuGWkEqGU7SD4
         85abFnMsYmIH52qnLSh42loqMTno/eXkraXmQIrscQy1D0IVDPGnAnRN6xGMoJOvcGhh
         mLCg==
X-Forwarded-Encrypted: i=1; AKwUvBx8661jpGOQAuUrDxQFtpa31PBFy9w6m7W2uvAaszzyv3mIdRGa4vxrLdjyWONqDXZKql9cUQcMG3cEcA==@vger.kernel.org
X-Gm-Message-State: AFuF++lY52P759c7Q4jS3TiYj/Ivr+JqISJbzVpQT6GjrePusXHPddF9
	val5V6M/xQrd5sKz88m7Ti/xtSkozM9ykJXe452PKYCVvV5qhB8AHRTe
X-Gm-Gg: AYBFou0D9W7l1N7JpFKlY/NDgFpoQJ1OQVXfPxoly6WlEyvKHsWLkeztgla/Bt+HSBF
	4PTSwLx9R9j+necjGQLN1Qyfhq/0ilhcfr0RG3jLvGj99L7vquk3t6LMUJtW2KXsL0KTzWhvaXJ
	Xr6qrXc3QPc2Zs6/2m3PDcPmFu90pPWkQtZggvp/cMsqIvoBGMOVKHM0U+Owh1VsV+jSKsdXfxn
	AY8r42tpED+mXE0CHyWH5FZFnvu4xxkfOK33R59hWA8imVDuZv7jIeL2HCXXvNGNTE1qV0wdzK8
	G+ATojM5o1LhQx4dUIwDLUwZ0Yv3WatrbFpCEStrs+6+T2reOW7/eCdrz0iT4WyOGCTYKvUiRTi
	NSmXWovYhx0OfE0Oeh4Rnlp7XvfZgjyM2a9sNEpODqxzo/k+Agya63M27EsAGjdIG1NoeHgGal6
	YgGJNFU3ojsoEeF66bxqkd9f/Oios1NNi8EPDcJ6VCrZrQJfVUjaPuFoQdl+vJ/elzNNSgR34pK
	MKM3LsC6l0FR7Cm+Qi8QrUal4XPGWl+P0tdq4AN0n/s/P+ogagpFVoT0LcFzR7Esx0=
X-Received: by 2002:a05:600c:1c1b:b0:49f:bc28:e8b1 with SMTP id 5b1f17b1804b1-49fe66d6c9bmr166175805e9.14.1790444006652;
        Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:26 -0700 (PDT)
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
Subject: [PATCH v3 5/5] rust: sync: lock: use DropGuard
Date: Sat, 26 Sep 2026 20:33:15 +0300
Message-ID: <20260926173315.56772-6-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
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

