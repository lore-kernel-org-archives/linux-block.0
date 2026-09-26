Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F5386C0A
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444005; cv=none; b=ZXQJta5FnvhJA4ZK+zCjNPEateSnWmn7/yCDeKqwvifu18SO4xsDAwVxvtKwea64QiSFqPu5WXBDNoYO13RrTKrOv7S4b5POydGr79uDOimZI0HD+z3tZ/vedzhHmVY/yfRJnxfV9bq0n2XALOuF08v3un0JMWbFr9Q/ibLg43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444005; c=relaxed/simple;
	bh=A2yn2hEK2qj8j1x6Cm1dqmZddSS6gL9TH6ZZpSW8ipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVykf6VqbnYukLuZ1sUEtdbkEZ538BHLKymM0tasdOi4oYjrGacWPOC43SAi9uQPbPJ+HmzMDNHvq2U9R8t6GYY74BqKEiSCbmOg6lCuMsnJIGb5c/jp/Wlif+eNivIdySNHTqisqg1njFa5OfqIo+9a/Yyl6sZ3nNXYIAmlqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpxzQoHD; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpxzQoHD"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so9723685e9.3
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790444002; x=1791048802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8xTX58ZbIcDsBwa8g5MaCBCsG+ItMzgp97urclUdY8=;
        b=HpxzQoHDchNOR31HDbB8pf0v2+PZS5c1FPR/qzUPryio9ZBxITBhNznqftQyDfBpIE
         48rgKOZppGMwLOJO32kG7iXOhSC8/aiYxJhFB7/2kd5wmXyrZMUuQR+26MD9OecmYbXo
         dXWI6hJNiZ9d0wJcGv5CDA65vPfMUSHYf0RdeZdiBs2mncMoTERES4Kew6JtYC2H+JuD
         FHJwISzMoFzBTFI6iyS6KBbIJlax8ZnOmUy3oG9WlqT2KSWU3TV2oXZzs/+JLVYvrvEJ
         lQMCnwdesv0DAEzN0PQRwsgKkkMSwxGLdpPNaKvcChvU7L/e0UC+MuHL5kItudLmAcbZ
         P2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444002; x=1791048802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8xTX58ZbIcDsBwa8g5MaCBCsG+ItMzgp97urclUdY8=;
        b=0GIV/QuJtr6ROluJEIGzXp0hAKx7C9+CoJFWXcfMqER393eM5zPbPPovV0JW07n9s7
         FX6v9CQktxzT0r6XscZqqQjk3OSAmGaKYiw4ka2jjJrKVW+VZtGkQKFkFCy4nz7oQjvS
         376h/pfLfYT2XFZsUY363ij9qZu0Va3KXwAooUmECjEzCo/ZRn/CunT27Ndzf0v6FyqT
         QGcNPy+69d+2lQzKesMLLLtopuXpjGYQJkbZnt+khYngsJ/oafDDpqWqt28a3ts0ostg
         Nd4jLsALBHwKkMJcLI3RwZmKrYviIDXNM9V8QsMQ/6Z6KXw675EW4sjKzAwk9dIbAiOc
         /aVQ==
X-Forwarded-Encrypted: i=1; AKwUvBysVviI0MC+J8FJFZaPB9cUyPWtRxvYtJRkm5Y0EBOJadsdjHGwymWTT9tgxttLXbw6TqBY+ik7ZqcJKw==@vger.kernel.org
X-Gm-Message-State: AFuF++n6bK6L5Gd+8Kd95oYh11zZXNkItQiPeeKuypb92jOfuUIXwIee
	CJpNd588D7v5qxk3LCp+hFpz0o/8mRgfCtd+jizwIuP/vcZZ7C3FMtu0
X-Gm-Gg: AYBFou0mkgtAYR0298CM0n+L8T6KkGcd92AddcSwGTQl/armpHQoSaCWeDqu6jRpSTk
	08FR9rmG7dXgqHOvR0fq5a6g90GntiUqv9vTtm0wmmZF0QuD81uGF7NuMsSpGqSLrkmHWABIblD
	b2xfxKj3eHqfnVwDGfGNwT/LIyN4XbFj2rCzkVTjJEkbM59esYC8/DivPTLcHAK++//FkLB+JKp
	Dhp1nwV50CilHkVQXv1tH7Ta80dr1bmyyQTIQu1Rlns2MOdD7hU9K/VWkdHNvQ/Jsyk49chhN5I
	CIAWxQ6KY5MxtUt98x8qKHnAM6XWq4s8Fz//WoorIxyYkR2OcKz5MPCnh7TrYAmWEKckkATZJh1
	ntWARSMDsXAZtVoV80yO5zGSXzYgCUn5govl8kQk6vTqVeko3CflgQdNnPUrODc7GszsNy8u3b3
	E4pxteq8kxCfoAikgA3qRX9YmhlWyHtl+epsC389cr1kKvl0ZOQB/dEr4WDEmGDhdBe/OK7psJ3
	iTCwFElJ/7pKuIzhOdUlXTEaVvDqYfomrngaggJMyOBtfB8g42/K+HyhPOTnf5FgFM=
