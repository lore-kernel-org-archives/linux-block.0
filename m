Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A264C9004;
	Tue,  9 Jun 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032247; cv=none; b=eKOcBgpMP7CuqDu75PKRcCKbLf+VUkRJiQCnzQ39jeqAW3D56/sD1JjIdjcxTI2Husx8MMQ8QKAOlOm1GV9r8gdI34EtiHZwJh705BD2T6th6CkfI80N1gLk7SKUJ4uSkKEhYF8hsXoDcQ6bvUkzWnAYTWDmyX6b2ugmJfgFm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032247; c=relaxed/simple;
	bh=bVLUGu7Yg0gIIoubIKQz4YBEP/nNvOd82422m1mRrnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvAgYVYGc0wA9VHrfbkHcffV6oebrPI6it+0aze90i0l9o2y4pKRLUi8Ze2EtC3gXvSpuDaxxBiC2nKRqp7VotGWJLodqR9gdc2X1PnVURLdlqTtxpcPAeTi0vYF5LHcOL/5dokHcZi49eoraVe+xeGDdpBCdJqRXyVY70RHVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz4cqmJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz4cqmJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7DC1F00893;
	Tue,  9 Jun 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032245;
	bh=ViEAmKmawxcF7N2WCFkvitTjmdUVh88IGEYKrsZa4rs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dz4cqmJlGK6zP1GJh8CiPq58n1tvdzDUWuVqpvqJF83oQPnB2lhpcMK1Re1PTMp8n
	 W+Tfe9M9q/+WpSZE0J8Zsw1M4i+EXly/2tqH4GDRNUz30ZxVUImUfW9qiTCD4F66tp
	 VHldJTtRunXv1ARJB8J8gXzUQy3k9u9Rx5CucVgt1SFADAh+8w3WIxebdYeGLLtdAW
	 W7Ta8dhN1wz1x2ZIexM54QH9ifybplFHKE49uDjQ+q9EoBv+vK2xXmUsN07JCGcL5x
	 NzH7/G/zrmcJPXemmxdQSdviLFCysSDnKAUvwi8Ol/fllT+LHQ5Qv9omDYKQVFrJq3
	 RSU0pk3Bt/xrw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:59 +0200
Subject: [PATCH v2 20/83] block: rnull: allow specifying the home numa node
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-20-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4728; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=bVLUGu7Yg0gIIoubIKQz4YBEP/nNvOd82422m1mRrnQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTGbf6fmgZgdL2qiDikI8Dlf9jeRNjBJ2UPJ
 UzTC72Je16JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkxgAKCRD6UCkIqsW9
 0J1rD/9EI6gaU8QWYs3K+I+msNoR8AihBwE6+XAin0W8lX+Fh2dpKy2KgPS0aDv3XhPrVQVApMc
 CeW3HxCugLxc42a0yRckCX8VLxWGm873dyJdDq/N06Vy0wQf65U22ubt9BKzjMPs6bjHguDd8mK
 IJAVG3SlTVU/RnsCOnJitaVqi3BIc07MzbXdbX956GIIdaAsD0/KjUqTGWIoU9VXJFUWavG+uG1
 fkfGJGCPH54b0WBCgOvrV1lzVfERmYGQ7I//4z0ZUBp17Iq0SgXwSpqLAm7iI91F2kx63LT6X7O
 51Mr2gtaIcmO433FOh082r47ymS63Xwh802eJimAyOL2pwbZHA11DTjSq587JCN4DTHkUU1AwZM
 DLpL5Yrr6BQz7JkRAKdqpmLxip4JGZczzaCc7W/lV6/e5aTl+KsWdPKR3tRmryh7Ify+/lo2pK0
 /hd1dUgVc7GzOehIvxoMETyGagOW2cpc1bkID57Rk5XFpeZSi2L/aM/z8WzWreDE3H3G44vTQpi
 uFStrF7v5ihgAR2f+DHyTP7DgFBuCqKl9Aa+pAj+HUjFFEOaA0PwY+oNxWt3ABrfLmCOW8MCq/P
 Y5Rx3N+9hGz8fsnacW0kRXPdvnlqrZ00rz8LAZtPwaJTpn3F6xc1Itomhod5p307PhVOPXPUR21
 OmL/ScaWsC86CUg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to specify the NUMA node for rnull tag set
