Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36E2FE58B;
	Fri, 22 Aug 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864969; cv=none; b=gYCc6ZRNQvj1BaANkWSYsxFB7/+XKWfxogoUJP3vCt0fUOAp5Bi3kCpKJ/NPHFdhy2OKylSumqjIk6U+ZufZw34fxgCdVE+1K9X8DYZg1kH6sVhrNWUOxHX59iaLUYmRBVW2VLqVh7eDwo+GqcEc26iaOHrwjd5UOjlVcU6XTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864969; c=relaxed/simple;
	bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwQLdmSulWV23xmMjsygvaxDNCKoOd73z9emspJ3TiemlfJWPlVtgfnsKZz+EI68J4zuu8Etrcq3nk5ejFNEEu+zKrK/6vJT+TFWfjVk5saGEp4jgAKDW8yfspZcoP8HS+ExC2Jb6ePVE/XYQ5fsrD5jSpJjvgy6fVmdCSYgCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CteaHG5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CteaHG5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3AC4CEF1;
	Fri, 22 Aug 2025 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864968;
	bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CteaHG5uYu+fgU0ydpsQctoO+NcRp99GavfSh0gZ5Neygi8ZsqBkW9AUBuxranIFn
	 rbioL8nUK4Hhqi1+tqYeIb99EazrzYRS8hxspN/PnuD/uaaLgq8RF2NoZcrIWb4OZL
	 WOkRFSR/IUk3hn0BuKjSPpgk4cn89mWouD89h9OiTDz2a3TSMJdP+ghSHu2uC0rxyw
	 oj4ZTKSyUmqRGomL9CDsA9CMZcHmlBpx9stSUKrjNikXxl+R7xGILPGXQs3g6kxxMC
	 625e0YKD1/5VCRGhbQ1mxeuNelgz3D9hZFvwrTFBDghkP6eK8DX1vvcJ9JTUY/SLoS
	 ybtXg1rw+1PPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:39 +0200
Subject: [PATCH v6 03/18] rust: str: expose `str::{Formatter,
 RawFormatter}` publicly.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-3-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=0EwZ8Bosdo4P1PMrvkQ74N/d1HBPfa9SjJN+YgtIPJo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF80+rrHS7+GZ81ClKoMp1B5FnJIH4cZzbR+9
 k4O04baqHKJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfNAAKCRDhuBo+eShj
 d2ldD/9QpdZrIQFQXXsHosaGs8sNuzaafpIEffo9hkUXORjV1Rp3i23cpbWzjtks/RHCyW6Jjy4
 +K7ZNNnngVY391rjjkrHlC8syOouJ3mnX8il3XHbCNIJ+n01lGo2SEGLm4RjQCzRWjn2N4ZvGJW
 H4BkX0y/BWTERKMdul0uDDP1U/FsFU2IgvWBG5W5zo4yrvmZD59aH5un5o/PbvzEXyDA7Psgm8+
 FAp0G5Gy/J8IfP5AGi+yzfcaFS+P4wMNmcwd11Wm1zu5FE40M7rgkMzRX978p5ssLt9cbwyfbfc
 Bj7EA7yKKMF+cm0PNxEoY+UdlRG2IyaECRExjmINEJfUAJxYWmrqqrBGgGfysKdH9a3zyi72Tti
 mVDe9w3lC7k6EM4YOMFLkILPe2JrN/q9wshtTbG9yTAZYBTTD+y+wP5fPKkqpgIux/KBIPa3doy
 tuBJHbl1RuFVniYBy9fc2M+6+FBHfyo27/r2llTI1/aC/RPJtObVXMAuHgAZ0ikkjQT3IwoNMez
 b/HbXvf8JR26GWQLuG0MywcNDTjXT/QLeK7U8pQKZkArXvdK4DpVcyi64l+Lb4pdir66N4XN4A2
 hMn+/985BOYL+TEPqLL/UjNMwaQVvspPfMAqZLGxjjt99lNVfL5uEJCQ2bt8DTIX4mGFpj/qp7n
 dV3odvICku5OSuQ==
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


