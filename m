Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FFC2E172C;
	Tue, 12 Aug 2025 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988375; cv=none; b=AfmKKilIaPLl5mOTMPLt9HSbjiI5x70Y/uy8L7D6g1OEiUgZgL+UCezw3C5Ub1p3cUD7sW55aos/UIwPDoqvfUUAVo4upsBQKU5ofumKDVpdOwTBdMZUqLOzoDLwG0rVbFrMtWuEV+hO36S9BLjpvVzb1fYqO4xyWgKEN576seA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988375; c=relaxed/simple;
	bh=SarPWE2WmtPmfcOjFzORYVCDQimCZg5WOJ+Eedavrtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFQa45kOq/gSKbDpcPawlIWnjhswLwMqgdL89HuffdVG8tVSzillzZgqhXecchQuv2BHxDXamnLmO8xJQG8JwCD9vSf36/X4effnMkS8Fmu9kstGxGjBD5JWgTviiQrEOgv2NZ0irPsK8PVOJfQYMadZ3iM8uiu2xNetYp9LBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaHEl/je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaHEl/je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F34C4CEF7;
	Tue, 12 Aug 2025 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988374;
	bh=SarPWE2WmtPmfcOjFzORYVCDQimCZg5WOJ+Eedavrtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oaHEl/jeeFKaivAe/gvmDG8jl2yfl5CUpcD4N8Jseo6SKIlDHwDYxtJWVS1MD5Nek
	 nQqFulVbOqCBv5P+Sh17OCVxahO2RIasmWvwLRMHnOqcbTjPF6g24oa9uLdaU0sZAa
	 Y99o2ssVqsYeB0zPYHD8cttc63RrlNdbO6TLSTBFrJ4QhQXkVg+gzKNgzpK8HQdm38
	 erdFq/GHzTnnNz86eJQv3G4eEDgrBogOx4+n9vDvf5fhzFLCtyWHfJVMzkDZRkSxn7
	 ZY0apkLviitsMQz1pO4eXRKUBm8cmDkqvp2LvfnmfE7CJRssE4XBrn9yO4utxbUi4Y
	 OVv5KPslGUOPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:32 +0200
Subject: [PATCH v4 14/15] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-14-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=SarPWE2WmtPmfcOjFzORYVCDQimCZg5WOJ+Eedavrtg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8o2QHChnXou8Lxfh1/0rj32z9j9ZoyXu9Yb
 jQU0+oeTeaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/KAAKCRDhuBo+eShj
 dxHCD/9bmVWFiWfqD/26kXmM6NbrM25WuYly7maffAO/JqUGVjgJ58hRv/R9wIrQgtFbmuyTd/7
 GHJZIql+aPLwcQMpj30xsqa5QvI99KhKRWK6ew2JUzw0k1fGBHWfMvyWbHRl8WiaZIo3Xjccpov
 4MWO6nfANLhRQ9U4hbm1JjrEJvWkvAdDeEY7p52TYArTrX7Wd/fwt2kM/ZLf4n6UrpujpDI5NBn
 gxgE9UiWW5PDqqwBoeflDpT0f0+P+72PT1Chdoiy3l9vRVGQA6NrAx4FFq46zCZezYsefL9mBC0
 cxMvcDVfrVzaRBVM8qZYcmHWL2MO61s2doOw+11l0CUgH+DrgJi7ONQJX4AadvCtDyIULHM+DgJ
 dTi+BG4RrzZ1RHdabtHkQHv23b9SHYKj7PmpT2ci03yOgyaKwEkN2+BP4EbB8gzlgubO13Naz1w
 /KU4Ec8VE4yOa2Nn5O6DSZGV5NgT8BMwf5DpOyhn0THQTszPlxDGBD9DCPXblxREZFUD64phPXz
 +0vU3gr7DwGreqsOFk/Cz7PObgFFDqzsTIs65QH30gD1oYRn1PjoxJ5rQ9Y5zxzZCMQZWnHMZS+
 k7UAM2bqSlmX9qgdE4cQbC9dJZYHgnTHGsu/7f8vKtDS7SMFHvL3nO4NbTProrhI+98/NJlO6hL
 EK7inB/NmD+SHkA==
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
index a6c1ee2190a1..fe516ca52ef9 100644
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


