Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEC381AF0
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440562; cv=none; b=iuR6c8LxZnIp7df//F+9g8W3Y9h6/2i844236DYztJxH0lgljYva2A2BtgmfaVu5JM18R25G1uWHdqRVUcx+UmOFgWYjrHmVPS5DK5umT5I8NAcSvxgBfmpHCt0J10yFa9AtT0aXml1fzrG+mPzurxYv8yn5ELOlio/J5gFmIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440562; c=relaxed/simple;
	bh=WrDFYcSEi8mmKbs/PbalUMt2FcpwePnaNlDgkKerblM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltqMqg6fGDpkhYFUFzbiQc0l6OE9q8qM+29qty4eESYtBE9UC1zXXs2eyPawBOSw0Ou1mC5BlnwIr1R8FFdNhHDAhrhXE1xcdLZ2r/5NOP5/hKKEP3BFJtYAXSCXikKrygz8R1U1hkSEkOidccjm0IQuuVhxQAbTp6FW31+/cLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLr5B0nE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLr5B0nE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so9572865e9.3
        for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440558; x=1791045358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lO7O4QUZWD5NpE5omykRWv4rfNxkme+dmfp6zOtWq0c=;
        b=lLr5B0nErLcvWheRidWJccnjRE1bRc0yfOiNJSBX3lx7wGM77z69S2/D5cq2upZUPY
         sfa9IDGTzKne1A6rL7GgZ3nJEDXlym4Gy0emewzYV/YHx1i8aJ9298c1Qso1fJYJoZ7t
         dE8gZL+r/LTT6s4uHZTg9luAuklBoOnyChCgMYk2j8o2pQJzJtg6sV9ibqXdxbF5G+rf
         hgtyRcftMZMNERT44FoyYAmZRZpVWR7A1EIu1QQ7PtNktQQu+duvNxXLqSAUx6S2eOiw
         NAK+T7puUP3mumVcfUiagRr7wTwMQEA6J7EJAEHIUxK+mBarzOo4eVEKN8VgoyrJfnZl
         o20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440558; x=1791045358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lO7O4QUZWD5NpE5omykRWv4rfNxkme+dmfp6zOtWq0c=;
        b=2Oj2bwUpWhLg3fjTPwLBP9PNszmNhpoV2SaJctLSsKzFevtLrF9Nem2LO1lqKQp6Zd
         W8e+Jj6v2HahzRMpslSSQOqxgXuVR638QeqpOpWrcGbfBG2kFgQ6g33fxLGOVu344wqx
         vbPXb1dX5q7ptHyfVbdElTiU97nWzED2kyWnINnduArNcFsv0IPN2RjyF3yK3m9SlrZX
         RJMvTQE6cnPP9Tbs1t3jF68jmlLCww3zw3jkjiPeFZ50hTK+d3dGPtja+jL4WRwkCbZw
         iRu46944aLorURNHsKCKojV4k8MUJqM7LynVdoxWBmrfIzWmyNnRO7ZJ3+6d2U7OZsEV
         3iEw==
X-Forwarded-Encrypted: i=1; AKwUvBylbkg1tIm3iMWkltuw+pBXagp5tCMOm1FqCkgyTf79+PEOiV5wzOedB7WszaRlXiDO35lsRVyq1wCMQA==@vger.kernel.org
X-Gm-Message-State: AFuF++nmrHeWbzfBVA3+gJhZYw1Bar3LV5K/FmozeLjlDX3uwNdmFpWR
	t6kKSEcZ/t3LHruCKdbArUGij/64/zD5sIRw31zlbxPnCa2lJR1PHSbh
X-Gm-Gg: AYBFou27Q7xBLyNWjp83ZfCfnbC7CxwzbAgpvkrWljuzZ7HqbQrAUr2gDcFqn8Z0ILm
	YgWmGR00G0XeoP6/Ki0bjc39pJAyUsi1ggH5t4WeFvg3AXc8ylqNrup/G5ism4+gq0kYBIkaGKN
	+PrEsgp5G3TOHncEJlfjkyEfFIfdP1gCWRRxUaFf7j8wB23OSn7ku9GKhF/LioSydYi5ZItyTZ4
	W2h9HVQTuP6LOFZZZHFMbDRk8VOiOvVsIlfvYQcIJUGq0MrErSXs1XRkRxpfNRWnle0U1uX4vFE
	TEzRPO7bNSWEPatResE9BScUbPhofXOnmEiKFLCrukhylTIDlaJmAncRc+xHknjJAU7cbGKHEtI
	evTsUMT8Lf1BF0MJy3CPFUVrd661CI5uMeSE41ssT5+mK5KLN42sIkeQAW4JhTKDa6NscMyUGHo
	HwN2yZ8cb3A0+5Ib4iaX5YlWjg9x+ijw5uTfQHsjmRpjRGZGRTD1RoM5t//zh5sZ2V1K1AGqIgs
	8ncWD/AykSF+6e2VT7PnQovvG2Dzoj31hR20JvuabGb5QLwIL99XeCXoSxbcKMjV8Q=
X-Received: by 2002:a05:600c:1d29:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49fe66eeeaamr181452975e9.24.1790440558058;
        Sat, 26 Sep 2026 09:35:58 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm16176146f8f.17.2026.09.26.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:57 -0700 (PDT)
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
Subject: [PATCH v2 2/5] rust: mem: add DropGuard
Date: Sat, 26 Sep 2026 19:35:48 +0300
Message-ID: <20260926163551.52371-3-mohamed.osama189110@gmail.com>
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

Add DropGuard to the Rust kernel memory module.

DropGuard runs a FnOnce callback when the guard is dropped and provides
dismiss() to take ownership of the wrapped value without running the
cleanup callback.

This provides the Rust kernel with a scope guard API matching the
upstream Rust DropGuard interface.

Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
---
 rust/kernel/mem.rs | 123 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index f2d4cdf87d00..17807c8e67ac 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -4,6 +4,95 @@
 
 use crate::prelude::*;
 
+use core::{
+    mem::ManuallyDrop,
+    ops::{Deref, DerefMut},
+};
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
@@ -232,3 +321,37 @@ unsafe impl AsReprMut for $signed {}
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

