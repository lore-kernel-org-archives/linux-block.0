Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1272D837C;
	Sun, 15 Feb 2026 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199216; cv=none; b=ggrZQiZDobe4o2jppYygHXod7EzaqXdpwfKcxFDD3H172XkWwQQtdL+o42+VwuUkN+mtckxv57aoiGC53sXvD+FpGoLp34HczzWJHLIBVEdm7NOhVTBUFGkjzI9g1j1my6PxbYVwXEALd6eolegZnAFg0B1AsJnfVQh5NtEEOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199216; c=relaxed/simple;
	bh=pHTvVkZRFYcjiaGREx9N7FRfc2mqdwNLh9peaN0Ub0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0qZ4FwE+ouVN05XTjca3j25MnGd72vZLC7XGrGJ7gt3jl/I5NVCVeEtUGZrYBz/ObraBPcwfMC/aQwwKEPd7jPlmaB68gglx0stCyz9ceBy9Pn0F+6EUWnaWvB1rc8doHy4QseudbmHzbObgsoUrnCl4wQR756VkiATwT4/3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmQjiPkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmQjiPkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFFC4CEF7;
	Sun, 15 Feb 2026 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199215;
	bh=pHTvVkZRFYcjiaGREx9N7FRfc2mqdwNLh9peaN0Ub0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BmQjiPkMGbCMCCRWpIRKmUkMrdGCR9uHTSwgOcA660yGX9ktAN30df2PCPV3s1HZk
	 6CEfKyzgEVdxnIQWZU2sAQGCS/S5FdfVQVx0cD/mKtl8lag7yrZ8mIUEs/tcjl+jas
	 tssEjIRSACRWsCVEMNjHKPKw1d/9YnUX5GO5JjL7vJn6UA0FNu/5BO4te+G6TLLUiQ
	 HzbZ8HZG8ZWn206d5cPypIxHAoQtaq4lhGaTNVkvT1CLAR88iFZsgYvzaUWz3IW4DZ
	 ukKxIk36VgGppMIBD5qzeXu/6eheDOcZsDLM1PwpEyM2bT1EGdmd7VcKD5s0+Beoq5
	 Pyi7Orb/Ucqhw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:31 +0100
Subject: [PATCH 44/79] block: rust: add an abstraction for
 `bindings::req_op`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-44-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6414; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pHTvVkZRFYcjiaGREx9N7FRfc2mqdwNLh9peaN0Ub0Y=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhDEeCdW/yi4dywjzU/1Nk+MWm9S2xIIH2Cn
 V0G9M1w7xSJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYQwAKCRDhuBo+eShj
 d/D6D/44ecuU5yS9H5GCaAuZSVh+YOzWJCcgz/rVCkktg1rouPSSpD6CxPVUon461IFCjG00DLA
 G0FKsh7baTRApFzDessKhoxB+9+5mm5uoe3KDBZka+ZtKw6XmL13kwSE6QDe4izJo2fXWh8ZECc
 T88vr0uJG817P2hEkIKdE7sfywllU2Boyaxc256EgmJko0htOudxKOPi0nX2tGTWC2quFmMbBnj
 5ZR4gxFx4OewOOIf2Iyt1vcRNuDuTTJRa38dGXbjwgF/KTExWRKIikmoN/0HKJgOYgsHtGvyCLS
 NrEInkyirWFL29VlZeTQAEcIuc5yYEBJwCaXeckvuyEk7pivpurH2atUKKpy1Qn/QshXpDuIBFA
 5cNc6Vu2ZlFJrGZBXaOjXwcN8Ra7nLJ6wgs82RQJ3RQP+CjK7FjLMFXceHE4cgluDKQtECeD3pl
 raa/er7bmW6GL7Q5ZQurcZJ6sptVEQC4uq/pWVwnC/IwZfCLGTQjFmhyYBLaxNqrNUx3u40ll9v
 /8ylEGx1cgYdBcnRaZSV90oIGgrAB8nipQus1bMtJV2hsXIg9jnAEa9dTHZTXuqbK2Aqw/2SmS9
 cXooL5FmaBASTDq6ifdv1QwvzLB+mS6rmIPRbTiD7s0baqG2g9Xpk8t7etiq84wChnJIRI1LA76
 32fIHtKfsDlyO5g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `Command` enum as a Rust abstraction for block request operation
codes. The enum variants correspond to the C `REQ_OP_*` defines and
include read, write, flush, discard, and zone management operations.

