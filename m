Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3930CD94;
	Sun, 15 Feb 2026 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199181; cv=none; b=joUe8DTAyybxEvQ4FHe8I8nt2CaezLrF0LGu8AYul3KNjo5pyX/qwgVi+9S8b1XFkLBhaOcpK1XVAhVK+z93wI9Z9Khd6qDt7UCfz+/MLuPBrojMlHrRCJONTmlm7j/PsQq8ZrCurxOPbSUZ59JazEQmdPRMMH6SUqQm8I87Ptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199181; c=relaxed/simple;
	bh=9wLxYaTCPfOG5uonTZ2h8ocU8FWs+hSDrEKcM2sv5z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlaRhCz4p0LLG/VnxxWTt1LPqSpYlNQwiorUfc1hoUiL8uuoP/X+rrCau22mgq5kX37nTTStWbiYKFYgGVozvDUOw2INX/Raic6m+22Meq8adxMvG9Qhjt5oATQ+BFSNHLMnvCwKxVkRl5iIhoe4V2xu8LZmzBjlUroaog+3ooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjCDYQsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjCDYQsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FD6C4CEF7;
	Sun, 15 Feb 2026 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199181;
	bh=9wLxYaTCPfOG5uonTZ2h8ocU8FWs+hSDrEKcM2sv5z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kjCDYQsRlhCQN6obSBw1ii95Qd4xqZ2D3oZ1pMKrFWp3LbPJEa068zb6SNYsrLyzl
	 RNtqfQABlx0D/geY5TXUSQ0unzKd7ZTFl8WrcQ6ptjFu3A7zKaqi2rHelGAxlnSd+D
	 J3eLNHh7W6AAppxKG9zzibmJ3iLxifuLzA7d+yJ7P4tFY8tPnGTRQKZ30Y2RvuxtbT
	 5aAU2fp1DgwaHG2wxFp/FdWtUMtAu/NBUq8CY2UY5lei5riX8DMBInCnZ5ry7D2sfd
	 9iQrZXLs9GlIXjr3wAh1d/iIpmUWJ6nvaC/yLvGJXKLavrqTYsAvNxCt1mLq6iK4Sp
	 nSEyBV6LaEO/g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:36 +0100
Subject: [PATCH 49/79] block: rust: add `map_queues` support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-49-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3879; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=9wLxYaTCPfOG5uonTZ2h8ocU8FWs+hSDrEKcM2sv5z4=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhHteQM6fc3Iu+s7ErTmW5+zxHdbuM7v9MUt
 WW0qbMjDayJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYRwAKCRDhuBo+eShj
 d82UEADCFQq4xg0GLRoFbDArGbCjq1pYimjtXweH1jUHAlgJbGGDkikwcOVePhVAnaq0cdE5BuY
 FST4N7wGwn5uDWVPQjXpCx3F0A00D312QyAmD8cvTc3vOP3J4jJptfyTx18my0TG3l/QpGh2k6+
 VRnt/4++OOUgxoE8WyWXsHSiexrgbP5JGRTRiN48GSZzVsD+hMHSp/+pgp7Xcl0BR+8bGdFiCQm
 LGiYwXAUL5k3Gqj/IYOdhE00o/x0U8DPQMfes514MGFteRl7clkgSvYEFKWth04xf/u7Ko2u7Ku
 9RZFRbrxsRa66tuTEpsFIA6IX/RwvMKZoXDegWKZ8M0TsY7LUUI2V7aNC7bnV2Xv0mertjEooNo
 Ua16efkXqh+Tx/mi18AdzA0+qemfM30vBYaWJ9xQDcAbSVCfSq+gB9EFg/ft+MzN7AS9w2UdGdt
 EJyQcDaAUyDI4zCU7pPSm/5GHu52+/vVcaHnTHT8vGfMk1tFZQ4t5d9DTiAS11OUgBMHJqhQEPX
 F2LkCpJ5bsvfp0U5L+/nuiphEGkRmHRxMhE4MQ2vGaAWhI4jUEAeiJC76C5ficBetddzfL4fS+U
 ZIk5m9JLWOTZyF3nP1DNE0C1fLiAMjBgV3OOwQg8Bp5j7v0btIbGpJUHAd4dzkHYMBmRMjTb/gX
 QQhP/zLigZgzM0g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for the `map_queues` callback to the Rust block layer
bindings. This callback allows drivers to customize the mapping between
CPUs and hardware queues.

The callback receives a mutable reference to the `TagSet`, and drivers
can use the `TagSet::update_maps` method to configure the mappings for
each queue type.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/operations.rs | 28 ++++++++++++++++++++++++++--
 rust/kernel/block/mq/tag_set.rs    | 13 +++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 3f84ebadec86b..017fad010d174 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -8,7 +8,7 @@
     bindings,
     block::{
         error::BlkResult,
-        mq::{gen_disk::GenDiskRef, request::RequestDataWrapper, IdleRequest, Request},
+        mq::{gen_disk::GenDiskRef, request::RequestDataWrapper, IdleRequest, Request, TagSet},
     },
     error::{from_result, to_result, Result},
     prelude::*,
@@ -101,6 +101,11 @@ fn report_zones(
     ) -> Result<u32> {
         Err(ENOTSUPP)
     }
+
+    /// Called by the kernel to map submission queues to CPU cores.
+    fn map_queues(_tag_set: &TagSet<Self>) {
+        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
+    }
 }
 
 /// A vtable for blk-mq to interact with a block device driver.
@@ -394,6 +399,21 @@ impl<T: Operations> OperationsVTable<T> {
         })
     }
 
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `tag_set`
+    /// must be a pointer to a valid and initialized `TagSet<T>`. The pointee
+    /// must be valid for use as a reference at least the duration of this call.
+    unsafe extern "C" fn map_queues_callback(tag_set: *mut bindings::blk_mq_tag_set) {
+        // SAFETY: The safety requirements of this function satiesfies the
+        // requirements of `TagSet::from_ptr`.
+        let tag_set = unsafe { TagSet::from_ptr(tag_set) };
+        T::map_queues(tag_set);
+    }
+
     const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
         queue_rq: Some(Self::queue_rq_callback),
         queue_rqs: None,
@@ -415,7 +435,11 @@ impl<T: Operations> OperationsVTable<T> {
         exit_request: Some(Self::exit_request_callback),
         cleanup_rq: None,
         busy: None,
-        map_queues: None,
+        map_queues: if T::HAS_MAP_QUEUES {
+            Some(Self::map_queues_callback)
+        } else {
+            None
+        },
         #[cfg(CONFIG_BLK_DEBUG_FS)]
         show_rq: None,
     };
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 600c9c6249123..330ff28c91507 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -89,6 +89,19 @@ pub fn new(
     pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
         self.inner.get()
     }
+
+    /// Create a `TagSet<T>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
+    /// may be no other mutable references to the tag set. The pointee must be
+    /// live and valid at least for the duration of the returned lifetime `'a`.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::blk_mq_tag_set) -> &'a Self {
+        // SAFETY: By the safety requirements of this function, `ptr` is valid
+        // for use as a reference for the duration of `'a`.
+        unsafe { &*(ptr.cast::<Self>()) }
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


