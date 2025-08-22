Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBA2FB617;
	Fri, 22 Aug 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864927; cv=none; b=ADU7wIy9asDJMkbhB5XA5kZnRB/FD8ej6zmf6p8kkNW+fec096VREli6R2kqPKTxWUjq388K/AieH5qltjZ4pF1FQNcYoXoE96ch++kiSkuRqLUZ7nparf6afsah/9ARrnmJN2GdOxWeh9ADB+2M9VurGB6HuVBF/XOHl0OgjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864927; c=relaxed/simple;
	bh=bIxxtoDqzYFDJ1IXIjGENBqJclBo9NxY+i1qnM7Qz0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLmsxGWM2ZfhucNNQRaG/gsR5vl/x7H0br+ZPOpuiUnSd53Qz5yBf+MZ+G+EVJc00aC94FxMd6LVikVu3H4SRXxJVWqzCcQ0TKgKEXvJwZ/w2B/f78GTmPjr0Gbu4HCPajldGPGDw5KqyEwgPlmpvAxSgAYiZTJAhwQXnbrwPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ1E3SEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ1E3SEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F0C4CEED;
	Fri, 22 Aug 2025 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864927;
	bh=bIxxtoDqzYFDJ1IXIjGENBqJclBo9NxY+i1qnM7Qz0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oJ1E3SEjEkH0GF8GsmcGJwDYv6SFby6YllSCraLikrMrbJW421ogFP6C+l7WWydsx
	 MwkOuzA1J67aU0aYHSjgyifSA4J9QxgLwM7cBWBLGaifRrpAB3DbN9rflsDKpKOFNh
	 yKznC6Q0FS3rnjiLavv8av/x8hG/Vq63INCzYUVZk/0QVoNrbmvF9+yJAyHU90+9fv
	 HJ5i72lqASkFkYF1BY+VC201hCgTK4hOhQsK7PCUf0tBS1LI+1bYFb7iEVqrRBX3GY
	 OAGZy9LseLzlkqFRxHOrYAKB2hptC+780arAEBiEVzMOcAXOGB2OuGTVs65bteyXyl
	 BpQqfUHq4knyw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:41 +0200
Subject: [PATCH v6 05/18] rust: str: introduce `kstrtobool` function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-5-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=bIxxtoDqzYFDJ1IXIjGENBqJclBo9NxY+i1qnM7Qz0o=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF82flEFsnvimB9symy7Ed4SF+IaSLnHrFYhA
 A7cQmKaMM6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfNgAKCRDhuBo+eShj
 dzg7EACPTsE9Guwck+I8kM8n6or3Jz24zvlyySn2Rjxw1riOjRg4gBRhSib7JbWycYglCJc7FvQ
 qPPOjm83UUJx+v+g97q4fJhmPR2PPUyr/BhDb2sZL14ZoP4zuaPaO1BQVUDv9gb7qcbQjnf4rjK
 iaFkANSvlUchHD/NA8WZ4VlcLdLWg1spQdhxmrxNbjFXTfEFavI1y6qKKCMXKEUnobCZ+aAj46z
 ku+bwIOPJmWo1Qnfb10dV+/T+0mZWkbKhJwFk0ONNDh22Sj/wYcNnKzaWrmU95rIdhBlDYlPxtp
 MytOeYq+6jsiZ9onfn3qBzIIEShC7JxKuKL2GBxRX5ZoGOrk51ZrzB2+wpWkzEtzCUpxJBPqwY/
 f2Mr3KuWyh+ywypVQwKGPDQMmeSjojXnG30dgqk7kVNwZYJXy7VwXE7w/G7IPYOWEPkZXLWE1tE
 yKgQvRgk4HHd7XkuPyFz+V5E7e+4fDKcGfQcqOLrMTiE++6vjNTpSmx/SveBdW+COHcJuB4SbL6
 rgojzDI9YBpbFgHo+X20hm0lWzSnQy6yzWmRcpP5HPj0KUGeu5ovUAlM1V9wo78a+2OK4vQU8+B
 6LLPBEWBScom2xemjaM9KuqmejRbl8mLwyxhVvcPLvjAnxaOLFGSRfvA1pEoKMpcCkJG75S4Oo+
 LscmfAWWT+X1YlQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a Rust wrapper for the kernel's `kstrtobool` function that converts
common user inputs into boolean values.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d8326f7bc9c1..d070c0bd86c3 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -4,6 +4,7 @@
 
 use crate::{
     alloc::{flags::*, AllocError, KVec},
+    error::Result,
     fmt::{self, Write},
     prelude::*,
 };
@@ -920,6 +921,62 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
+    let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &mut result) };
+
+    kernel::error::to_result(ret).map(|()| result)
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


