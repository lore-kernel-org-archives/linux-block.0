Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C342DE6FF;
	Sun, 15 Feb 2026 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199151; cv=none; b=JK1YKQ9BEH//DlzVWZybODkMWpgoj7HnjbhpPfqj42thcNjT7mf/tXPAT0wF2CZy81pfozr/3wjZ+ikfIYwq7Sgogtox9Eq8BVxvuQKgDZ0Y8KwcN2bRKNisVjiKXf6A//9Cs3t1sSA+69YIOOOnGPKBZ2My35+VbntSHrNeVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199151; c=relaxed/simple;
	bh=Cd90Kd9HZBS+t07qweteZVt5e7ejNNo7uFQ2B+yelCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olLTNMdCTkEZAC92OAILo9bopcr5fDOJy5WfGqyjM8GgMJTrpNxRD98u9YbTUxYdRpys/djZA2OFKbF02J0YwqzpCVvGSCitspQZKf1FrgNVgqXVcyS+dkjZJfPoUjNEJITkVzdfWdbbCG5LCG2t7FqDGmiTQPJtYBuqDATIQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKuMyOSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKuMyOSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6295DC4CEF7;
	Sun, 15 Feb 2026 23:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199150;
	bh=Cd90Kd9HZBS+t07qweteZVt5e7ejNNo7uFQ2B+yelCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jKuMyOSFwHX0iejhTs6DSzYtDAHi0TVVWOXrm312C8vhFHJSLdQ3Qle0ezUBJQsw/
	 BSjBS9FT9sjz2iinpGKkXF+uXTaJcMDWxTE1PpXiRwy+F01l/qjyqwi8qoNi9kXhiv
	 z2af+M/GRndl5ZsexUd9sVl++PujRwZvbxYVVw44vVapdsfjxyFKx50JAVRdT/X/ih
	 ZF67rBtRb8vcjHOIa8k9Z7+IEvvKLtMWk/jUoRlMlgxs0DHOpCm2EbmQB/3oJ/Xav2
	 64j1uyqB/P/qRkcufIMYcor/n3SQyW1s/JdFk8MwOP5FaY3Nq79eBCloOG5bQ0zP1N
	 pdALkPc3DGxsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:42 +0100
Subject: [PATCH 55/79] block: rust: add request flags abstraction
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-55-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7161; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Cd90Kd9HZBS+t07qweteZVt5e7ejNNo7uFQ2B+yelCs=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhN/gQhzHqP+13Aj/SzVGlQW5wV04BcO9cf5
 o5yh0IrX8eJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYTQAKCRDhuBo+eShj
 d17mD/9bbJUdmA/hnedCkeHucvwcMhmYMNx/PApRtG54XNFS/o5+Z4hGXSUFO8b2BSrr3Av7LoK
 LrfBvkr3pORY0mA4uOssbPoIvhuyYniEuNyjdp7eaujRBCwz+4hA6a2pMu0lRxG3288s/7TnrK0
 uM2oZsPIMyw+KIHeMmArlVqsHDo/WycktYLXetrMx9B9ZOgdNmfkOj5sxH2jWzXG1/P1Blxb5DQ
 38JvKPe5DiihDyGnTVtK2GYhUuD96kum8ZU4jsS9MYZCIC3N4PhwaaBbmFV/zFiL99/xJh1lqdj
 QcHNVaiIhCoo071CMXZGCQqySMsiof0WmtZmybW+wS14ubNvIEWv6hkFep1+ji2iR6s0orB5egx
 jjYO1ZM/K5EIoiN1YPkW4AtySA+kG2GnpuoUnaamv+lLEliQiUjmvRqQzsP1C37SiPiD7gldCVO
 juSzBOu/wITj/idLDHbNv8IxdV1muTtWds7JzF4gOHBnGHm33L6rIVx/kMgPKhgzB5O8vn2cSIi
 ABvkS4pBH7SQFR5Ckkl7pescdpJ9+CAcr1Ph/O829WEFjsi2F3DVkqfJZkTBMJnAGvX1v7bT1ip
 M7ozfp78KMpSkVceNkwDEZOPxXJQLpvbKyqxtuUzxB5l17pLrV2y5dvpQtvFBGgZ1J5MgAIQP9U
 N888I4Cln+wpFxg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `Flag` enum and `Flags` type as Rust abstractions for the C
