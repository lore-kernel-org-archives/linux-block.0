Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3472E498D;
	Fri, 11 Jul 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234228; cv=none; b=cSkF+u641doH3SAE0+0nYweFUzrdps6NKgEPmBoa96ppVpJCl1UpMOAKnrARTPWW5pcq7+uT0vQ8sV7aJ2bgabflcEJw8iNcN/+FwVF8rraDwCBqS2HR4mzM36DPzAkCibXtlsT5KLfcwUCuqVs5Q41cJlbZfT/GW5gwzAS64Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234228; c=relaxed/simple;
	bh=xZxbhgmVN01wUF60DeMwDRhnPjojUh1KgzCRHhMmUmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNQhePvMW6kyl/wc/JBIprr5AeuUsEAuq0j0rmFk36Skk+Yl0J06+Zwt/3+2YOxbSfy173fHqnk7FlW5ZnbXMv8RWpH6DEwF9okW/cavWZ1v0jkCfuXta4m/ZmgVA0QojWiSMDauwrlXFMKLcnD5mE7nYOZW/xiS/6zRXYeTaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSO+xglU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSO+xglU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D78C4CEED;
	Fri, 11 Jul 2025 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234227;
	bh=xZxbhgmVN01wUF60DeMwDRhnPjojUh1KgzCRHhMmUmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hSO+xglU/FqjynG7/j8fwnroX0gNti24HDSlnUdwWaG2KUqVDlwtdG2gZpwsCsDa2
	 /ZwfzbFxZlniX1/mp2elzZuHMaW3Ku8yGEUgoEp8sScpcFdBEAb5jb06t8rtIbO6jk
	 rtG3JbMGW05maE/XMBTPzf9q+lCgqTRbYrXz11OWWl3peGLrDWNko+7ZDUC7RCmPBt
	 k4Ge+gD4GIPeMlaZuDR3VVGW3KTAalLkkbEEfHZLVljqCQwdVaTNU8bNSH8hUTchhU
	 TQQ4Y1y+gDaH6r/NLBmdwlvpGLfHZkg15YvbnNKyLN4PbpeBDP++Qe5cW4g6Rl9H2J
	 oRRfI1aAm+NJw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:07 +0200
Subject: [PATCH v3 06/16] rust: block: normalize imports for `gen_disk.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xZxbhgmVN01wUF60DeMwDRhnPjojUh1KgzCRHhMmUmA=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjPTftHNyvPJOZBiXgWJKvvRUufBbmAXg+Hm
 nu8v+K5DaCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4zwAKCRDhuBo+eShj
 d9TrEACYuzwo6y8OnstIRUqvJK5xiumnApmqBDRQqE2BaCPQ8hQDVC72NEmfxRgMQf8leI7QjgV
 Ami7PcQwyBGp9xkK1dMeAvrLfHvgW1VQ9q9Rnm37hwndOT8xV6gKFOETe1mvi9aH0HhS4GGTRgB
 RSDMTwsygG6iFz9mTeB/BwTVwPsa/wb63iCfGNl65O3e2My/PazDyUB5cu4LuOKaT4CIHmG693q
 OyLwizIw6gCagMUcI2pLW3LmxLFB+j3K/2HgaA/Hsx9EcOW2du0J2/TFTDAVDGFtnQT+MQXWmmY
 CvEme6mP+i0FsJGR4lvwjus0SPU6mWkzVmJXAwXlVQMclpoWEAOUXoFsMM/62uhiUE5sfkGX8ZQ
 XoEPhFSdRuL53IVO/8BmUcb1WZRyXv/RhEzddj3HEVbwSRcNcliJhC08C+ZY4MdHw2ZysAg8SGT
 Ak2uu7AK2AKjESax8OJmA34hRfyb5kZ/ThDQJK7Ky42ojVSb1VRGDmYBs7bBRlLCdXkVZS2/hQy
 TtxgNG0yvXc5f/YMXYGlZidw/aHCV1TU9hzt4AGaboUXGtqEdW9r87KL4qEyyjNQW7v+CpClC7C
 oGpIfqgw8vjtDPyk3J5UF5JOOvBZ4VNL22eCSFXl+8y12sAdxFTuFkVFTxLVEz6OwWz4v8pQAbJ
 9OqpPGXdtixG5zg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up the import statements in `gen_disk.rs` to make the code easier to
maintain.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


