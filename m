Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C525487A;
	Tue,  8 Jul 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003972; cv=none; b=fyfIW50cj1D9ik7jFPZVfsVo5lr+YGHN3phW5ujmbV15pyfiEefpEJ5Kx4Hv/Ydoi8tRO/9WdPHg3ZhlBgVS0dY1Zq/Zzhd6SuY+ileYL6UV6U3gbd8FQwKLfD/++qu9raK99FacETNKbAT/i6IUZvu6hPpRxsSEM21GLACShYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003972; c=relaxed/simple;
	bh=r1Ti8mK0XX0RvsscDl8Fnpgr342uxk/7gLrReFuGAvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1UZY4WvxyTKEco1aB8PVgu9Eqjili/+4aAU7itiWGCKpRad5OQZsB6D94YRNFloHZcrj8Qc36B7iiKWo7poSVTPHKezGHsfMzfQsGAz6v7s3daBYGHStYTjSHqgESq3Qs6lqsttD2/fpNTl3cn3gFR4M6HOzae0LGCzKmIDL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVfc+GMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVfc+GMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375BDC4CEF5;
	Tue,  8 Jul 2025 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003972;
	bh=r1Ti8mK0XX0RvsscDl8Fnpgr342uxk/7gLrReFuGAvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lVfc+GMeU395eajoAEEsb4ecLeUfFEVA25gYAA/Xpnz2T+jfFxiuBuvD8qwZW2ojJ
	 xwbXPT7SE95I05a1mRIbdnmltQ1AYNqQdujnjX6TRXcn2UInWnhiPajberJk2fNRx1
	 2q91Nb+aRDXhmr3WE8u94EfRLw6BtQRDbD4lkalUAE2bARgu3X2l4kjHFrhF5Ac/Us
	 rz9B7UstQtqdJnnr9noCdKfsugigJmUPMU9a64e+vk5CiZXc6Dy2KQYH4RjnqA/gSt
	 tyFm+b0qWr/79zCqtqZscUjTfEIiPoT4gA6tKX5KOqJcwk7j98G8UbPIlKY6XGFb37
	 JfpSjoX+WY6qg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:01 +0200
Subject: [PATCH v2 06/14] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-6-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=r1Ti8mK0XX0RvsscDl8Fnpgr342uxk/7gLrReFuGAvc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVFvPXh1hTdix/inMHLBf5ERvQEGu9KTYE+B
 sjXvx8UyGqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11RQAKCRDhuBo+eShj
 dzJXD/4iZ7SCIVD40OfjzjhpkI0XHCktn3/n7ywjfj5FjaDtwrW78Vm7pBewylmaL6XetfVQGGJ
 uFaALh1a+aoSwm2HpTO2LW7zHzyN8Iyh1FCeVPbo9xfQ/xiySA8iHp0cLvVzv5cruQEq50sp7SH
 0er99rW3avyDF0JEGJ8qrS+chkCOtckPO1SmLz92LSVtmHfn8PUIl2Pu5vT576UII86dARdrOaY
 QhQiN2ZNI6KPG1OH4cXBu+fcb9H+F4T2KMPiYpnY3k54TncZ9FHe7O30989Fci2EHv0KiJEu7+2
 yUfMm7Gg9G2uzmiP5+hSWS9DAlzxVvKFX27Nk9ySwuqTzdaGB51saosy1ISgNmJb2vSute5w7rX
 dWDFPe3mg8r+g2paTi2+o9SdAnmZlycSA0MXv6Hzx24QgK+LO21A4bAHtsEJvSkZG9znI2kwoQG
 KBfMS/HKD0p+mpvVNX2+6omwjkE9vT+C/SPME/tsjbgQq249wWgCBPEgvE+cpDSBbd1oUpo3qFg
 zMXBXVhXpYX5uPuR5E1ADkL9GgNJlI9SSOqgE/sEXGk6/9RnYApBUZY/UwRWxVNUVDUqsqkMiXJ
 xabFNEQQA5u900asreNL+ynsfehvtKJ84ODu1zXMN37a4UJInT2j22PxP9F+O3/VzmK5VIKqxzb
 kxI3Dcvzq7m0DOA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`RawWriter` is now dead code, so remove it.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs            |  1 -
 rust/kernel/block/mq/raw_writer.rs | 56 --------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea6..faa3ccb5a49a8 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -89,7 +89,6 @@
 
 pub mod gen_disk;
 mod operations;
-mod raw_writer;
 mod request;
 mod tag_set;
 
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
deleted file mode 100644
index 0aef55703e71d..0000000000000
--- a/rust/kernel/block/mq/raw_writer.rs
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-use core::fmt::{self, Write};
-
-use crate::error::Result;
-use crate::prelude::EINVAL;
-
-/// A mutable reference to a byte buffer where a string can be written into.
-///
-/// # Invariants
-///
-/// `buffer` is always null terminated.
-pub(crate) struct RawWriter<'a> {
-    buffer: &'a mut [u8],
-    pos: usize,
-}
-
-impl<'a> RawWriter<'a> {
-    /// Create a new `RawWriter` instance.
-    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
-        *(buffer.last_mut().ok_or(EINVAL)?) = 0;
-
-        // INVARIANT: We null terminated the buffer above.
-        Ok(Self { buffer, pos: 0 })
-    }
-
-    #[expect(dead_code)]
-    pub(crate) fn from_array<const N: usize>(
-        a: &'a mut [crate::ffi::c_char; N],
-    ) -> Result<RawWriter<'a>> {
-        Self::new(
-            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
-            // at least `N` bytes.
-            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
-        )
-    }
-}
-
-impl Write for RawWriter<'_> {
-    fn write_str(&mut self, s: &str) -> fmt::Result {
-        let bytes = s.as_bytes();
-        let len = bytes.len();
-
-        // We do not want to overwrite our null terminator
-        if self.pos + len > self.buffer.len() - 1 {
-            return Err(fmt::Error);
-        }
-
-        // INVARIANT: We are not overwriting the last byte
-        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
-
-        self.pos += len;
-
-        Ok(())
-    }
-}

-- 
2.47.2


