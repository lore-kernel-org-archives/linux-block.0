Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB32E5412;
	Tue,  2 Sep 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806936; cv=none; b=FPyEsn7e3k4W5+GVwYSPNpHFmxvvz7FJwgr48boZgOMZ1uOLv17dze7k7AUrSSjrTmS85HtxXb3KrF/RnCroA0+WdVVXVVf2skCjoWquw5KECnlI/twYgmk7ypeS8kFZvsRG+K7OsvwsvIi2aNV8P1FFqz01uIh8mqx0SIgDXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806936; c=relaxed/simple;
	bh=rOUQXRZ83o80AuQ37m2uEGiiSyGCYlN8hLzAd5IY00A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctWbPC0Az/OxWSGcMA1zVW+d75u5F8KCYW0BrEjTAyXQxN3iIv2R5KBeJ4moCzbUwI69+a70R9Gm+FIO6ENVCG+KRlv4rL5nW8hEgN+831brg2wH9GEt0A0FK9g3yifhlqloiaMeFucJvkf2Y0b5fNyPIqNBfq6KRcp3DwjJUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc3v+sD7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc3v+sD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47129C4CEF5;
	Tue,  2 Sep 2025 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806936;
	bh=rOUQXRZ83o80AuQ37m2uEGiiSyGCYlN8hLzAd5IY00A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sc3v+sD76Cfp91bar+8hY2uR2Vll3pz0hhxpiWvWMHa/4fyLD9hZ68YqjeNTAiJ3n
	 rkRj1HfUQgFEO/MxuOlVNDS5Urkz9zxZtKnEqjxFioxafp0Y2kNKoPnDPQ4hayNMFi
	 IXBnH/jnduiZrN8BjVih5Fd6PLg+36rsz3kGWrnJF5vRpE9XsIMuAHhpCl9cKuE8FO
	 WxNZkY9Xwx5T525dhCTVyVR5yTarNENPcdlLng9ndrgVcKl+Gj0C1s9s/MLf3tBEGr
	 6/ooT17fvibx9xJlXG8eOwzmb6VabtmhQ9D9qZu6Upp68MfzqKUb0pm1IMnF9mWv8b
	 G0HDNCgJlrAww==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:02 +0200
Subject: [PATCH v7 08/17] rust: block: use `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-8-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rOUQXRZ83o80AuQ37m2uEGiiSyGCYlN8hLzAd5IY00A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8A5Ei+YAWjlEujbD5s51yKCLiyheQdKiXgd
 4WJLo1hCROJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/AAAKCRDhuBo+eShj
 dzUkD/0VhEDq9QT2aNlifacumpaLB2zsg3v2zXvg9bKAAIFZWZBN+txR+cnPpAaz/AdXhty/eBG
 5R15sViSwzIKUn4H1FI5/VhBimnj0Th2/4oqszYCH2tvIrrVdmF4cCrl1nCJRrNoMePTKGIV5Et
 u4cf9xmzgLmdRajLmE96VeV76/qxyyFRlXAVZzUjQ7u2IgxBaZxCnvE4G6IEqHzE1bKfM3Coe/O
 Ua843TgDUu6D9xCTzy+8ISMFnSdZ4kHCdGbav5WdCyNgKWrc+WfE3W8MF26Bkem0uHyl9Na2b3g
 gpxfMSrgQyj6nfQm8Pnk5guH+A6QVY2gO/2Y+pp2Fc0ihLFQl0WgVf+vrRh2UVppxEc1s0Ml/OO
 je6zv8Pw+juxm47//hvsbeY1hW3k1Vbpm0dWBHy//79XtGJw818s1Ms6UJz1ugXEOHpIYXoCsp6
 Tzdf8bmIWh1G7uCvoqQPUNa+1eHdsKezNYnVgmwxggcL1MDLeORWQGq+CZ3biWRhlFhWnDMyUh1
 +c8mMWQpN0wxK5PfCn81Vphcv516zNODd+n85nSFisbaReBSXRhUAr/kHvmjGeO4cDnncsmXG4Q
 uh8FDnga+Zl/m09MR/+euCtpcQXlJpmcCrdLcV7X/IjSv3EJSDfnf16h3Qa7tQm2FsIdlYSnCgb
 00i47XTSSLv5riQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
the name buffer. This new formatter automatically adds a trailing null
marker after the written characters, so we don't need to append that at the
call site any longer.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 12 +++++++-----
 rust/kernel/block/mq/raw_writer.rs |  1 +
 rust/kernel/str.rs                 |  1 -
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 679ee1bb2195..20f1d46c774d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,9 +7,11 @@
 
 use crate::{
     bindings,
-    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
+    prelude::*,
     static_lock_class,
+    str::NullTerminatedFormatter,
     sync::Arc,
 };
 use core::fmt::{self, Write};
@@ -143,14 +145,14 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let mut raw_writer = RawWriter::from_array(
+        let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
             // yet.
             unsafe { &mut (*gendisk).disk_name },
-        )?;
-        raw_writer.write_fmt(name)?;
-        raw_writer.write_char('\0')?;
+        )
+        .ok_or(EINVAL)?;
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
index d2f9ebc94b75..5c74e5f77601 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -886,7 +886,6 @@ pub(crate) struct NullTerminatedFormatter<'a> {
 
 impl<'a> NullTerminatedFormatter<'a> {
     /// Create a new [`Self`] instance.
-    #[expect(dead_code)]
     pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
         *(buffer.first_mut()?) = 0;
 

-- 
2.47.2


