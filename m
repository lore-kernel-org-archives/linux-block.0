Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CF2E765B;
	Tue, 12 Aug 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988364; cv=none; b=lA6Xtxk18QTBn771IGsVAO2SVbIycUXwUOg511w/Z9mK6P/gtumqWg9YdyxxP/yA9GilwK8fy380G9GGfoCH7rYTRtA6r7svF2xHIYy4NZ678OUkwzipTZPUAQ7Vmm944sIUDEd3FMQFfaP7ekgNyUGFX+WFPz1VryvWDpezMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988364; c=relaxed/simple;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzFlD2ThOFk9koW4TlNQjjwXOLpZmNv7Mix4kC3kCh1vF8p2wdZavGm9g5OLg+YZXetdhc9g7TbYK6sJJDmrS+frTmvGXUzpdSPjkMYTtFUNYdEiphNyE1MkDP9cqL90RSeG6sf7ykHOOgbZz802uwQ4kz75bBNxBk1JkaMKoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuGlXe6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuGlXe6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43372C4CEF0;
	Tue, 12 Aug 2025 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988364;
	bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SuGlXe6sCLIu3okn7PYaN4bDyJUnQZw0gpk0HR+3CITWXJeZ/Q4pDsi1XHUIEaZab
	 x7zVtLrOH5e38qgUqMWXdibYT6QvbtxbT9YyAyMbORD1uteRB2pKNbyGUEnuQ5Qfzl
	 EeXIpeG0PXpxNOAe596Rk/hldYcQ8bCWw7pN3NyimIKkGPtT7IIvujBW/Sr5htP3nl
	 b09qpJGiYIClfoyOjJW0zEVBCyh5ZT9yBV7sEPLEvnMIF0JLTDXGuxpOuN0h3oi5fI
	 cT6NK/MXWbZd31uzdLbZP+g54580jJPQXp2DV48sZz38u/Nl+4BI2/crslsLhrlm3C
	 lCuD8wxG8OCTA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:23 +0200
Subject: [PATCH v4 05/15] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-5-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IorSNq8bDFCuUxmsqyPpldQ/kj+0H+QjukXF6SExSLU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8gbDFSIyS+dJdKjQepL2c0T78gls0br2zuD
 5W+XncDEyeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/IAAKCRDhuBo+eShj
 d4UPEACt4fVFdPJtSaZGxLfUpgJvz6zQ903Fb5lTRp7ufbkONXm+N4qMG8JIbAc2Veo2PgmOpWC
 xTtu7+mzlp05XnmP3jeM/eMf9G0GFGPlZHYhzMFM6t08YWjGrqXanfRHdtdYLbpBhP4MIzleQG5
 A5Z1061hMu3GydadqHG4g8o2H/lMRenVPYMfT7kfWrkZ7t5ZaSXLGuUdkzRYkLZC8tzNz1SsD5T
 IRe7eQ1yd6z/9wLa/sMXJoV7fymjfCmTExNGPWcQxJ6vYOHwfrOzgwn8ee5uO4M0rH/S9kNzOJI
 2Le4oRgk7HAz/I8Eu8NOl+7uov44QSH9U7qoGzfIYjHPTeZ2qrnWkwJspr9JTcH1yEHZBpRbVe2
 XQ9OXIrHk44fkVhqdM1DivdAbTv7/2pybXCGMnXUD3OWVFazXd4NjY/X+SVtXTh9rjT9gNFc8PU
 fv+CgdJiECC9p3C4SntbfwXtClPoo1fnwV3Ww184UHe+zFsvdmG7/VxP/+Cf41c959nPDJ7bQFn
 Ze8b9+7k14fhY09gh4Cyr9GZC0LcEvSCZ0ogCXuENWM0SVc9PokoivuKEG+kFzwqXRjlCfSZe+Z
 yNPw9583CrLpVdjqKBfGQeSG44i4IuKNFXW8Ggm27Yy3nyrkoPgtV5eJAMzN1Kl7kaF4wLWE8js
 KjfrAUKobr1uScA==
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