`REQ_*` request flags. These flags modify how block I/O requests are
processed, including sync behavior, priority hints, and integrity
settings.

Also add a `flags()` method to `Request` to retrieve the flags for a
given request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h      | 21 ++++++++++++
 rust/kernel/block/mq.rs              |  2 ++
 rust/kernel/block/mq/request.rs      |  9 ++++++
 rust/kernel/block/mq/request/flag.rs | 62 ++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 05133a78ecf95..b8c2f3eadc730 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -134,6 +134,27 @@ const blk_status_t RUST_CONST_HELPER_BLK_STS_OFFLINE = BLK_STS_OFFLINE;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_DURATION_LIMIT = BLK_STS_DURATION_LIMIT;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_INVAL = BLK_STS_INVAL;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ZONED = BLK_FEAT_ZONED;
+const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_DEV = REQ_FAILFAST_DEV;
+const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_TRANSPORT = REQ_FAILFAST_TRANSPORT;
+const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_DRIVER = REQ_FAILFAST_DRIVER;
+const blk_opf_t RUST_CONST_HELPER_REQ_SYNC = REQ_SYNC;
+const blk_opf_t RUST_CONST_HELPER_REQ_META = REQ_META;
+const blk_opf_t RUST_CONST_HELPER_REQ_PRIO = REQ_PRIO;
+const blk_opf_t RUST_CONST_HELPER_REQ_NOMERGE = REQ_NOMERGE;
+const blk_opf_t RUST_CONST_HELPER_REQ_IDLE = REQ_IDLE;
+const blk_opf_t RUST_CONST_HELPER_REQ_INTEGRITY = REQ_INTEGRITY;
+const blk_opf_t RUST_CONST_HELPER_REQ_FUA = REQ_FUA;
+const blk_opf_t RUST_CONST_HELPER_REQ_PREFLUSH = REQ_PREFLUSH;
+const blk_opf_t RUST_CONST_HELPER_REQ_RAHEAD = REQ_RAHEAD;
+const blk_opf_t RUST_CONST_HELPER_REQ_BACKGROUND = REQ_BACKGROUND;
+const blk_opf_t RUST_CONST_HELPER_REQ_NOWAIT = REQ_NOWAIT;
+const blk_opf_t RUST_CONST_HELPER_REQ_POLLED = REQ_POLLED;
+const blk_opf_t RUST_CONST_HELPER_REQ_ALLOC_CACHE = REQ_ALLOC_CACHE;
+const blk_opf_t RUST_CONST_HELPER_REQ_SWAP = REQ_SWAP;
+const blk_opf_t RUST_CONST_HELPER_REQ_DRV = REQ_DRV;
+const blk_opf_t RUST_CONST_HELPER_REQ_FS_PRIVATE = REQ_FS_PRIVATE;
+const blk_opf_t RUST_CONST_HELPER_REQ_ATOMIC = REQ_ATOMIC;
+const blk_opf_t RUST_CONST_HELPER_REQ_NOUNMAP = REQ_NOUNMAP;
 const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
 
 const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1d58eea971bd7..5a1c8e914bb9e 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -134,6 +134,8 @@
 pub use operations::IoCompletionBatch;
 pub use operations::Operations;
 pub use request::Command;
+pub use request::Flag as RequestFlag;
+pub use request::Flags as RequestFlags;
 pub use request::IdleRequest;
 pub use request::Request;
 pub use request::RequestTimerHandle;
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index b4f5a98a97b16..cebb30fe9b3bc 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -27,6 +27,9 @@
 mod command;
 pub use command::Command;
 
