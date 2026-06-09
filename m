Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57B4EA37F;
	Tue,  9 Jun 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032386; cv=none; b=iD01UGiYjlGamaIIQFVV93EE9tS4WR/008Gk2QDEgAEFaXu5eIfWR1dFy5tvHWVUk18nqePQkpO0K9AMSLLVcw50+XXX55sYujHFSKiEtO1y4eWpUuTCfnJv58LvdXd5HSo3/oYIyAv7ZgccU6C59KZy4IQ8eTfare+Byc6mOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032386; c=relaxed/simple;
	bh=OyYo3h9FH7tddSUSU2yGqcG1rcOMZa8+hV0gLvVXT30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djSVfR2YmnToY8L5g2oFUucOu/aT/ToAO9PNv9fpOjB5EdhhiBqfBZlg8PAeOAYX9DflXaXfioRCUEU4r5BcQZ1e2RIvK8YYhHEec+PeM1TXjFNNQ7bt4jIDArMzrLFwerAqffjNpSWKtbfs5yG0HJlWwt4OfdoyROo+dWlqsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFpYDTDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFpYDTDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1051F00898;
	Tue,  9 Jun 2026 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032384;
	bh=JnD8AYBlSFJHV8ifo4XwIzlj5eOON9Q0z1EH0iWmsCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TFpYDTDBuIAzpa+0TjHG5dMSItuqqqLZhFGeQ34qoDBgGbY2MoHw2glhTaoX81oCm
	 9z0VXjifWppnmUn0b/0WnuVlIJ/msxO6TdXR2BXu0PffY8j17xDH0BLMyNEONtfaa5
	 0b0MveTNIZzwhgPjhPSz024RZcIvQd7gj+d/h3U7rX+T2oT+TRUe6R9PPvaDucAlo3
	 dhgUYoDWmMPr6lEelcLBQi9AtCdCLExLm7X/WjKemb0TbVpLy6lOWzE9nDibDxjxrJ
	 rKsjZGaDcoo4HrDKmvyXeaniKekTP9LHlqPsMQ7A5+RAgenOJURmR0Y/El9KRA68M3
	 nSA6T58L5V6UA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:25 +0200
Subject: [PATCH v2 46/83] block: rnull: add shared tags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-46-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13841;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=OyYo3h9FH7tddSUSU2yGqcG1rcOMZa8+hV0gLvVXT30=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTeznS9taKg4dSs5gVp6USJA2+jTJFwZidH4
 aBNBag7rUaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk3gAKCRD6UCkIqsW9
 0HtxEACstjqG92HymGqbWHGNy9sEvKNUzNlbVl7NQKWv5rxeAIN2/U3xOvzo9HHjRbXBbQrz3Hq
 /ygvkPv1e/v6mOOFMSHLLL3rwlfgGXZ1JSZykGsCYNc+ggl6+cGbuOetVXEt4E0LHzqNLBi1/IY
 4E3qoazdTGvD7Ms4eycgZ/Q9WpPM1SzmnGZz6iucfO0/zumZhVEWty6ofpwVDXWA2pMjJNFymCx
 lVC7/sgmJfQzvMMLAskuJwCBQ57FncfWBQKlyUT8TWJdmtQCVjyNFRH0D/pafBn7M0nYTwi217H
 z45FxqGkhzSe0AOZJgfmWf4yE3DgJ95LqlxaG3pXKulcf7m2L9LehCoEfOKVVF0Wvb55/pAiPu1
 ofTBQ2sJKjf8pNdm8/R3UVcO44WJDbll32vo6/h4tIpH/P4STXAW/SnZPN23Q2T4M945He/g21E
 d1hK4m6b4ljc6hjIh92kokd0Xn2nVnajcqZpNhCxSG98at29luZcwruLAag6M2KtV+1uimnIKP2
 mAiMahiFIBKe+4ZW9KIKuScsxOkaQ6nwg6XckyaCxi16iIC6CJ7HQ7Ix5xu/ndi9o/2pcp5kc4+
 JS4G2uI7K7ZdKlm2BQq93oxC4S2WvjB28W1v9h8A0C+6Mlafa8QUaVhUF4EOvUXAWSg2+xy7v/7
 GS9TiRF96HEb1pg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for sharing tags between multiple rnull devices. When
enabled via the `shared_tags` configfs attribute, all devices in the
group share a single tag set, reducing memory usage.

This feature requires creating a shared `TagSet` that can be referenced
by multiple devices.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  44 +++++++++----
 drivers/block/rnull/rnull.rs    | 136 +++++++++++++++++++++++++---------------
 rust/kernel/block/mq/tag_set.rs |  18 ++++++
 3 files changed, 136 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 5e6bcf9d31d8..a84854e7c358 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -10,9 +10,12 @@
     bindings,
     block::{
         badblocks::BadBlocks,
-        mq::gen_disk::{
-            GenDisk,
-            GenDiskBuilder, //
+        mq::{
+            gen_disk::{
+                GenDisk,
+                GenDiskBuilder, //
+            },
+            TagSet, //
         }, //
     },
     configfs::{
@@ -45,7 +48,9 @@
 
 mod macros;
 
-pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
+pub(crate) fn subsystem(
+    shared_tag_set: Arc<TagSet<NullBlkDevice>>,
+) -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
     let item_type = configfs_attrs! {
         container: configfs::Subsystem<Config>,
         data: Config,
@@ -55,11 +60,17 @@ pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, E
         ],
     };
 
-    kernel::configfs::Subsystem::new(c"rnull", item_type, try_pin_init!(Config {}))
+    kernel::configfs::Subsystem::new(
+        c"rnull",
+        item_type,
+        try_pin_init!(Config { shared_tag_set }),
+    )
 }
 
 #[pin_data]
