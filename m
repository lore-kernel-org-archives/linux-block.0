Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB61BD035;
	Sun, 15 Feb 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198874; cv=none; b=l0Wbjd9iU50bU7lFxLo4h3uDaIWW+UUtcdb2roQVvGQczemDdZWW0S5QStIum198zywaM4rxw0wm0bmGGwDKBDSCKxGH3RitoatPuH3QGHo2kVOgMrbria9yx47eymmyUXPWi+XsdEnUYPN0s0EjVMFmyEuto/eAgJIc1g/+3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198874; c=relaxed/simple;
	bh=oPe8xTPtUm7MU6OaQHlhI5ZvU2RiaWhjCxNoERzRn94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vnr/R2eBX0obCEtmYvjoWFD+iykSao+a1LbFRek6/AG7SJ1CnyNOnTFMailErGQ4gYR4N3FFLSODj0++CrDbWgBSfUK1c7vkPp3ZUqmM5udi5Y2OWZO4ZKsdVQIDAqre6ZF2hkWCwowDufpAfhVssZJAbJHby94YA/oLaV0IZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4HkhPLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4HkhPLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F060BC19422;
	Sun, 15 Feb 2026 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198874;
	bh=oPe8xTPtUm7MU6OaQHlhI5ZvU2RiaWhjCxNoERzRn94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N4HkhPLL2+UClx4hGhGXzseXnzQg4SGO27nQbo0G78ClH94QxOAUF1svWavDlEMws
	 v+3GCnbJ7PelKTBeWj8hNce8IoNTYBolND+Ut5M27Ysam9gPKWyrWfc2EDSzQXqLSr
	 Yo0Ex3gxHOOwWTCfC4oAKWJZ9PnN5Yx/F2ZMFpMb5EcB70d3yZgvtJdB7GhZekydp2
	 OaxZjK1/R9a0y0VO4L54lxhONQMfQ2lqR2O1QYqNe2tfmCdkhO+6hVGN0v6n6Ql6Ux
	 9kscZ03Jow8PgfjhYUa8uwY0MW10rD9N1taHvH4xGq47DHr47fh9efvydVBZXIM/lm
	 KTlvuKxEH/Nwg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:01 +0100
Subject: [PATCH 14/79] block: rnull: add submit queue count config option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-14-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7281; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=oPe8xTPtUm7MU6OaQHlhI5ZvU2RiaWhjCxNoERzRn94=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgocr9tcJuX0/u2H2v2dGPhOmiIz0V7rredg
 ljKxj2DbTKJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYKAAKCRDhuBo+eShj
 d0KfD/9HduJ9u1Dz2i53t5uptOOHZJWiq5J44S0C7hFuqOn7ciTpEW9jB6p012sRG0NdfGlU9wC
 5wY8zNp0II+nrQ3Z7baNUQBjj8eCmgzIgoiyajufI1VTC5j9OlMlGv76VVGW8abuA21RtpTxvu1
 LQ051KmcQCFrMWY6JNnI9ZsaCEXwBPPpwfZ2fROuKL7NEQutSKWYmXwnr5JF0EB746b3Gl7YFYc
 KxsNfXHcoCH8H2Q7pEeQf6FeQOgbVITNW8TuqZdpVeSUYJYU7tku/KuiKWVWv9QrjV14aRTjmXW
 4nZ0oVFSB0UdmMjsU2ki3/jUuDXRnjbSYO4bIqC6cU7VK7ozdHWz+krobdr8HhkQNFZbiGjpVnZ
 ExhyYez/CA9Idt7BzXrTql/MKkF1IixJQK3ipYI5toRQNg2u/RrOgNDBv+iFHDFm1//zHQwIgIS
 9n9Na57cPIsHWxjD+l7tgB/NV7dWAXKkvHqRNlxOuYKmsRVIRPWnXoguKayXs2rxSTn0REmbbpk
 f4vnf3sMSFHq3+VtUQh+443S2fzdMTttk1L5mDhYEExwB34ujSW7QV5UkMSZLrkLidPAT3j2AOg
 ZpAcNEJydOMa9BQOh8KqyhJrrJh62rbtBDCXdf34YCvx6kcf40950ai1DR0uHlg+smHF+QdvFJC
 vCqrzlQJiQAoKFA==
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
index b5dc30c5d3e20..fd3cbf7aa012e 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -59,7 +59,10 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec,memory_backed\n")?;
+        writer.write_str(
+            "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
+             submit_queues\n",
+        )?;
         Ok(writer.bytes_written())
     }
 }
@@ -84,6 +87,7 @@ fn make_group(
                 irqmode: 4,
                 completion_nsec: 5,
                 memory_backed: 6,
+                submit_queues: 7,
             ],
         };
 
@@ -102,6 +106,7 @@ fn make_group(
                     completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
                     memory_backed: false,
+                    submit_queues: 1,
                 }),
             }),
             core::iter::empty(),
@@ -157,6 +162,7 @@ struct DeviceConfigInner {
     completion_time: time::Delta,
     disk: Option<GenDisk<NullBlkDevice>>,
     memory_backed: bool,
+    submit_queues: u32,
 }
 
 #[vtable]
@@ -180,15 +186,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
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
@@ -244,3 +251,32 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
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
+        if value == 0 || value > kernel::num_possible_cpus() {
+            return Err(kernel::error::code::EINVAL);
+        }
+
+        this.data.lock().submit_queues = value;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a1156a368c467..55ee5165b90b3 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -80,6 +80,10 @@
             default: 0,
             description: "Create a memory-backed block device. 0-false, 1-true. Default: 0",
         },
+        submit_queues: u32 {
+            default: 1,
+            description: "Number of submission queues",
+        },
     },
 }
 
@@ -102,15 +106,16 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             for i in 0..(*module_parameters::nr_devices.value()) {
                 let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
 
-                let disk = NullBlkDevice::new(
-                    &name,
-                    *module_parameters::bs.value(),
-                    *module_parameters::rotational.value() != 0,
-                    *module_parameters::gb.value() * 1024,
-                    (*module_parameters::irqmode.value()).try_into()?,
-                    Delta::from_nanos(completion_time),
-                    *module_parameters::memory_backed.value() != 0,
-                )?;
+                let disk = NullBlkDevice::new(NullBlkOptions {
+                    name: &name,
+                    block_size: *module_parameters::bs.value(),
+                    rotational: *module_parameters::rotational.value() != 0,
+                    capacity_mib: *module_parameters::gb.value() * 1024,
+                    irq_mode: (*module_parameters::irqmode.value()).try_into()?,
+                    completion_time: Delta::from_nanos(completion_time),
+                    memory_backed: *module_parameters::memory_backed.value() != 0,
+                    submit_queues: *module_parameters::submit_queues.value(),
+                })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
 
@@ -124,25 +129,38 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
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


