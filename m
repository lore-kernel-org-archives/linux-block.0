Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC87246768;
	Tue,  8 Jul 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003950; cv=none; b=nh7s+oz3VjtKiPvDMCRp3Af4S100v7qzwBCSY5C/u9zSOcX5rN2eMvtLyn4Vh6S+yDR4dcQPKLzqZG+TjOLAc8FZFSECx2cyyjXpOOEPc0qU5XBgmJMX2Km8bs/ZwavEMfKH/IhMuhuj605i42mk/eir0wUSS4Ifx/L2U1NgB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003950; c=relaxed/simple;
	bh=ZZpCWZQcgpSLHSvgu+5Wu9OlonmFvYaDz/ku4DcnLIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfBMtTbMiWWZMmX2kHgrzRad4k8zccQy60JKVoAs1uybfziwvWQplJaSy2nmtjyNTTp8bBpxEAO3zj90VxHXX/MsB8Aj8hDJa8yap28dmaE3/So5deVdzm5/8JMVbV+2XGpGVPv2xrQi7Dx9HD/hO/bOPkxd/Olcfxw7nllqN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT3ajMZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT3ajMZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACF9C4AF09;
	Tue,  8 Jul 2025 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003950;
	bh=ZZpCWZQcgpSLHSvgu+5Wu9OlonmFvYaDz/ku4DcnLIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hT3ajMZwAownDJoxQ1lGe2O9YsyPK05j/08PDdhAtYoJ2mGZZhWW+dZQzDhRIlddM
	 jKBu/iXsMmYHLOWtDKo5AUfWK+ANTII8nyd9SMi61+drs0HJv+1lO2ZwEm1iriTRdP
	 ZwmCvquFzIBpU5P69TK5C/uPvhIhbtsGHdi6gctkj3hqpuS9hiwOViHnSRP7dpk7CR
	 FFnqHzn0N5BARPTpCjsXYyuCkfeK6ldn8xatx9LwTE0rr6hmDrIpGsgEZ1gii33CWh
	 N1i0z4PMt7Qwo9aZeJ3E87wNl1VWhzM8pf15xTLt72oj24AE99xej+zglmL/9zMw5C
	 BzuCAbK9pykIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:44:59 +0200
Subject: [PATCH v2 04/14] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-4-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZZpCWZQcgpSLHSvgu+5Wu9OlonmFvYaDz/ku4DcnLIs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVDJULtl9kfhBJCutDHkF65seZyQbiU5sTID
 TiALKWxtTmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11QwAKCRDhuBo+eShj
 d5xyD/940AMT2NjuhS51jei3L0Ac4BF7H1bujtnPBTt/f0WKJRVa8EjY9dN6tq8X8j+0lwBbyTy
 UY2Y2d7AZrKyfq2dyrUKlkdPJ1e0bIbEhTjvobY2EpFkF3d/9o9CfWtz5W4cmSRp21G1jnb8cRb
 aaoR3tUD6lkQRjG1rhDiTDa2WCU7veA62rZdjCDZqU0JzKrwWc0mSyHG0S4j5Fgfk99cxVoMtj/
 +G0sbRufyjfCNl0pYZeiYZTpeGdGXBUvkdSy6+m8JjABIf5mA/nzwnhsOgpdbp479q+akkBfLpG
 A5yrq3l835sV5TYkbHyL8VxeSw9acjJLJ/hBKKFc2E8g/d2pb4bZDolEvXdyam9S9F+dRBEX5hF
 6A5AkiSNcDsB0RA17AGLT3AJWFyEyBUpiOlvlVIxN8mi1A5Lb42vim6zMGhLqls8YHXlQmYR7wX
 pBW1TjLkZhJAf4wrqN4l4VbFPKxNPizn36nJVQZgwNNNT8GV9FZABgA1W89fBuXX2tia59ZvoGq
 pKnBqAIYZ7zY3Z9VNM58mGMFwymhJ2P4k4u10DXqSRwJlJM95xGjCi2WLl11wq0IA0QZGqxPw9f
 8QUVOB6xdqYI8fPjxEGCIR0EkGtd2B6IQZ1/mlsIJPFMWrRxCcJUn0Y3Fy8cOjm4vCtoAHsLhe+
 em3bvXdBG0eTuFQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up the import statements in `gen_disk.rs` to make the code easier to
maintain.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea887..679ee1bb21950 100644
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


