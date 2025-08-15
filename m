Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031A2E2853;
	Fri, 15 Aug 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243135; cv=none; b=m5SFfHE18hKY0n0bE06uNRi6lPogvSrykQQROPPLuN0igDKiTPJbKPdAO1guUWVw+S+C1mxMRLbroPVnQ5SXyb4jbcXC250t8RLC0Wk2QzsivHOQXV/ecWynOc1apUTirz2f/Y7l5sbp39cWQ/toED7X9Gh3a+KBXiujoyGtZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243135; c=relaxed/simple;
	bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnJnBT17EWIL70sPEfGsD9ukejK9+xU/m2qSlL9oXSgfM+fYhdXIKNFwgECaNmn0gKL2UD+UVcNW3SBdQJfpEvsOuQ+D7Voak4PWufZIgf8q7kIKdKV5x5Dv4Vurn2C+ebWnsr27qMnz/Q9JhpMx8g/fFgwNYDAEqDun2MKzvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gER1V5hN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gER1V5hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA5C4CEEB;
	Fri, 15 Aug 2025 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243134;
	bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gER1V5hNMG5oecJuxGCVxwQ64bJnJNVuc3KTfgFDNHqa3aif7xeaiGxSS48+Wevqc
	 1bWCdeTdq+Sl2pMu8tKjzmdZfyhej89Tzoru1YGOrtDqbstR7b6fVX9t9MK9t4ByD4
	 iYf+f/f/N5uHY+ZFjUIEW8vNhigVaYVTYxfHf3hlGR8mzoA6Je7Y5e27Nu52UQYioX
	 onskeIkM9M6NxIRYB4EiXUTNCYiO3okMRuJXaSpi1lf+5NRTGM/Vx6brBBxxDvdg+v
	 i1zjzSiyweNKfP5TwSKVaBew+2kFhK/vO0fqIS1Wi+7qT/jWQbjxew36xtuZVHYO7G
	 3NtV7/N9yMI7g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:38 +0200
Subject: [PATCH v5 03/18] rust: str: expose `str::{Formatter,
 RawFormatter}` publicly.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-3-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI2hSO5+cQftJrpInWHKQMFvFjF5OjwYj0py
 eua0QDIG5+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iNgAKCRDhuBo+eShj
 dwELD/9cTjghKDWUtkViDnmdNNe2B7cwgasLZEVzMGhRCUVjX0VNhPaU3YflbBRRqhHDv4HAC9Y
 gb0IhsmdtcBqBhgmp9Z9wQ8/fR0zECWaNXh/p+wpKjI1iVpJmZyVnYMa2YQkPvBtMFgJWBy7JI4
 tfwNQhysauxk5ybhyaiQTBQb7xzxrxmfYI8OD03OssSTu6ahDk88cVE3zxemslExOY0QYqJ/tvG
 538hAYJPqGUIMlmT5NgEI+D6zO/dXMIBDzOURjIv8YuIswg3btLQnwCb2fJLqWBs1379B1dT1L/
 st7LBQVznKqOd8iKTx2A94HnDC36b4MB8f5cqY8s+jCF6xnNYtqVMeWxiguasFvAC0dxp7EiqMp
 8gA+OcCabd9VlVB9ybB5+aSUVFE+pe/wjabtRuuR1+szRTrOknIEhfbKWxcKK+xisEUxn8iA56V
 WRZ1XuMdkDKDqetL2VjGvDt6HuGFCCbYKx1sxFg8nIK3iQRY8u0pbGmuorG00nUMhtjstvGkIGV
 CJacumUVlZyJwJzn7bk0sK3KhCv/1jYyt50l0zciMy5cTbJ4weU7TjuKyAQYN88Rre5hIHDI4rx
 yte2xcpI7LejcPExKvlloteuL96bo5yiFGSFpqJryviWf0DOU2vnY3UM6dQfnWx+ubbqp8rNPf4
 Kajcpgvapr6pUhA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull is going to make use of `str::Formatter` and `str::RawFormatter`, so
expose them with public visibility.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 76632da357a6..46cdc85dad63 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -736,7 +736,7 @@ fn test_bstr_debug() -> Result {
 ///
 /// The memory region between `pos` (inclusive) and `end` (exclusive) is valid for writes if `pos`
 /// is less than `end`.
-pub(crate) struct RawFormatter {
+pub struct RawFormatter {
     // Use `usize` to use `saturating_*` functions.
     beg: usize,
     pos: usize,
@@ -794,7 +794,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
     }
 
     /// Returns the number of bytes written to the formatter.
-    pub(crate) fn bytes_written(&self) -> usize {
+    pub fn bytes_written(&self) -> usize {
         self.pos - self.beg
     }
 }
@@ -828,7 +828,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// Fails if callers attempt to write more than will fit in the buffer.
-pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
+pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
 
 impl Formatter<'_> {
     /// Creates a new instance of [`Formatter`] with the given buffer.
@@ -843,8 +843,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     }
 
     /// Create a new [`Self`] instance.
-    #[expect(dead_code)]
-    pub(crate) fn new(buffer: &mut [u8]) -> Self {
+    pub fn new(buffer: &mut [u8]) -> Self {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.
         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }

-- 
2.47.2


