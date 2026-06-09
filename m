Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0C408A19;
	Tue,  9 Jun 2026 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032455; cv=none; b=fMzManZLTT2uZYLxSHfPU6e5Qx+NGvQykcBGY1a2cA5wqP63TELxBhKRbpjzvskX9qlU54t9FMoQedrT/Mhmr5nalKi5oY7/knZ414Lzrj6/mrPXj7tdURVvJTAxxQKwqE7IhTvkU7nqxGRZJXQlvGNFHydzYpVpveYRacBrfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032455; c=relaxed/simple;
	bh=7zQettVVHdmYaGqWkJYUonz9KPKSfJ5OcoVNXtzcUHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFUOMyMaT+DFgKPK/JzScjdXX09sjCB240FVDy+KYXZNOWxszkQApPwFpS9mX0CoFeYzfbS3/HWHvvBuL5VFT3y0a7KE75bOM/ZM8O82XOtFBhEIWVMdw5DeYWrvw7Nyhprr6EGm8YTlxFgMpK049GQ4eFCsPXUeQ77HQ7tFAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSgxWhKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSgxWhKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306531F00899;
	Tue,  9 Jun 2026 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032454;
	bh=jxOzQ6UxSv5lSwC8v6zCHNH1kojG7yWT9JQ+45S4GSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kSgxWhKqzTG8qOB3fXj50ITpeAwOaC/pRYz1PppMxkMYDPPx0nu2Cl12jIU8/ctq1
	 lvg9jQdGIhiVwX4dEDE+G7rveBOVMJAM48+5CrRKr3nTRiwmPDIvij2dlMfSaiUuME
	 TIadX0aBwnEPF91l4ocBBNLl6DSM+Zcyk5bHao6Mpa52xFkWGlc+msEKdtV4BCYlH1
	 H1upFhHpU9vKCzDkUvkG/SfywICCp4C/mtQJNum2baFWf+QpjAJ7rOJNycRqg5Yl+z
	 oMveEJwIXmTlx0p3wSRsDeyhD7sba+F9dEgCTjEOE4r8ph3Cm8D40YbvNuOxvqhTHT
	 66EOKtknms32Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:46 +0200
Subject: [PATCH v2 67/83] block: rnull: add an option to change the number
 of hardware queues
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-67-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11986;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=7zQettVVHdmYaGqWkJYUonz9KPKSfJ5OcoVNXtzcUHo=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTxT9gH0dHBCKVhfGgJYCHI0gPbLH/3uApdr
 Pj7/fHqrUmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk8QAKCRD6UCkIqsW9
 0D7ZD/98jV+hTmerVF71nmBv/TWQvvm9FV2jfHts8FFuwWnBEOlK4JF1WXexgKfwSi5XGmP350t
 jcRIuZZmCFEVuuSI/awo/oDxU40sGL1y7oAEhPR/v4zUm4WV3f4xbEQ8C7CQDx0tLvPrT7Dm/UN
 LWIR5TLicCXRADWdpiTlNAJEomvqmOpwMxERISwevyOHaBztFsV6q++3gAZlYpfVIn/zTavG/lp
 oPzkOdiNfgkMbNAjiBdPh9Yly7rhQEeGkiu8L/mIJ04WPiZHSA9I3Zd7/b5JNb849k7G7+BPCDB
 c5wvPV3S4+ugFENKvvvphKmKLRrJtfb306tyeSA/tErYpu5A00ftUL10JB1X4clK83XwMxJbbq1
 AtGuD13CbLXneYAvIeOxC2W8v6955UZiGqV+ytzILjcYVbeU5B3c5gCIG3/cDGkfOwJQpN1wo+V
 5FfCAxu+gqgpiaxgGVEHBwa/A4nzkg9l4X3L9oAyQAUaW2u0ouukoIvokIxDv0v+SdvglLBd5iP
 2MuLy01HVGobAFqlc9NMSE3nEeMcY84WR8AZ4vIA9VZVZddSDrCf728rOcvUJ1TOTLtv/42RW1N
 cvVr1UW0Oyud30wNVxt8dbSsPn/icsggyX1bGUaGUIZUJY6brtIb6qSMbOOnu2wXcWyNyFLBSvc
 S2hEAEupv9/HQVg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a feature to rnull that allows changing the number of simulated
hardware queues during device operation.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 117 ++++++++++++++++++++++++++--------------
 drivers/block/rnull/rnull.rs    |  46 ++++++++++------
 2 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8195d645ecc6..d9246b9150f4 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -148,7 +148,13 @@ fn make_group(
                     completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
                     memory_backed: false,
-                    submit_queues: 1,
+                    queue_config: Arc::pin_init(
+                        new_mutex!(QueueConfig {
+                            submit_queues: 1,
+                            poll_queues: 0
+                        }),
+                        GFP_KERNEL
+                    )?,
                     home_node: bindings::NUMA_NO_NODE,
                     discard: false,
                     no_sched: false,
@@ -169,7 +175,6 @@ fn make_group(
                     zone_max_open: 0,
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
-                    poll_queues: 0,
                     fua: true,
                 }),
             }),
