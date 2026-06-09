Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE224EA39C;
	Tue,  9 Jun 2026 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032500; cv=none; b=hMnM5jjewhbowQIt2ieieJ7wo83Jn3YVUVpdsqi2OoQlSNjmLtubaGV2Jfvpx4+GorynExwO/rCsisMdxNfJMQcDdL+csu1Q4JJkXFkdp+dmqkjbTVFnODA6WS0YcnFKC5LMUVFGmQW0InBzt2OOu2LX143vnfuFqlfRtAWz+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032500; c=relaxed/simple;
	bh=mKAY/8gcmYnV4CeK9ErSKMBIuQ/5EOAccvACmxqa5ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGJDnlXZVPsKYx2b8F60UuWQr4b9Pf5WUe+gQS9oRwSGwrvog6ssX1Du4aCb4YshVTLNAbDGxJY/NOZwXHZJqxQVIj2MGIIgv6ESemw3fFlGYoYS383p1UH+nCu41t8yeI0Y6Iruzj/bLKAR9U41uRW2Gi0LtTBFcXUwGKtvZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHAC1mMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHAC1mMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366131F00898;
	Tue,  9 Jun 2026 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032499;
	bh=mrJG8KiUxKUHfvXwMNkNGZhqS4gsQJoMju1kYZYGQYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HHAC1mMSrZnRSEnk724VpwowU20c+RummkN3EX1Wk7AmLhuBnHQwz4ky+nR7DScgd
	 sUIpXnqZuhzZmyH4K56+t0kuwhbQpfND8xQDxHmMrOu9OYvXCsZat41IvOYIVn90st
	 mPoG82a+TP6gJ8uXM8wtqwfwJFnllYZRYBsmhEssGX1sVIEesB9M2rpsakkaz/jm9V
	 lZDBM8NHls/nCoAJWk6Yrw0OSbFxsaAoNRgNyHy+3P3MBKBcZ2Driuiky8/i/IfnjV
	 kDV86hLZ+dBFl7ijvCoZP3X2BIEbsFWmvPdYAmx3/glcjO8IxuLGNHO0FZtxGMVjaz
	 DrbPd4rWTf6ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:01 +0200
Subject: [PATCH v2 22/83] block: rust: mq: add max_hw_discard_sectors
 support to GenDiskBuilder
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-22-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=mKAY/8gcmYnV4CeK9ErSKMBIuQ/5EOAccvACmxqa5ao=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTIgHAgY6l2Ttz2UGa4fGnWqQhoUxmiEEF/z
 54xXUGsE+mJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkyAAKCRD6UCkIqsW9
 0Bj5D/96wH2IqvfrEeXl1taIlDXI8bvB6U+cgPclaot3GKF7pKW5w0nNNbMXmAuzSnikbTtXAwN
 3FZjaf2kUe4pntQwnEQqVRw2Yg199oPewGn4uyUpmTRdT13CQ2+SzkBRevnwKW7cywDI0oIgOHW
 qRkdpzkSUK8nzHXsXCqA9EOdzKCmCuiFwQZQ9lKF/eXMVpQXdvuOWSRRNHV2xtFk1n1ALFsxAdw
 spdqpARcO9SjoZrIM9I4wi3VWfSjgPP2/6QLumakyvOtXTNASaDUY71bxSHA/tkuDUR4jhLwV18
 tAEBl/iwJQxOlAQRcyU0rd1mToig1Y+SLoeq+8LXTW+IWTbj3zxWj6hJB6FRN324/4scjob/j94
 8g7pLaVTjlxeiLl51KFrNwnmxrqB/p/IUA9RTxUXbkbjsCzE8ppjX9zY8yJCs8/PxCdpXE389sI
 LRUKc/I34zz0ttv7WAyjTau8f++O5Elj/wfnJn0fx/8c4QBpBXk/8az74W1QDwrIqVTg/D+plXo
 u13K7NvAzzAQw1Hvgqv8Do5vbuG/Q9ijMn8qCuYLn1vDgCeSrTxGwT33vmKUegXVVojj0coZank
 s/R5IjGAl2SvsSdbu0Lk+8xboJZvOi/Cl5KSCtyBBYlZYnd7OZA6tfT1KlzDxT2VksKI/y2Mq4q
 WXaE27QIK7CyMYA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for configuring the maximum hardware discard sectors
through GenDiskBuilder. This allows block devices to specify their
discard/trim capabilities.

Setting this value to 0 (the default) indicates that discard is not
supported by the device. Non-zero values specify the maximum number
of sectors that can be discarded in a single operation.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index b36d24382cc3..2b204b0ed49a 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,14 +7,27 @@
 
 use crate::{
     bindings,
-    block::mq::{Operations, TagSet},
-    error::{self, from_err_ptr, Result},
-    fmt::{self, Write},
+    block::mq::{
+        Operations,
+        TagSet, //
+    },
+    error::{
+        self,
+        from_err_ptr,
+        Result, //
+    },
+    fmt::{
+        self,
+        Write, //
+    },
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
-    types::{ForeignOwnable, ScopeGuard},
+    types::{
+        ForeignOwnable,
+        ScopeGuard, //
+    },
 };
 
 /// A builder for [`GenDisk`].
@@ -25,6 +38,7 @@ pub struct GenDiskBuilder {
     logical_block_size: u32,
     physical_block_size: u32,
     capacity_sectors: u64,
+    max_hw_discard_sectors: u32,
 }
 
 impl Default for GenDiskBuilder {
@@ -34,6 +48,7 @@ fn default() -> Self {
             logical_block_size: bindings::PAGE_SIZE as u32,
             physical_block_size: bindings::PAGE_SIZE as u32,
             capacity_sectors: 0,
+            max_hw_discard_sectors: 0,
         }
     }
 }
@@ -94,6 +109,16 @@ pub fn capacity_sectors(mut self, capacity: u64) -> Self {
         self
     }
 
+    /// Set the maximum amount of sectors the underlying hardware device can
+    /// discard/trim in a single operation.
+    ///
+    /// Setting 0 (default) here will cause the disk to report discard not
+    /// supported.
+    pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
+        self.max_hw_discard_sectors = max_hw_discard_sectors;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build<T: Operations>(
         self,
@@ -111,6 +136,7 @@ pub fn build<T: Operations>(
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
+        lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         if self.rotational {
             lim.features = bindings::BLK_FEAT_ROTATIONAL;
         }

-- 
2.51.2


