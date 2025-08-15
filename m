Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B22E3717;
	Fri, 15 Aug 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243142; cv=none; b=HeXtdDIzRqQy+sfYwyirZEUopXEycszb6UmDLN3AsJxw0rAkc6JtoDfMe0kXNeKR4lBMc5fjdXW3QvL2yP1H4qAsIm6tFpNUQ9t1c3rjEwI/XYPYuSX6xrc8y9JGDnsbRmfCfoRsTE+ycN5W07HyEfnkBF9xSfUVpRwVG8k1cRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243142; c=relaxed/simple;
	bh=ptlSB6M90/rSSKcTITvpEJrxVHE1Cq2YggkTtF+7zuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZD63QtOl4R7oVfkAKmuB4CYaZwZwqH9sVTQFPtlhLSaFW/NLBZooB5W9JlfgTpQ8ud+sJytGqCwqVqlltuOI9acjncIrEgtDAKHn7i7Eng+iz5CfblT1xR5B0fbYFJRbW6aO6LxtivsQ3MV9AfmVvAuEQGE615rB7/gUxeIUfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoZljY9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoZljY9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62D3C4CEF4;
	Fri, 15 Aug 2025 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243141;
	bh=ptlSB6M90/rSSKcTITvpEJrxVHE1Cq2YggkTtF+7zuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XoZljY9Ldj/5cPq5m0vhHaIgNOEzPK8va33By5BX1vTY+rJc7R+8Kt+S6L61VIPw1
	 k+hhYiduVKs1zhiVUPitROCIhFuXPmJTaxtllbJ1k29fB0Ooab5gUOGqElsX2yMHgf
	 3xIuHt4MShJ0mm16uc832iBEJFgWr4PqSArSzAwxuxfK28jrZ4QLyGRSaEdUM8p1um
	 09OCoa7mJkocvNp3iaDOgNpPquPbFgwouTikJR5lRNgndBB2BaHtR/FCKbHW8TPZ4I
	 zOC+EC5GJBg4huzzSU2hApsZag/Y/MxfYlH2x1zz7HCDJuCtHLssNCzrxqI/wIt5GQ
	 pJjzHVHQKBkVg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:52 +0200
Subject: [PATCH v5 17/18] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-17-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ptlSB6M90/rSSKcTITvpEJrxVHE1Cq2YggkTtF+7zuo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuJDRbh+iYUm3B/Rl8pnd7/DbU4talFphY1OV
 GNtK+xAov+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iQwAKCRDhuBo+eShj
 dxUOD/90P0qxled8tMgqTvZrwRFsQm2CK0mivxqCFoCrMruKHcUiMTXV/CxqiskJGYqYCkpkBCH
 etAlWuhoqjnhjXloLMEYN6ekPg7Wbr8xuO1fWfIC5tBq7AlGFYSIYqHzpgIpui9IxOSjpPug6SO
 6YqbDCfc0TdmQiUwe03PMMzrVTm9v6kiKHQ/ZKJviSf16AGZlfMSbcfo97vqK/WRd9C8xV9wSp2
 aqQtk/rmPyVYYKKm+Du1OetqntcnRi8flT4VkBqTytugIXk2midRXZo+5eu6ts07GQHHCxdgs2z
 Pedh+fJ13dqN3sJogGoH1GHZglTbrgpEEvGLP+OpC1mEAyRs7p74IpYUTM+WEKsKf1r0Sgcknxh
 8Vk55GWdiF3HEHSgAaJWAg1wsJKN9TKINx6aI/ZEHWGLNH2iVnjiua3EmQ/AtNB5C14J5+R/bx/
 dfBXSurWbO6YfneqXIRqQTutvTV5su03B2pApa/82fPw0Klph7aEQYdIEYe2k0/rDpcUO8OHsS4
 tqXbGQbf7KgeG39yRehlOe3JqO78/hNBADBR3ne4VWYYCN1LoeGroim1jgrqxNEmFIZeJ5yhrgb
 pHySvaZnkCzl8StpnU4+8vGAJRSimdSjD9QKOkB6lySWBgIJ3wTqt8XIi5jnioRvviNlAQQyhf/
 joinvrE3NcOQ18A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow users of rust block device driver API to schedule completion of
requests via `blk_mq_complete_request_remote`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  9 +++++++++
 rust/kernel/block/mq.rs            |  6 ++++++
 rust/kernel/block/mq/operations.rs | 19 +++++++++++++++----
 rust/kernel/block/mq/request.rs    | 17 +++++++++++++++++
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a012c59ecb3c..371786be7f47 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -83,4 +83,13 @@ fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Res
     }
 
     fn commit_rqs(_queue_data: ()) {}
+
+    fn complete(rq: ARef<mq::Request<Self>>) {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            // We take no refcounts on the request, so we expect to be able to
+            // end the request. The request reference must be unique at this
+            // point, and so `end_ok` cannot fail.
+            .expect("Fatal error - expected to be able to end request");
+    }
 }
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 6e546f4f3d1c..c0ec06b84355 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -77,6 +77,12 @@
 //!     }
 //!
 //!     fn commit_rqs(_queue_data: ()) {}
+//!
+//!     fn complete(rq: ARef<Request<Self>>) {
+//!         Request::end_ok(rq)
+//!             .map_err(|_e| kernel::error::code::EIO)
+//!             .expect("Fatal error - expected to be able to end request");
+//!     }
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 6fb256f55acc..0fece577de7c 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -42,6 +42,9 @@ fn queue_rq(
     /// Called by the kernel to indicate that queued requests should be submitted.
     fn commit_rqs(queue_data: ForeignBorrowed<'_, Self::QueueData>);
 
+    /// Called by the kernel when the request is completed.
+    fn complete(rq: ARef<Request<Self>>);
+
     /// Called by the kernel to poll the device for completed requests. Only
     /// used for poll queues.
     fn poll() -> bool {
@@ -143,13 +146,21 @@ impl<T: Operations> OperationsVTable<T> {
         T::commit_rqs(queue_data)
     }
 
-    /// This function is called by the C kernel. It is not currently
-    /// implemented, and there is no way to exercise this code path.
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
     ///
     /// # Safety
     ///
-    /// This function may only be called by blk-mq C infrastructure.
-    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) {}
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a valid request that has been marked as completed. The pointee
+    /// of `rq` must be valid for write for the duration of this function.
+    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
+        // SAFETY: This function can only be dispatched through
+        // `Request::complete`. We leaked a refcount then which we pick back up
+        // now.
+        let aref = unsafe { Request::aref_from_raw(rq) };
+        T::complete(aref);
+    }
 
     /// This function is called by the C kernel. A pointer to this function is
     /// installed in the `blk_mq_ops` vtable for the driver.
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 3848cfe63f77..f7f757f7459f 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -135,6 +135,23 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         Ok(())
     }
 
+    /// Complete the request by scheduling `Operations::complete` for
+    /// execution.
+    ///
+    /// The function may be scheduled locally, via SoftIRQ or remotely via IPMI.
+    /// See `blk_mq_complete_request_remote` in [`blk-mq.c`] for details.
+    ///
+    /// [`blk-mq.c`]: srctree/block/blk-mq.c
+    pub fn complete(this: ARef<Self>) {
+        let ptr = ARef::into_raw(this).cast::<bindings::request>().as_ptr();
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`
+        if !unsafe { bindings::blk_mq_complete_request_remote(ptr) } {
+            // SAFETY: We released a refcount above that we can reclaim here.
+            let this = unsafe { Request::aref_from_raw(ptr) };
+            T::complete(this);
+        }
+    }
+
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///

-- 
2.47.2


