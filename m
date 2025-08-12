Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32D2E975A;
	Tue, 12 Aug 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988381; cv=none; b=f9lGFzI4S28XHfywwIgmzUxtRn+WQIUQiklhqO3wlXIJi4uVZDoofAqG69VqEE0QBW6e07H8tuUMeJxTbuiUB4kCPveRJteggpBRyENGY6RMrmLY25H9ot+3LlDVvZomaEv8k3BJWpSk+LSk5ozXQYVJJJNC/toJifQgFWTAqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988381; c=relaxed/simple;
	bh=BveodvWEzB6MGjcIRLP04oNvaHBriQqviB96NYNDa+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNTtj0NnNrwwlruLfcoHksC9Ga8l0wUse6P6r8yKf6gmxNK+KHSJDhcq4nxbK3KscSXwYYSvpakql7cjyFKTi/MVLKYkc/rVGvcet8gCEmwyyzFKd4rY4njeif7z0A7TOZPb/t37HeCzv87KSjr4Zu3hDnCRKKzjWN6cqlD9YaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f53wvq+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f53wvq+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95366C4CEF0;
	Tue, 12 Aug 2025 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988381;
	bh=BveodvWEzB6MGjcIRLP04oNvaHBriQqviB96NYNDa+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f53wvq+hCa8Mw98rFvVkIOxx8V3faZJqmnNYw4Uv0S0A/1C5VGu7DOdu61uIRzrSF
	 IrnsiR2xA+CsLP4NvLmG/0M0ENCjSBG8T5kdzbwrkzv3bmQem6WV9tgC/VAHEaRnEE
	 WR5uss8GI5v/vQpHRPLYZxTedsPL/ztcg2GlhPa0crfXzMNJEDtchqQssUngS48iBh
	 x/IdEwseLKpkkmW/oGYk2v5GGKhYrGdMtEcLkzLOnNLM0zE/nCdb2L5ha/E57qNF9q
	 lZGok57JD4eWzkgMQh7VQ4NHPUEhJvIwrJAEpFosqlb/ANCAEVGfonXy5NpYcnuTdb
	 vRcstGW5pksZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:21 +0200
Subject: [PATCH v4 03/15] rust: str: expose `str::{Formatter,
 RawFormatter}` publicly.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-3-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=BveodvWEzB6MGjcIRLP04oNvaHBriQqviB96NYNDa+M=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8e1+pSFP4hOqDogQ+2AgdUf3lgAkjqSMCC1
 SkWss+t5D+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/HgAKCRDhuBo+eShj
 dxtdD/9l0hy2XeewX2P0rBg1c3j+ESPyb6DIsPvAF92HbJHwpTB9pqwe2aMbzc485+uPm75WGuZ
 fuPMIbKvW6u19cqW+ICIh7hXV1KlQSySV6J8bBT7JB6Jj6vMbFgbQpbSjBRM7L0W6vR7Vvd+R5F
 672Ih8d4zMre1zUvaNH5gr+rFRfsZU5Daif0BreOeaCfZNG3mUFrWxzmG/G1hc81Ve7gPZAxyVs
 PTcy0BGP+YkRG8J3aR8N52vswbw4KXxbpv0fwCyEV1i1H9hjlEHEdV8qHx7PrrIvMqcLMjUthKh
 txLP/Ha/FoKqbnxYTmDIm7uUh4JTCktBlW/lt4TvULlPen4K/2HplKVK+VnvvWIoamNlMt3jSgG
 7UQ9BHwfGdxfQAjHxXFDGg8/sAbY4RLHapfN/8IdSC2CKStxEbz22jDV4IPkHDgdXcMP0SKsnV7
 SoGHmw4Zk2TEa5MrdMuLeSDnIazg/t1LzB3y/euOazBvJJbn1zgXq2lTJAn5U8Pl6myQTxh3Lzc
 3p3tQUffachPkOOTRXbJ3xYE38fMNalow0x1LqxBPow3WsPNLf64LLq2dvVgGGO3zhLVDycHbZ0
 Ex7TejJObfvWL+jORHbm2hkOg862MA2BZ4WGK7JGh2m5p22Ru9377nFmMGKuHvDUoS4f1pey+1x
 eN6uknV5nhJN3dw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull is going to make use of `str::Formatter` and `str::RawFormatter`, so
expose them with public visibility.

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


