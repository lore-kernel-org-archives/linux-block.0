Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B648B389;
	Tue,  9 Jun 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032292; cv=none; b=ojD3wxANc2cF/B2xsSSHMWdfe7a92krZ+BrgCJuY+kalElkpbU/OXPs6gR+PWNCxVSgKtrXV9MN7L5dowrPeYbPB7WyfmSqRkquFgq7W5O8VoMyMsKZ12LwRJ8yi/A+6fDF5pSkeojxVO7caReqXeq06L/sRbJ1nX7YHQZlpO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032292; c=relaxed/simple;
	bh=lzez8j8zqRLV6gbk6iWV9jQDc4roUyUsLUzz7LgTQpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtNTCzdL8xu99mgvwfHEaQkww7xEwme8rye9+SW3l/BoTh7aBi7/aMSODMbMO2DYkC1Yx6EdTGexoO8yEV7eYDSvWvJJAvk4jKHt9/3m5xXjkj5c2NNrlwRxuUmp1nUXvuwNm/bIJTPbt/8j+qdRCbuQObMR6VyW3cgpgdzEe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZHUEfJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZHUEfJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8D21F00893;
	Tue,  9 Jun 2026 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032291;
	bh=GI7bMkhPaaNJq9fuPFFaiFn3pKn1655aVcxzZP2OKa8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EZHUEfJYGN1jW1sAkKwr559XDdZdWoWVCrAILg5iUtNDYxlfsJNdrRbWicD1yB5U6
	 TqvbVW1DOFFNkiF95/STtQ2qQ3lxZaSw/prEon1gGhr6ejYbhr6Z4uX1xLVAsqj6SA
	 E5X+4oDlhNpgd5O7Z+Wl4uwsP/WWaa6Vlnf6hEybMLT560soImnS9AvaU/2C4pXUa6
	 gmDjya5H7oMAy9ZIJmjxQubrEgO0jRt/Zv4H6OBZCY9HGIvVxL1/dSRjIXT16lrXGu
	 mlSGYbAu6Uq7rzxdps74pGMWhKiMsxSxvvcpeByzHKlYNVj/9iP9fDuoW9U4jmpuhk
	 BAv/+lIVO3QPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:56 +0200
Subject: [PATCH v2 17/83] block: rnull: add submit queue count config
 option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-17-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7246; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lzez8j8zqRLV6gbk6iWV9jQDc4roUyUsLUzz7LgTQpc=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTEugFhxWOtTsK/8FP5iDzSz6aLCztmYQWKh
 q35rokSuQKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkxAAKCRD6UCkIqsW9
 0AeqD/wNZq1pWUrULFGmIEbOx73Cl6XyiQcErKBUzZVdec3C6xECJjipuL9gjVjAUQI/Q6B0QLj
 0UFnRtYmRP8OMrfo2AYryyW6ZcWJFuzRqkm3d36ZkBgIwY3GZ6pIwb2SBH5S2GmvxokxEJdO7z8
 n6k0M8Z4pUta9Cw8dDy34OwP1axygPMoVzy5hX7Hh5spwxuuxhb/8YhgtD+J15wxS+BPzdxtdRc
 oEcTbUilzEqMGUxPfL+AwSTo+vZDOSjWpekfkO1n6bH/N6nuhrpp/2Ftyy/XTSAEL7C7ZlXINmE
 lZoyLq+Cdnw99vQFKX7orrRhflx7aRrtTPthwzudOpVJcX2ecadD3fd69Cjz1E5V1hCJi0wyNvY
 qUlV0dv7zQrvbIrQbSmHd6C5LGHEa5RPzfn8L0QH8CSo3rSXFHeeX47TjRN1xFt8Fr2m5q+C+6D
 67O/5bHx2QnGRoOcBaLKxn1Prtnzod9OyXk/Kv5r97GWwXCNuCp9sarwHMqRTg4DkK4OV7rypKB
 AZ6S1TaR+FtmyZfDUt/TyGeRrA0PIBanT4xsYsAgH4B5AL7wQTwpD3tgUzrlBK8PC90wzncRnmM
 vZIbR+CxAXXWtMbaMYOVGiCPo9SlisFxFRwYQtfUSj+s/rx9AR/pr818kvGmPgvvUxfBeLC9SD6
 C61RVrxw2QMRGnA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow user space to control the number of submission queues when creating
null block devices.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 56 +++++++++++++++++++++++++++++++++--------
 drivers/block/rnull/rnull.rs    | 56 +++++++++++++++++++++++++++--------------
 2 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8daf2ca409ba..0dea92a9079b 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -60,7 +60,10 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec,memory_backed\n")?;
+        writer.write_str(
+            "blocksize,size,rotational,irqmode,completion_nsec,memory_backed,\
+             submit_queues\n",
+        )?;
         Ok(writer.bytes_written())
     }
 }
