Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E712E6125;
	Tue, 12 Aug 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988371; cv=none; b=ANN5+Kt5d+597BhxG2M8AWU/SCj2aezmY43+n3PRde2ez8LooOrPZR+QOJ22+JJdc7JbisMhq3nJeI3eiUQBk/UAUPLYeVTaqwYTqiwZNFO6kefWPK3Y7CEJuyW52e9vNTkwIFOHJMhvOCKgvlSbMuEqaKDONqXDpOffexwZPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988371; c=relaxed/simple;
	bh=Q1K4pcq9Ex/JoCw6ncPnJkkByzSKTsmoTNB/gxpnoZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+BP1I0DBzlewFF+55cJGVyoMxTdGjXXvrLTH5elMIzGumdOmUbHa64Nyp1A+Q6n2LbK95S0uSbB9m1OJRZEdjxTNZ+7j/Q+97Oo5TJgxp5u5Li407gGgy+13atmPa7qJpMYp2b7JeMgV7wcz21zHLRebmMgLGvlnNPwhl2uDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC8J10j/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC8J10j/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8FCC4CEF0;
	Tue, 12 Aug 2025 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988371;
	bh=Q1K4pcq9Ex/JoCw6ncPnJkkByzSKTsmoTNB/gxpnoZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OC8J10j/7DzNIU1pYSQ0U9/QEzWXAArkR6UciZTIyslySk9whyoL9QPQ7LRmJqE3Z
	 hotu+0NdB/I1ecBY9X1SZU9WveDWxQrC9+BDYBEGtWToZ1hvitHVz+bNgG9iNAKz8g
	 U/IJhpGzx1ywrEQh6JEUvzbJj/sClFdtFNTnA7PIEdKS31yjdAd1BTxpYONXR036Ba
	 2810VwEFRiL9PmpfJpvzHgzQbbqfzzx5rL8+vA/uXaGz387BgjGYzJAxY1xh3Y7cNd
	 3nfHty/UbQfaKEoJnQdG5OF6u27dKUrxzlpe2HeXeKU4vDyPr6zG/WsM7iVhuOy1xG
	 jXqI+Pp7R9alg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:24 +0200
Subject: [PATCH v4 06/15] rust: block: use `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-6-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Q1K4pcq9Ex/JoCw6ncPnJkkByzSKTsmoTNB/gxpnoZ4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8hmvXK3//0xXc0H/bbvDx/v5E2gnXFrpfMq
 aJZVvGgOzGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/IQAKCRDhuBo+eShj
 d6JfEAC6gBRwonGCHhfmqzFwU4IYTGIJgwnC9Z83VSxrfZrezMqI1In+X21PgqcULrt/00sEfbr
 kSH/QFNzfOtByQRBXWRgwxL9FYMAn7wt9XVZ15fpR37otIhtHrpbXEjvbuhFILM1Z1WufrN0yyA
 0LkOzd343AoMFgdL+IgiSRbn3TJHJG9euivQ/ULsPxn820P5g8MxNWcZ6MT/nx8JoBTLt4Wc89Y
 dRIt1GjG5Mj5qUvRWEKw+KKwBAlsxiSMohPYXiw7Z1CkOp1jYWhDwlASjgjnfQrBPHDeIye+RIk
 w/FfMnnwmcjSSv3ygMxzRTMILGPyobbIIaZNI2jBIviA53AxlQ3CPXdz2zOYMzBLzMH0OiiPy64
 CJm5osMlko+/3YzbaAEWqwvfZ+N2Ty34B4eWIbjsUbxe7gNyouCbHKPvENkIzQwN/z0mpnMyX9q
 yIoXYEOjkJ9wnHu2FAEkNRzP9C8lmYoLeolBA5jT//07q9uH8sOla6ryOBtyIsb914AtXtHcZKO
 JUETQg3Yji3jhr0Heab5/GHN3jWo7/8Cwp98PdzbQI0ZgXCpttxG+XC7vchlkphh2912GvMAiCy
 NMPQ9gBaaOUigNtNeAwe+O4+B5wDm7jSaL5uI9VVO1s/CGVkYyqAnT4geqasj0C/JcRNccaMPLr
 0A2zBDIaEjhiDBQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
the name buffer. This new formatter automatically adds a trailing null
marker after the written characters, so we don't need to append that at the
call site any longer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 12 +++++++-----
 rust/kernel/block/mq/raw_writer.rs |  1 +
 rust/kernel/str.rs                 |  7 -------
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index e84f62c01815..b8eb50afdb24 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -893,13 +893,6 @@ pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
         //  - If buffer was not at least length 1, `buffer.first_mut()` would return None.
         Some(Self { buffer })
     }
-
-    #[expect(dead_code)]
-    pub(crate) fn from_array<const N: usize>(
-        buffer: &'a mut [crate::ffi::c_char; N],
-    ) -> Option<NullTerminatedFormatter<'a>> {
-        Self::new(buffer)
-    }
 }
 
 impl Write for NullTerminatedFormatter<'_> {

-- 
2.47.2