X-Received: by 2002:a05:600c:1912:b0:49f:cbf1:e765 with SMTP id 5b1f17b1804b1-49fe667a597mr162790305e9.0.1790444001670;
        Sat, 26 Sep 2026 10:33:21 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:21 -0700 (PDT)
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
Subject: [PATCH v3 2/5] rust: mem: add DropGuard
Date: Sat, 26 Sep 2026 20:33:12 +0300
Message-ID: <20260926173315.56772-3-mohamed.osama189110@gmail.com>
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

Add DropGuard to the Rust kernel memory module.

DropGuard runs a FnOnce callback when the guard is dropped and provides
dismiss() to take ownership of the wrapped value without running the
cleanup callback.

This follows the upstream core::mem::DropGuard API, which is being
stabilized in Rust.

Keep ScopeGuard for existing users rather than changing its API in this
patch. Migrate the existing users that can use DropGuard to establish
the kernel API alongside the upstream Rust API.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/mem.rs | 121 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index f2d4cdf87d00..e7a84d15f3b3 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -4,6 +4,93 @@
 
 use crate::prelude::*;
 
+use core::mem::ManuallyDrop;
+use core::ops::{Deref, DerefMut};
+
+/// Wraps a value and runs a closure when dropped.
+///
+/// This is useful for running cleanup code when leaving a scope.
+///
+/// The [`DropGuard::dismiss`] function can be used to take ownership of the wrapped
+/// value without running the cleanup function.
+#[doc(alias = "ScopeGuard")]
+#[doc(alias = "defer")]
+pub struct DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    inner: ManuallyDrop<T>,
+    f: ManuallyDrop<F>,
+}
+
+impl<T, F> DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    /// Creates a new `DropGuard`.
+    #[inline]
+    #[must_use]
+    pub fn new(inner: T, f: F) -> Self {
+        Self {
+            inner: ManuallyDrop::new(inner),
+            f: ManuallyDrop::new(f),
+        }
+    }
+
+    /// Consumes the `DropGuard`, returning the wrapped value without
+    /// running the cleanup function.
+    #[inline]
+    pub fn dismiss(guard: Self) -> T {
+        let mut guard = ManuallyDrop::new(guard);
+
+        // SAFETY: We have taken ownership of the guard and prevent its destructor from running.
+        let value = unsafe { ManuallyDrop::take(&mut guard.inner) };
+
+        // SAFETY: We have taken ownership of the guard.
+        unsafe { ManuallyDrop::drop(&mut guard.f) };
+
+        value
+    }
+}
+
+impl<T, F> Deref for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T, F> DerefMut for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    #[inline]
+    fn deref_mut(&mut self) -> &mut T {
+        &mut self.inner
+    }
+}
+
+impl<T, F> Drop for DropGuard<T, F>
+where
+    F: FnOnce(T),
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let inner = unsafe { ManuallyDrop::take(&mut self.inner) };
+
+        // SAFETY: `DropGuard` is in the process of being dropped.
+        let f = unsafe { ManuallyDrop::take(&mut self.f) };
+
+        f(inner);
+    }
+}
+
 /// Transmute between two types.
 ///
 /// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
@@ -232,3 +319,37 @@ unsafe impl AsReprMut for $signed {}
     // `usize` is not normalized to particular integer for portability.
     usize isize,
 }
+
+#[cfg(CONFIG_RUST_DROP_GUARD_KUNIT_TEST)]
+#[macros::kunit_tests(rust_drop_guard)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_drop_runs_cleanup() {
+        let mut cleaned = false;
+
+        {
+            let _guard = DropGuard::new(42, |value| {
+                assert_eq!(value, 42);
+                cleaned = true;
+            });
+        }
+
+        assert!(cleaned);
+    }
+
+    #[test]
+    fn test_dismiss_returns_value_without_cleanup() {
+        let mut cleaned = false;
+
+        let guard = DropGuard::new(42, |_| {
+            cleaned = true;
+        });
+
+        let value = DropGuard::dismiss(guard);
+
+        assert_eq!(value, 42);
+        assert!(!cleaned);
+    }
+}
-- 
2.43.0

