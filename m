Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD52D3725;
	Fri, 15 Aug 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243111; cv=none; b=sSNDpjYEC3mPHaPsWv431KJw6Mf7foJMOq55Ml3o9BYrN7gZd4TcY016jJDu4iPrkCtWPmTGb54UzWrcx3UVLDzhMG1OcxBMsN8BQoXOQ1tjZqSYw6Hg5wj+Jc7f7YgpftLX9mvzST4OXR5YODN7RPQqjRuZFprE3cy5D5soG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243111; c=relaxed/simple;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJmlHlVG0Z7eRjmEiVLMyqxJHxxACO1JICdap7xwse2m9cg/ucAiHUHm3Pu3qLQ6tTzp/jA9tWYzFkRVYVeqg9VSfoekyOMol3BDLRdz+Q5cwh2KlrQ/7+UlN9bsCcujDQsz3lTdvmEuG/SH23oJrIidOH19mC20ZGzlqij7reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCi6hrM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCi6hrM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68790C4CEF5;
	Fri, 15 Aug 2025 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243111;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VCi6hrM/NWYXHPrciG39yNdmLZPR5YDYNZlUFtZk8qAv8f1JmCMM/cyh0aPJo5ofV
	 SWwQbtUQ/SJmHYMxn0FjdwC/EFhD3DWBStrD54lcccFVKQmnJBD8ToQB53x+iPhxtw
	 S/bx4jXIqyFaZjcVtI+ug95RMi7hV2FGIEFdGSaOV4Yt9ApWDMIhtV8KXoaYLqUHl2
	 824bZMbt5ppBXQn7kbXLtGqp0YPAjFhYUN1ZQr1OalI/+H7ll+E+xCh4he4kVTIvrX
	 /itC+RvEX1VZyjCyFElkzLqWv+uqN5/B7JzDHIy2qRGEFztLGwVz4TtiX11M4Xgb4n
	 KJkvX7vOk9abg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:45 +0200
Subject: [PATCH v5 10/18] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-10-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI88IWZ7fNLhL0M+W00aAZDcjP7iujh+g0i6
 ThQZ6OPhHaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iPAAKCRDhuBo+eShj
 d6EhEADF619stZYj6i5xxO6CmLRojhkTXGrwOWBatsaqHH782uAvz6pkM2dB6MZD2JLf/RR8eYr
 fTONHUNnf8/2djGrAbNF/DtL9o4PQn0/7rMKOLQ06XpdKk/qSuC0g+XYc2ROzBt55WorpbC0B8M
 HQGRbRFsSHvJ2y63x4s/3Vyc3NEJAvBc4ygOKlvnVeh/fTrhmhZ5GvGGA8v9NzJi7GZcQgseMM1
 3j342DuxIC2KRH8I1bYGsX6eVLoXbqhuMJoFvp7ywf3F4o/CPH1l4WMX9TuHmNKGOd82zchuzSc
 Yner+FSZ3xJ71iHuikIFS65HeEZHvC+7XzlBN8Fds1BNeKTa0JhNK/4/2P6OJSMUZR+56+i09UH
 IWQ2q4GALjiWSkIJWM9HmY5mmcXWvNvglucexsQMB3LmMI1ZeSq70K/t0RoJtX5KAb3ji3k4cTK
 ELVibfziNnAMirMHQXWqdsx3qOzqhJ1P9FNuV2k2/ep+JE3cjQFxNr2tpB4lneNxGIZp+NMejC9
 GtvhCfPVxnufPW/FnP5INlEj5u4/hZKgX6EMfP2Pur3RY8qO//zV6F3WEtfQhKi7CChhLFN79Rb
 rFnitcP40afmfT+f/t4zjISZJqg05DCQi/Q91YYp+7sd252OlZQDYBGqjdMRDgfE7de3Elwrt0s
 3s5huC8FqyJI65A==
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


