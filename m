Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D622FB602;
	Fri, 22 Aug 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864958; cv=none; b=MISSI1EmhjCJTcxyyMtAnPwGyqjUVmrVMhN7jHKPkyunAfRa0Vy1trLHtHJZp0oWZZcWG/IDtVD94i9CTfOngZVtene56j53jOR9ZbcgAYN64hshj4pJQRGNkGBKrENSa+G4YdKvkohOvT5Wf6KkahM6Z+S+PcVyWzIEL9mV/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864958; c=relaxed/simple;
	bh=pnrl4BHc/0QCGXcnlvXhVfPL/hCVQSnNuvvFpYApzks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI0unaqys1kKOCTRR1gH0X3FAi22O/gwlseBZia9TMFlQ35LBqyVnEbokDN05Xlsybn5KLKyxl00pAVco8dSz6xWIZz62uJbTajY4XQMiZ4YemiRK1CZA/ne92ryRq+dbX1q5B8WtvVzb0GElsX5wdqb8svgSPJN5ftTo8U3y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/FLA875; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/FLA875"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4161C4CEF1;
	Fri, 22 Aug 2025 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864957;
	bh=pnrl4BHc/0QCGXcnlvXhVfPL/hCVQSnNuvvFpYApzks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y/FLA875JXp7wJkqK81JuURrI8rDS18UCuzxgdG9ySClggRM0mvBppLbrEPqMVoGw
	 RPXYZfptCAkvG3jtNnRH2GPgxOeLHv2RvmZb1VOwkcoY2YB5MflQjVc9Y9I/pZ6WZ1
	 8COUTKr+chcMJ77uOarmjjvFGa2beAdsDkgAc6VYEBpRHSMWHDALzIF1V9gJ2nAHwr
	 e9DwEV1MFbIRNm5uh/nDwZN8AcKBharOUZjo3qetqsd7cftWf9d2qiUYeqFmdKKVe/
	 ZUXDbFDAMHWrBS+JoKIHEHAxa5tl1DrbHMp+ftRa6L5cAV+6wmPVZ+cNQTXS1LIP8M
	 YydsuVI/UmmhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:42 +0200
Subject: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pnrl4BHc/0QCGXcnlvXhVfPL/hCVQSnNuvvFpYApzks=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF83joD+qfDFd5COVCdtfn2Uj8Qes74wKaVFg
 LfX599ms3+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfNwAKCRDhuBo+eShj
 d24nD/9YPa7FLU1snrfCuoQK6W+EWxTuFfetVokgP3TXmRcM3lq8ycM1MWGV2t5DUL4yhxLYzcu
 i5sh49axa3ZwtZTlqOmt1E+D3U+mpXrWI1WkR+J3mhT7feLXxD2cj7VfKLa5gY5OC4mXWq7xmMe
 mUyhk/MFHhxPArMQuaF5FK8r2kYqTuiLC7lUmT+IWQsZrMUMKP87ms9+4t6HZ7CuRL5UBIDUDY+
 TbS2v5K4BYwhSA3iUUwBHWoj9q187d89yKh4x/4Pu0OI7pcFLfZwP6QmRjbrgpr/nb0fmkP4JFd
 2z0lpQm5VqcwwfzncnFFtQ3ZYWJ5aI6Flur5op+G6dC4MZMv9PzXE1kmlGrAKSbGhG/GG8SpmG9
 4Lf9mISNr8TrwEWhVIEHNyvv4rmegtWchMu93W2dIjAHmmdyn/hACsVstiKx6gp1CgRxfIQ3s9v
 WAWuK8dhnw/xqEUHbP/0Ns1zY/4wA/kyA56x32eleAk9lcAqr7j+SbA2bYplmcDw9G6UeWyuzGf
 khbgYT2n+qAcwyypgkC5fHcmigRUR+xhbmSCFk3CjJZfpPkNQXa5K2xV9TCCBfZAOQe5GmUM363
 5YYyZak4Rl+MQBRHQL/bSI2UE1PyF/yXyxc/DCKLWNY0RP/eqZz1ItU72AMOK1SwsZrmBwS2mfX
 v+HpO2IytWO5Jhg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a convenience function to convert byte slices to boolean values by
wrapping them in a null-terminated C string and delegating to the
existing `kstrtobool` function. Only considers the first two bytes of
the input slice, following the kernel's boolean parsing semantics.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d070c0bd86c3..b185262b4851 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -921,6 +921,20 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
     }
 }
 
+/// # Safety
+///
+/// - `string` must point to a null terminated string that is valid for read.
+unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
+    let mut result: bool = false;
+
+    // SAFETY:
+    // - By function safety requirement, `string` is a valid null-terminated string.
+    // - `result` is a valid `bool` that we own.
+    let ret = unsafe { bindings::kstrtobool(string, &mut result) };
+
+    kernel::error::to_result(ret).map(|()| result)
+}
+
 /// Convert common user inputs into boolean values using the kernel's `kstrtobool` function.
 ///
 /// This routine returns `Ok(bool)` if the first character is one of 'YyTt1NnFf0', or
@@ -968,13 +982,22 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
 /// ```
 pub fn kstrtobool(string: &CStr) -> Result<bool> {
-    let mut result: bool = false;
-
-    // SAFETY: `string` is a valid null-terminated C string, and `result` is a valid
-    // pointer to a bool that we own.
-    let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &mut result) };
+    // SAFETY:
+    // - The pointer returned by `CStr::as_char_ptr` is guaranteed to be
+    //   null terminated.
+    // - `string` is live and thus the string is valid for read.
+    unsafe { kstrtobool_raw(string.as_char_ptr()) }
+}
 
-    kernel::error::to_result(ret).map(|()| result)
+/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
+///
+/// Only considers at most the first two bytes of `bytes`.
+pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
+    // `ktostrbool` only considers the first two bytes of the input.
+    let stack_string = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
+    // SAFETY: `stack_string` is null terminated and it is live on the stack so
+    // it is valid for read.
+    unsafe { kstrtobool_raw(stack_string.as_ptr()) }
 }
 
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.

-- 
2.47.2