and CPU map allocations. This allows testing NUMA-aware block device
behavior and optimizing memory placement for specific hardware
configurations.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 19 +++++++++++++++++++
 drivers/block/rnull/rnull.rs    | 30 ++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 71b38373be33..2f3fa81ea121 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -5,6 +5,7 @@
     THIS_MODULE, //
 };
 use kernel::{
+    bindings,
     block::mq::gen_disk::{
         GenDisk,
         GenDiskBuilder, //
@@ -91,6 +92,7 @@ fn make_group(
                 memory_backed: 6,
                 submit_queues: 7,
                 use_per_node_hctx: 8,
+                home_node: 9,
             ],
         };
 
@@ -110,6 +112,7 @@ fn make_group(
                     name: name.try_into()?,
                     memory_backed: false,
                     submit_queues: 1,
+                    home_node: bindings::NUMA_NO_NODE,
                 }),
             }),
             core::iter::empty(),
@@ -176,6 +179,7 @@ struct DeviceConfigInner {
     disk: Option<GenDisk<NullBlkDevice>>,
     memory_backed: bool,
     submit_queues: u32,
+    home_node: i32,
 }
 
 #[vtable]
@@ -208,6 +212,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 completion_time: guard.completion_time,
                 memory_backed: guard.memory_backed,
                 submit_queues: guard.submit_queues,
+                home_node: guard.home_node,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -288,3 +293,17 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     })
 );
+
+configfs_simple_field!(
+    DeviceConfig,
+    9,
+    home_node,
+    i32,
+    check(|value| {
+        if value == 0 || value >= kernel::numa::num_online_nodes().try_into()? {
+            Err(kernel::error::code::EINVAL)
+        } else {
+            Ok(())
+        }
+    })
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6323327d4a5a..1d0faf524f5c 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -20,7 +20,10 @@
             TagSet, //
         },
     },
-    error::Result,
+    error::{
+        code,
+        Result, //
+    },
     memalloc_scope,
     new_mutex,
     new_xarray,
@@ -93,6 +96,10 @@
             default: false,
             description: "Use per-node allocation for hardware context queues.",
         },
+        home_node: i32 {
+            default: -1,
+            description: "Home node for the device. Default: -1 (no node)",
+        },
     },
 }
 
@@ -129,6 +136,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     completion_time: Delta::from_nanos(completion_time),
                     memory_backed: module_parameters::memory_backed.value(),
                     submit_queues,
+                    home_node: module_parameters::home_node.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -152,6 +160,7 @@ struct NullBlkOptions<'a> {
     completion_time: Delta,
     memory_backed: bool,
     submit_queues: u32,
+    home_node: i32,
 }
 struct NullBlkDevice;
 
@@ -166,6 +175,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             completion_time,
             memory_backed,
             submit_queues,
+            home_node,
         } = options;
 
         let flags = if memory_backed {
@@ -174,14 +184,18 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             mq::tag_set::Flags::default()
         };
 
+        if home_node > kernel::numa::num_online_nodes().try_into()? {
+            return Err(code::EINVAL);
+        }
+
+        let numa_node = if home_node == -1 {
+            kernel::alloc::NumaNode::NO_NODE
+        } else {
+            kernel::alloc::NumaNode::new(home_node)?
+        };
+
         let tagset = Arc::pin_init(
-            TagSet::new(
-                submit_queues,
-                256,
-                1,
-                kernel::alloc::NumaNode::NO_NODE,
-                flags,
-            ),
+            TagSet::new(submit_queues, 256, 1, numa_node, flags),
             GFP_KERNEL,
         )?;
 

-- 
2.51.2


