Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4C4D2EE9;
	Tue,  9 Jun 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032314; cv=none; b=QbPNV1hNVrdSXGvrxAtXA2CTbLlJ0oNsSgfc5Ss5sNhSe20kjdUd7G8g4rTk7BK0LvTnKMeKUD6RBcRNtdUXoBDD0vFd2oBcuSKQOcewFondcAsi1lhh7Nwhkh8gZbrgrbDia7ATHezWKm9rP+/nb5wTtycmMq2i7mVORDYAcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032314; c=relaxed/simple;
	bh=aC+DAIoXKVhLZjQ6VtxK/CU+nypY/dW+t6e//OC/LfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ST0t+Q858cGPYXkX5ZwwKifaHaRrMrzyQTK7b9LLUj6NLjqAIfVAq2526cqzTFtZTY4jueeTreY2+JZv4MeKaXXU8pT/b6pUXbpSolppXMgaz/18Yd5WcMkUIDH3nP0iIRUdBTmcZp4iot9gvc73y9sBA4D7AzvXGx6v6pb+4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBqeDFBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBqeDFBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8E21F00893;
	Tue,  9 Jun 2026 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032313;
	bh=LG6tMe5IWSj2wlms7qY7Y93GPHV0FPQd/hj6Ivr47HU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BBqeDFBO6IhOZgXsVP1UWzizuRgZi3kU7sfun64CmXti2K6oPjtIBK9ig3BdDxI99
	 cF7sX5GSOB9a6RMswzwGJ7G7wZWyz/OfM3ww7kqrGDbMJUrfhm2MfUAy4dhiIJfUv9
	 lxKN4uCMP2DKqoRBLiWW+W+lxD3bzRPoS1unHHzrTSIUA5h5UlVsTL+dXBA1j4FZLV
	 rMUy57xguGXz2SWZBBNK+OUjIdOGj04TXu2YFAKrqi0ypCd7uemPexNeQWMWarv446
	 GXbWEZYV7iPTK5o/ZILzn8GsZmANF8B20sLgQqjMB8ZeqEKOEZdqbn6/zR5YMgJkYr
	 bqqCWK/4xzSTA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:09:01 +0200
Subject: [PATCH v2 82/83] block: rnull: add `shared_tag_bitmap` config
 option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-82-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5599; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=aC+DAIoXKVhLZjQ6VtxK/CU+nypY/dW+t6e//OC/LfI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT+NlnHQn5rbaLOqNWNJZ4pO68g/2hZz04u7
 eduX1XgsBqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk/gAKCRD6UCkIqsW9
 0PeWD/90gWv84QyKgx1/RYvYIvXyS8hP7dIG5obg9kqAuuG0GqZasGqXWQwPi7fElVX7xT3U2jr
 HPB7ByYGppRrwvyHt6ai6tGJAAY8No0tir/Lf5sW+HIZy4rJmWSid+N9fhnWj0yft0TGKqmMx/v
 ucDqJO9i3hfO6qGo/0nFAgB2f4ao7DZ66A3Z494exLc3UvYGIbhgo6Ux1GcY8EZvKmD4Sz2mKDq
 U7Sgv/YbBaacDWVZSopGuy6V3KwESVPjmEUFwVaXxKvgK5enyB+DryohgVsTKzrcZB2Kxi0dIoT
 42UzjEo+Kw6pNiADr2FvTSzmGfpdGbJta9bdVt/ehnJPf4RYMiaASV3JkY1W5bhaUtqyU6nsvca
 YnW0ymLhTvxVkaaUHODoEyhbMYRpPKoDd/VYXcW37a/QATqEYS0NX5O9j8j/H55gpDRt/SiN9qc
 BsTP/kqQAk3962iTwxTiDEeNfcGbZ/jSszC4svAyMcqMC21DBdq41SrV8fhKOeigFaWuzeilq9U
 PO6lsfFeREpMMJkPbT8hyElT3qnFzQ4qk7MgfpEp+XqZCqyFqKnISg+ECIm8gwcsEYFD3FNukZk
 gqKc75NFApUc40oqvG4e76V8QyYJNVoK6Tg38XcH59mRvwQibccjYe/xcrGVJ7MGeTZmzB4Zo9T
 rtv+TYGXxJnL7zg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute and module parameter to enable the
