Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272C2F2C4C;
	Mon, 16 Jun 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080381; cv=none; b=gRpac6iSiPeB1TSDByTJo1kMnEJZmmropWL5RLpTNNBdfL6Jn1YMcAGLWxL/5K9Z6j8G59r4Mlg+Q71z7AGdldHCC0rT0wX48Wu+3DOEric19WQNzryQuH7XfWE842FEAp8Pyg4rVAgdduuwkfHpKqhabS+4UoKd3Zvz0KUVSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080381; c=relaxed/simple;
	bh=LSx1ItJzMBA57/EBhXrxJqKwSb/byhu1bF1rbuvWUgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dS1klL7TjdGZSD3zGduD9bOrhqwy8p4oq0H/Bwn+HnwvZQlcYcQ+QLUKRZpcTDYpVt8x5LBW3XslbJ8TzE+3CxUevYi/ycrwzSrPFjSebwRtGlWAWr0L45ricpBBBvLhvACcGfx1vB8ktfbDD0xc3fN9fVRGCOY20oaMTR4GUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTHFzI/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTHFzI/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287E7C4CEF4;
	Mon, 16 Jun 2025 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080380;
	bh=LSx1ItJzMBA57/EBhXrxJqKwSb/byhu1bF1rbuvWUgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qTHFzI/T7RhcHzlWmWx4c1+3wSc0uDhggiRFZeC41taIiraaPS0iIG6tSFDsucqKH
	 kwOd7u3+XUEtV5ct9U8BO65xt3EozATsEQj5gFdQlPuyyM6CsdnWTeIIEkGwZ8GJVO
	 J1l8ufL54FCE4JU10e2IJ5bCkLGfo4fmsrZ3T8J4n3qHtsu1zS8eFYF37ofuE0SASU
	 ndgBTMvYVRozH+6m1S/4WyfVPjQn4wArvGajJEDlI7UnFnwXm6SL/Ap26Pg8bYx1Dk
	 RmkwehxKs+52eFc5GvLQBZ4NsQnMp4Q3l2a9k/a5QujsDPQXpMozJielPahSaepIZb
	 Q2jgvVCzu4Qcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:58 +0200
Subject: [PATCH 8/9] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-8-a4168b8e76b2@kernel.org>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsR/d5gaFcHFDlfh7B9XFwQr1F1YFEYchXmx
 CtkWTO5JpWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbEQAKCRDhuBo+eShj
 d6RgD/40R+zDCrUV9n2zTAAh1R61/NdHRWuZs/dYUE9nBCwpfjfBDIf48u9Fhb0ama//rbKw5RY
 QaGM/odfgvHWWdrhc6jEegbEs29SR41EiyNkMkNYDHupFCECl/8qL3T+vl91mPlJk/XQ1yE56NV
 BzVHM+D21yLV6lLO5Z0a1Elo5E/8XBJtYwDpK8MGnXNH2nMVLKuSSM2JneEUNsmHrt5ohcF/Biv
 7HD1CYpfbskEH48URIksdX+LKjJ/GvSmRar5wiGLy4Pv/rpl77r/kpCpwvoda0JrJLUrdul6cyQ
 R97m+KZkdAlx//clMw4XDfxoeIn/WnMXgCrmqc0G3bD1fEPe2djS9j4Z3DXlFN2gneWvo4vTKCW
 avFeglpTcMYKuZhkYygaHjcd5PBTLzxCgEKt088hDzNUl58FEdrBiIIn7cmmC30rcbsMnnnvyhB
 OWp8Fzsmk4FhJLk3N/dmJ0TaLJNSZSG3SWQ27YgePVaI1rgSPI4h+VAHTo/QVoC5mp1yyWhOpFQ
 X+n4hFEHprFoq0aCZeisGedYqR/j78/+rFRYZMQq4y+z6xEAEJT8IgZSwfCCMoU5a/UGpBH9isS
 L7wBT3o9mpomuK/Gc6AU7ZcywyXiHQd+uqBa0zQrCdtlJwlgrC0YWeXUfK2rII5ZfY2nLfy7QVt
 lD/9yJGXTEvwh/Q==
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


