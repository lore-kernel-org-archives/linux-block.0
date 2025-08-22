Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA42FC03C;
	Fri, 22 Aug 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864918; cv=none; b=SEg8WoIiK5WokLf/hAcIYIEo2JJZ85x6Mno34sBqkWUxuZ93ZQIAhJDr7KQZSSfKTXzPeZbhfPjoDCjjrpm1+ocO5BySaCKK8WRAT/RdA6mdmbZ+if7N93VyX3YMezP2Q2VxvTk2in7PxDB2gwfis4RQx9RUmkw0MTi/b1oLMf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864918; c=relaxed/simple;
	bh=FkVup2wcuL8c9tJJq2cNTZw4TsjvE38QLG8Ll4ELGPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dO5aNsSxr3eWHd3A2BDVGWR+PtjRsSe01CVGbKhLZSyfToveyR3KhgcwCo/60Gao/52jwypbZyrv9VbqV75GcjMmRReE4gtcOZxk+6eveDmLpUbEbyQ9WinE+3sjOCP2gEX5aHVv6B06uSQizrXNja2/eFY+T/ZhyHqzRAktOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdX5lPCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdX5lPCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69583C4CEED;
	Fri, 22 Aug 2025 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864918;
	bh=FkVup2wcuL8c9tJJq2cNTZw4TsjvE38QLG8Ll4ELGPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YdX5lPCb/yI3Y1wC+QWIW6K7Lx/o0oQ2TJZtr/21ijWoMz26dP/IKX6iwLLjVqjH3
	 esFsQjyfUYTfTmh+WEvvyjlHMn94bzI8vDph7BBszSASy9r7fIh5XoDFWSvWnwIm2M
	 fsuS2Qhk6BpSgW9zqckcvCSw1jBwiwDXnrSbdHC7rMSqrziPugTP8qkpGbSvm/PW7I
	 AC4ase2hxTuiGu+pxMn+K1aH1Pu7CeEEqatiULmRfDPZbMJJPADVBgflhaSnGI+bP9
	 aa9ouP7fMoPM514IBpZ0rPHEpH7rZhecTgBujNXMxxjXDWFEey9jjEiubOz1yQLW8+
	 zKlPt0DqS7Epw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:38 +0200
Subject: [PATCH v6 02/18] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-2-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF8zhIn+GVKRFOTsaKYZiWBbPIfzc7f0NsPbt
 s7TiC8R71uJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfMwAKCRDhuBo+eShj
 dzerD/wNMRoN7oTltvty/HcxYgoiej+j/Yo8g6zwoAFfnPaxTMhVZW6zIpLpKSKUeoWVDQrCsT7
 k/LruEV7vzKUykXHsXICE8ZIa5uYGfqizepqwYB/tT0GQb4xJ+X5O/2M3ODDzWXsu5+8kJ5KE4g
 5JKuhnaMovBR5Kahbsj84AIdnA/WVfLzYkBu6mZoWTsFV0FThVYH03irwRTCtSckVOffQD62ygs
 3Ba1yvEY+2C9I2RtpgSEbupcZ0GlqJ0l1ghaXHBvslE1yFPHvYxuA6GK/wYyXPzSlBJTNASmhgT
 gbdbKAwAmDXRfxbqomDl+lqFHlWw2QFxRD7ZiRWSo4AJlI1s1Kk2N9KZAsDhMWlM07RSL+4L9cB
 TNqKqNkLWjnYif2U8/csmxQUm+8K67BeTx0US6HigxT3aOmWjvGAWWfJqrFsKgR3CON8RBNiqze
 czxCpQmEGV1CoS/zY/pQvPHbYKnxk2Q0MP38ll5bxNCaKgfBXWaIF3pCIjYaAg/aOuct2FibFFq
 R3xyxUC8PS0pkTNClLTE6mF6uoKCOwLu43J22UXOLnmlC/j6xOiZJjGaCjq8CUU+eapJGNmVAGW
 wPErnSBddDw9uEucsd+mTGTS+nmk9e90NlUwC8tG6lViw+Os6dd7y7JezF/vnusCC2IRAFO9vXz
 i3sNZRHy3KKCn/g==
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


