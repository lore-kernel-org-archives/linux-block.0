Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9B2D739D;
	Sun, 15 Feb 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199156; cv=none; b=OZdDgv5Jla772QWlNqgD0fy0nUn910iwa4OLUjCS6kK1GYP6R/X70l7eakFuRx/C2jArRv1OQ3wF3BGnDxlocqfJeO8LdC919Cy6cEqkJ32wOyYInL6gJ/W/PiHfKP+Cso4S0KKyflm6eNbHagdFgTHpbrhPiVs740IY1tJSQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199156; c=relaxed/simple;
	bh=wrhcSML+9BrPk1dlrkX3dG3Gv57kLOFA8v0YPzvxLbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMfrOMrfn+HFQFy78X1MElRsfDOHLiksdFVpZuOPRgrB0Vl7AToLqfw4BwwBa7pGmSeGix8jPjDsJhCvBk5LuBo/Ad079xDDCUPmakKLPL/4HC8ZYafBzdCCcyXDdXw2reXG2nX85Bf56vlC1iYC3PwBZm74WqKbgUZneKJrFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ+sY5FJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ+sY5FJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FADC4CEF7;
	Sun, 15 Feb 2026 23:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199155;
	bh=wrhcSML+9BrPk1dlrkX3dG3Gv57kLOFA8v0YPzvxLbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQ+sY5FJdFK7C0bMKDMNQG//TkYOVO2Ma+pP2CqA0jHQ6Kjt5PMd3AHl+pMQZI+vX
	 T/dj3D/hKGzZq5zB1TgW2QBg3UZycnJ0SMt2QSQWpbTrPTNTCAqiUjStS/koUCbY0h
	 q7xd082mA9CIk5ClY4pTkcHa1SWkezlG7fuT+vmHU2lmNpMlmUdH1xc/j70j+vxGIa
	 qt/PRGHV01WoCxvgNhK82st7kTqCemWSlV6QBVTq2WhnJAwZmJXaOK4AMSEZkmXDar
	 hXYO2EYOXPVJNcxs/t6jRyR67CplbyDkJB/WcB/HSUsdxiZccQq56R6O5/n77YhiPC
	 IyA2ggG35mjOQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:25 +0100
Subject: [PATCH 38/79] block: rust: require `queue_rq` to return a
 `BlkResult`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-38-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2623; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=wrhcSML+9BrPk1dlrkX3dG3Gv57kLOFA8v0YPzvxLbk=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg+aD2Q5nTpLbFekOe4kY2SQW+CRM+wzayNW
 25s6DTXJzuJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYPgAKCRDhuBo+eShj
 dxAmEACUQDpqem2zZeoXicjw1rcXE/XDLpB4OxcbpJHvAtlXd8Aeb9D/hJe3GMCXRFn7Cf9loKT
 ZRWGAJSF7Lc/MHyX7/WAKCNkpAboNTpi2P3T0EkHTOVKJYNLF9dTlpXEsOEvEpzfXOx4pHB+4B4
 3RvW3jFJvNl629qfdyos+8dYi+SjXc7ibhRUjIrfplr1X4BYzgxeiVIZiXspMFkz15aZW/9Dzdb
 u99kjs6xhkzqw5xAM9qd6hExxH0igyyE10VPark7jPgsjbrj1jO2GdTZj3cmG9Jl8Q9EP1Y1zDl
 FCehWz2ZycZZsH5Xj91UulUhUbRmPujZlrBgnJ/J2rAqjHpGW/hmTA+GowYaxK1iA+zMRpe4El9
 ygNqT9CN/pnC4F+YOn+5df7L3i7+UBop86EOW1iyz59sGtsmh0o69MK24skCsoonQ+sGUovhEW+
 z5+bl7IFzWgffJNz/XCvM3Gp62t2dLHFfsJrlMa4aZQfuXLP1nZSEPAMmZwb/UXfD9nSBi57+Pd
 fSFtbGL7IEyAmyBjr/w1lBJ4pgZvyHgrzhjXfp3HwyI+vLDuyMGpGAaXetNTMCDrQJNhwfEvzxA
 PGHUZnfD5K+N0kzsylNrukF/W6731eIbtPimHorIODHsra0oI2Bn1+zEfGbFrFhshcgWYbF6YHT
 OTXZstg5sbfAyVg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Change the return type of `Operations::queue_rq` from `Result` to
`BlkResult`. This ensures that drivers return proper block layer status
codes that can be translated to the appropriate `blk_status_t` value.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       | 3 ++-
 rust/kernel/block/mq.rs            | 4 ++--
 rust/kernel/block/mq/operations.rs | 7 +++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 034ddc06eabf9..55cbdfed25414 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -20,6 +20,7 @@
             BadBlocks, //
         },
         bio::Segment,
+        error::BlkResult,
         mq::{
             self,
             gen_disk::{
@@ -577,7 +578,7 @@ fn queue_rq(
         this: Pin<&Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
-    ) -> Result {
+    ) -> BlkResult {
         let mut rq = rq.start();
         let mut sectors = rq.sectors();
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index a898dda2635e5..02738f52389ba 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -64,7 +64,7 @@
 //! ```rust
 //! use kernel::{
 //!     bindings,
-//!     block::mq::{self, *},
+//!     block::{error::BlkResult, mq::{self, *}},
 //!     new_mutex,
 //!     prelude::*,
 //!     sync::{aref::ARef, Arc, Mutex},
@@ -90,7 +90,7 @@
 //!         _queue_data: (),
 //!         rq: Owned<IdleRequest<Self>>,
 //!         _is_last: bool
-//!     ) -> Result {
+//!     ) -> BlkResult {
 //!         rq.start().end_ok();
 //!         Ok(())
 //!     }
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index fb75d65f67071..17468a39af60f 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,7 +6,10 @@
 
 use crate::{
     bindings,
-    block::mq::{request::RequestDataWrapper, IdleRequest, Request},
+    block::{
+        error::BlkResult,
+        mq::{request::RequestDataWrapper, IdleRequest, Request},
+    },
     error::{from_result, Result},
     prelude::*,
     sync::{aref::ARef, atomic::ordering, Refcount},
@@ -62,7 +65,7 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
-    ) -> Result;
+    ) -> BlkResult;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
     fn commit_rqs(

-- 
2.51.2


