Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992042FE560;
	Fri, 22 Aug 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864955; cv=none; b=Msjr6jgRkOJU4oN5bDKcjXFP7nWqpuu+3VFcYSbHnGEHmLsNxFPkanA4goSQBN34t/OLHuNaCxIIELWqDmBa9yD+DrIgF6SP/9LgR+L2VAYrRPWWWBs8402pIBWSRhkjFhcqkGnxIAi0xVmi/lFd+b7sFCuhnMcOj8dZkm2ED0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864955; c=relaxed/simple;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/0Q5n4VFA4hqIfj8rSDcVY6bXiYk1IwfJ5ttBerwYwKs+ZMAXbK+wyyBbEONB9XqOXSYfQrUebdm3njgXUQvJ7ZbnqVwslTPz+9YcZ+vCOGj4JZB0pl+TdEpIpcXLg5/pD+tzAQb0TAvfajAPG3GvG5t+JhRaxQoX1QjOz3EPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNvlq2Qo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNvlq2Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB535C4CEED;
	Fri, 22 Aug 2025 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864954;
	bh=Ccx5zgSLlbSIiXofZb52HFU6BY4bx1BMin6k8F+fBLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BNvlq2QoAlt+R95WvgpaQn4IfjlpSeKsqIg0mFAUsxHMbnpY2W4zfOZxbuQHaXEj5
	 VhLJlcWsfiqt6WtEvOeMvMm/IPRwV6VKSSTZgRRJpbG6X7MOFtTmneiKuRZ15UChfQ
	 bK+U80uFAC7P90XlmJy+ObMymqjVYfVwfHWqPCAQIeYmRAxpLGVZt0dWiN+Hxq5Sqf
	 WgGDv1ykYmgM+4BbDIaS7CRqElhWrexKiz8ehv4tbDrVRJOCHaYxzV21u60eoVRpmY
	 3PHcK8eudRkbzvP6MPM2VvP0jVH2w/CEZvS9MbGwbXozXHnaWu1SVTnzMk63DcQe/O
	 SzuCtFuLSp/NQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:46 +0200
Subject: [PATCH v6 10/18] rust: block: remove `RawWriter`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-10-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF86FoAaKosNvDG8ngMAfCKCWd9BadJVJCEft
 CEZlJp1unyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfOgAKCRDhuBo+eShj
 d/1OD/4j5JC5VxiHDtaORfNSyAmNclBnbRVJHZj01dhorrCKQ1UDk7qO+OKTJi0CAzro9pGiskp
 Vjl520At8JnixeVE691zQ7GHTCRy53zwRSVwK9tpOGE6cVShJFLyDZUZV/IiqAic+NTVfQ/DsDu
 8ZhQSRJnuNRsmMfzSu66v5riLv+tOZN2eM52QvogZkrPC5K1fsgq7gSPPw7gQpTCfzqEj2Ad+aH
 /jnaK/X/Ximf6EoF7SOExCG2tnhOYcj6I1oQNm6ex+BiU4yytalNlklvKaBp56kIjUv9SBFC9SE
 eiruFnUqhlBlBtBmIZhkCVF59sH/pWv2gWg9s49xlJUZQY7v7cS48MsnBCK6lv3KrQ8+yA3Exa2
 KJD7ANv4nRLZm4M/DC0yfIKYpLRQujcXPwosIptCOzIlHfO6xEVDG1tVOaTzJoHgbyM33dFYvGa
 Ii+yhAbYtG6JpKQzwiwVvP/ICq2OwNSVSk5CD33Aqn6drLKIozqnwvGOwXTf1hoqnyhQOc6QGg2
 6am6OVNmy3xdzQwIo2D2b7hVEBkmQ0UfiM43D65mXsVq0IR+DJxMHyha+4P18dOaz/4dDVliBTK
 tATH3e7/HfQqgSRLZDfZVurxOfxVxTaVMB7mLOZc+Nzw5l5MHAdS1AX6cZhLJgTy+6cZaxxbBlf
 jcq035eUUeubmfQ==
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


