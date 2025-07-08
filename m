Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A124110F;
	Tue,  8 Jul 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003944; cv=none; b=DyaQT58gxKujNPlxc8KCvWcPNrOlaeOU0mqqDJLPe7uW4CY+v3euYzGz8FoUkzC6mhp9O0NAyp/eFLejrK/tYDX8zaVECIGWz0sWnnJ1QC9bHKiLjsPkZH2Bwzpap19WGRlu5ZUCBkwT4ECIgQ61T4q80rsgbhZ6qAEFAIlqTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003944; c=relaxed/simple;
	bh=S1YvVw9btOE1k1+ZSLyFicKOHlIpthgkLxSgRfxxtWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdDjL+wg3yUnSbXNdQufkiZYgx4A2D8gwmh3lULWLPjeXI5V6rDpHKQVrcLqcNIbLl1mYaTy3YoF/QSu+OU7SL2MyM5PWwh+RXyYFw0coENrsjXlH0VAuias3Myge54o+g/MYyVd3w52uRjGiTGlwahax1tLEmczYMm0C9d5oVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2sPBeK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2sPBeK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07678C4CEF5;
	Tue,  8 Jul 2025 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003943;
	bh=S1YvVw9btOE1k1+ZSLyFicKOHlIpthgkLxSgRfxxtWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K2sPBeK8Ob1xX3FzWQFmqJWh/ju9lb8M/ExBDTg4oRsESQvtMGRibzpYIOMf9Wxnz
	 D+/LMdS+gt9fMN0fXa+SixlYBQXS67FBGVT8ZwjzS77pW9kYFUB1ZOzTVm6tV+xo1J
	 9wVc4wV+u+lAtkfrx1RCsjpPRHaD0muG18ptPCdZDBb5iKuPYipfadNs8bmc5+NJJt
	 preJdrRmaqsHEXgXVdMi51gVJyDyVgrMKNaOnw7H00oP+RvKmC0ag9Ev7/qRih/mWJ
	 1zv254KjrVixShrWRB/CjTKJse32gQUh2tIJYaMUnqFZ9BIfWEHGn9jtluTbET+uzw
	 jCYkbi0VkVDlQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:08 +0200
Subject: [PATCH v2 13/14] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-13-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4996; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=S1YvVw9btOE1k1+ZSLyFicKOHlIpthgkLxSgRfxxtWw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVMj4/Hj1QhktbhgAd/zLaImmyq/E+z3nyBy
 OIAr/soTqiJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11TAAKCRDhuBo+eShj
 dyqwD/9ELvYnnB689pWIYcj2I1pJyU0ZJHkYN17INvKyj2NTOT8D4EPzgSu0cYyXKSABh0mqIiW
 eAZQDsghBRLk30WlLRAS9fusg4TsBP4arKKqWGpQo2Qsx9+Y8RGbEZ6FHP2f+ln8nQ69ZrOVduo
 KUQCtJww9M0mYRMCO1ZiuqPnAKx7Tegljcsf+DFjQlsgMPgk0VUCb0cOf1SdAlNPLyVqZdK5Cih
 XPYx2yhTFeIcL5S+Sa2GwwVS9K1QzGIHs8V1RcMbushb0TAlOvNeCFuxj4+3fx0HHFCTh8SI4eb
 kjTrC4TE4sWdvZAuPD9SVIHuC7CeQGvgrQ0Z2LVfn8LtZ96IMyRHRM6fa5Z3zYzeA6zgzuQfY3n
 tYtM5gZYczBfIk/KPzEv/x1/1jhJwoofswzAcpu8vvvfVZ1OceNiTFpFCXlN39lVHFNJvjEy/Hz
 t6p9aHoMpwlrM45Ad8DaxpcuTGBFZo6/4VEuUPufm3QemOTTvzFCwyShoyvlUfe0i98rAH0xkjn
 hB2dKDfPphTwuji59H/aQowzO/vBsLWQ4AT9wj/wS+wfT35hIul+mS3ixf7tuOWon+swJ1xN51z
 vAe0QBDLBEPWGJbL6Y5O0xHZb2gpXrpMiDXjADHlj5mQeEjB+IWpiKL2xq+IofQPgTAtoI1muTA
 5XCeus1Gf9ydb3w==
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
index a012c59ecb3c9..371786be7f476 100644
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
index 34b7425fa94d8..551ef38efea25 100644
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
index c50959d5517bc..b6b26cebd4f55 100644
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
index 873d00db74dd5..244578a802ceb 100644
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


