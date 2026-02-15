Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C2EA732;
	Sun, 15 Feb 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199066; cv=none; b=mSB4gyr6jrxD/qppTWz2JjSL9YbqK8/Aev8qUfS9CkG75UVK+ls27uCl6EaN9zMQaDH+FJcrycSEsSxOPgSIDGNjtMnGabw+Jl8KiIJpxsz8cNPsKsz/q/RBZ+bxhhKHxMDP4yFCMqPeql7zNU6wAFphfJ75i8DZ0oyUCCnLDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199066; c=relaxed/simple;
	bh=enMteMP5s8/CfnF3wWbknhPBzI+BpA10sTDrdile/IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9WSPpe4ZdC3NFJsJZ2g34PhT/6KEn0xIXHdXcTTRAfNqM+vy+UJ2eQDiK0IDj7jmqhVtaeeYAW4ObYU8iQn8YHzGrU/jL/ks7DsnUAv0EydHqRBLMbI6zt9NQQDCuoxh+Cvf7GMsOo9+yo8DPMfHTO1M/wPgc0qlSBIzgRUP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi7zEjiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi7zEjiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31973C4CEF7;
	Sun, 15 Feb 2026 23:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199066;
	bh=enMteMP5s8/CfnF3wWbknhPBzI+BpA10sTDrdile/IM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fi7zEjiXHEcQox5CSzxIu8gEQJNU3drOgLK/ZCUnUl8SRgsygu9o8tlBmDwqzN7tC
	 WWOO4630doCXhemOiYg7oNF2HkVI51FL87JWKO0/H31u+sIF/7pkYT9R+tPZKZmm5C
	 Gj188GWSPqXoNqPlP6pRJacUEs/A1Abnb22H7f2WhTwJuJTZBSTV4gg8d10aVwyGgS
	 5hJGDBtIgGONZoc4kRRhR358KqdtkaJJYrQJ4zqSLOQ/nwHjSZ4BP5sB9aMPuBxI6N
	 WFeTuesNYUcZcYZO+xnMw702tACBpSU8Y3UdOToaPeyG0lu9yyBnQDd6WT3WrPBxM6
	 IVjBwkbpuJlDQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:29 +0100
Subject: [PATCH 42/79] block: rnull: add shared tags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-42-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5495; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=enMteMP5s8/CfnF3wWbknhPBzI+BpA10sTDrdile/IM=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhBL064yZgPJ9mugO4wJgGrxE2244ynwHMHH
 zlYceC/FKuJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYQQAKCRDhuBo+eShj
 d5nHD/0ZLzSQ6fLnmrRaqZcDtZxnXn5I8kL8xB9CSs7SomzddSxg5j8EqpW5yTSUgmISr2dFH51
 K6ol+CRJQU0TUhxt6cONjzsdJUQPm1Uj/U4+2yhSvj5qoA1uhrw68M49v+XQ70f3IAWj8jukCwc
 crCE8EZqgAd7BBtAxM8g/0yHpTnZdODTIsbEOS0r5oKT4dJ3wuPDWzTw/qk2BlYK/sccOj8wLFJ
 7Ah1FukNn1a921F1Ol+GUn7ZoHWV4XNImSRK/vF79N02eP8VsqvoIRbXpDgM6wsSN/iDmsxCxB8
 oLltq6SzHTb7D2bGrgkKN4Vby9JxE8mEpmDrrRiumUJ9nXPBbAmhZdchS+vgrIWMWscFzeDjy0k
 MnG6aHC7k9+FXMShBK2L3F+Lt9HzGkiknV79V0yLZp25awM1pZFXk+pFHyyJL8iu+9DNMpjo4gP
 ksm1M+bZtwiaclKVUIGRMMsCUG0oemikiJIyW6jaNrHMqRHdlzvK0ofkWd1MShzrbTs/pvM1yUf
 DEAWbp7M+t41QAppAgnT98WO8RI2jz7XVS99IDcCZu1hPxINxl/j1kEFD1Rau6O99fRYb0QXWu2
 MQ3jxj/5M8PdkSBMdU71L+5fv7p/+FiNhlkwnYnd4Qw5UyiWgwPd86SS6X7nIgXWGJZDNqVWe30
 x1YFdvqTGyvgVzg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for sharing tags between multiple rnull devices. When
