Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12584D8DB6;
	Tue,  9 Jun 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032364; cv=none; b=EAi2kcq0AyP4z7+WeCDOFMRvsSobCSb/VAcc/0pSNnNbnK7te6GPwZJm4gGR0iNoogO2lyXk6zasRr0zSSIV/tVeukRitWToN3q4J9NjZT5c3GSifxstD9ZI5mTU+PNnQOtZ81odv7+WbqH6GL7kxDttR3kGFrQUC8JaVypgohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032364; c=relaxed/simple;
	bh=JQ3kG/WGGmu6/EYTDHQbX/u4S5Z3d/R/pgMZd3cP0HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aScR0FAWQy7smwgDF6IZUA4l3eGK9qNQcyzpWeevojm1KvfoLPKut2BVlGai23d+44NxlAZAgk7i9g2n84Tni8mlf2EypjZrFHpDLWFIWmWcZgsb1STXEijlbxlcUd6Ea17ng6gfztKoONv2QpGdBXF93A+cF5tQv+NvwQJZM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy16hqjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy16hqjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EAE1F00898;
	Tue,  9 Jun 2026 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032362;
	bh=z9SH0w8iIvKNdd0B99CMlOWkeY6yYgzCEx1TAgow6z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dy16hqjQw2Mog1tvdwcHBgxNe6GgyDQM9lfuJiH/uSL8HAFAWfLPU6tA8x9VRqQwd
	 k+3SzKdu754K2Qb2Vyyl+iCqoQz5wlixX76y9mxsGH+LOLu23YCNSnl2t0wBebYnRz
	 oF/vaWFXAdOFWQX3Zl5UAFkKbK2R5pR9gPPIkKpTpEpNhwjhrh0XOrnay2hDQYlF3m
	 BIi2jA5ulZsvWpQsOrZmxd2LWCfCbHRd5+N3kYu+LV783dC4sl4qhmAHF40BN7rfBB
	 Jjg+bT3idl2VsnrwL9xR2aaZUsQu3DLq1qcvG9nTflg/a20RuBa7EpB/Rn6NLLWVh6
	 Q9NcMxrDuw+cw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:58 +0200
Subject: [PATCH v2 79/83] block: rnull: allow configuration of the maximum
 IO size
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-79-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3966; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=JQ3kG/WGGmu6/EYTDHQbX/u4S5Z3d/R/pgMZd3cP0HQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT8rNaIp8s3qv+4COUoMMnibZPjUIMIFeJDh
 oso6l2MqniJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk/AAKCRD6UCkIqsW9
 0PsFD/4xE6M+uoXN4PZ2IfrksGAEmNVSk7zRi9n1KitGIRUO+UXtc5+N2QRfjVe6sYx7Tp7EqAs
 RWiPCK8XoQeu59WSbcfLQ6Uiw6+OnhcWG4IDQbZeiAmkq5lLXGEMMjjCFXyVE/P2oXHqkSHL65u
 mDxAorO3h2M2aPim/kUBZ+OYSg4flgEeSi6cQlnv/O5PjQwJpDiQVAs4n5gcq6M39Iayt3dZWgv
 JO4rZFnYQNdCiVv5rO4clM2Y0y+V5YHquDcJvYq0Oq3PkNhSh8qeJ63Qe/2H/6rhoc/GaNlzGQp
 o2UVDDj3YdOvRIiUJrbMTZeTzySTO6BhLPRqXnreFIoK3Ek7loiI2whFBNS5OiOa8lqgwuWg5WS
 ZDcru6GX3keiMByCTYc5cBeicOZE7LVFuTxIk/kpX85QvuOc2Egr2xcgF9za/QGg2hTJ+zF/Ary
 OWqTvc335xTd7d6HXnj0Ab2Guam7+eCfzPNROf3FkFhh0fFO+T3U6AKk7/s73rIttGmhrGCX4sl
 HNulUFvD1lcl6anYjUPepd7whnquIe0VJKe4iy06/U3LG/vQo7Y20FXtVs9roAu63NfhByKGIaY
 bJ6U/vhYVBd/Edt5kZth5o2Zv2P/vSkHHDxXS8uwwqkdeevhuVh8vvI/I9K/xkmHUlm97NHGq0S
 /IRjhjK6XdwyWCA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add module parameter and configfs option for controlling the maximum size
of an IO for the emulated block device.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  5 +++++
 drivers/block/rnull/rnull.rs    | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index eaa7617e5ffa..5ab217e43e2b 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -132,6 +132,7 @@ fn make_group(
                 zone_append_max_sectors: 26,
                 poll_queues: 27,
                 fua: 28,
+                max_sectors: 29,
             ],
         };
 
@@ -219,6 +220,7 @@ fn make_group(
                     requeue_inject,
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     init_hctx_inject,
+                    max_sectors: 0,
                 }),
             }),
             default_groups,
@@ -312,6 +314,7 @@ struct DeviceConfigInner {
     requeue_inject: Arc<FaultConfig>,
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     init_hctx_inject: Arc<FaultConfig>,
+    max_sectors: u32,
 }
 
 #[vtable]
@@ -384,6 +387,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 requeue_inject: guard.requeue_inject.clone(),
                 #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                 timeout_inject: guard.timeout_inject.clone(),
+                max_sectors: guard.max_sectors,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -612,3 +616,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     },
 }
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
+configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index f909360ec70d..15b8c365b9fa 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -204,6 +204,10 @@
             default: true,
             description: "Enable/disable FUA support when cache_size is used.",
         },
+        max_sectors: u32 {
+            default: 0,
+            description: "Maximum size of a command (in 512B sectors)",
+        },
     },
 }
 
@@ -307,6 +311,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     requeue_inject: Arc::pin_init(FaultConfig::new(c"requeue_inject"), GFP_KERNEL)?,
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
+                    max_sectors: module_parameters::max_sectors.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -352,6 +357,7 @@ struct NullBlkOptions<'a> {
     requeue_inject: Arc<FaultConfig>,
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     timeout_inject: Arc<FaultConfig>,
+    max_sectors: u32,
 }
 
 #[pin_data]
@@ -487,6 +493,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             requeue_inject,
             #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
             timeout_inject,
+            max_sectors,
         } = options;
 
         let memory_backed = tag_set.memory_backed;
@@ -548,7 +555,8 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             .physical_block_size(block_size_bytes)?
             .rotational(rotational)
             .write_cache(storage.cache_enabled())
-            .forced_unit_access(forced_unit_access && storage.cache_enabled());
+            .forced_unit_access(forced_unit_access && storage.cache_enabled())
+            .max_sectors(max_sectors);
 
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         {

-- 
2.51.2


