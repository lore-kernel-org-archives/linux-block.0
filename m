Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745783043A9;
	Fri, 22 Aug 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864950; cv=none; b=mjVVoB6izd/tIMTgQ1PeXfr42QgSiuh+3gy3hhCqsJdVJMvr0JGagJz8sMmLDF+zG/ILloeA2feX/WPXSTedWYZCpPvUwIkOuJoJ1DQw+pRg0BtmoXqmN6tiwTmfTCuMElipTCu5yFpKAhfUC3lxiHA6VaS61ZoE5oo4hjuyB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864950; c=relaxed/simple;
	bh=/9IChsMSyP1ostiMTrAMl16dR46Wiyp00l1jbhMBpuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/0NGSLTHx4PAQQe0L8blw984vUfR00TejmXbRKW7vJSOaMKa8HVgcU633XHsxnznT57rQHS7YwmtFDe8T7Tlv+nya8uBiksDdMc97oqEJ5ENiRaECPkVCxvZERG2hiEL3lwR2pbNOcd9vKikbHvrfbbel/GGvuotd5a2E4ONJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5gsG/dN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5gsG/dN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA73C16AAE;
	Fri, 22 Aug 2025 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864950;
	bh=/9IChsMSyP1ostiMTrAMl16dR46Wiyp00l1jbhMBpuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F5gsG/dN+EpqIioF+5Crx9jqBdMVWahUbwtn3E/GmU0zgdy/I53u6GHyVyOaNXEgd
	 P15Ff86rSnlHaAnx6zCQ6fXh4tApHRG2j9G2cNckEjWNLloo2TV++osT6euxf3f4ud
	 TeOwxjy2RK21bxvq8tnNFMhNABK6eHDQaMYV/Y8mSQ1Co/W/S9GeaoiGxgkvc/S0v+
	 +yZoh1pQhr2bUQ58+g/pU9lB1TA8Avsx22ctyW+nA6jYqnXJkTgW05uz6/66BIaKsa
	 Nn/0fMuBhi30btKDaAlf5RvMTrc373k+3N5SPL3r3ITwFri7VpcN29gQCJs9Fxf4Oz
	 tpUpHCOM2huqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:45 +0200
Subject: [PATCH v6 09/18] rust: block: use `NullTerminatedFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-9-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=/9IChsMSyP1ostiMTrAMl16dR46Wiyp00l1jbhMBpuE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF85tuIe+jHw5Yrp/W7w54gULQ9gjtqD8kzcK
 8rlqP8N3+6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfOQAKCRDhuBo+eShj
 d0JAEADE6g7CESKxxVlGqo8GKfTbnQxwLmN2BTD+du02ktR+sVgySmlLbCgX9t0rdWGG01JKIYU
 uTUzXs+baA9YiL8YHxmFO3/pWC2VE0PAnzaJU8gyvJrTblU010ei6Ze8johw+45ENaDUhWlhI2k
 YuwXphez1+p9yNbJaBh1KuNK/aC4QJgNGigaSvjjCrYT4NEc9375F5D6sTuKll0GPcZnq/pr3zj
 sMhVYbl9GqOs3gKpCUDYInqZ+cEcGzl9AGdqqyjkz93FDBg5zOQIAmwt3VTWTwlQkgy4sCbmZbS
 z86O0pRhZi4RjrkBXt+424H06+BFaE8y0WCRbfMONpNrMUyZfFK0sJdNVlDWEDz0v5Hqg3gPWas
 5K0WVD/B8OjlDxje7EVsTzKSEJFyQZMrdPRunsCO91SkuimCDBcBCVBMv0M2hxEK6xkiCFv4m/M
 3JzGh5x7mwGfGHz9qT7fn0v7jtyGMjSrDPyk5RrD7CPX/zX8mebb3aMVF82LEjKxu3/WNa8bDx9
 vksc5GLOAxDwDcE6iIEHvSM4Tyk/z2QtLeVmyBx40CoMBVJ6LoC3bFm7Jik8xHjlpQkY2Ig6TKV
 7rfsBJg4+VlIIyRsprZwRyqDAvZ3CtXzL08LR5j2ySn9diMdLwMpiAG/ArXlLbi/oSAtAeqbW02
 C1ea3nuysqe2fZw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` to
the name buffer. This new formatter automatically adds a trailing null
marker after the written characters, so we don't need to append that at the
call site any longer.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
index b185262b4851..a3e34f566034 100644
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