+mod flag;
+pub use flag::{Flag, Flags};
+
 /// A [`Request`] that a driver has not yet begun to process.
 ///
 /// A driver can convert an `IdleRequest` to a [`Request`] by calling [`IdleRequest::start`].
@@ -104,6 +107,12 @@ pub fn command(&self) -> Command {
         unsafe { Command::from_raw(self.command_raw()) }
     }
 
+    pub fn flags(&self) -> Flags {
+        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
+        let flags = unsafe { (*self.0.get()).cmd_flags & !((1 << bindings::REQ_OP_BITS) - 1) };
+        Flags::try_from(flags).expect("Request should have valid falgs")
+    }
+
     /// Get the target sector for the request.
     #[inline(always)]
     pub fn sector(&self) -> u64 {
diff --git a/rust/kernel/block/mq/request/flag.rs b/rust/kernel/block/mq/request/flag.rs
new file mode 100644
index 0000000000000..47d25224a1ab4
--- /dev/null
+++ b/rust/kernel/block/mq/request/flag.rs
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+use kernel::prelude::*;
+
+impl_flags! {
+    /// A set of request flags.
+    ///
+    /// This type wraps the C `REQ_*` flags and allows combining multiple flags
+    /// together. These flags modify how a block I/O request is processed.
+    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
+    pub struct Flags(u32);
+
+    /// Individual request flags for block I/O operations.
+    ///
+    /// These flags correspond to the C `REQ_*` defines in `linux/blk_types.h`
+    /// and are used to modify the behavior of block I/O requests.
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub enum Flag {
+        /// No driver retries on device errors.
+        FailfastDev = bindings::REQ_FAILFAST_DEV,
+        /// No driver retries on transport errors.
+        FailfastTransport = bindings::REQ_FAILFAST_TRANSPORT,
+        /// No driver retries on driver errors.
+        FailfastDriver = bindings::REQ_FAILFAST_DRIVER,
+        /// Request is synchronous (sync write or read).
+        Sync = bindings::REQ_SYNC,
+        /// Metadata I/O request.
+        Meta = bindings::REQ_META,
+        /// Boost priority in CFQ scheduler.
+        Priority = bindings::REQ_PRIO,
+        /// Don't merge this request with others.
+        NoMerge = bindings::REQ_NOMERGE,
+        /// Anticipate more I/O after this one.
+        Idle = bindings::REQ_IDLE,
+        /// I/O includes block integrity payload.
+        Integrity = bindings::REQ_INTEGRITY,
+        /// Forced unit access - data must be written to persistent storage
+        /// before command completion is signaled.
+        ForcedUnitAccess = bindings::REQ_FUA,
+        /// Request a cache flush before this operation.
+        Preflush = bindings::REQ_PREFLUSH,
+        /// Read ahead request, can fail anytime.
+        ReadAhead = bindings::REQ_RAHEAD,
+        /// Background I/O operation.
+        Background = bindings::REQ_BACKGROUND,
+        /// Don't wait if the request would block.
+        NoWait = bindings::REQ_NOWAIT,
+        /// Caller polls for completion using `bio_poll`.
+        Polled = bindings::REQ_POLLED,
+        /// Allocate I/O from cache if available.
+        AllocCache = bindings::REQ_ALLOC_CACHE,
+        /// Swap I/O operation.
+        Swap = bindings::REQ_SWAP,
+        /// Reserved for driver use.
+        Driver = bindings::REQ_DRV,
+        /// Reserved for file system (submitter) use.
+        FsPrivate = bindings::REQ_FS_PRIVATE,
+        /// Atomic write operation.
+        Atomic = bindings::REQ_ATOMIC,
+        /// Do not free blocks when zeroing (for write zeroes operations).
+        NoUnmap = bindings::REQ_NOUNMAP,
+    }
+}

-- 
2.51.2


