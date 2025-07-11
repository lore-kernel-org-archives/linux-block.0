Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E5291142;
	Fri, 11 Jul 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234255; cv=none; b=EJ/4uLZY0lyjUUEjDy4E29nGpUgyE7mpYsaXSZL+BboKR6Fv/eymjbmTgQB9ByqrPm79mSPjE5WU4MIOCjp66FCVuA1k797UT33bEhchB9Cq5LGOH+FHwx+XPkZPgCkSCRWzIZbl/6Nwh/z00IY4J01vytAizc2CRGKl/WEFx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234255; c=relaxed/simple;
	bh=1AU4xJI0E5Q+J1Ud3T+hTZQungA0edH5V6tp+Lkf0Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYj35rkJnsG6x48uyJemIFjoKmbLuuvCGum6gXBAMHu7d0wHbAg3CqRh0S45Qv2p0wng+cEhRS8arYYvTGVFAx5ILjCeTr666gdYJBPcB1egOeOZq9lObkJUy32jHOn97KP3kkK7J/yC8dLsi84arQirrnUn0LXUJDkdSnLvSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sccE1Bt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sccE1Bt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2FC4CEED;
	Fri, 11 Jul 2025 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234254;
	bh=1AU4xJI0E5Q+J1Ud3T+hTZQungA0edH5V6tp+Lkf0Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sccE1Bt2EMVQb0TBPpUYIMCtxCz4Tikua/en4ARh3pSK0mqIDbiXp9pqdxgncVGZE
	 SEiHiBd113HukeacYBUj67yz2RQgsvDeV/VH8Zc/329m4PBhd/cdHPqbv79H09zXbF
	 g6P8NMAkUZB/O0JNI1Td34PEkNYM2NYV1RazGHvnc7OX5rH1vUbD5xKbiUZISEbaP2
	 Cf5q/lgXLrRxh/0vhoLedC1VgoJy2kRipocxAijJ//P62TE4LCIBoBMk7oP4TDUsgP
	 A+2UC7t2xZ1V7r4ul3g2WbBrY2Au5jUQb1I9daKYHrDRVaf+VJ+Fm2As8QbbbJernV
	 ob4GpVK6RMuFA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:09 +0200
Subject: [PATCH v3 08/16] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=1AU4xJI0E5Q+J1Ud3T+hTZQungA0edH5V6tp+Lkf0Fs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjRreHfGsCeoO20oQo5iIL6Q25Uy0r7oK7PS
 v/GWIRDww6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD40QAKCRDhuBo+eShj
 d9BxEADGYPRAd2cccXOYG4GjLum++ufegiZ9XCBIEdyYdDdNlbx6LKC1cR17scivwnsgK4+cfqW
 rprNg3WwCJz6YaVmuClCnc9gdYL+EC9/bmhmer4m4FbV28Q7v+r1W1UPI0g/U0YXOhE49bZN+YW
 2hguD9fnyW0WefmVMXKjQDfO0EppjV+IHcWTtbMisiAqJpm3xDs5i7qwI4r4UyU7eSgc/jdgOoR
 7OeA+jZ9amrJLqdpoLqUYG28gbfGSEJZ3QLlStwm/htqvW1MacjDg/lnbxdad+V9HCRo6PIyX5Z
 bBR50ZP11AHAt9SlXAoa9S1xxl07m1ry8b45AyoC7ZnWnZfANPlpsoF5i8y0k8q8s3pRfkcqgdo
 lbDIIRUeLggHhIaeneS0izbesVoOcWmN1o39j/UGOJOOCc1aFobQj1HdyyD2eECPzhuk3V2EO8G
 8o2gvGSR6fJgA9MQy36G1JmjWJjpV8COenrI04kc0upJrS8Ocy2Rx5iLwYsDd68HazaEITspufR
 9Y5zGnQCo1mA6uDRihyL528gtIjivSewICLG0YEAiOsgbm6um49hr6xZMNwAF+mg/HUBUFAnk/6
 Areih00Vb+N9GAZ9/IiWNnaqYOvnBWE4zIrw9orDGj9HnlV0ZHI+ulQyup/ORGe6sDhrvnabQYP
 ipCPe9s9mMDXzxQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`RawWriter` is now dead code, so remove it.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs            |  1 -
 rust/kernel/block/mq/raw_writer.rs | 56 --------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea..faa3ccb5a49a 100644
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
index 0aef55703e71..000000000000
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