@@ -85,6 +88,7 @@ fn make_group(
                 irqmode: 4,
                 completion_nsec: 5,
                 memory_backed: 6,
+                submit_queues: 7,
             ],
         };
 
@@ -103,6 +107,7 @@ fn make_group(
                     completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
                     memory_backed: false,
+                    submit_queues: 1,
                 }),
             }),
             core::iter::empty(),
@@ -168,6 +173,7 @@ struct DeviceConfigInner {
     completion_time: time::Delta,
     disk: Option<GenDisk<NullBlkDevice>>,
     memory_backed: bool,
+    submit_queues: u32,
 }
 
 #[vtable]
@@ -191,15 +197,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         let mut guard = this.data.lock();
 
         if !guard.powered && power_op {
-            guard.disk = Some(NullBlkDevice::new(
-                &guard.name,
-                guard.block_size,
-                guard.rotational,
-                guard.capacity_mib,
-                guard.irq_mode,
-                guard.completion_time,
-                guard.memory_backed,
-            )?);
+            guard.disk = Some(NullBlkDevice::new(crate::NullBlkOptions {
+                name: &guard.name,
+                block_size: guard.block_size,
+                rotational: guard.rotational,
+                capacity_mib: guard.capacity_mib,
+                irq_mode: guard.irq_mode,
+                completion_time: guard.completion_time,
+                memory_backed: guard.memory_backed,
+                submit_queues: guard.submit_queues,
+            })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
             drop(guard.disk.take());
@@ -232,3 +239,32 @@ fn from_str(s: &str) -> Result<Self> {
 }
 
 configfs_simple_bool_field!(DeviceConfig, 6, memory_backed);
+
+#[vtable]
+impl configfs::AttributeOperations<7> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+        writer.write_fmt(fmt!("{}\n", this.data.lock().submit_queues))?;
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text
+            .parse::<u32>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
+
+        if value == 0 || value > kernel::cpu::num_possible_cpus() {
+            return Err(kernel::error::code::EINVAL);
+        }
+
+        this.data.lock().submit_queues = value;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 8e4d2b270bcf..a7c35f33631a 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -78,6 +78,10 @@
             default: false,
             description: "Create a memory-backed block device.",
         },
+        submit_queues: u32 {
+            default: 1,
+            description: "Number of submission queues",
+        },
     },
 }
 
@@ -100,15 +104,16 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             for i in 0..module_parameters::nr_devices.value() {
                 let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
 
-                let disk = NullBlkDevice::new(
-                    &name,
-                    module_parameters::bs.value(),
-                    module_parameters::rotational.value(),
-                    module_parameters::gb.value() * 1024,
-                    module_parameters::irqmode.value().try_into()?,
-                    Delta::from_nanos(completion_time),
-                    module_parameters::memory_backed.value(),
-                )?;
+                let disk = NullBlkDevice::new(NullBlkOptions {
+                    name: &name,
+                    block_size: module_parameters::bs.value(),
+                    rotational: module_parameters::rotational.value(),
+                    capacity_mib: module_parameters::gb.value() * 1024,
+                    irq_mode: module_parameters::irqmode.value().try_into()?,
+                    completion_time: Delta::from_nanos(completion_time),
+                    memory_backed: module_parameters::memory_backed.value(),
+                    submit_queues: module_parameters::submit_queues.value(),
+                })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
 
@@ -122,25 +127,38 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
     }
 }
 
+struct NullBlkOptions<'a> {
+    name: &'a CStr,
+    block_size: u32,
+    rotational: bool,
+    capacity_mib: u64,
+    irq_mode: IRQMode,
+    completion_time: Delta,
+    memory_backed: bool,
+    submit_queues: u32,
+}
 struct NullBlkDevice;
 
 impl NullBlkDevice {
-    fn new(
-        name: &CStr,
-        block_size: u32,
-        rotational: bool,
-        capacity_mib: u64,
-        irq_mode: IRQMode,
-        completion_time: Delta,
-        memory_backed: bool,
-    ) -> Result<GenDisk<Self>> {
+    fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
+        let NullBlkOptions {
+            name,
+            block_size,
+            rotational,
+            capacity_mib,
+            irq_mode,
+            completion_time,
+            memory_backed,
+            submit_queues,
+        } = options;
+
         let flags = if memory_backed {
             mq::tag_set::Flag::Blocking.into()
         } else {
             mq::tag_set::Flags::default()
         };
 
-        let tagset = Arc::pin_init(TagSet::new(1, 256, 1, flags), GFP_KERNEL)?;
+        let tagset = Arc::pin_init(TagSet::new(submit_queues, 256, 1, flags), GFP_KERNEL)?;
 
         let queue_data = Box::pin_init(
             pin_init!(QueueData {

-- 
2.51.2


