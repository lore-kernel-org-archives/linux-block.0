Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69042594BE;
	Tue,  8 Jul 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003985; cv=none; b=ryNpECfamIr5xtJwzGMIESZ1QTr4k6/nOpZGkSUYDUViYaoWcbQHY31TiZbjaXvyMdsdr/1MRBrd0+EurFE7OO5zQ5Nc7M3JXArhgyui7sqeqDoJ+SJZQL8Eh/39FMH20Jfkm27ZqEr+e522gzd5sA3KH7ZZjCdxAna4apqvGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003985; c=relaxed/simple;
	bh=7i7e7fiEtIGYD9fchcq2LcqXTHm92DVFhpGmcv+f2KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2ce7nTUASTarwVNkCVfeOl6fgW2i9Fs+46nQhos/iNKkyS9oGkr2n4yDlNEKNrDuAvUNUroobxBiCiOMHn+KRyfCfLgPQKSxRjUYdiIPqKDse16LRi2UaYBgJ7B2X72y0YY9CnnWejOythumNl8LA1S5ZiBreemZUgBeSLXQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI+UqtDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI+UqtDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A67CC4CEED;
	Tue,  8 Jul 2025 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003985;
	bh=7i7e7fiEtIGYD9fchcq2LcqXTHm92DVFhpGmcv+f2KM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fI+UqtDC3BgSBTqMyT2dxnS2KQ8KJYge5ZtQmNkDiBT+D7OQhwyeZryHiOn2NL+ew
	 ACW4mdx94KQQcYFjOp+KpqNkPxa1Smdst86sGxmqfJmlbOQqkt5vrVVocbEq2PhLV+
	 TyNrCXZBCx9qVy6C5OiH5ZTJYDlJfgzZ6f4hv4aiOP/ixVNnAMyCkpWfbb3NBF6I+B
	 R3hN6+/MSntUiLSAZQ0KgUG0pxMELq/FmGc9hO6c3dzJk3VZy4s3jHciAgkOuiVMP6
	 9NG7bbzt+tVUGLzDsIyE1ff3lhXlNf6ODAn4y/P4U+OD8LGdbT2L62hNgMigo2Pdky
	 gUhTBZz7fFTwA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:44:57 +0200
Subject: [PATCH v2 02/14] rust: str: introduce `BorrowFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-2-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7i7e7fiEtIGYD9fchcq2LcqXTHm92DVFhpGmcv+f2KM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVCEabjxTjPw05XJUqWVzIF5Z7Tmo2TrmLgZ
 cNeVFQgUdOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11QgAKCRDhuBo+eShj
 d4q9D/4yv1KgPy/VvY1lc20i5dN5twWfhYTDUwVs/vjT1Br2tP5ElMgaJ1f4G1/2l5DkHFO52on
 4cgVJAsIcdqmS3tRMnLs6XrAShN+b+q67HIMzSX8YRNmaHHHDaiC8brKNvmUlrz9kJ/3rDpwh1m
 eP30pfxNqUo5oMv7gVyL9mpSE4IQI/3cr2bqsBO1WJRF0UvlubEADWpFYj1M2JEBctHayEwmf6V
 iWNjIOPAb3KRQfcYno8mf808MdATsP/IvYzCQMFL06QAgc3qrGZeNw5taC2SxFsjJcfsy7Mb++6
 IiD/jGiQmsUDtI2UsLt6miJEdbp660p9V1pRxoMRDorQGX/2MF2tMmEZBjSmSou6e0b66zVWFs1
 VB2LzTFkWwWjGzBKRQLeIA8zcQgX3VEZZ4Ex9Y+Vpyybp+mHeB+A4w2fPEPa6Tah62uEP00UlBm
 CfPu+A1De9wyUvXUAIPGVNRZFEPx0b7zsI9w3NyH8XYm/9XanncaJ4igjvzBQg0+aI9t2LhPDvt
 8MPgIdtmJdpUvCPdQu0SWFoXITynRB6amVwbB5hlO9zDxEjKLUaZTj/6pO8bZs0YVnv+nzF5x4B
 uLp32pZVBFpT3WD0usGOhoFrDy1jFoKqRusfx/QzWoA2+LnnIBJAE+l/b7mKoquh6N3fqmat55Y
 yu5YZgcoEztWTWA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `BorrowFormatter`, a formatter that writes to an array or slice buffer.
This formatter is backed by the existing `Formatter`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 488b0e97004ee..78b2f95eb3171 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -6,6 +6,7 @@
 use crate::prelude::*;
 use core::{
     fmt::{self, Write},
+    marker::PhantomData,
     ops::{self, Deref, DerefMut, Index},
 };
 
@@ -702,7 +703,7 @@ fn test_bstr_debug() -> Result {
 ///
 /// The memory region between `pos` (inclusive) and `end` (exclusive) is valid for writes if `pos`
 /// is less than `end`.
-pub(crate) struct RawFormatter {
+pub struct RawFormatter {
     // Use `usize` to use `saturating_*` functions.
     beg: usize,
     pos: usize,
@@ -760,7 +761,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
     }
 
     /// Returns the number of bytes written to the formatter.
-    pub(crate) fn bytes_written(&self) -> usize {
+    pub fn bytes_written(&self) -> usize {
         self.pos - self.beg
     }
 }
@@ -794,7 +795,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// Fails if callers attempt to write more than will fit in the buffer.
-pub(crate) struct Formatter(RawFormatter);
+pub struct Formatter(RawFormatter);
 
 impl Formatter {
     /// Creates a new instance of [`Formatter`] with the given buffer.
@@ -830,6 +831,35 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
     }
 }
 
+/// A mutable reference to a byte buffer where a string can be written into.
+pub struct BorrowFormatter<'a>(Formatter, PhantomData<&'a mut ()>);
+
+impl<'a> BorrowFormatter<'a> {
+    /// Create a new [`Self`] instance.
+    pub fn new(buffer: &'a mut [u8]) -> Result<BorrowFormatter<'a>> {
+        Ok(Self(
+            // SAFETY: `buffer` is valid for writes for the entire length for
+            // the lifetime of `Self`.
+            unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) },
+            PhantomData,
+        ))
+    }
+}
+
+impl Deref for BorrowFormatter<'_> {
+    type Target = Formatter;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl DerefMut for BorrowFormatter<'_> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.0
+    }
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


