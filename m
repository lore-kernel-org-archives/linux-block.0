Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C052EC0A6;
	Tue,  2 Sep 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806941; cv=none; b=JzSr0dYpHUofce824auud7HDyNWYk2QL8ukDs+FX1Ezrsu7qCS7euNLhok6C8n1jRuLdyYd4cElb35fErRFb7vDgFvbxJaR35MIrFNNHmYyKgCGIuhQX0NpnL80SncF3N2ZuGGEj9fC70mIKe2+nimae6OzvKTDQRk0XPzyCsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806941; c=relaxed/simple;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLV9sKM5VqspwaGl5Trzki61OXpatSIxyQ7fDUjvkmRHUf1njCKtX5YpxFZoR2Znr4lfveEiRl1LuNbbyjePPRXkL9gKHukjpGaYgTTk/tHckaHMSlh3pAHWg1opp19BgdwLgeibOBwFsANpiycE+3gN+zatYtBsV4Yx07zVo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxqv/w0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxqv/w0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EC8C4CEED;
	Tue,  2 Sep 2025 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806939;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dxqv/w0i80AdDS6EklP0g/qQpG4WtZwrifySVJkOXA7grhyBKrGahzM2ere+UJoZd
	 lCz9/OXd2+xEFOyK12Tn4A4oIM57x1T2UGMj2Uacu2MjXQujjVhTXs+zY8ZYv5orxr
	 5rnADlpJcSCo5vXyUL7F7Oe1D+9vuMFum7VJoWXGxs5PSR++JEHyG0zmlGVtbvRCTB
	 evjKvFJIFmx7xHQSay3EScLd0hI4IB/llfpqNhp8ZVwUi8igu3qkhB+EIVWVkRImoA
	 6/joGdNcGxZZgAaiZYbE0ofXPCfpyq7SinD4rsfiNNRlypoBqXH3Y9YXqkVESYdvBx
	 TfSyso/+cemQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:03 +0200
Subject: [PATCH v7 09/17] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-9-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8BMQQLj0yN+Xma3LafyoSW49KGgCCJaKdiC
 IwDwwjBIYiJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/AQAKCRDhuBo+eShj
 d5GsEACYnYVWaMdu+NvEExxfgA7yFObB0KyUrgg/BaDPSa6ua1f4WumVBsiFzzuJPCo2HbRoIEe
 Yq3YHs2BHIh0bTnpiIg/kYDPrQmhrE9FXKOiqSBdaZ+7oOinX0/Aj03iqMPGtkR76jYJmEEXVbJ
 obSgDU+6H23DEBzl6bhenR5qUehP+uoqlCA5TN+AN82jWuOSx4Ol3Lfd/LLBmMeY+m2XTSnD7Vd
 G66XVLjBm/nXTXAfQTdLLNrSNotg/Yn/+pM5YeOX1g64a5oX7WH+ZrFvE67R1soJjpgXF8WD8iP
 3P2DOFO3CfjaggxUfo+ZWBK9k9TLSdLR2xidTiiSD1tw3RYpIv6rLVz5oX0lK2StFpFHHGV9lrB
 XDx2wmd4FCLW5IEy/OALxmG9F5De7sosplvtJ2V7TBss3q1jDM0BF2aIs227ErmYLtfUw+LalUY
 nqNNaNwvlK39Dv8BQk4X7ADA//2zVgWRMdhtLJrWI3Ipz3SKjFC09wi6CIhXwZjVFqhm4GwLYQa
 bxcIet7L5q0lFCm62Zzrp2Oyi5XckvJBkQGL1+zzmr7sz2cOrOftX6D9BCWLbus7GcaGyaAy0/T
 LmwdDmD839Clj1QIjrQDCGcPo5Emmpngd2v9DRHB8lFjbnvE4j9fVq4gzH8eRFwQJ4/sqSz2MN9
 O0iTtuEFY9bwR7g==
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