@@ -236,7 +241,7 @@ struct DeviceConfigInner {
     completion_time: time::Delta,
     disk: Option<Arc<GenDisk<NullBlkDevice>>>,
     memory_backed: bool,
-    submit_queues: u32,
+    queue_config: Arc<Mutex<QueueConfig>>,
     home_node: i32,
     discard: bool,
     no_sched: bool,
@@ -257,7 +262,6 @@ struct DeviceConfigInner {
     zone_max_open: u32,
     zone_max_active: u32,
     zone_append_max_sectors: u32,
-    poll_queues: u32,
     fua: bool,
 }
 
@@ -310,9 +314,8 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
                 shared_tag_set: guard.shared_tags.then(|| guard.shared_tag_set.clone()),
                 tag_set: crate::TagSetOptions {
-                    submit_queues: guard.submit_queues,
-                    poll_queues: guard.poll_queues,
                     home_node: guard.home_node,
+                    queue_config: guard.queue_config.clone(),
                     blocking: guard.blocking,
                     memory_backed: guard.memory_backed,
                     no_sched: guard.no_sched,
@@ -337,9 +340,17 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
-configfs_simple_field!(DeviceConfig, 1,
-                       block_size, u32,
-                       check GenDiskBuilder::<NullBlkDevice>::validate_block_size
+pub(crate) struct QueueConfig {
+    pub(crate) submit_queues: u32,
+    pub(crate) poll_queues: u32,
+}
+
+configfs_simple_field!(
+    DeviceConfig,
+    1,
+    block_size,
+    u32,
+    check GenDiskBuilder::<NullBlkDevice>::validate_block_size
 );
 configfs_simple_bool_field!(DeviceConfig, 2, rotational);
 configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
@@ -363,38 +374,44 @@ fn from_str(s: &str) -> Result<Self> {
 
 configfs_simple_bool_field!(DeviceConfig, 6, memory_backed);
 
-#[vtable]
-impl configfs::AttributeOperations<7> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-        writer.write_fmt(fmt!("{}\n", this.data.lock().submit_queues))?;
-        Ok(writer.bytes_written())
-    }
+configfs_attribute! {
+    DeviceConfig,
+    7,
+    show: |this, page| show_field(this.data.lock().queue_config.lock().submit_queues, page),
+    store: |this,page| {
+        let config_guard = this.data.lock();
+        let mut queue_config = config_guard.queue_config.lock();
 
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse().map_err(|_| EINVAL)?;
+        if value > kernel::cpu::num_possible_cpus() {
+            return Err(kernel::error::code::EINVAL)
         }
 
-        let text = core::str::from_utf8(page)?.trim();
-        let value = text
-            .parse::<u32>()
-            .map_err(|_| kernel::error::code::EINVAL)?;
+        let old_submit_queues = queue_config.submit_queues;
+        queue_config.submit_queues = value;
+        let total_queue_count = queue_config.submit_queues + queue_config.poll_queues;
+
+        let disk = config_guard.disk.clone();
+
+        drop(queue_config);
+        drop(config_guard);
 
-        if value == 0 || value > kernel::cpu::num_possible_cpus() {
-            return Err(kernel::error::code::EINVAL);
+        if let Some(disk) = &disk {
+            if let Err(e) = disk.tag_set().update_hw_queue_count(total_queue_count) {
+                this.data.lock().queue_config.lock().submit_queues = old_submit_queues;
+                return Err(e);
+            }
         }
 
-        this.data.lock().submit_queues = value;
         Ok(())
-    }
+    },
 }
 
 configfs_attribute!(DeviceConfig, 8,
     show: |this, page| show_field(
-        this.data.lock().submit_queues == kernel::numa::num_online_nodes(), page
+        this.data.lock().queue_config.lock().submit_queues == kernel::numa::num_online_nodes(),
+        page
     ),
     store: |this, page| store_with_power_check(this, page, |data, page| {
         let value = core::str::from_utf8(page)?
@@ -404,7 +421,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
             != 0;
 
         if value {
-            data.submit_queues = kernel::numa::num_online_nodes();
+            data.queue_config.lock().submit_queues = kernel::numa::num_online_nodes();
         }
         Ok(())
     })
@@ -506,17 +523,37 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_field!(DeviceConfig, 24, zone_max_open, u32);
 configfs_simple_field!(DeviceConfig, 25, zone_max_active, u32);
 configfs_simple_field!(DeviceConfig, 26, zone_append_max_sectors, u32);
-configfs_simple_field!(
+configfs_attribute! {
     DeviceConfig,
     27,
-    poll_queues,
-    u32,
-    check(|value| {
+    show: |this, page| show_field(this.data.lock().queue_config.lock().poll_queues, page),
+    store: |this,page| {
+        let config_guard = this.data.lock();
+        let mut queue_config = config_guard.queue_config.lock();
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse().map_err(|_| EINVAL)?;
         if value > kernel::cpu::num_possible_cpus() {
-            Err(kernel::error::code::EINVAL)
-        } else {
-            Ok(())
+            return Err(kernel::error::code::EINVAL)
         }
-    })
-);
+
+        let old_poll_queues = queue_config.poll_queues;
+        queue_config.poll_queues = value;
+        let total_queue_count = queue_config.submit_queues + queue_config.poll_queues;
+
+        let disk = config_guard.disk.clone();
+
+        drop(queue_config);
+        drop(config_guard);
+
+        if let Some(disk) = &disk {
+            if let Err(e) = disk.tag_set().update_hw_queue_count(total_queue_count) {
+                this.data.lock().queue_config.lock().poll_queues = old_poll_queues;
+                return Err(e);
+            }
+        }
+
+        Ok(())
+    },
+}
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index c3126b923367..6653db5c069b 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,7 +10,10 @@
 #[cfg(CONFIG_BLK_DEV_ZONED)]
 mod zoned;
 
-use configfs::IRQMode;
+use configfs::{
+    IRQMode,
+    QueueConfig, //
+};
 use disk_storage::{
     DiskStorage,
     NullBlockPage,
@@ -224,9 +227,14 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             let hw_queue_depth = module_parameters::hw_queue_depth.value();
 
             let shared_tag_set = NullBlkDevice::build_tag_set(TagSetOptions {
-                submit_queues,
-                poll_queues,
                 home_node,
+                queue_config: Arc::pin_init(
+                    new_mutex!(QueueConfig {
+                        submit_queues,
+                        poll_queues,
+                    }),
+                    GFP_KERNEL,
+                )?,
                 blocking,
                 memory_backed,
                 no_sched,
@@ -256,9 +264,14 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         .value()
                         .then(|| shared_tag_set.clone()),
                     tag_set: TagSetOptions {
-                        submit_queues,
-                        poll_queues,
                         home_node,
+                        queue_config: Arc::pin_init(
+                            new_mutex!(QueueConfig {
+                                submit_queues,
+                                poll_queues,
+                            }),
+                            GFP_KERNEL,
+                        )?,
                         blocking,
                         memory_backed,
                         no_sched,
@@ -338,9 +351,8 @@ struct NullBlkDevice {
 }
 
 struct TagSetOptions {
-    submit_queues: u32,
-    poll_queues: u32,
     home_node: i32,
+    queue_config: Arc<Mutex<QueueConfig>>,
     blocking: bool,
     memory_backed: bool,
     no_sched: bool,
@@ -352,9 +364,8 @@ impl NullBlkDevice {
 
     fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
         let TagSetOptions {
-            submit_queues,
-            poll_queues,
             home_node,
+            queue_config,
             blocking,
             memory_backed,
             no_sched,
@@ -379,14 +390,18 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
             flags |= mq::tag_set::Flag::NoDefaultScheduler;
         }
 
+        let queue_config_guard = queue_config.lock();
+        let submit_queues = queue_config_guard.submit_queues;
+        let poll_queues = queue_config_guard.poll_queues;
+        drop(queue_config_guard);
+
         Arc::pin_init(
             TagSet::new(
                 submit_queues + poll_queues,
                 KBox::new(
                     NullBlkTagsetData {
                         queue_depth: hw_queue_depth,
-                        submit_queue_count: submit_queues,
-                        poll_queue_count: poll_queues,
+                        queue_config,
                     },
                     GFP_KERNEL,
                 )?,
@@ -823,8 +838,7 @@ impl HasHrTimer<Self> for Pdu {
 
 struct NullBlkTagsetData {
     queue_depth: u32,
-    submit_queue_count: u32,
-    poll_queue_count: u32,
+    queue_config: Arc<Mutex<QueueConfig>>,
 }
 
 #[vtable]
@@ -970,8 +984,10 @@ fn report_zones(
     }
 
     fn map_queues(tag_set: Pin<&mut TagSet<Self>>) {
-        let mut submit_queue_count = tag_set.data().submit_queue_count;
-        let mut poll_queue_count = tag_set.data().poll_queue_count;
+        let queue_config = tag_set.data().queue_config.lock();
+        let mut submit_queue_count = queue_config.submit_queues;
+        let mut poll_queue_count = queue_config.poll_queues;
+        drop(queue_config);
 
         if tag_set.hw_queue_count() != submit_queue_count + poll_queue_count {
             pr_warn!(

-- 
2.51.2


