Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5302D29C3;
	Fri, 15 Aug 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243158; cv=none; b=A1AZGzPoWnbyC5HQIbEUB6N6wqXKY6tamt11UGU15s1ZA7J+GaWhOWS4wcEzS019WGkV5yGpKF7IfztTL8eBsOGEXHDvQJSfRTnLkM1w4K0OBfeZn93Pdx9NjI0xmPlOQEg6+8qp0WmAz22AFk/3+y3jx4SGqjd04ZOVf+gFPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243158; c=relaxed/simple;
	bh=FkVup2wcuL8c9tJJq2cNTZw4TsjvE38QLG8Ll4ELGPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbFmaJyjMKkoOIm5qjm63q35ZPV0jNiC4fPfNPOHHaZdkzLFGT/OJuWZCtQJfS4TWy1LvbKeUtSTdP1f2E1oScQvvpDOkWewNQy+5d7xREtPpAyJqj5Eou27tCe1ExOUmGqDpod08nn8Bw5i+wPp5Lj+cOa3kmTeyuWhw6l+SO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUq8VeVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUq8VeVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CAEC4CEF4;
	Fri, 15 Aug 2025 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243158;
	bh=FkVup2wcuL8c9tJJq2cNTZw4TsjvE38QLG8Ll4ELGPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bUq8VeVq4G2Lbo/FB9Gd5FzGmagP1mDDFACpLKgw4kKbuFIY4JJ6qNhZkVAdH6sfB
	 RG8e9XoNuDeiCCWxGPzbDKELueBaitFbeM98mt1f7qpIrzNk4AsgiZXiXLhoBP8qb2
	 iqrcQQvieA7gAkyX1qPwTrAI0bnK+H/kTipCSe6F5adw6fabyaQoRBNAbIhW5O97cl
	 6bYlSTVL4IdWTlEgdMiKI7iJkfWAor1Twf0z8GFMPhsonu5x3U4A4GHxBXzF3yfvKH
	 3CpwtcKpctLexJGdjn0pL3DYOFRaiAqpEODvOw8uUxtyDDqWHCzonsPii0yuXCCLQp
	 IOFb7nkeBRysg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:37 +0200
Subject: [PATCH v5 02/18] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=FkVup2wcuL8c9tJJq2cNTZw4TsjvE38QLG8Ll4ELGPI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI1gCssunQzXbTBS8yYArxhqZnIwsIj8PGqE
 7tpubIs5GuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iNQAKCRDhuBo+eShj
 d6r7EACi7Lm5Kd2xpfgDDT66mnDNnEUmZ0ajjPempnCbfR9cvf9Ot3avkZBTwe2ZdTAVyCudpuI
 UCPisGWUp1PEBL9RoN6kTwF6B3ht25LLgK5jdhotyUoKU5ez+wHucYHABPgCXiH0t6pJQlibiEE
 RtAdi0iG51gOu/9EU/Dxd0UXhqKIJ584tWNqVE3Yfp4A24oMBit0qMYa5iiVT0NYkQdQ+b+WR7e
 VxJuhUuul46NkukxPcuFpr9lWPzEUXLuruAsTzSV8Erj+T7ZsgC/bIDaKLDSsOF5xzcf4myhcXO
 tqVJI2xrwK59Qcf1EQviKbJN+8MOs6napZ9krvosgC6KTnJEtTFee5+OKXJ0XyckIZlYWKSUHee
 qlPdXLw7oAQn6GcZDTXNuh4NSqeAzQQXeGN+rTdC04ukxENx85CeKGm2iOQgRWFIN5nronAnhUL
 DLmWdcUYdM10+TB4sQmHvjxCaLi5f06bbwA2QcVF+PX0uiiiXKDoIFFIykujJGtRwsSf9wMpLwF
 oqV5yiztugX14+y5tupFrhSrY9qB/yLHq3q5Wb5n6R3Jvv+0mN+/G1+rvwCzcbsVZ3J7fpH4S+T
 vDtbHOXDbH8FuZ4OOR73H8FiGnjobE0BzOK1oBSbpCmE/TKpYpSEOFdfyBDWXtfGY172JntVQ2+
 +FqJp54b7t/QrhA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Improve `Formatter` so that it can write to an array or slice buffer.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 082790b7a621..76632da357a6 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -7,7 +7,10 @@
     fmt::{self, Write},
     prelude::*,
 };
-use core::ops::{self, Deref, DerefMut, Index};
+use core::{
+    marker::PhantomData,
+    ops::{self, Deref, DerefMut, Index},
+};
 
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
@@ -825,9 +828,9 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
@@ -836,11 +839,19 @@ impl Formatter {
     /// for the lifetime of the returned [`Formatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
         // SAFETY: The safety requirements of this function satisfy those of the callee.
-        Self(unsafe { RawFormatter::from_buffer(buf, len) })
+        Self(unsafe { RawFormatter::from_buffer(buf, len) }, PhantomData)
+    }
+
+    /// Create a new [`Self`] instance.
+    #[expect(dead_code)]
+    pub(crate) fn new(buffer: &mut [u8]) -> Self {
+        // SAFETY: `buffer` is valid for writes for the entire length for
+        // the lifetime of `Self`.
+        unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }
     }
 }
 
-impl Deref for Formatter {
+impl Deref for Formatter<'_> {
     type Target = RawFormatter;
 
     fn deref(&self) -> &Self::Target {
@@ -848,7 +859,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl fmt::Write for Formatter {
+impl fmt::Write for Formatter<'_> {
     fn write_str(&mut self, s: &str) -> fmt::Result {
         self.0.write_str(s)?;
 

-- 
2.47.2


