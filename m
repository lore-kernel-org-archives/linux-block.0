Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249172DE6E6;
	Fri, 11 Jul 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234221; cv=none; b=O1MiwIW+m7O91USJFPxpaOg62A2c+tBJ5qwDF4rzFfTF1weed/+hfzOeDV8qa3sa2VAgp15EOncjGQeTr1akAd214jNCX3u4tpU2EC3x6mkm69HBSNuBPqIpsQaeA8ONaJxLtKnMar+d3Fz/B6cBsQnoFLpWavsoTFwOnGgEo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234221; c=relaxed/simple;
	bh=LSx1ItJzMBA57/EBhXrxJqKwSb/byhu1bF1rbuvWUgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0awLvZa2teugz/MR/zRKM9QQeKFoK/UqvZLz9vHdplqlDfJaza3uGSyViF8hSrhMsG9Wj96N+g2rhFC3YEl1MVGl0M6oUdZLAh15x0vw3u3h4kcr1VPCacgA0ODIbyO1J/I/YaM1DWD/EElDjZAkghLWXNNYmOFztqdQnepLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrR7ni1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrR7ni1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5EEC4CEED;
	Fri, 11 Jul 2025 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234221;
	bh=LSx1ItJzMBA57/EBhXrxJqKwSb/byhu1bF1rbuvWUgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LrR7ni1YPSs0r3RkVSo17/sicYi83TfoU7GHxB4EWODIP0rV+EbT+/uAuefgSKZUK
	 UaAruYDXt7t1q2uIKxmDQ12UumUX2eL5DcB+dcb3iugJuuYx0AJOACjmzqTJVA9vXb
	 o8kZ7rpWK4gNheUwc9YCsjNYoLPSfgzSYCW2rNqGnX7uxdOTEAALcE33raTSaStq9d
	 fheV6pI3040MyLD6seCVNQTKPQZ+b/2GjE+Yw3/s1/ZGA2DXDxm6pP1eQBmgiwfw6S
	 7i2yRKH2Hkw4v+gQqqUgvQTLfbRWPLDvYgJzVMDbpOrEvVTN6zFxJT66SrFBkW5obw
	 +OW/GF1ZIF4gg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:16 +0200
Subject: [PATCH v3 15/16] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-15-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4988; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=LSx1ItJzMBA57/EBhXrxJqKwSb/byhu1bF1rbuvWUgY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjXjJ5h+X/52bpiq+g1p0EkDmulUlDzWVwK+
 Hqe0mke+Z+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD41wAKCRDhuBo+eShj
 d/N6D/9n2oK3tRZ+5im8UulYawUc/j2qGQgm5MhJ1gGksKmQfI5DmBJxd3rryoC2C4xXqExELO4
 6KXrk5yOIrLBjS/0QTO8SNt9UlxmP97I+IuKcASEoLnf/a7NmXq2mFrpU/fiQVQQHn0W7vOTle6
 CsrcjzK7Gj4ZsjWrcjBpAeFpiAWAP3n1i/jr9CwkF6hV3p+7QlzeGU32CgbbfPqrrIHzd695Jwj
 rEJiJKG91udigrzconxABqna/n2kdXCfD4ZIkOOwIiUOjafhh/V5aGauHXq0JO1AZxZLhYI6oTw
 9rguHAyFU8rIG5aPrjiUcmLS6cFbG1Vq8V/su+3PMdH8ZCjdKhmLPBpEHcu5bVo610TwsrQlKxZ
 08wlnKeAAwfMikag0T6KE1LMc8UL7GX/xWEEr4sBe3zvc/HAVduD2iHT6Pc3zpztQ4IBrSiIkFF
 Rs18tjkmmFHN3HWqiEGKpv8FckqX5WWNUO/rhP6GyIqdAPRCbZGxLugf+qUHR5pK28XXSSxtPO9
 cTdHfaVQ1wlqREECASoZD+6+VudZTtoghp0fKHlSOOFbDsFhk0faIja+aXVfnudg9G2K47YaOYB
 0nPTotxoA97GR0j4yJIfCLDGef0NEaFgLTmRCa4bZnv8Dl8ChUtpkVFKhUKTp4ssUW3M0cDnhFi
 1SonFjAD6S4ryoA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow users of rust block device driver API to schedule completion of
requests via `blk_mq_complete_request_remote`.

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
index 34b7425fa94d..551ef38efea2 100644
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
index c50959d5517b..b6b26cebd4f5 100644
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
index 873d00db74dd..244578a802ce 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -130,6 +130,23 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
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