Also add a `command()` method to `Request` to retrieve the operation
code.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs            |  6 +--
 rust/kernel/block/mq.rs                 |  1 +
 rust/kernel/block/mq/request.rs         | 11 +++++-
 rust/kernel/block/mq/request/command.rs | 65 +++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 3fb19836ce6ff..9383b82f9a736 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -508,10 +508,10 @@ fn transfer(
                     .len()
                     .min((end_sector - sector) as u32 >> SECTOR_SHIFT);
                 match command {
-                    bindings::req_op_REQ_OP_WRITE => {
+                    mq::Command::Write => {
                         self.write(&mut tree_guard, &mut hw_data_guard, sector, segment)?
                     }
-                    bindings::req_op_REQ_OP_READ => {
+                    mq::Command::Read => {
                         self.read(&mut tree_guard, &mut hw_data_guard, sector, segment)?
                     }
                     _ => (),
@@ -703,7 +703,7 @@ fn queue_rq(
         Self::handle_bad_blocks(this.deref(), &mut rq, &mut sectors)?;
 
         if this.memory_backed {
-            if rq.command() == bindings::req_op_REQ_OP_DISCARD {
+            if rq.command() == mq::Command::Discard {
                 this.discard(&hw_data, rq.sector(), sectors)?;
             } else {
                 this.transfer(&hw_data, &mut rq, sectors)?;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 02738f52389ba..057a5f366be3a 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -131,6 +131,7 @@
 pub mod tag_set;
 
 pub use operations::Operations;
+pub use request::Command;
 pub use request::IdleRequest;
 pub use request::Request;
 pub use request::RequestTimerHandle;
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index d6f3ffde1c5c4..4e47419776e0f 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -23,6 +23,9 @@
 use crate::block::bio::Bio;
 use crate::block::bio::BioIterator;
 
+mod command;
+pub use command::Command;
+
 /// A [`Request`] that a driver has not yet begun to process.
 ///
 /// A driver can convert an `IdleRequest` to a [`Request`] by calling [`IdleRequest::start`].
@@ -89,11 +92,17 @@ fn deref(&self) -> &Self::Target {
 
 impl<T: Operations> RequestInner<T> {
     /// Get the command identifier for the request
-    pub fn command(&self) -> u32 {
+    fn command_raw(&self) -> u32 {
         // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
         unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
     }
 
+    /// Get the command of this request.
+    pub fn command(&self) -> Command {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { Command::from_raw(self.command_raw()) }
+    }
+
     /// Get the target sector for the request.
     #[inline(always)]
     pub fn sector(&self) -> u64 {
diff --git a/rust/kernel/block/mq/request/command.rs b/rust/kernel/block/mq/request/command.rs
new file mode 100644
index 0000000000000..70a8d67fa35c0
--- /dev/null
+++ b/rust/kernel/block/mq/request/command.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/// Block I/O operation codes.
+///
+/// This is the Rust abstraction for the C [`enum req_op`].
+///
+/// Operations common to the bio and request structures. The kernel uses 8 bits
+/// for encoding the operation, and the remaining 24 bits for flags.
+///
+/// The least significant bit of the operation number indicates the data
+/// transfer direction:
+///
+/// - If the least significant bit is set, transfers are TO the device.
+/// - If the least significant bit is not set, transfers are FROM the device.
+///
+/// If an operation does not transfer data, the least significant bit has no
+/// meaning.
+///
+/// [`enum req_op`]: srctree/include/linux/blk_types.h
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+pub enum Command {
+    /// Read sectors from the device.
+    Read = bindings::req_op_REQ_OP_READ,
+    /// Write sectors to the device.
+    Write = bindings::req_op_REQ_OP_WRITE,
+    /// Flush the volatile write cache.
+    Flush = bindings::req_op_REQ_OP_FLUSH,
+    /// Discard sectors.
+    Discard = bindings::req_op_REQ_OP_DISCARD,
+    /// Securely erase sectors.
+    SecureErase = bindings::req_op_REQ_OP_SECURE_ERASE,
+    /// Write data at the current zone write pointer.
+    ZoneAppend = bindings::req_op_REQ_OP_ZONE_APPEND,
+    /// Write zeroes. This allows to implement zeroing for devices that don't use either discard
+    /// with a predictable zero pattern or WRITE SAME of zeroes.
+    WriteZeroes = bindings::req_op_REQ_OP_WRITE_ZEROES,
+    /// Open a zone.
+    ZoneOpen = bindings::req_op_REQ_OP_ZONE_OPEN,
+    /// Close a zone.
+    ZoneClose = bindings::req_op_REQ_OP_ZONE_CLOSE,
+    /// Transition a zone to full.
+    ZoneFinish = bindings::req_op_REQ_OP_ZONE_FINISH,
+    /// Reset a zone write pointer.
+    ZoneReset = bindings::req_op_REQ_OP_ZONE_RESET,
+    /// Reset all the zones present on the device.
+    ZoneResetAll = bindings::req_op_REQ_OP_ZONE_RESET_ALL,
+    /// Driver private request for data transfer to the driver.
+    DriverIn = bindings::req_op_REQ_OP_DRV_IN,
+    /// Driver private request for data transfer from the driver.
+    DriverOut = bindings::req_op_REQ_OP_DRV_OUT,
+}
+
+impl Command {
+    /// Creates a [`Command`] from a raw `u32` value.
+    ///
+    /// # Safety
+    ///
+    /// The value must be a valid `req_op` operation code.
+    pub unsafe fn from_raw(value: u32) -> Self {
+        // SAFETY: The caller guarantees that the value is a valid operation
+        // code.
+        unsafe { core::mem::transmute(value) }
+    }
+}

-- 
2.51.2


