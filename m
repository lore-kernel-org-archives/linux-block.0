Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F022EAB62;
	Fri, 11 Jul 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234268; cv=none; b=G2GVvs3/zU5t/f7Xs5wAhRbym4ry1qxRCP8rqLB0nil7oAXFNQC+gEdPMKzem9NuIHtJAl3Sfu2kV43BJFb52V/mYVf8sBJYsOU8AfJ+jPEUCnJTqTJnkz84y4igpw83arp8pI2aEH5iXEF0ti+dOiDqY6ZmS6HSwdCdwPLEsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234268; c=relaxed/simple;
	bh=YR3+KxDyGdcP+mNlRtl4taUFDwd89vDjI3tc8bE0Zrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BT6nfjyXURWUD1/thRSjgZ5BTYR4uSkhJfsXi5PIChACvSrGu+d4a7BO1N3ycnZdNmGW4xtMb6fE1xfKFnED8RUmZs+de3XGimxmB9P682G83T8wYCV+Gr3t1hHVImOJ6ZtCuNgzQj+RWPxUCg6wZ5SF9Chaw9l1mTkZgKgaymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/EfB5VF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/EfB5VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB3FC4CEED;
	Fri, 11 Jul 2025 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234267;
	bh=YR3+KxDyGdcP+mNlRtl4taUFDwd89vDjI3tc8bE0Zrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l/EfB5VFaOH9n3pwwxaB+J2zSQYRdKTthzcmHAgR9j2ccJIGcL4R3GzmB2EyUsQYt
	 a1pRhH9ZccX28O2puUaUWFxduLJLlYIYO/vHC4/2eg3D8VhdI/FfbMgtMY9ThhY2qr
	 ZYTUEO22HFSsY3qocRrc4JLgERW5uwc2n8cF0b37487IF2lgho/xBPZmBfmhPNh+fp
	 Cl0H3afjPidm+5h0lIKwIepvuQ86k8P7E8Ty3AMQ4BHEYOJZmjHQ0ga4nKUZjkWrKm
	 VyPTwAyx0sSHVL1SFVNb8CLtFxXgldIAhBJDKg9EuClDNybAWvgWDP9xP+cphC8Ygj
	 v2OWJQIQnaOfQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:03 +0200
Subject: [PATCH v3 02/16] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=YR3+KxDyGdcP+mNlRtl4taUFDwd89vDjI3tc8bE0Zrc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjLa/RPa7IihwUNcpudTtRNnpMt3yl/RrYb9
 W1u1CEqjECJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4ywAKCRDhuBo+eShj
 d0OrD/4yBwrg+x8SfhqC1StjqxYxDerfuLQC5zH6ntePB3nydWy1awF/QWcW6s+6eZaNSvRwtFg
 OKWGzlmOWMgxdfSpiX752ELAsTmF9ge74MkbPnRLjTyrzvxKQtzrY9jTYAmk1XcSUZUN/NPUDQe
 7bTeHvM4lNOZ4DE2Y1hoQ9uPhNbGb8mUH2ukexbCTbpTPVuf/smH8+N5PVFUwbc0mWvPHaLAFq3
 0L8J1/jduPzdpohhZeRYDrPZjAH+6515zvaKCzdE42boj6fF1d68Vv5SsgJ9GJSzwF0l6DJSrLR
 uCzAWjcxwzNxVfWZT+l4YRWpXu7OqBHjyo2IZs30jRzbsPKkvsh3CsRC/lwnGy1ItcCXhkWF2Ii
 YOljPM2MX2/Fxhuwmckm0tStPDpRdaeq8jdetjvvZn3RROwHl/PwZcTccyDO7Grq1l93e5BVo3K
 nUpaahKPxa4peV/tADjc4tKg14gEGoZHFMBXqNpbare7RmFA0z8md0IYNN2nI1MhpeXIavyDaPM
 hmfY2NaJkczQJhTqkGSlpYbSimOjC83xshHd8WF4K2FiP1Aj+hfT9NgCpw2ciSgso0leaN7YJKw
 auYVwyQ1sqeVpN8fz75ecbOdmkcFDU1omC2NT1vmRhjV7JMgkUbBbf8+d6YUNJEcymxUrgdQ17p
 OgAoECwIGfGUBqw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Improve `Formatter` so that it can write to an array or slice buffer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 488b0e97004e..41af456a46c8 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -6,6 +6,7 @@
 use crate::prelude::*;
 use core::{
     fmt::{self, Write},
+    marker::PhantomData,
     ops::{self, Deref, DerefMut, Index},
 };
 
@@ -794,9 +795,9 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// Fails if callers attempt to write more than will fit in the buffer.
-pub(crate) struct Formatter(RawFormatter);
+pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
 
-impl Formatter {
+impl Formatter<'_> {
     /// Creates a new instance of [`Formatter`] with the given buffer.
     ///
     /// # Safety
@@ -805,11 +806,19 @@ impl Formatter {
     /// for the lifetime of the returned [`Formatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
         // SAFETY: The safety requirements of this function satisfy those of the callee.
-        Self(unsafe { RawFormatter::from_buffer(buf, len) })
+        Self(unsafe { RawFormatter::from_buffer(buf, len) }, PhantomData)
+    }
+
+    /// Create a new [`Self`] instance.
+    #[expect(dead_code)]
+    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
+        // SAFETY: `buffer` is valid for writes for the entire length for
+        // the lifetime of `Self`.
+        unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }
     }
 }
 
-impl Deref for Formatter {
+impl Deref for Formatter<'_> {
     type Target = RawFormatter;
 
     fn deref(&self) -> &Self::Target {
@@ -817,7 +826,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl fmt::Write for Formatter {
+impl fmt::Write for Formatter<'_> {
     fn write_str(&mut self, s: &str) -> fmt::Result {
         self.0.write_str(s)?;
 

-- 
2.47.2


