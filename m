Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F53093A6;
	Fri, 22 Aug 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864983; cv=none; b=Z638fDK+xfOR7LLB26qjXHNmkGPtTVmQU1A/ZuqJq5KYQ0gp44mQlRlrCXhgnDFbMP0c1d1/4dvWMEFyLjyTogObR954d/OnODMoWS9QgHk0lVuTbsfv5mbDn49hbX67nlQHkuILgvDnzc1JP4wk6TxB3jfnS0G078qiyljZNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864983; c=relaxed/simple;
	bh=/q3BHJ4OBUGrEvfMJAnS4b16x6NbLDJGWQVOq+Cb5uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdUgJ8zCY5qamZySCrJ2IjftmMf9OIdmhn5X4N4DJLzEsJAntEChGSWKzXNOTlZKl1pVVRp7xb5EboBNRtZ3Ioa0QfTTDtSIjh6bJCZdJM+6vQ53DO48bJUmlc8ILk5OsWmci3EizgfEL6ZtZzJwXEJwuk4B1M0hd/GZv4w2hFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtMtEpoY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtMtEpoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31164C116C6;
	Fri, 22 Aug 2025 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864982;
	bh=/q3BHJ4OBUGrEvfMJAnS4b16x6NbLDJGWQVOq+Cb5uU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RtMtEpoYkzibvcasSDr1cZBGonwA9xeXLrKd6nlII8gUQVl/srmYCpDbcv3tFh+Fb
	 8SbhI+lfZZcfys2PHj1lZWphhfmtGGhQ8ziEGb+8xq02eNCl2NlrFtSD9XgEoqFl3h
	 JmbnT2jcbrwaj5vNpjoamEZTfSGABYeSK4YumRL5vh75Vrzgl6PNTWk9ZsG5t7nJ1x
	 vtZ/af/Hu+tRrFQybTd4N3yGhBuF1MGyYvZPg26Ca1OD5b/n5eaZUu//hcBSu9ldoj
	 xQO9jL9NcYmfT3S93I6gQMwtIOKDnuRe0f/i04kk32XbMlIiTtygxvDjLeo//3YLw5
	 MUB1YCDswMI2A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:53 +0200
Subject: [PATCH v6 17/18] rust: block: add remote completion to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-17-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
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
 h=from:subject:message-id; bh=/q3BHJ4OBUGrEvfMJAnS4b16x6NbLDJGWQVOq+Cb5uU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF9B0QbpmE+wvq7lNs2hawy9BgyH6y+HGY1UR
 /cZqI1GnLqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfQQAKCRDhuBo+eShj
 d+yXEAClAdZfSjB1v1hZEBspjqmjPu3dBNcFRtAtw4vgeFTOO80iQLswPbq3WcZnw1Hcgj3FcrS
 MjqfMd6z6FToOwvxqKzKNgk8hItYfmvLH+80bnMSCUo7O/im7n+S3V0712mTC9Ov8o0GeBfGlpX
 pRClqhJlfqRFRGgoMWtRsC8ZTRAaEYzUwck9oRjeeQghp8p23XReudZcMsLeH6tgBnwmEHaFzrF
 FPHHxdOqvZM6tDQbBQ/6zk4LFoE8P6tFjeZW7KBpqVZRDZhmJchH8ZFDp4J9OmTJFGIFgAM2e0K
 +ZbAdbK/VIeVg+jp85clymPCMcpS5jEP0co6IHjU6mbZduDeKb7NlvXGQMH7G1Fvo1w3zdvvBpk
 ZMepeUa+SLCcCPXOFAKbUolS8lIk1UWrVixZFU8Dx3F2iUFzYf4FyJEDY6fhRvT1K86bX1dDuaS
 UK5H+cq+aM+UuWa3O5pgeRSAPLX6BFBxrDXtLH/m+evMRbd3HMwIKgccXSBQcFyijPDw9lksQN5
 GsVowLd3qQr/9UaeuCEowUBe0dDR6smQUwTlWwEk5gYoIc0uTeHpYipEwMVQHJvaPHk8kQRLb34
 rmlBPCWcgv/uh7Y9dpn20qlhDMYhlCxpA9h1CHhLl2YNZURVFVQQn/LEycI7gd9f4Tp/0ilgSgU
 NcFthhlq3DfMNnw==
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


