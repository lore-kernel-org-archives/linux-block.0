Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32858218EBF;
	Fri, 11 Jul 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234242; cv=none; b=XG/fndMeKq6LWan8lzuUpJYk8LspZpQ4nBORxM9ocHzxrEf9P6mSb0FsG+qloEH2ylU+mUbkPduwyLXJmyY5CC72tll0mxkNKhw2MX2sxSsynCEZgbBmxjE8tp1l3LUKQgUL9mkZq4SWQUQBkR2v/bDiLStkTi/rdIYy7G9cEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234242; c=relaxed/simple;
	bh=c8ef8NCxcJj3uhP3telW9Gs7hYZ+vnC1spPz72jpOXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYs/5Z0GlELmi6s6tKnZ9U0OuoBx5UKItqkNlFNd/3P+ecNm4eGkh1B/5vlskZm9CsEnTUV0GUAF6iIyLzqMZ5lZqxhzvFsNoojjQ8258iwpCgGL+UKI9nx7UQgUGEyIYoPWQdIaNZLlxN4r5WLemHcRlEH6Ymy9XHsWRSoIOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPhYgKfd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPhYgKfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640BBC4CEED;
	Fri, 11 Jul 2025 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234240;
	bh=c8ef8NCxcJj3uhP3telW9Gs7hYZ+vnC1spPz72jpOXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FPhYgKfdqbO7r+g+fItzkqokF7x9IzuEZPwUh5nmz2Mzp49/GuJW2VbOXnDJMGvH9
	 MTtNxsNpcSHU66wQmg53ijo+cuuQt3DYAulm/f+n+M5h7ynolr9GA3XlJRUFVoOdoJ
	 ZfulZPbL7V0bV0ivMhSK12y673c30FkQc0HDhVxeXKegmg00wgL30IPdcZLcFVGtuH
	 +m5jVX1Ap6o7dkIeLK2I8Qwy3+1tl3x6zh5lqnx+/vSKBn3ZR6VWaAGdQTK2hVgaL+
	 M+c5EiRyr/LkTnpjvpZIkBevkvaNGuxFoi3ncKNfsoHS7OhflHiNCao1p5ZhT8NwKn
	 JC/sgV8NGXqbw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:08 +0200
Subject: [PATCH v3 07/16] rust: block: use `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-7-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=c8ef8NCxcJj3uhP3telW9Gs7hYZ+vnC1spPz72jpOXw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjQfUjXOcIs00NfAyS8HbQU/kkUa/+DvN9RD
 Y+RJQ+1useJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD40AAKCRDhuBo+eShj
 d1BtEACaOsfocomU65bbbd0tTJUQH9S81vtE5L2lCPboJoYhEcb3KQLUIb2tIGs1vaSEBKtqsuF
 7CZ3BMzrBGP9Co05GFO/wP0sDzmnijluy8Lwj40tcbmPcP11WIJftbDckGuwTSQ/NlKNMxCyUmy
 cPE/4Jv7yJq0mCwZhEM2l4hlWiVJ9kpt2K4KTjMDXbvUiPdsIjPMJ8MvF8A+Eua7vHsYAc1KKa8
 5nY3vwv89+iTOYelPOIHGzkdGvInB+X5cpLEml0hzItEqXQhzXVqNio192LqbhV14s9jiBtlE/7
 0ypFN/aG5Dp8lqv7AHXY370BpWYr8s0vEH7hx6TAM+T+YnSx1Q4aj4aCkfaPnkfPi+sBb1E+4YU
 6/qLts5wFv0O6+W4k/UP3NIQSDx8u0Eg+/tgrUqJ4ouHKyMohdeq2qhrxSALWTLv51aNkRwoSKN
 /GEKEpvrwVHaO2FPe5v3EEx2VV4XraD7XP/s5a4xqFvh1GTHRdY6z61pHFak2KXhlp4htx+Xqax
 33SyCxuNcM9u5onMSx53zyKBAtWCYrtYtPVpPa+2cH1QKP2eBhiqAON/QhJsMIB1qqaD9Sl86WY
 cGzMYmAVHEsKHeDTfsaWYX7+KvEaasmOZ8XZL0CLjq5zO0Fw+0oVJdh+CFJ+OPHjRQE7w1mx5eJ
 cidIwNrWGSIgnNA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
the name buffer. This new formatter automatically adds a trailing null
marker after the written characters, so we don't need to append that at the
call site any longer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 11 ++++++-----
 rust/kernel/block/mq/raw_writer.rs |  1 +
 rust/kernel/str.rs                 |  1 -
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 679ee1bb2195..39be2a31337f 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,9 +7,10 @@
 
 use crate::{
     bindings,
-    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
     static_lock_class,
+    str::NullTerminatedFormatter,
     sync::Arc,
 };
 use core::fmt::{self, Write};
@@ -143,14 +144,14 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let mut raw_writer = RawWriter::from_array(
+        let mut writer = NullTerminatedFormatter::from_array(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
             // yet.
             unsafe { &mut (*gendisk).disk_name },
-        )?;
-        raw_writer.write_fmt(name)?;
-        raw_writer.write_char('\0')?;
+        )
+        .ok_or(error::code::EINVAL)?;
+        writer.write_fmt(name)?;
 
         // SAFETY: `gendisk` points to a valid and initialized instance of
         // `struct gendisk`. `set_capacity` takes a lock to synchronize this
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6..0aef55703e71 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -24,6 +24,7 @@ fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
         Ok(Self { buffer, pos: 0 })
     }
 
+    #[expect(dead_code)]
     pub(crate) fn from_array<const N: usize>(
         a: &'a mut [crate::ffi::c_char; N],
     ) -> Result<RawWriter<'a>> {
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index c58925438c6e..7396c49174cd 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -858,7 +858,6 @@ pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
         Some(Self { buffer })
     }
 
-    #[expect(dead_code)]
     pub(crate) fn from_array<const N: usize>(
         buffer: &'a mut [crate::ffi::c_char; N],
     ) -> Option<NullTerminatedFormatter<'a>> {

-- 
2.47.2


