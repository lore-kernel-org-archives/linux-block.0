Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051922F1FE7;
	Tue,  2 Sep 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806955; cv=none; b=KBvL4cdaCRZt2EMN84XS0v85dXzPqbhIQ9ITxU3vkhRMKJ4SHifmSZ6+xDSvrOXZ1MA8F8Ny6ch8GgixmQlihhDmGAfq6LmuJZVpybpeb8ePSMg9D1cJkvAsdXFTZU+5AE8eGlA3cKGQL0B0ETsP9sQz/HNnQQllbyR3k8NGHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806955; c=relaxed/simple;
	bh=YwUF3HJQztP31Vw7ZaxJ69OuXp+5+j2Zu1cR8QzNe+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HkjmrcZ/7N/QR1+kzVGhgAlpc7FjoZOuR6pyCNryHV5sujXkRAH8cB8H0uhQShrgZ6P/7vdhCc0B40BreamY1KUbd5ChXdlv4aK29d5cAsZAsPZd7hiQZWV+R5xDcz1dhe3gNbqwJvLVqVUkfH/zoqabb6K8OLIOYihWb+ckUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck9dwNAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck9dwNAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFA2C4CEED;
	Tue,  2 Sep 2025 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806954;
	bh=YwUF3HJQztP31Vw7ZaxJ69OuXp+5+j2Zu1cR8QzNe+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ck9dwNANve8Ne07xu+AirZzR2EBbPSww8ib2Vc8HjgubaHxLCmRmMZ1hCtNta5ipZ
	 PwY+nMPI7lp/yvz6I2fpQz1GZ+4pH8h4P2VZzkcv/z9D0gy5Xokj9hAtxDfrO0zIa8
	 +5lsuG404qojoocZrC6Sp+6qhK6MJ4AJba1OBNoso1PneKZckOiyKiUs58w1tkfsFu
	 nkZ0t6KLNCMbjNPoMERvwyHf4iwXjM4w1/rb/5gAJCAPWmdrAIF2aNY895V9nbP+GO
	 yvY5dpHycAe2i/7b64wMtPyWItWvPh7BkDJZeM+c/b9XMPB+u6B2bcz93Ho9HsxluF
	 4N1zDc+WaJ3zw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:10 +0200
Subject: [PATCH v7 16/17] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-16-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
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
 h=from:subject:message-id; bh=YwUF3HJQztP31Vw7ZaxJ69OuXp+5+j2Zu1cR8QzNe+g=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8HVoiFEohNXcMvJ10o1RLWE0ZZxSrQFCEj7
 KsX6wNYVOuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/BwAKCRDhuBo+eShj
 d432D/4zM1sRmiacMnsFNRMn96mFZy6dtbiRextv5n51Q1z+n+WKRdCnPqqkm9nDvocudZE8PQ/
 OIJOfwZCMsDwUnDUhFU3TzR+61GK0PhdxslCeBy6LrHnWZqw+mjsm5WSXV94EehtZCsejiedItR
 4hsKAjFt+dYfWkEOQBSyyang5iott/7IyABtmM4iAHnvLGxrLp+/xPfk4217EyvtS8oOOWK40EJ
 7YUhy0U2T53IyTZ1bbhgZv3eH/gTQGqtHVKK7sMrBeuz+vCAR7Br15qgdLsWC5MvdhPk6BkKPK6
 CTYs/TzSw9Jl8JvrUGKwIJqld+rpTwwoIAALQnnS8LFDCvA3yNmOyCS4T02cyzSS9fiIIfxDG+e
 SNmRWhccoF5f7m1Ppx6gj3mmSf+ljv9gUXXFpXJ37/LZNYRhVCUr7iHUpo+po3eiY37siNQ7toz
 6+yGzbUWAvszqfwGpQXTDH0kCFRK6irveEKzSh3IAnHP+b6x0pZhDBGDTg2CgY7MwJzNLwDAiWX
 V4h62DDs3Jxvzfe6SbOfePNwb4I6/9hP1dKeDG3DNm3sJLBJLUFVj92hxVEiMCKW2zogFzHofzu
 1ZKdzyVrGAMekKGQASkz+6dZupYftF6jCTsbkGxSCQ7XJhQIj7ypEe8SzlNKW6GrZKHBtLWe3A/
 m/vRrgl4jESHYpQ==
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
index 8255236bc550..a19c55717c4f 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -82,4 +82,13 @@ fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Res
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
index 9e31d24e1164..d098a8a3e434 100644
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


