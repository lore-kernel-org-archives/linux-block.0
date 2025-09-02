Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD702F747A;
	Tue,  2 Sep 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806995; cv=none; b=RDwSAE5/SCN15VB/k/hvsP4e0LZz9y9DrjnoQ2pk2PxYxIbN7mWfBRc8m356Ica6opkzbODhsc07sn+CLhrek+NI+16t09NmaJ0T8UH4+0kbtIJDtLqBUEbyG8Xj4Q9Tvo4toSVK6FQmT19O2/1EU9nppIlapkRz8PJZkkkcwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806995; c=relaxed/simple;
	bh=PA2GD1ivE6Vnr85r4kVB0yNi08FXMSJYufL38ad/0LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApFoTx/7xPIVYXxslktApje7zM0hv1Qf9QljTDohAkRkW0kEVpW/OMH10105pAomY/H852RVjkeE9WA9B4+w7HsY6ZG8CtWa/kwrw8a5tAkrgOwnlV6SifLzQIlyFRxoVBu1AKxjvwOFDbE9XRP5RbBrewz8dkKugLr3U5iDn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1/R2Qqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1/R2Qqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A3C4CEED;
	Tue,  2 Sep 2025 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806995;
	bh=PA2GD1ivE6Vnr85r4kVB0yNi08FXMSJYufL38ad/0LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m1/R2QqzD5hyXp4MZasOnKHRVFrY3nX4WGUqhsZvgxNuIvTRnShMRVIDOJUtLoJou
	 DoV+/7jLgBon4qimx0AkcWwcx1MW6FNJ/6ytcnGSrCXxHvqtIL9sUQVGKPNf05z/YD
	 Qb26bRrnqWcbEt92OC6+CwY6wBWCfzkxHeQ3s3vjY9xWZYQvHgOoHebv43uF7yiuWx
	 JRNdIrxJ1i834VuI/XxS3jgr2ZdVrHrT6YgoqTwbETP9ElBTuiW45ruSyXrn9zINfR
	 h7nGu3ZNlnVdYyoGL0GHTmoKOm1XYDpRIbnG0CAdYx0siNadpCBAKeBDJOeQ60Qw+E
	 t6pCAz1v0jttQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:54:59 +0200
Subject: [PATCH v7 05/17] rust: str: introduce `kstrtobool` function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-5-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PA2GD1ivE6Vnr85r4kVB0yNi08FXMSJYufL38ad/0LA=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr79HmUgz6G4EBNPl0dxD+hrow3LluSvmaZ7b
 DUemhcllo6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa+/QAKCRDhuBo+eShj
 d7f3EAC4hPem+YJYIxRpY9Smx8FEBMRBSZc6i+RAphuzs2bA5MVN0sGrE7SsNaXNWpp8Mp5hZP4
 piq6lWQJGH7WgD56FYlAAWzfYYJxVClE8MRYK5/47hA5Mf0jkvQUeLUoSBvTD/EXdoKTe7OMLwP
 LQWJclK3CDKw53T+tGgYCw0TYiRXxoWAqMV8bNNbfSAK6TsLa9To8NaKRkX7y/h1gK/LtvQ0WSP
 jrVNLxIGJv1CuFGwIhJWBABfHN0kuOcbY3YA1R0k2KeDWFO71iIzy3iQnt2hXBY9YnhiKiwTSQx
 EaqG8XYmeBIivFZPHb/TKUknh94OHCEx1sb2hIyftiaKtyvs+FodCjRFWhrpa9cHPwYiLXzHwHT
 8Pl5kew8rW4oNODzqfzZIbAMiqURVpbic9uIABYgnGh3mY8JTh9797SCiQKR51waIEmhY67uYDB
 pyCsg47gHPhNiBJBiLeMB1q2RFHnHHs6ZCh279spjTo+Ri1CoBsZR1Xx5l9lTDZE56enisp8TKE
 FzK+8M3/Xyjg71ZqdIM8o5m6/i3RH5Qu6dsL38/xE574jthnCU4fxcvnl78xTCTN6uIcCI8J1z9
 wkfGjRwj36z/zwZ3k/PntVEAWG15i/w1NxNvZmxLYFO00iVlboYlaCIbZnULBrZvJYtLiBY63nG
 5YrSZc+/LVBO4yQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a Rust wrapper for the kernel's `kstrtobool` function that converts
common user inputs into boolean values.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d8326f7bc9c1..d2f9ebc94b75 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,6 +4,7 @@
 
 use crate::{
     alloc::{flags::*, AllocError, KVec},
+    error::{to_result, Result},
     fmt::{self, Write},
     prelude::*,
 };
@@ -920,6 +921,84 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
+    to_result(unsafe { bindings::kstrtobool(string, &mut result) })?;
+    Ok(result)
+}
+
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
+    // SAFETY:
+    // - The pointer returned by `CStr::as_char_ptr` is guaranteed to be
+    //   null terminated.
+    // - `string` is live and thus the string is valid for read.
+    unsafe { kstrtobool_raw(string.as_char_ptr()) }
+}
+
+/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
+///
+/// Only considers at most the first two bytes of `bytes`.
+pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
+    // `ktostrbool` only considers the first two bytes of the input.
+    let stack_string = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
+    // SAFETY: `stack_string` is null terminated and it is live on the stack so
+    // it is valid for read.
+    unsafe { kstrtobool_raw(stack_string.as_ptr()) }
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