enabled via the `shared_tags` configfs attribute, all devices in the
group share a single tag set, reducing memory usage.

This feature requires creating a shared `TagSet` that can be referenced
by multiple devices.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  7 ++++++-
 drivers/block/rnull/rnull.rs    | 25 +++++++++++++++++++++----
 rust/kernel/block/mq/tag_set.rs |  6 ++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 640e3de230c0a..d1a70fe030cb2 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -70,7 +70,7 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
-             submit_queues,use_per_node_hctx,discard,blocking\n",
+             submit_queues,use_per_node_hctx,discard,blocking,shared_tags\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -107,6 +107,7 @@ fn make_group(
                 cache_size_mib: 15,
                 mbps: 16,
                 blocking: 17,
+                shared_tags: 18,
             ],
         };
 
@@ -140,6 +141,7 @@ fn make_group(
                     cache_size_mib: 0,
                     mbps: 0,
                     blocking: false,
+                    shared_tags: false,
                 }),
             }),
             core::iter::empty(),
@@ -206,6 +208,7 @@ struct DeviceConfigInner {
     disk_storage: Arc<DiskStorage>,
     mbps: u32,
     blocking: bool,
+    shared_tags: bool,
 }
 
 #[vtable]
@@ -247,6 +250,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 storage: guard.disk_storage.clone(),
                 bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
                 blocking: guard.blocking,
+                shared_tags: guard.shared_tags,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -467,3 +471,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 
 configfs_simple_field!(DeviceConfig, 16, mbps, u32);
 configfs_simple_bool_field!(DeviceConfig, 17, blocking);
+configfs_simple_bool_field!(DeviceConfig, 18, shared_tags);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index cfc00c104d9ca..84e75a7042214 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -145,6 +145,10 @@
             default: 0,
             description: "Register as a blocking blk-mq driver device",
         },
+        shared_tags: u8 {
+            default: 0,
+            description: "Share tag set between devices for blk-mq",
+        },
     },
 }
 
@@ -192,6 +196,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
                     bandwidth_limit: u64::from(*module_parameters::mbps.value()) * 2u64.pow(20),
                     blocking: *module_parameters::blocking.value() != 0,
+                    shared_tags: *module_parameters::shared_tags.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -224,8 +229,11 @@ struct NullBlkOptions<'a> {
     storage: Arc<DiskStorage>,
     bandwidth_limit: u64,
     blocking: bool,
+    shared_tags: bool,
 }
 
+static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
+
 #[pin_data]
 struct NullBlkDevice {
     storage: Arc<DiskStorage>,
@@ -267,6 +275,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             storage,
             bandwidth_limit,
             blocking,
+            shared_tags,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -286,10 +295,18 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             return Err(code::EINVAL);
         }
 
-        let tagset = Arc::pin_init(
-            TagSet::new(submit_queues, (), 256, 1, home_node, flags),
-            GFP_KERNEL,
-        )?;
+        let tagset_ctor = || -> Result<Arc<_>> {
+            Arc::pin_init(
+                TagSet::new(submit_queues, (), 256, 1, home_node, flags),
+                GFP_KERNEL,
+            )
+        };
+
+        let tagset = if shared_tags {
+            SHARED_TAG_SET.as_ref_or_populate_with(tagset_ctor)?.clone()
+        } else {
+            tagset_ctor()?
+        };
 
         let queue_data = Arc::try_pin_init(
             try_pin_init!(Self {
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index f18b51e5217fe..600c9c6249123 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -106,3 +106,9 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { T::TagSetData::from_foreign(tagset_data) };
     }
 }
+
+// SAFETY: It is safe to transfer ownership of `TagSet` across thread boundaries.
+unsafe impl<T: Operations> Sync for TagSet<T> {}
+
+// SAFETY: It is safe to share references to `TagSet` across thread boundaries.
+unsafe impl<T: Operations> Send for TagSet<T> {}

-- 
2.51.2


