Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43E38237B
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440569; cv=none; b=W4XxukZZIvU3lUzRTpYCLgYQzDmzm070YMHm7WDyWJudqIrVy4zEeezR5OSzfTjvfxrwucn08FzChNhW3UlF68cU5cdsXsAI/IvuuKDSsQvKwkaoB64PgL6l/jFcj+EThvykWzgIMGYfASLJfrgAXkZNM/AeiKmq8z/QmyCIAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440569; c=relaxed/simple;
	bh=bG4MyftsdfdbaBykmDiiNfkzsWo9nnA1ngVnb4LMZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2Wy7JI0qDd22rKhm8pocWsBzRwHVm2FcVxucAwL5BVSQClkqqKbjzJsYPN7Yx0tpSA6rtW1GxCKryMQARYwYfQeDSf3UAp8oJzlPpJoZLvVNqfxx1cKjBoUbYh2esWDZLraAmnpQKlTfjGCEhSAV3ETMTcaby0ty53d1OuOXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYLy7tXS; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYLy7tXS"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so984953f8f.3
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440563; x=1791045363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=iYLy7tXShZxTAhG2W3NNlmxf6L4RtJ38na9e0k0glaO097X12jiRsivDkfbSyepjNU
         3pZlupDMTTZxyjrRJBXMkORkTV7uqGPkKP4MY9832Zj3Va5oa4ZfHOWACt+JrlVuE3hH
         7daMOWjwXyXxE4pTP7lsJ5nzRipcmElXadRxRY5OhrdwclMXFwTVHo/lLs6W9ro7Cicg
         OhObvRR8xsXr6FcsG3tuz13C/F/+JmWMrnWG68OuWA761fCDy0utcPCfHqAExz9YUB/A
         dwDCh+05CYuMU24D9C1CtIvYjY4A3maP0kPbJkaX0QJT0nj0r3+Xoa1Gwv6G/wH8J3wb
         zRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440563; x=1791045363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPw5CBxQDFpFXhy4vfMV2uncUCg9SZRmO0QrAN2QOdE=;
        b=p5jNMefktSG46gbq8cPg8DCW6WF+0l1++7N8xwqcNg1yDoldj9mKaXwyj2K7Xlurp5
         J7n5cY8oc/if+zpdTtNf1rJPuNuBmbFgXXmSlajz35QN3gn3MTph/PSxJEo/MV4G4Iid
         K/Ne1y9Y5muPEE5P5G36xa1F3BnTCqK4jNu5jgEnEvX19YeEE86Ndn21hXDz49LxBO5w
         c0dKslExY2CThF1RMdU9+OV7Bp4G+mY8NvdAF6oOUyLqjW+zs8/BOalCffmChj7wGQpN
         JnRUooCYXQe3FHGdnAd5CcEc7uRfHb5Q7/1M/M95P41FVVpeB4GELG/J39sbYTw0IeNn
         uKjw==
X-Forwarded-Encrypted: i=1; AKwUvBwcppaF4h/VuvQ2fmPZyW5J++4g00QeDQbqLhLcddmTzse9Cjea29I92OCoWv4rsc1DFqI4ThIFXBQweQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK1lyE1r0OqI7wYAuMswdlPuOId8I95GmTvCXcahXlOhgMytB/8
	wehs6HKuOzJeECkR/enCfSeyntxB4vP1NSZdTSvcAHHiqV8Esg4SY6Wn
X-Gm-Gg: AYBFou0F9qmIyhuCWKWAIs+z9Jwb66FJchc6XRFkEPOZAqA1AFhzeVA1jaLQ5OxINbB
	InZoNO9b1YOGdliEKf61t5M9NSHgXMUme5Xgrm7Y6jNcNP326mGcTy/Y+ig3Fx+4r+lwxBJDQjH
	tG1UJssmXnbrPkFiCeo9CyQE2TpUeEE2SOC7CLOoAnFgJtfHlMsNwHlXYW/e8lOjWbMLqRhGsnv
	d3lBkqcoYF8TWuvo8uXUuq8NCzXaMwc7SH18ulb8zTsXud+MPbvQThu4lBbvdHN2hS4GejVJIUf
	kyd/AA9OU4lXCeVQjm0h9ACfeRfJs5dM0Go+D/oVmz+Z8Icp/NYT3IQ6ddukEOTB7rsGGq4PdOO
	90qy9o61loEbjk4w16N+2hh8pxNkzFua4ARKBh977f2JGlOt59R0XzMFOgdRDnZ91wiYXJ51vH3
	WGz3suCboaWJne8UR8J7NkhdvUs4dYR5ODUiwGnO5xLKoEhiKPHgeHVlIG+z8p7OHqP+87GFYGF
	sAVBKWlil6N2W1LPZD6y+Eg54F1ITwUm2R+ekOe7Yrwi/Bsa9zA/rf3+OMTSMutBxQ=
X-Received: by 2002:a05:6000:2999:10b0:488:79e5:cb2b with SMTP id ffacd0b85a97d-48879e5ce9emr7985352f8f.43.1790440563055;
        Sat, 26 Sep 2026 09:36:03 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:36:02 -0700 (PDT)
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
Subject: [PATCH v2 5/5] rust: sync: lock: use DropGuard
Date: Sat, 26 Sep 2026 19:35:51 +0300
Message-ID: <20260926163551.52371-6-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
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

