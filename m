Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41552E92B7;
	Sun, 15 Feb 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199191; cv=none; b=acnKk9zNDLUxau5vSmnWfNm9EGeI1OJxjNwCIG1vrvzyZpdfOHjvQetScQnj60ywVXimBbqsFFaKWLBxMDgbKNOD29LhDa+dzmcvhAPNrwD2NtsYcVO7sVDi3BJPjCuJ7A+oRy0pZtp6JOCbU8N1h4Ttog+HE3JAQqb9RS6F0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199191; c=relaxed/simple;
	bh=APKT03ZiQU135E3WUwHyPYiO1viCqNZ5coeNcIBfq84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ie3w/NdmyXlFs7B+EtQIYdLe19P/4rI3aHi+S9XoyBwZbO9USuER/HdzSQnzMk2Al6RHY5WP4l5EdUi6q/68DKMDu4lgrVPJ8PPhaNY21AS1Y1QqQklH6zN3R8r5NNvJEaKSHdjeJ5K1EsWiIwqpa1vrZziPBa/2oBdfF0rsBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgADxpSr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgADxpSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCEC4CEF7;
	Sun, 15 Feb 2026 23:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199190;
	bh=APKT03ZiQU135E3WUwHyPYiO1viCqNZ5coeNcIBfq84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HgADxpSrEK++iloNXm0dnv+lPw8PVJH6rkUFydSeWsUY3/vjJ7KQzLcayU1lcgIjr
	 Peoe0Ghk8slIlwenivzdI5Z6QI8vSefKN+hFcJP6jzjYtIgsAeOKMWu/0t+9ZJuQIj
	 XCQLAuAavYqo3FyRh5jcob4tOdrSrvbSF4RENPBNaaDOMqUUeWvZ/0TKFKyIiU+pJD
	 O18RmlfqA+4HUxYEuKNhnpZ5vDSHmiK0NsYqk6+hv+50SW70K+hNzCSrRxcq6JoaWT
	 JSNm1Zrr9uRP9arGCa9VkHkv/EBo++kVwqlNVSww3kjVdNqTAqizOKVS8jGJQyiuBf
	 3WUMyModOsOLg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:02 +0100
Subject: [PATCH 75/79] block: rnull: allow configuration of the maximum IO
 size
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-75-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3986; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=APKT03ZiQU135E3WUwHyPYiO1viCqNZ5coeNcIBfq84=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhfgXdxK7ttXIOY8hQZaSYd5Mu4euKOGaiXx
 5uLWTbYb22JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYXwAKCRDhuBo+eShj
 d40HEACZ5T4gkVkYvJNBnOSrIznKGWvjkIyhCyZHxOH9+g7Y0MC6tHeoEYprX5ajdXLwiM57ykV
 20YFMSaXWARI/zRNd0iBhRfr2sLliHiEAjhALtiU/exWz84ntqj7x91LQfT68LO2ssjRBhvqW2O
 DYM9rEfZqTmuCK1cBFkFWPAmcZ0xaZGncNLwz5sK5mgrlydVPiYj/rjQI70Jk/IozMq2lVnn8ol
 mdx4uQnQ6SneDipQdYxwbHO5fULYmB6KzyVvu/7H5J+nKpwyvJZj6AoJ3XcnutJNMuIH9TwLrH9
 DzM6h0CHQI0Oufl1qnf8mZ0cV/pnKKCPE6LftOZ1rAFQ6rvKJPVBOJWLxbJlIvlxqOERfHWyGdY
 QV+1Bt75TnNe2nufG3fkconWds293dATdw0C625tXnqC7ybMqWuXCYY9v9aRm7GQ/r/814TuHGG
 SljZZ1Dh2d+I3fl2I0exPjJAREe7FQ6nQVggS7sh7w94+g7oypSNUz/QNrm3VnCZE33gkE+/QM6
 a6cDED5Iqkm8vHEkr0+kK9cmufDBHfU47j+XDBLPNTi5Ro7t0T5tlFbX6ee8+kGftqnU2/p5kN0
 wmpNcSwKJ7vTiJICdhewvzxAlmuHHosKs18vhHQ0/PTGuknXPTOBLb1Ef7+fdJ7ZIsCadz1Ry0C
 ilaIYwkI9anAQuQ==
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
index b449ac882d961..9eaace8b4257e 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -122,6 +122,7 @@ fn make_group(
                 zone_append_max_sectors: 26,
                 poll_queues: 27,
                 fua: 28,
+                max_sectors: 29,
             ],
         };
 
@@ -208,6 +209,7 @@ fn make_group(
                     requeue_inject,
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     init_hctx_inject,
+                    max_sectors: 0,
                 }),
             }),
             default_groups,
@@ -290,6 +292,7 @@ struct DeviceConfigInner {
     requeue_inject: Arc<FaultConfig>,
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     init_hctx_inject: Arc<FaultConfig>,
+    max_sectors: u32,
 }
 
 #[vtable]
@@ -347,6 +350,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 init_hctx_inject: guard.init_hctx_inject.clone(),
                 #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                 timeout_inject: guard.timeout_inject.clone(),
+                max_sectors: guard.max_sectors,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -624,3 +628,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     },
 }
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
+configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index b2b089a657f12..495a810f4f4e1 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -206,6 +206,10 @@
             default: 1,
             description: "Enable/disable FUA support when cache_size is used. Default: 1 (true)",
         },
+        max_sectors: u32 {
+            default: 0,
+            description: "Maximum size of a command (in 512B sectors)",
+        },
     },
 }
 
@@ -282,6 +286,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     )?,
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
+                    max_sectors: *module_parameters::max_sectors.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -336,6 +341,7 @@ struct NullBlkOptions<'a> {
     init_hctx_inject: Arc<FaultConfig>,
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     timeout_inject: Arc<FaultConfig>,
+    max_sectors: u32,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -407,6 +413,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             init_hctx_inject,
             #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
             timeout_inject,
+            max_sectors,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -502,7 +509,8 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
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


