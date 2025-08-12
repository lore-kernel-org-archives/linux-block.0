Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315E2E62C8;
	Tue, 12 Aug 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988386; cv=none; b=PnYRJfxMjEHr/U/Y09Dp4YdH0p7oULIYTwEZmfOYjnZIUndZL8BwJ1LPlvrpk7NOjgab8Mh4g4fOt1nUGn7lEoVmKBDN60xANsFxsVKg9NkfVkmgG4o+9Lo+BxUjrOUYPEi7C6CSc6K5xKos2zRiVWNUwzUzOCGx4ASMWTi4Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988386; c=relaxed/simple;
	bh=LiaDRIukgxQ10jLoKnR7ZV1S7vIQx9wTW24ArpjaY5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhoSsSgEglf51GuxH4RDgR2ATL+Z2fdPG7k8EuVTy4mMt/yLulO2OF1OYIl1gfgBmbT1hqD5f+4kzvTXVCg6SdLcsuudTXIiD6EkSA80wwS75bdNig0Sp0LnSq4zhF3FHlQa8jvKKrUDsLBgXA74dA347ijrbL2Ot6u/hl8wgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft800Vv2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft800Vv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF37C4CEF0;
	Tue, 12 Aug 2025 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988386;
	bh=LiaDRIukgxQ10jLoKnR7ZV1S7vIQx9wTW24ArpjaY5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ft800Vv23gZxQJ+SZOvHct4qJJRRa0SWIqLK/KMimXn7YYReaEov4BM+h5G5dmVVi
	 1oUO2ZUXyv7cOqH+J1F5YMNMFsNoAmn45vfH49JjSUL+p/cK7GL7tbEvUmkvMNmLC3
	 txQmwJIXravQwYbP3Q0G78TuHDmn+lFGjxnYXgWBKuXGdmn4NtK5mxPoey91d5b2lp
	 wOlkxDElAP5C+ilnX+jPeZ1HLycukFnQU//OCwPaNQED29LgbTmhwGVWOxSpQ+E0gv
	 BPKdiNeKFsQXPUCdBqXdAxYyarGk/Gg+WpK5tmCPj5pz/UMakdmX/jquR2GqvbMKdv
	 G/ZMkEqc+siuA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:20 +0200
Subject: [PATCH v4 02/15] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-2-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LiaDRIukgxQ10jLoKnR7ZV1S7vIQx9wTW24ArpjaY5M=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8dOg+tWAebpOsOzOIbstCu7JSswO0iOdbYh
 ccMq+Xhv46JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/HQAKCRDhuBo+eShj
 d06iD/9CMSzzqlw4Eya2xtHn6xJ1Yxa7LWvHaxBhAFlzr/L4YxubXJ8y+RphqtBnm2V3nSTJDPp
 7/WtlyAWJ5wtWlUWEcelv7qDbHlBuV4YbeXTCu6BRS+mvU5qGJDWDCRFPb/tQM5mbUnCDfnVN2d
 NJk1s0HOmu1B9ZzyUbB6vUirmFbg4LEBCsdTeTNCx8bf5fj9YFtZ4DVgWwlRcFQh7Ohw4Bn5uhF
 KfKxSwXeUg7TLKt3TWGdbaN3IvhEOjzb8p9nPSDEkg8WtvhQTK8VK64OSB7UT/6I3DO2GszmvKY
 SFK4qrnEY2bJypNoFGRmlj7MlJPlw8lFVOzhtvePH5FzlG/Ajv5bOGFnPNbdzBWKKBwHPca1qSe
 Gtw7cVLIiBfQ6K7qT8yisf3UYJQHab1sdoUwv/20ppNLo/+VW9axNFy00Nf3KBt4xrxcbMPW0Kn
 g8lF/dFhfvcjHFEMtv+pgStQWReK9+hekwz3u2yd3nDA/lCZ3szOKNP33TDU/RfAzR3GJPA5NZm
 L3xzdgL+b9cEHJqWhIzmN5M9dWjEozOvp/BAwOChpZ1uHv9Lt6rAqYjh2dthN9m8v3e51G2q77S
 fyW6UrTrUmIQi+rl5tQa0kFUfxMbEnjMSmjWw5iH4il29C4qXNdoJ4Bm++RMNGxhaBzThb0Zbf3
 NIDhPJjG8xR2+lw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Improve `Formatter` so that it can write to an array or slice buffer.

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


