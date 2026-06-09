Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986741D9E8;
	Tue,  9 Jun 2026 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032654; cv=none; b=W4HdcNlGPt4dPMMrSbFl6cuVEh64xjpQgL1cp8R7k16zBZcO9FgjmfnoYr6cSoG2Zy3z1kd3cLxytuCZRkEzuOE4MobjX4mG8nb8lzegV0+bt+o9pLX8CQThxh3XcsxbpG8TXAGuobui5DJCqnpwpfjz9U9nS7uF2n35QATAXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032654; c=relaxed/simple;
	bh=mQLcR4pADqmwISKMJS96CwmsvxCUmL6qoCmsZgQdi8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3lqT+CWNosHFTMKor0saTQ9Eq+rKpBpTAyD/GTbnZnwgWrHNpuBzWAbymeFq5raurOUYgV4mIWTAljs62RfMVB5ppIv09JQjaLovFfzutnaFKHzMXlnGFtO7UPdWaJ+sjCwNBAa9b1ZpE5PvNPc6XEEFqPmmhFqM4y9nj0/1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LruU/bVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LruU/bVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F381F00893;
	Tue,  9 Jun 2026 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032653;
	bh=p4d5I6NPrj9QC3rwhT3LQJHa+sFgEUUsxiN1Rw94+DE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LruU/bVU77MdbFwvtz6tVmVrLebbYltpAyDnwaI/L/LiUSYzHPzOHjRpQGG1B0B8k
	 nn5Jmd8IxW3BhKtJQUSXx/YNYEZVj6eYpbutYbHnFIoEImSTZejbs2amCQM0+nlr71
	 L1MxooAh3o3g/sGwX4ONYXHiqpysjm4P2HZ7o/tt3CpyHSTQ3rtzCNmHxMVoQsrAls
	 3zgdYKdnNLIbrSlrsqieFvEbnj81xd3gOtI0GLc0GV92gyVjECNoQBQeWGNCA8kMCI
	 0LsjhRO3fgTgr/xfHgcQ4fASYVAOdRJ8zEtVO/PvfoYfqjXeIJ16HgtURboUMq2lGZ
	 ZfHKDcLs8VkIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:09:00 +0200
Subject: [PATCH v2 81/83] block: rnull: add `virt_boundary` option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-81-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4411; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=mQLcR4pADqmwISKMJS96CwmsvxCUmL6qoCmsZgQdi8k=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT9ToLPR7x5aepZTCfCm4HkjbgUTRQRr8bi+
 tSPr1Q92iOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk/QAKCRD6UCkIqsW9
 0Aj8EAC2EoIkwX9KZomazlQrN/N8C7wXO55qgCiGfevd0Arj+x9lodAq2aTUUrDM01s/qoJZ2q1
 LvRpFf+WmwsdVW7UFlwZgCfaiUBQdMT94rxnN0WMm8GVVE9DMC3ma4u/SVC8GLNgpzSU9UQ2gcw
 aZHwZTzw5/e80I9Qvin84j+ml5alD3PfvBvSkknSX3jgwp5XRcCva7H7XFUs68rvu+yV4p/cc6b
 Hg8LxEPI+7/ZdrOBLtEJ9pn5HhJqp6wZ5T5eMvnurirWHXzwBm4tEtsQNUsN1kUIM236MIR4rcf
 HeJ1LqEecW1kzwAUFEcz3z230Vuud6OmaaU6fkwqbDg3TkrPPfHbsO2gm92OzbvMv1l5u5V8PRt
 gMtAfjC+RS4XtVmilxUn6adKKG88lqpHr9K5pvPpBAPQkUAZnumxDvtiW1+KBeVP/Tx64vBGa/j
 sacJzs2KDVCTn/7sXKDoFunqaH0m34aby1033yoKawIwnK33+FGLHeFSU7UG78KubP2CyDWEu60
 E/gt2qz4kn34tHBwPT6rVfUDomeePgXkKN9mqA62vZn5lmRHagfDZdnZxJHxd/CjXtl4q28PilY
 kfMdnyG5t5tf1lnoCf4rEq/0osNjf1KQBD9CXKMHFEJvIjbMq9Dda/UhHEg+rYAZZHW8R/uPmMu
 6v6OG2Elg7F5Y4g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to configure the virtual memory boundary mask
for the rnull block device. This allows testing how drivers and
filesystems handle devices with specific alignment requirements.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  5 +++++
 drivers/block/rnull/rnull.rs    | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 5ab217e43e2b..3e054339226c 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -133,6 +133,7 @@ fn make_group(
                 poll_queues: 27,
                 fua: 28,
                 max_sectors: 29,
+                virt_boundary: 30,
             ],
         };
 
@@ -221,6 +222,7 @@ fn make_group(
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     init_hctx_inject,
                     max_sectors: 0,
+                    virt_boundary: false,
                 }),
             }),
             default_groups,
@@ -315,6 +317,7 @@ struct DeviceConfigInner {
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     init_hctx_inject: Arc<FaultConfig>,
     max_sectors: u32,
+    virt_boundary: bool,
 }
 
 #[vtable]
@@ -388,6 +391,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                 timeout_inject: guard.timeout_inject.clone(),
                 max_sectors: guard.max_sectors,
+                virt_boundary: guard.virt_boundary,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -617,3 +621,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 }
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
 configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
+configfs_simple_bool_field!(DeviceConfig, 30, virt_boundary);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 15b8c365b9fa..147dc8498c3a 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -28,7 +28,10 @@
             BadBlocks, //
         },
         bio::Segment,
-        error::{BlkError, BlkResult},
+        error::{
+            BlkError,
+            BlkResult, //
+        },
         mq::{
             self,
             gen_disk::{
@@ -54,6 +57,7 @@
     memalloc_scope,
     new_mutex,
     new_spinlock,
+    page::PAGE_SIZE,
     pr_info,
     prelude::*,
     revocable::Revocable,
@@ -208,6 +212,10 @@
             default: 0,
             description: "Maximum size of a command (in 512B sectors)",
         },
+        virt_boundary: bool {
+            default: false,
+            description: "Set alignment requirement for IO buffers to be page size.",
+        },
     },
 }
 
@@ -312,6 +320,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
                     max_sectors: module_parameters::max_sectors.value(),
+                    virt_boundary: module_parameters::virt_boundary.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -358,6 +367,7 @@ struct NullBlkOptions<'a> {
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     timeout_inject: Arc<FaultConfig>,
     max_sectors: u32,
+    virt_boundary: bool,
 }
 
 #[pin_data]
@@ -494,6 +504,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
             timeout_inject,
             max_sectors,
+            virt_boundary,
         } = options;
 
         let memory_backed = tag_set.memory_backed;
@@ -558,6 +569,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             .forced_unit_access(forced_unit_access && storage.cache_enabled())
             .max_sectors(max_sectors);
 
+        if virt_boundary {
+            builder = builder.virt_boundary_mask(PAGE_SIZE - 1);
+        }
+
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         {
             builder = builder

-- 
2.51.2