-pub(crate) struct Config {}
+pub(crate) struct Config {
+    shared_tag_set: Arc<TagSet<NullBlkDevice>>,
+}
 
 #[vtable]
 impl AttributeOperations<0> for Config {
@@ -69,7 +80,7 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed,\
-             submit_queues,use_per_node_hctx,discard,blocking\n",
+             submit_queues,use_per_node_hctx,discard,blocking,shared_tags\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -106,6 +117,7 @@ fn make_group(
                 cache_size_mib: 15,
                 mbps: 16,
                 blocking: 17,
+                shared_tags: 18,
             ],
         };
 
@@ -139,6 +151,8 @@ fn make_group(
                     cache_size_mib: 0,
                     mbps: 0,
                     blocking: false,
+                    shared_tags: false,
+                    shared_tag_set: self.shared_tag_set.clone(),
                 }),
             }),
             core::iter::empty(),
@@ -215,6 +229,8 @@ struct DeviceConfigInner {
     disk_storage: Arc<DiskStorage>,
     mbps: u32,
     blocking: bool,
+    shared_tags: bool,
+    shared_tag_set: Arc<TagSet<NullBlkDevice>>,
 }
 
 #[vtable]
@@ -245,17 +261,20 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 capacity_mib: guard.capacity_mib,
                 irq_mode: guard.irq_mode,
                 completion_time: guard.completion_time,
-                memory_backed: guard.memory_backed,
-                submit_queues: guard.submit_queues,
-                home_node: guard.home_node,
                 discard: guard.discard,
-                no_sched: guard.no_sched,
                 bad_blocks: guard.bad_blocks.clone(),
                 bad_blocks_once: guard.bad_blocks_once,
                 bad_blocks_partial_io: guard.bad_blocks_partial_io,
                 storage: guard.disk_storage.clone(),
                 bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
-                blocking: guard.blocking,
+                shared_tag_set: guard.shared_tags.then(|| guard.shared_tag_set.clone()),
+                tag_set: crate::TagSetOptions {
+                    submit_queues: guard.submit_queues,
+                    home_node: guard.home_node,
+                    blocking: guard.blocking,
+                    memory_backed: guard.memory_backed,
+                    no_sched: guard.no_sched,
+                },
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -427,3 +446,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 
 configfs_simple_field!(DeviceConfig, 16, mbps, u32);
 configfs_simple_bool_field!(DeviceConfig, 17, blocking);
+configfs_simple_bool_field!(DeviceConfig, 18, shared_tags);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 181fce551a91..bcf6a85f1cbc 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -143,6 +143,10 @@
             default: false,
             description: "Register as a blocking blk-mq driver device",
         },
+        shared_tags: bool {
+            default: false,
+            description: "Share tag set between devices for blk-mq",
+        },
     },
 }
 
