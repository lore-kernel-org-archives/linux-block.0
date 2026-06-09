Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBC4DD6CC;
	Tue,  9 Jun 2026 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032571; cv=none; b=KcZIYfcnPgSs8g/Z+GUB+A1zA33XtH7xwIwDhusSs0PRwRvOpEDa/5sJmBA5Xa+OgWLvtiFTg+JQmhI/HuSShHpHERtoVqV7AyX62exp9qObyQM8uEwgTjFDXXY0masNsScoYGI6pafR09vWedk1RJ+XY8CfrtHky//0evHlCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032571; c=relaxed/simple;
	bh=2WihwLY3BKsR/bUh+8xVFcjC68ymvUSpcl2aNu7m3ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAe4GP86f4SJXjl8is57UzJnOSprPigMX75zpgGXepxAMSh+cPi1TimmkNUdck6hrgKJO6sVQ9O2rTNiKV7+52VHmXVtou/tHfD+HAi9Du6dBSDRpg8BgVkoD4NvkZKR0sU2ejEeHRp316VkIWNcwMSoUW+kV5dY2wbKSpuHFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUzkqU+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUzkqU+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48B81F00898;
	Tue,  9 Jun 2026 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032570;
	bh=Orhut8IhA4k/fI1g8VtdPP5GiujeWv5wMA2yYIWY1p8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RUzkqU+ZXawZrmlyk04BLnOhiuJzHkfl61joHhZcBaJzAK6ZcL1k6CE2FsibWxiU7
	 RYBL/UjhqKpDI+/39m/Z9JiKYUdcO9PK8ohduC4fYu3E0T7i5TCnvfraScXLOaEGh3
	 S+gZoTn3QrqlDt0k4RgvmC3st+7ihZ7uo8hy0+zJrYWIuqmhltbPlwr+FbaM63QyRz
	 11bRCpQFv0VBLxZiB3u+NuaeVqyC7/FHEQu/r+IjOwfRffZHpGz6sep1y/Xcc7GZ4X
	 3+pEleRTX5HmupMZswDkaL2Y8vLRrOkd4yCOBevKooC1A4X0p6ue4AtmVgoE3jCKKY
	 vxwxONaV/5lkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:50 +0200
Subject: [PATCH v2 11/83] block: rnull: add timer completion mode
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-11-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8400; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=2WihwLY3BKsR/bUh+8xVFcjC68ymvUSpcl2aNu7m3ro=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS+rU1gDuulIyezDBGUgrXsFtIS6RTlCiVRL
 3EBNU/is9GJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkvgAKCRD6UCkIqsW9
 0KnwD/0bwBHMPBBCjhyRdIxobUfjyBnsEtn2wXnswCENj7OIZnPKIiR4pzsIijIprkOLi+Xh/rR
 Aj2+xTHMdRGVHPz/gZX2rsrde9a3ar0Eqv3xd/8WtXbW6lFynQTgEqBsDxD4xFHDvegdth1FFFT
 zX6Qs7QhtK9QoQvbrizt2qP/+Rc6QCoLB7CKXr4UhWV1BIC4TQjVZMlhGvF+VTW5UU6lOTQ72IR
 aLsHVbe03W2nuO8HOhl6d/ZqzPAeifmI5KvH6ep0ARDTCIGK+7g/TLrNKlSScLmMUI5MQ5H0XYb
 X8n+mA5zynpdOnPAuFv8N0LTtN7TaOokE8mGIiTXgswZXdxqzx/mGIRxNY6iQ3yOhyyCw0wAwCS
 Cbr/JD8gjj8qUQcI2yThBBSvXn9mJOxuqVJSYT4QAeemEQE6w7nKrCITN5OZ/6haENVWg3jHt+W
 I+nckkSVS3F8v8ZU42L/H9IHaekvx3yaQuGlA5lZtiHrGSPojoJevRkJNlMc7gbaLoOfyPYU0oa
 YF8Q4ELRoA2VIIp1QMDK4jKssuV2eDGgH3QC2E76jp0oKV7BGb2ul+h1T6nqQjPxfua+9H0TXal
 /QJfn3BY4k+XN9vv4Dlvo2mk+mIUBCPqRTcdN1t+d8CDzAJBpIT00omYkYnAesldTy4wyE3fiEs
 /ZAVOJ55sXdCcww==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a timer completion mode to `rnull`. This will complete requests after a
specified time has elapsed. To use this mode of operation, set `irqmode` to
`2` and write a timeout in nanoseconds to `completion_nsec`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 34 ++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 63 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index fd309fc17e66..83b474f6da60 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -25,11 +25,15 @@
         kstrtobool_bytes,
         CString, //
     },
-    sync::Mutex, //
+    sync::Mutex,
+    time, //
 };
 use macros::{
+    configfs_attribute,
     configfs_simple_bool_field,
-    configfs_simple_field, //
+    configfs_simple_field,
+    show_field,
+    store_number_with_power_check, //
 };
 
 mod macros;
@@ -56,7 +60,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec\n")?;
         Ok(writer.bytes_written())
     }
 }
@@ -79,6 +83,7 @@ fn make_group(
                 rotational: 2,
                 size: 3,
                 irqmode: 4,
+                completion_nsec: 5,
             ],
         };
 
@@ -94,6 +99,7 @@ fn make_group(
                     disk: None,
                     capacity_mib: 4096,
                     irq_mode: IRQMode::None,
+                    completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
                 }),
             }),
