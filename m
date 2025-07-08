Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98902405E8;
	Tue,  8 Jul 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003982; cv=none; b=JKO3qILIjWV5XM9lsxmswuO/gabG8vl0+5/HJRY891kMCur66dqiybf6N9x0n9IwNGnvw6xQ36yB2UwlTjrU6dIzg+f7y4A7I99XupYZ8vW8EX6Gn9mnuIQg9rdm2emGo0Anu+Dy4jjYU5If6GBx/GrT5wKLY3XVBegbknJu3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003982; c=relaxed/simple;
	bh=rI3PMBuRoxQk4V0KGavukqegyFDWNHFNecQhnnrOVMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4eq3EF0Pln2zWlusckkSxsujR6dDGQAx+mKvttVSYvwkyY+J9KmNAAXfyHUiFy4Ef1p4LAg94NXWv4np8/Y9w1QK/q5TwWoROPQ67u33LCnlmXJXCycf1uWqUBYU7PA9rFNkHF4QxZEjt5cnUAd/6EwhzbJunuMEDpZjRKiigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFiH8R4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFiH8R4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94773C4CEED;
	Tue,  8 Jul 2025 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003981;
	bh=rI3PMBuRoxQk4V0KGavukqegyFDWNHFNecQhnnrOVMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PFiH8R4nnhGB68C/FqbYxA5++Esk9oIVZpkEpqIdFEMYMgw4nyFCheJmXXaKk1ILM
	 Hpe4rLts9To3oH8Gd0TK8H4oqg4WZ3mNtSEzJvcpGrsetsRZHSe+kollITl5nWMINF
	 bUaUDtApZlfP0CjWRf4PRGBa5Z1s12ljtasFUoK40u9dGwZpkYe6LS22PKK1kWGr9n
	 42DOF24rX5KngonVpvwBaWkUtdHCl9hLbbTqYuL6SWE0FVKQiWznGgjeYP4ricsHDg
	 m0ykS1/SFl2uvs4NC2zxKFymJLheIf0W2oK+rK5e/SewcpXC+5hn1Fnxx2I7FhINzM
	 5LozSIsssxHEg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:00 +0200
Subject: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rI3PMBuRoxQk4V0KGavukqegyFDWNHFNecQhnnrOVMI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVEwXx/A97m/Qc65sLZ0qY5/J1wRThTKRGFo
 kVCyU9sm5KJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11RAAKCRDhuBo+eShj
 dxvQEAC+gnO0EHTbKeHnj9f2L9pEzdhwkcR5/OUeySZcSzi3O+xyQzUBte0OUCZqqT+GZI8bUxN
 16klAl9nvGweu4J1pK9lSOnB88ArwbsU6VlyBFXTu4MIhiVrNzrRXHcgSk1hmyIiXxiONR6pYh+
 +2Xpw/m3i31EngidyC0+Bq+4DvPh0KZQpJgn2qZqRXlHZ7LnTHKrZpqbLuOBfuJ2dia/Oo1d7A/
 9+18ugpOko+IpX0p1nRQWHtIs34IX0vIugMzV51SzbHZmelh5WFxUbeUcY5yaXbPtV46o2BpDos
 G1Iv9UoebD4N9QiuEoQKfXlrRxNFiWzrGw10OAKKXAdbnU4NpIin33kxeTGh9KFsu9bEVDppoW1
 +abDoW7e0Rqzoa5XSZNYC4hx5wPTylC7jiqC+zEL8Gjj6+fOK5/J57L5efzsgWNiBr72jzYcz/b
 +YByiC9uR281XeEOJrPLPwjBt2B52/7oG6UQn2Hdh1RCFjFfQ/Omyn51obUyT4aKCDZI8hrEQVZ
 ieS7iX6Eq93nwN05LBkC5QcDPqH/wfU8ePVIYN2yEetZn8D2GaY7jkCCw90SL0DsmIYMk1ihynD
 GeFIYV1+zFpH3nmH/kRUEnwSX7MX7QbsU3UF+L3lbTxfnRDsB6sQZpDb0qiW478BYDsto6zKsYf
 Up7ROsVQTYG80Fg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to the
name buffer. This new formatter automatically adds a trailing null marker
after the written characters, so we don't need to append that at the call
site any longer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
 rust/kernel/block/mq/raw_writer.rs | 1 +
 rust/kernel/str.rs                 | 7 -------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 679ee1bb21950..e0e42f7028276 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,9 +7,10 @@
 
 use crate::{
     bindings,
-    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
     static_lock_class,
+    str::NullBorrowFormatter,
     sync::Arc,
 };
 use core::fmt::{self, Write};
@@ -143,14 +144,13 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
-        let mut raw_writer = RawWriter::from_array(
+        let mut writer = NullBorrowFormatter::from_array(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
             // yet.
             unsafe { &mut (*gendisk).disk_name },
         )?;
-        raw_writer.write_fmt(name)?;
-        raw_writer.write_char('\0')?;
+        writer.write_fmt(name)?;
 
         // SAFETY: `gendisk` points to a valid and initialized instance of
         // `struct gendisk`. `set_capacity` takes a lock to synchronize this
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6f..0aef55703e71d 100644
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
index 05d79cf40c201..4140b4af64e50 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -881,7 +881,6 @@ pub(crate) fn new(buffer: &'a mut [u8]) -> Result<NullBorrowFormatter<'a>> {
         Ok(Self { buffer, pos: 0 })
     }
 
-    #[expect(dead_code)]
     pub(crate) fn from_array<const N: usize>(
         a: &'a mut [crate::ffi::c_char; N],
     ) -> Result<NullBorrowFormatter<'a>> {
@@ -891,12 +890,6 @@ pub(crate) fn from_array<const N: usize>(
             unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
         )
     }
-
-    /// Return the position of the write pointer in the underlying buffer.
-    #[expect(dead_code)]
-    pub(crate) fn pos(&self) -> usize {
-        self.pos
-    }
 }
 
 impl Write for NullBorrowFormatter<'_> {

-- 
2.47.2


