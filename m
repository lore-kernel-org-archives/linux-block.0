Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DF1862;
	Fri, 15 Aug 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243128; cv=none; b=H0kVDH2lND5yygF+t0YFEW5DddKf6wGVU/qIWxpeI1w1btzXiCzFmPu5VPmUkoA/R/VjInrt8r8G28kZJneLBW27t3KJd7Dzmlfg/aGy2lj0dxF+W56v1OGXxF/FXq8cIsA5saF8yfC3L+OTI3aBxWbbI37e2hR8jZkg5WpLQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243128; c=relaxed/simple;
	bh=F7NQZ7aM/sjs4UN0cliuzm5bcnx/6FXfwMp5ca3gN68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDC5YfBH4NbsY45Uww6iETWR8x4ERrZziLJc0ae6DWvFO47JJtegDES27zz+S7bEoxGjwIjKIrKDRFCnV2Ml1mSp6+tzrx0wEedt4Z10aoEy+dBEs9/6Ewcd7n14WnzAaTuTx2f3Sxds9P+HuudnpBtOD507ih2J28AMlghG0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYMV7rmS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYMV7rmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234E9C4CEF4;
	Fri, 15 Aug 2025 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243128;
	bh=F7NQZ7aM/sjs4UN0cliuzm5bcnx/6FXfwMp5ca3gN68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uYMV7rmSbFot9wzZKrNeruUNAUb3LXNE7Oh87g81u9uQMs1ahVLYMsJXyP75n5T2u
	 sGlXU1xesYUwsCqtzzu8J2YUyI67W+KugiIfQQN9nbWVDDiE0dCqj1pRaHGFvHkUNO
	 N5JtV7U2cTqicQ0OoNuWEWBbhr042rKFI41mopyYOoJ/mgj6EY9iRVxy84rTsWFdWz
	 6VrjgEq1+AX1/hfj6JiSKCVhtbCMxyMT20EWLvcxLdA24BnksKPVq3mS+sMuYY75y4
	 TkFUXTrbVzARYGQUVsBLyeM/IHWxOfKYDYr7e3KDMW09c4VLg1c7muSRG/MjHva4ib
	 rsEOMFaFk4a1w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:40 +0200
Subject: [PATCH v5 05/18] rust: str: introduce `kstrtobool` function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=F7NQZ7aM/sjs4UN0cliuzm5bcnx/6FXfwMp5ca3gN68=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI4uJJ0g/pyBl+VMaxi7s8/sdPJWjSHksM2z
 MarvgzP2CWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iOAAKCRDhuBo+eShj
 d4zcD/9oB4VDVb8WdtwzJDnbNqIIm3vbDWqynjDFM0hSP001ea3NPSZWir0Q118jOnTkLzMUhmY
 DGTbQePcd44bLHQjHuiQSCzQtpuIeXSOREyi747yCW7nHjmdWoQb7odNml3nyKO/xe7bXDrs5x3
 wg/n/30r6fob4DivAoM/yv/pJyGSF2rWUYEVljZL4XuCbWg1tKSPVUiViubHgxQSQQKtQBYZwad
 RJKJ0WtfS0Rzrce67aXTq6f5XcvaMWWdta9hCmi9kwTjqIxeHMq/bn9ceRMpUQN2+MEy8Um/+5Y
 jHzDFrsZeiQ+DArCZxDRlK2hGmdbh9YeSpWnfRRIE/FsTy25CJ2wyKDhH3mRAEUDLpFFBjHLvBs
 AJizLS78HC3S+V424c3HLuVwEVXsclGou90WEpOiNB8GCb54luvm4UAYwwsGiPspEYkosiao9jz
 emHZhGaL5/pMLp8mODVSVylBCyE4r++A0T3DdrSvA+4lcfNIe8X1SMvOGgoZggH6bCtdwLGJz/n
 QN8eTDTcG+AmP2tc2hrSaH5hq6HqSxv8oaMkN2BvPTyBO1pI4KN5mP6zf4v4XEu8beQopcxrlii
 FY6pa77H1Xd0m5tGXFfKvoFMD2qxGWG9wiWl1xeIQ8mXzqHChW5P4SGzlNS+PzREdYH1+y+tuOz
 ZP4BsWdHYJmHwqw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a Rust wrapper for the kernel's `kstrtobool` function that converts
common user inputs into boolean values.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d8326f7bc9c1..5611f7846dc0 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,6 +4,7 @@
 
 use crate::{
     alloc::{flags::*, AllocError, KVec},
+    error::Result,
     fmt::{self, Write},
     prelude::*,
 };
@@ -920,6 +921,63 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
     }
 }
 
+/// Convert common user inputs into boolean values using the kernel's `kstrtobool` function.
+///
+/// This routine returns `Ok(bool)` if the first character is one of 'YyTt1NnFf0', or
+/// \[oO\]\[NnFf\] for "on" and "off". Otherwise it will return `Err(EINVAL)`.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{c_str, str::kstrtobool};
+///
+/// // Lowercase
+/// assert_eq!(kstrtobool(c_str!("true")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("tr")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("t")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("twrong")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("false")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("f")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("yes")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("no")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("on")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("off")), Ok(false));
+///
+/// // Camel case
+/// assert_eq!(kstrtobool(c_str!("True")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("False")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("Yes")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("No")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("On")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("Off")), Ok(false));
+///
+/// // All caps
+/// assert_eq!(kstrtobool(c_str!("TRUE")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("FALSE")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("YES")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("NO")), Ok(false));
+/// assert_eq!(kstrtobool(c_str!("ON")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("OFF")), Ok(false));
+///
+/// // Numeric
+/// assert_eq!(kstrtobool(c_str!("1")), Ok(true));
+/// assert_eq!(kstrtobool(c_str!("0")), Ok(false));
+///
+/// // Invalid input
+/// assert_eq!(kstrtobool(c_str!("invalid")), Err(EINVAL));
+/// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
+/// ```
+pub fn kstrtobool(string: &CStr) -> Result<bool> {
+    let mut result: bool = false;
+
+    // SAFETY: `string` is a valid null-terminated C string, and `result` is a valid
+    // pointer to a bool that we own.
+    let ret =
+        unsafe { bindings::kstrtobool(string.as_char_ptr(), core::ptr::from_mut(&mut result)) };
+
+    kernel::error::to_result(ret).map(|()| result)
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