@@ -106,6 +112,7 @@ fn make_group(
 pub(crate) enum IRQMode {
     None,
     Soft,
+    Timer,
 }
 
 impl TryFrom<u8> for IRQMode {
@@ -115,6 +122,7 @@ fn try_from(value: u8) -> Result<Self> {
         match value {
             0 => Ok(Self::None),
             1 => Ok(Self::Soft),
+            2 => Ok(Self::Timer),
             _ => Err(EINVAL),
         }
     }
@@ -125,11 +133,22 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             Self::None => f.write_str("0")?,
             Self::Soft => f.write_str("1")?,
+            Self::Timer => f.write_str("2")?,
         }
         Ok(())
     }
 }
 
+/// Wraps [`time::Delta`] to render the value as a bare nanosecond count for
+/// configfs attributes that historically used this format.
+struct DeltaDisplay(time::Delta);
+
+impl kernel::fmt::Display for DeltaDisplay {
+    fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
+        f.write_fmt(kernel::prelude::fmt!("{}", self.0.as_nanos()))
+    }
+}
+
 #[pin_data]
 pub(crate) struct DeviceConfig {
     #[pin]
@@ -144,6 +163,7 @@ struct DeviceConfigInner {
     rotational: bool,
     capacity_mib: u64,
     irq_mode: IRQMode,
+    completion_time: time::Delta,
     disk: Option<GenDisk<NullBlkDevice>>,
 }
 
@@ -174,6 +194,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.rotational,
                 guard.capacity_mib,
                 guard.irq_mode,
+                guard.completion_time,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -189,6 +210,13 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_bool_field!(DeviceConfig, 2, rotational);
 configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
 configfs_simple_field!(DeviceConfig, 4, irq_mode, IRQMode);
+configfs_attribute!(DeviceConfig, 5,
+    show: |this, page| show_field(DeltaDisplay(this.data.lock().completion_time), page),
+    store: |this, page| store_number_with_power_check(this, page, |data, value: i64| {
+        data.completion_time = time::Delta::from_nanos(value);
+        Ok(())
+    })
+);
 
 impl core::str::FromStr for IRQMode {
     type Err = Error;
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index dd7a30519870..3e7a47e6d0e5 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -28,6 +28,15 @@
         Arc,
         Mutex, //
     },
+    time::{
+        hrtimer::{
+            HrTimerCallback,
+            HrTimerCallbackContext,
+            HrTimerPointer,
+            HrTimerRestart, //
+        },
+        Delta,
+    },
     types::{
         OwnableRefCounted,
         Owned, //
@@ -59,7 +68,11 @@
         },
         irqmode: u8 {
             default: 0,
-            description:  "IRQ completion handler. 0-none, 1-softirq",
+            description:  "IRQ completion handler. 0-none, 1-softirq, 2-timer",
+        },
+        completion_nsec: u64 {
+            default: 10_000,
+            description:  "Time in ns to complete a request in hardware. Default: 10,000ns",
         },
     },
 }
@@ -79,6 +92,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         let mut disks = KVec::new();
 
         let defer_init = move || -> Result<_, Error> {
+            let completion_time: i64 = module_parameters::completion_nsec.value().try_into()?;
             for i in 0..module_parameters::nr_devices.value() {
                 let name = CString::try_from_fmt(fmt!("rnullb{}", i))?;
 
@@ -88,6 +102,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     module_parameters::rotational.value(),
                     module_parameters::gb.value() * 1024,
                     module_parameters::irqmode.value().try_into()?,
+                    Delta::from_nanos(completion_time),
                 )?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -111,10 +126,17 @@ fn new(
         rotational: bool,
         capacity_mib: u64,
         irq_mode: IRQMode,
+        completion_time: Delta,
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
-        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
+        let queue_data = Box::new(
+            QueueData {
+                irq_mode,
+                completion_time,
+            },
+            GFP_KERNEL,
+        )?;
 
         gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
@@ -127,15 +149,43 @@ fn new(
 
 struct QueueData {
     irq_mode: IRQMode,
+    completion_time: Delta,
+}
+
+#[pin_data]
+struct Pdu {
+    #[pin]
+    timer: kernel::time::hrtimer::HrTimer<Self>,
+}
+
+impl HrTimerCallback for Pdu {
+    type Pointer<'a> = ARef<mq::Request<NullBlkDevice>>;
+
+    fn run(this: Self::Pointer<'_>, _context: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+        OwnableRefCounted::try_from_shared(this)
+            .map_err(|_e| kernel::error::code::EIO)
+            .expect("Failed to complete request")
+            .end_ok();
+        HrTimerRestart::NoRestart
+    }
+}
+
+kernel::impl_has_hr_timer! {
+    impl HasHrTimer<Self> for Pdu {
+        mode: kernel::time::hrtimer::RelativeMode<kernel::time::Monotonic>,
+        field: self.timer,
+    }
 }
 
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = KBox<QueueData>;
-    type RequestData = ();
+    type RequestData = Pdu;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
-        Ok(())
+        pin_init!(Pdu {
+            timer <- kernel::time::hrtimer::HrTimer::new(),
+        })
     }
 
     #[inline(always)]
@@ -143,6 +193,11 @@ fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool
         match queue_data.irq_mode {
             IRQMode::None => rq.end_ok(),
             IRQMode::Soft => mq::Request::complete(rq.into()),
+            IRQMode::Timer => {
+                OwnableRefCounted::into_shared(rq)
+                    .start(queue_data.completion_time)
+                    .dismiss();
+            }
         }
         Ok(())
     }

-- 
2.51.2