`BLK_MQ_F_TAG_HCTX_SHARED` flag for the rnull tag set. When enabled,
a tag bitmap is shared across all hardware queues.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs       |  5 +++++
 drivers/block/rnull/rnull.rs          | 12 ++++++++++++
 rust/kernel/block/mq/tag_set/flags.rs |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 3e054339226c..1bab38c55698 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -134,6 +134,7 @@ fn make_group(
                 fua: 28,
                 max_sectors: 29,
                 virt_boundary: 30,
+                shared_tag_bitmap: 31,
             ],
         };
 
@@ -223,6 +224,7 @@ fn make_group(
                     init_hctx_inject,
                     max_sectors: 0,
                     virt_boundary: false,
+                    shared_tag_bitmap: false,
                 }),
             }),
             default_groups,
@@ -318,6 +320,7 @@ struct DeviceConfigInner {
     init_hctx_inject: Arc<FaultConfig>,
     max_sectors: u32,
     virt_boundary: bool,
+    shared_tag_bitmap: bool,
 }
 
 #[vtable]
@@ -374,6 +377,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                     blocking: guard.blocking,
                     memory_backed: guard.memory_backed,
                     no_sched: guard.no_sched,
+                    shared_tag_bitmap: guard.shared_tag_bitmap,
                     hw_queue_depth: guard.hw_queue_depth,
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     init_hctx_inject: guard.init_hctx_inject.clone(),
@@ -622,3 +626,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
 configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
 configfs_simple_bool_field!(DeviceConfig, 30, virt_boundary);
+configfs_simple_bool_field!(DeviceConfig, 31, shared_tag_bitmap);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 147dc8498c3a..81f9e2d03f31 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -216,6 +216,10 @@
             default: false,
             description: "Set alignment requirement for IO buffers to be page size.",
         },
+        shared_tag_bitmap: bool {
+            default: false,
+            description: "Use shared tag bitmap for all submission queues for blk-mq.",
+        },
     },
 }
 
@@ -245,6 +249,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             let memory_backed = module_parameters::memory_backed.value();
             let no_sched = module_parameters::no_sched.value();
             let hw_queue_depth = module_parameters::hw_queue_depth.value();
+            let shared_tag_bitmap = module_parameters::shared_tag_bitmap.value();
 
             let shared_tag_set = NullBlkDevice::build_tag_set(TagSetOptions {
                 home_node,
@@ -258,6 +263,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 blocking,
                 memory_backed,
                 no_sched,
+                shared_tag_bitmap,
                 hw_queue_depth,
                 #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                 init_hctx_inject: Arc::pin_init(
@@ -300,6 +306,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         blocking,
                         memory_backed,
                         no_sched,
+                        shared_tag_bitmap,
                         hw_queue_depth,
                         #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                         init_hctx_inject: Arc::pin_init(
@@ -404,6 +411,7 @@ struct TagSetOptions {
     blocking: bool,
     memory_backed: bool,
     no_sched: bool,
+    shared_tag_bitmap: bool,
     hw_queue_depth: u32,
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     init_hctx_inject: Arc<FaultConfig>,
@@ -419,6 +427,7 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
             blocking,
             memory_backed,
             no_sched,
+            shared_tag_bitmap,
             hw_queue_depth,
             #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
             init_hctx_inject,
@@ -441,6 +450,9 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
         if no_sched {
             flags |= mq::tag_set::Flag::NoDefaultScheduler;
         }
+        if shared_tag_bitmap {
+            flags |= mq::tag_set::Flag::TagHctxShared;
+        }
 
         let queue_config_guard = queue_config.lock();
         let submit_queues = queue_config_guard.submit_queues;
diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
index 2561d7090c49..afc9d31ed998 100644
--- a/rust/kernel/block/mq/tag_set/flags.rs
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -21,5 +21,9 @@ pub enum Flag {
         /// Select 'none' during queue registration in case of a single hwq or shared
         /// hwqs instead of 'mq-deadline'.
         NoDefaultScheduler = bindings::BLK_MQ_F_NO_SCHED_BY_DEFAULT,
+
+        /// Use shared tag bitmap for all submission queues.
+        TagHctxShared = bindings::BLK_MQ_F_TAG_HCTX_SHARED,
+
     }
 }

-- 
2.51.2


