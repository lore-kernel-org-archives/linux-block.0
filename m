Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C711F37D3;
	Tue, 12 Aug 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988343; cv=none; b=mbFH5xCS8Q3mH+J4DthA9ZCPMCRSpikDJzvQT7jx7JGGOjH+rk022URoqKt+4R7QBQXCYE6CGerGKXZSzrgHUGMB3nkxwR4ByQLfplnU5PTdAn/R3MEtc4UDXPCJIpci0+aFD0Oa7yBzktwIZ7/mhYz7vigk05abMWfEK4VnofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988343; c=relaxed/simple;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fptkrUorGs6nxICQewD1niW/OULKv02vDjT8pnTxlE+DTZh42xUvD0/Z08bbcGkw3MeJSvwXhhLRtZgMEwrCbTW7jz38DGE1yt1ypixKE4P0OZ16peqaWGS8lbuzjy21Hu6n3X8fOD4p0Txm1tVb5KOqzYfY8jrTr4czQoFAqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKFo4FVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKFo4FVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0272CC4CEF0;
	Tue, 12 Aug 2025 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988342;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oKFo4FVZm43yYmuz3eVUVd/hsTA/yidp1enNvBSPO3fpYKBEUlWrEbdUvFVeuAnwd
	 7a2sRAJzEF7Gt+SRpuRbAKDE7vaTW/aQPP7Qv03XKOnjXnI9G5q4OlclWjQDV/Z+KR
	 Be4SxiiJYYhiReKNs08d8Ymaap6YpnlZGr6aItA8+/MOpL+zFJvIAi2D6oH/q6jizx
	 WPlqRIVeUFaL7KVp7S0KHXAIcI1g3aHJvRXRL46Boi7Wrk8hYZuDRi6vfG3MIEL/YA
	 H3s44Hs5Vmhs8NnA8y+F+JaOzkON64yKeZNQ1XUs0myGYXNpt4OCDck8g04I66Hihy
	 /FX1CXJd7Kscw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:25 +0200
Subject: [PATCH v4 07/15] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-7-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8iIkoNkqQUOnDywI9o6nQQFQELgIpckIOPV
 FPvKRB0To+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/IgAKCRDhuBo+eShj
 d66UD/9FI7DxPt6eeUbAybLCy13Y/KUouBapa3d2tfUklAlEDtK4XIum0BrtyGWbUvTwpzcofpi
 tcwaBvFH3+K26D1sTDgykvMdHdHUGIXBxWK3va381Wdlx9QAKJ2frWCYQxV6QXBg5dkT2ORgEZ/
 J+oMiq53O82eIBmxNHMxs4ioHFRcU7kdSl1GIPXtbmtAlkS2+r8sxutQCbVpQWlZHaFQ9n8boen
 HO6Ibs2LBIKmNgXWG8jGWa09mVaS474zOHpuXei0TRDUoSKKL0OUQXNjujx2D5577W1JEQ91rko
 N+MLnkgMKB69HbQC2InW96KRDGKhRZizU35bPmbsVRMoU4TqZoSA3xM8qYAjYCuIPRoKZ+cgfJH
 dW+Aal+djZxYReAIzig1APbxKfmuc2gRHZnu4ZTFcuiHMucbRq75ZM3GmpA8G7cFbiCTbb4FrpD
 BwIYOY+1mnIxRcsiq4KcfkmqJVWQ7Zdz0qTzI2urCVhm1L62C6t+zKXe1kQTmEaa1licilECFJa
 NBTvq2fjinwrbY/81wgxiHnPD8HgDZ+EzXV4dZhgt3K+O/kWMqPAhM1TVjGVdbIF3VQcWCRFNP1
 /tNDkIVyHryZrYt/8ievZ2AAdBPx5DrurwnaLVId58xGjcFDahfKlt26b0iz2QCu7ZhJN79dLVD
 QHmBExR+eepfpwg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`RawWriter` is now dead code, so remove it.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs            |  1 -
 rust/kernel/block/mq/raw_writer.rs | 56 --------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..98fa0d6bc8f7 100644
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


