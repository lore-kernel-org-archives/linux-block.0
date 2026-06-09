Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C53C10B9;
	Tue,  9 Jun 2026 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032449; cv=none; b=o6nFjUYd5LhCHQdn2gDj2eKyq/5NznpGw0CTl5c2AyHUOyLHnCpKCk/gQQFA22UdChVsXm1GvNE85eD/y+rK3yH470n0t7wm1NaEE9ecwY0ilxPUzyYKdSjzH2qJHccRSy0DbI9cmq9T1IbKMfe/1hDhTV7EpSB84wxZsnIP8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032449; c=relaxed/simple;
	bh=DdV/NLJR9VTmPqZyVaI6uzyHec586erqdAzY/0l2Nn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MD6V9IO2k+ot5KBaDik0mzhBG+40oc4Tn4ZuxCoZgxhrXJ1DJwj6edYDqvabPdAgnUrFHrAkZ0lrR+Ct6che0+ya462Emmm7WmqVLdqy8bSq4bNTizCzol9Cxt9v1YcBrZOd612aNDPQzCyWYun6/SzYokGpnIhFYnrDYb0gEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjlyuyx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjlyuyx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB8C1F00893;
	Tue,  9 Jun 2026 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032448;
	bh=x2PxxA3MSPDESp6PPRlNFBFe70vLv/38gregfZpEU1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zjlyuyx8bYL/2Qw4pNRLmAEHI0GjtXrDc1K8a2ffnCDtsJKoZFEUWFTPw5PIPVTCX
	 5+Dt7qmtIZ183zEAPDo/azahSlF81GVi6ROKQcaRe0nw3b2a+2p9gjQqbjky35oFLO
	 XD7KRmiIGvuYUSIN/vxnscSb0sVUIo0MtsZQ/BVEFxwxHoNvSSQx+1t3iHQ7wTlw1n
	 LktGX1Rw5Fu9Firh01MDlOSQuf4Pgng5clcQPr37BPO/TSXsABkdM/VzMgjrxRhf3S
	 E6m0gNa8NKgkt4f6tNYgeDngM246bQ9W/ZRLYeCZ5wTaSqnO9EKfafJ25tHWnTfAtj
	 GuAEmxBHcXrFA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:21 +0200
Subject: [PATCH v2 42/83] block: rust: require `queue_rq` to return a
 `BlkResult`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-42-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DdV/NLJR9VTmPqZyVaI6uzyHec586erqdAzY/0l2Nn8=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTaruS+IOkE14zFQtyt0+NF5/WYzKnu8ZDWM
 tiGv7qIRIaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk2gAKCRD6UCkIqsW9
 0B7yD/wOR8PPlgBri1+hwHQY+XDM3u3f1pRkc8cj7TuKaXgHixWBdzbLkqsIc5cdFkOgiBSAc5N
 pfnFEgZ7b267KmCIrTUViibhwJ9jmlH2J5D/bdZlWKKLLrBhoxoqh2OEiMO0feNI76lzcNmps/C
 Hqcmlql6GDiMD2qzQbpOmwMTv7VTPB7y5F3rUIE82SFcSk723PdvakjbKmpLTXp8lScT5QRnEuY
 06m5hQPXoRHNuNnrIZcVB1k/8A2DkXoy8xvRcmh5/aP35iEe483vHo02SMTutUEyaxQSsANxbmW
 c/dIWCHfMHesodP5gH3QGt7HTnKYnzoJYfnscdsnepM0oGXrQIoW0tQnLVzWLNlnMN/Ekj5ti/b
 Jov7ZRf577FRhmu+xXe/8oT0boTu1rRoj6DePhfwAoXOuTzZFH8/xzdckSiNEy/dQOa0r8zRYOf
 SSfMFSQylDoWRPmBjRXMPATHYLcf5Z2CxZj5w8T6dU+uahBumZbiIKRlgzOQcjLCAKOajj5V1+Y
 uL8mYOZmcIBJilixB9XJhB7x+Wp1RZJtJlNsvLs55CH6c68XWISE8iMMeptSBBNCWram6eBqQr0
 ugbcSrBoHnaNa3lniFssKZqkH/8FXV9JljrSy/X4gZCoAWLR+U+vUpBSghlDSMJiVh9xOSlocNB
 hx5UUvhdKFemNiw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Change the return type of `Operations::queue_rq` from `Result` to
`BlkResult`. This ensures that drivers return proper block layer status
codes that can be translated to the appropriate `blk_status_t` value.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  3 ++-
 rust/kernel/block/mq.rs            |  4 ++--
 rust/kernel/block/mq/operations.rs | 13 ++++++++-----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index bb8c4df08218..6ceba23a4d3e 100644
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
@@ -595,7 +596,7 @@ fn queue_rq(
         this: Pin<&Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
-    ) -> Result {
+    ) -> BlkResult {
         let mut rq = rq.start();
         let mut sectors = rq.sectors();
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index e89eb394001f..503623267b19 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -64,7 +64,7 @@
 //! ```rust
 //! use kernel::{
 //!     alloc::NumaNode,
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
index 01917ef213d1..b9a2bf6592b3 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,10 +6,13 @@
 
 use crate::{
     bindings,
-    block::mq::{
-        request::RequestDataWrapper,
-        IdleRequest,
-        Request, //
+    block::{
+        error::BlkResult,
+        mq::{
+            request::RequestDataWrapper,
+            IdleRequest,
+            Request, //
+        },
     },
     error::{
         from_result,
@@ -82,7 +85,7 @@ fn queue_rq(
         queue_data: ForeignBorrowed<'_, Self::QueueData>,
         rq: Owned<IdleRequest<Self>>,
         is_last: bool,
-    ) -> Result;
+    ) -> BlkResult;
 
     /// Called by the kernel to indicate that queued requests should be submitted.
     fn commit_rqs(

-- 
2.51.2


