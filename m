Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5592D0C76;
	Fri, 15 Aug 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243108; cv=none; b=WR6SNZzmx2jVZYzCTf9Z/KTSfWn4ILU8ziQ4BYjmfsXu+dK4zAVTFZsDyz+EcM91i2PLE3EnkSGkem43+KI459fDQzntIsywhP06y1Y2KcAScfTwsPZVvDMdPOtSYpJcOFE1jJMgzlaon9XHOv1pnPcLdeOkxigQjIzNyIG+YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243108; c=relaxed/simple;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeDZ6ywzzdAYhhl5UgCaLxbASpDnbzGEqEKLJ8DVj51NC5DSr3F3e8GzTHeCfJM+T3F1vkD5M/sS68wdshWNdVbSHr0F8ykrN2sKr53YF7Ba9DSjAXDg35Gy3TnYNZGk/EqMfFqB9MmDBp3x6hGv5FL5k5e8HEPc1pfoz0qStWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTczE54H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTczE54H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0040BC4CEEB;
	Fri, 15 Aug 2025 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243107;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mTczE54HZmbbZNwvOgdux1ShnM/tskNG8EVR0IcK30fWOVKmqLAVtN5ZotxfFDHRE
	 DonrSW6M6oo/52meB6FhZzdG35k7aEZWYfzUXss/sMQkkEEOGs6cuomp2fBk0fstkY
	 Sw43ugOfK/NMXzXirGCfgVQDUnB9H6+IdXfLLSPvzP4n0PsuKQc7EC+jooE1yMzQXg
	 CcL7ojbSARx4LTyxEpNkS2r/cqc45jfLMJlisBiLfHwHO4hvtjcgVRoGeKzfO3AqEE
	 BpNiebryK24kAo4JQVNncD6x10EOHE75iq5hLWVJgSPXZmAkp+gGwD2P3BzGX18xmA
	 x4jnIbvAIln6A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:43 +0200
Subject: [PATCH v5 08/18] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-8-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI7fvb3LqftyA+u91hXHn434EGDlRuCUeMAM
 vLY3ldxArGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iOwAKCRDhuBo+eShj
 d7M3EACUnDqc/rSdU8ExOD7kGKqbjFboBiKRTMhwuu0tG7ZIvEghvLe+AwIBoDX/OMxm2hHIIcc
 u/g13byv6CyAkTnaqBFgrMzVhvnGCBxzLUAxl9aVGTRGLm5+bzdjqfJtVuR6e8dqzlGGpwykRZn
 95FEZvwVm53TYqSZSIkWNODfmUgQJUbPjAghUxBJCd1AUM6k+6o0Ldpif6mnYuQgzNaGXwloRp6
 +iOk6xAFHTgEiXs2Ilo4n0PHT8nA86poRQgbi3Pk9Z0fXXBCTk+t+z0igEMGSe4wmDfr4cUtTbA
 zOCiM477pADPsdBI8t1kPlYaPu4aAZix8I7pPUGZDn//s6MbYl+kYQpFtwp52ghUl2mdEybvZvc
 Luja/Og5mARKtE1ko8zajW+4BREGlF4CozzWXRKQxfS4W8VmVnM9iP4nIgbQ5xYQSk5fQkSbtAp
 NatbL1TVC7XTjhjRwsek4x0ypVwVa9On9dn0Lb6UOv4Pp9F93BXSXTNVM2xyElOk7w1YQOaW910
 Z0Uq3aC0YGSZn3VMPvHTEjMriP5pGQ1sLCGJkGcg8xPmTkJmkVsTCE210XnBySMoaQdA1h9sV26
 AkmvSQZ0vNx5Om9wXj98QLXXwNbvGHQjlcHUyDv7vHX5rpRKoqoYVD+Qb0XPEcrU7AYp/0kVNjY
 BvuMp2wuwYPLzRg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up the import statements in `gen_disk.rs` to make the code easier to
maintain.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..679ee1bb2195 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -5,9 +5,13 @@
 //! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
-use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
-use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
-use crate::{error, static_lock_class};
+use crate::{
+    bindings,
+    block::mq::{raw_writer::RawWriter, Operations, TagSet},
+    error::{self, from_err_ptr, Result},
+    static_lock_class,
+    sync::Arc,
+};
 use core::fmt::{self, Write};
 
 /// A builder for [`GenDisk`].

-- 
2.47.2


