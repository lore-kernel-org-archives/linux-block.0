Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193B2F361D;
	Tue,  2 Sep 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806959; cv=none; b=Nm9d06OoYEwqFuzg+jV7oR/YZCcV/khcFupyTc9XhPjtKT1lgdWSC9eQmYkdkrvuYRZ/2SJPVriAcukv98YRgHQ+8k/TO4rtq/POY4I6ek9xasO+RLAZV8Rcm2iT+q6uKgaHhFW8m0IRqGApnXwfPAMt07SdR4kynMQmBpsUMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806959; c=relaxed/simple;
	bh=IrL/8CVvNpNsvWx/imrKJj4WMBwbgrl/umfTbfpllO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPwsvdCe+LLnwcOCfqZK2zb/9Cj5oHbf2UH8ViMY3Gj/XVTj06rdaTUe0fYS1sJIzviio25EAV4xpvpTje8tTlSTfTMAL3LVcSkZrCVuyx0nQ9SHJ/PlGyb5jqKaDwgmKtrOyMNeIABRMnum+9fdG9byuRjcSZrSgs1l45YfQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9vxmmsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9vxmmsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F7C4CEF7;
	Tue,  2 Sep 2025 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806958;
	bh=IrL/8CVvNpNsvWx/imrKJj4WMBwbgrl/umfTbfpllO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U9vxmmsC3tp+pFf5yW0izGduhGdZ4NKPs5JzudT7ypEEKw6kiPVYQpnnvARuNEx0M
	 SIMpiYKkpzty7UG9ygmycmU2wWUo7Amk8IKiFzPk21EyhgVeE7nSHTlfBB9K90tGu6
	 LCe7GbC6jhq9r9kEKLp4UgZbfSaylsEpBKm3lvqJ9KTOQkrAv++cuoxo3I2b1/+XDe
	 WAyucytgfyyhOrp590EomvCl0CGyua956IcyefCxVQJLuJseRMzLDWdnaw7A9LY/3p
	 +axzQNl7mQHxTgN9C4F9aS723RZ5bM6EI9leyTmzbd3YtZirGza7/5GFHdmPNVu25Y
	 dZA9XGkIWY6iQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:54:56 +0200
Subject: [PATCH v7 02/17] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-2-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IrL/8CVvNpNsvWx/imrKJj4WMBwbgrl/umfTbfpllO4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr761I3BRpi697BRKP63oG0wjqocLEh0FQTQQ
 fLGuOvUBJKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa++gAKCRDhuBo+eShj
 d1CfEACQ+tDMq+ZwtJ1m3FbP3fXlmgVY/Q47HuQ6Lpaa9c4Y5+9ZPXqp2ngtf4pYJF2ekmZNtwd
 OF+zVyBnWgXWVFaNs74aEMQvbd689/e+ABSsd0z13xNUkM+jyGMCdKmMKkEWA3XuTtcrZ/exODp
 9HDWVdctrnMoW2TmHjIrj/5w33xPbP96dT5yLHFBTvwVAd3a/lMmzdw1ANEduVutIb71g1DvECD
 tz7IhWRVYQNUGY4JZaI7GLIuVdU7nBNO22TcUQf02pDpSmjhJhncNOJXnVNtC4KB10M++ftrTxs
 ag8FTxQGKEQmIZXiCbVBjLIXQMx5bSP92AkZnHhrJV4wmXnkpDrQEZ5ZCjLyJ5OjWcsbx6AJ+IY
 KBhhAgKNQrn0IXCcwSOz7JDkTGmb0s8AK/d0pmelGXYQ6wO/90fJPP2J4GgFA4Vy0VA0MyUCwV9
 xBQ3m4y9O+z5gwCjuTwFAgSQsb8W4GZfBCsz333ylsl8MPhgtnKpPrhPBNHCKSTgsPD8pPPiFvZ
 wuqsVWakUwclEM55NqlX4cIB/3zaj+ok4zgjcvnG14WaEuDEwuTbRgHH6R0JNp5GYfakVFyLKT4
 TzXa24a0dzvoz20AA8UNrVL1lUECkiMJdLUvi7wyD+9lfzqJ9HMaBrWSDlJneLmp5fbb/aSq7tO
 JMXy+LVt0tFDRXQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Improve `Formatter` so that it can write to an array or slice buffer.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


