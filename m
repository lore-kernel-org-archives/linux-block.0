Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA202F3C23;
	Tue,  2 Sep 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806968; cv=none; b=aaTt4FQtec9qXiMMAsuzJxjIj4c1u2HCM6KgTvwG8BP+mFUVqsqVi4hmAHDwmJqi0rDkABnsNPaS4JXjG8UIbAb81nLDpfMw3OAwR4J3Yl6RvZoEoPezD/XPgjLSzFCJrLWvragMZJaXVR9pJw38m34tFX4htt7ksFnvQW6tXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806968; c=relaxed/simple;
	bh=xhASc7MyrF6ZWmGALrZff+ftLIcqdjV2w4QxOR2K+jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgfO1jqQn4v+B4hGMXPLqkR+bxDIKFgY4p6uMTDBWwLrubZUa0hQ8mIjBB3QNL3VecB92K5xabYnU1a8zdilV3PKAIsuRPZuPA+6AFa5wLwsE46pg2hzqNIqns9KkNxc0dFIrKo6nBrlygo+ukUnwI9p79a2l1IKhEoWgO8L+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaiunMUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaiunMUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B47C4CEED;
	Tue,  2 Sep 2025 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806968;
	bh=xhASc7MyrF6ZWmGALrZff+ftLIcqdjV2w4QxOR2K+jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JaiunMUorhrb9n+7c/+66hbeNwr/l6n5hwYrS+OnG9MKqgcj7xsIsdYeulWNIXR3P
	 jbeEvdrvKL6A6G3r29asxuNtXUE9LsTHkaYOa2R0knDHce6zO8di5iL/tukwXmDO00
	 7QuVhl9FLixPFSLzWSFZ84l15257PKR+5CpSZMoq980UqtFRrV5lFLUmtm2RTr8eXA
	 ThN7NwNpcMul+m9EfSV+EXL0RrBZlTXl9QmftVCCdxw8+GvUrJEIFtcU4KYf48KcTX
	 jIlPeJHqJsSH45WFASi//3qHZzsrcQ6buee+mrpOhwwGgXaICjBPtiemEy6G0iGU4s
	 tV0lBY739WcLg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:54:57 +0200
Subject: [PATCH v7 03/17] rust: str: expose `str::{Formatter,
 RawFormatter}` publicly.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-3-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xhASc7MyrF6ZWmGALrZff+ftLIcqdjV2w4QxOR2K+jQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr773NZpjhJkGgNmPnNTJA76nsMoe76epzxcg
 FehD1w1rTeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa++wAKCRDhuBo+eShj
 d1M3D/4syDxQdfkxcNkio+Sau7pIerdaNfCa0Zw33/p39M+WuzE9jUHu56w/EE1ZRkd35dpvtQs
 iTCoqCYog5LVJVgYXR/TwmYjAm4FqQiaUL10W84CdG681SZXQkLqcv87BDIazOWufrKxtJuSRMW
 WKeMtxk5AJ1s1ggP0/+ITEkRXzRkQ8jpYslogfZNAaLPo5HGXsqvO1bRMYGOfbIhaF8v9zIiNL0
 ViDDFaaF+voqQm7o7qSsBKbZNFnSphdAS/Hr75xWO6Y7mhl0RCuS4XwpWh+TR3RrF3oWlDfH0PY
 MVwBXTR45b6WvD0YHiAIjTGSrUfPooWhX+Houqb+acVrUt5EhiFvRQjhvSRnYNNI6IlS82LdnWZ
 gBIJ6N723lkjrAywbcZMDc0b7AEa3+Joqmtb45De7wdklFWqAGw8/5NeLndHz1YNyh4rsCmsYrl
 26Ca5NUgoR7AHtoOP7gkS/qLwCxNnwsmLQN7lGgvTAFYGIZ9Q/LFUG5mM3Im+WQ5R35Wb9AmQN+
 GdZaVu62V+Qa6z+tw0WaK5jpmyDJHXgfWJr2QBJ1OOk1/GB5mNb0wenOBMhzPo//Zd8mFYK+0Oy
 PJYGvtdOATcJxiueiZuUnIC1NnXdpwm+hOVC8zRzJn5UFFJAwl1WXW0cbm7WJuHkplPz4c05fsK
 WLvTfAcN5ZKRBQw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull is going to make use of `str::Formatter` and `str::RawFormatter`, so
expose them with public visibility.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