@@ -158,19 +162,30 @@ impl kernel::InPlaceModule for NullBlkModule {
     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
 
-        let mut disks = KVec::new();
+        pin_init::pin_init_scope(move || -> Result<_, Error> {
+            let submit_queues = if module_parameters::use_per_node_hctx.value() {
+                kernel::numa::num_online_nodes()
+            } else {
+                module_parameters::submit_queues.value()
+            };
+            let home_node = module_parameters::home_node.value();
+            let blocking = module_parameters::blocking.value();
+            let memory_backed = module_parameters::memory_backed.value();
+            let no_sched = module_parameters::no_sched.value();
+
+            let shared_tag_set = NullBlkDevice::build_tag_set(TagSetOptions {
+                submit_queues,
+                home_node,
+                blocking,
+                memory_backed,
+                no_sched,
+            })?;
 
-        let defer_init = move || -> Result<_, Error> {
+            let mut disks = KVec::new();
             let completion_time: i64 = module_parameters::completion_nsec.value().try_into()?;
             for i in 0..module_parameters::nr_devices.value() {
                 let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
 
-                let submit_queues = if module_parameters::use_per_node_hctx.value() {
-                    kernel::numa::num_online_nodes()
-                } else {
-                    module_parameters::submit_queues.value()
-                };
-
                 let block_size = module_parameters::bs.value();
                 let disk = NullBlkDevice::new(NullBlkOptions {
                     name: &name,
@@ -179,27 +194,30 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     capacity_mib: module_parameters::gb.value() * 1024,
                     irq_mode: module_parameters::irqmode.value().try_into()?,
                     completion_time: Delta::from_nanos(completion_time),
-                    memory_backed: module_parameters::memory_backed.value(),
-                    submit_queues,
-                    home_node: module_parameters::home_node.value(),
                     discard: module_parameters::discard.value(),
-                    no_sched: module_parameters::no_sched.value(),
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
                     storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
                     bandwidth_limit: u64::from(module_parameters::mbps.value()) * 2u64.pow(20),
-                    blocking: module_parameters::blocking.value(),
+                    shared_tag_set: module_parameters::shared_tags
+                        .value()
+                        .then(|| shared_tag_set.clone()),
+                    tag_set: TagSetOptions {
+                        submit_queues,
+                        home_node,
+                        blocking,
+                        memory_backed,
+                        no_sched,
+                    },
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
 
-            Ok(disks)
-        };
-
-        try_pin_init!(Self {
-            configfs_subsystem <- configfs::subsystem(),
-            param_disks <- new_mutex!(defer_init()?),
+            Ok(try_pin_init!(Self {
+                configfs_subsystem <- configfs::subsystem(shared_tag_set),
+                param_disks <- new_mutex!(disks),
+            }))
         })
     }
 }
@@ -211,17 +229,14 @@ struct NullBlkOptions<'a> {
     capacity_mib: u64,
     irq_mode: IRQMode,
     completion_time: Delta,
-    memory_backed: bool,
-    submit_queues: u32,
-    home_node: i32,
     discard: bool,
-    no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
     storage: Arc<DiskStorage>,
     bandwidth_limit: u64,
-    blocking: bool,
+    shared_tag_set: Option<Arc<TagSet<NullBlkDevice>>>,
+    tag_set: TagSetOptions,
 }
 
 #[pin_data]
@@ -243,9 +258,50 @@ struct NullBlkDevice {
     disk: SetOnce<Arc<Revocable<GenDiskRef<Self>>>>,
 }
 
+struct TagSetOptions {
+    submit_queues: u32,
+    home_node: i32,
+    blocking: bool,
+    memory_backed: bool,
+    no_sched: bool,
+}
+
 impl NullBlkDevice {
     const BANDWIDTH_TIMER_INTERVAL: Delta = Delta::from_millis(20);
 
+    fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
+        let TagSetOptions {
+            submit_queues,
+            home_node,
+            blocking,
+            memory_backed,
+            no_sched,
+        } = options;
+
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
+        let mut flags = mq::tag_set::Flags::default();
+        if blocking || memory_backed {
+            flags |= mq::tag_set::Flag::Blocking;
+        }
+        if no_sched {
+            flags |= mq::tag_set::Flag::NoDefaultScheduler;
+        }
+
+        Arc::pin_init(
+            TagSet::new(submit_queues, (), 256, 1, numa_node, flags),
+            GFP_KERNEL,
+        )
+    }
+
     fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         let NullBlkOptions {
             name,
@@ -254,37 +310,22 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             capacity_mib,
             irq_mode,
             completion_time,
-            memory_backed,
-            submit_queues,
-            home_node,
             discard,
-            no_sched,
             bad_blocks,
             bad_blocks_once,
             bad_blocks_partial_io,
             storage,
             bandwidth_limit,
-            blocking,
+            shared_tag_set,
+            tag_set,
         } = options;
 
-        let mut flags = mq::tag_set::Flags::default();
+        let memory_backed = tag_set.memory_backed;
 
-        if blocking || memory_backed {
-            flags |= mq::tag_set::Flag::Blocking;
-        }
-
-        if no_sched {
-            flags |= mq::tag_set::Flag::NoDefaultScheduler;
-        }
-
-        if home_node > kernel::numa::num_online_nodes().try_into()? {
-            return Err(code::EINVAL);
-        }
-
-        let numa_node = if home_node == -1 {
-            kernel::alloc::NumaNode::NO_NODE
+        let tagset = if let Some(shared) = shared_tag_set {
+            shared
         } else {
-            kernel::alloc::NumaNode::new(home_node)?
+            Self::build_tag_set(tag_set)?
         };
 
         let capacity_sectors = capacity_mib << (20 - block::SECTOR_SHIFT);
@@ -294,11 +335,6 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             return Err(code::EINVAL);
         }
 
-        let tagset = Arc::pin_init(
-            TagSet::new(submit_queues, (), 256, 1, numa_node, flags),
-            GFP_KERNEL,
-        )?;
-
         let queue_data = Arc::try_pin_init(
             try_pin_init!(Self {
                 storage,
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index bfb8f8af4ee1..5359e60fb5a5 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -124,3 +124,21 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { T::TagSetData::from_foreign(tagset_data) };
     }
 }
+
+// SAFETY: It is safe to share references to `TagSet` across thread boundaries as long as
+// `TagSetData` is `Sync`.
+unsafe impl<T> Sync for TagSet<T>
+where
+    T: Operations,
+    T::TagSetData: Sync,
+{
+}
+
+// SAFETY: It is safe to transfer ownership of `TagSet` across thread boundaries if the associated
+// private data is `Send` (it will be dropped with the `TagSet`).
+unsafe impl<T> Send for TagSet<T>
+where
+    T: Operations,
+    T::TagSetData: Send,
+{
+}

-- 
2.51.2


