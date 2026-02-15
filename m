Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5E30C368;
	Sun, 15 Feb 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199026; cv=none; b=FzE9ipdQMRzcIe8ZcFOFWKuL98o8bwGvwZDLCKEuKGGd+Oz6CiVSX6wt5QAhJao4O3C6pp7LjdJmNxFhtpe2i2LogJophQJXJfARDx8KLXykExIp/t3Qi0B2uROd4o7uq/6JQfaZ4sQYD/jMTPsTKuSCCvtGWV3n1dGrCGCUH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199026; c=relaxed/simple;
	bh=hyJWmGhHnYKgGumF3acRrYQ7yD9VZFPwyaRRW4uns7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhaVWf09pPPJbd0M+Yl9zWP1V9Sn+Frw3XVAk2ZNq2vEt1lQHd32Kiktcdy1zup9pJr2b2wCvXL3T6iQOXNlPsPEhYyD/HPg9a/zdeQRp7OJ0msnE30LVch8SA7c4Sn0J13A8/osM/QzZpNFoQwocrb/TAFC+lfLq8ef+s62II4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0Xvw+Xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0Xvw+Xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD5BC4CEF7;
	Sun, 15 Feb 2026 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199026;
	bh=hyJWmGhHnYKgGumF3acRrYQ7yD9VZFPwyaRRW4uns7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r0Xvw+Xbl4WyoIV0Fgvc4CnezN4AquFYJprwOMMZ4tW2FWDP8IEMP5IspVkvapRKr
	 eyQCXlRj9nuKYDdDqQr3EeH1EDajPMZ6uvg/8RHpfiYqBCE1AUpo51WkLT2mkQWzuf
	 8yAVDEjVXa5fUyolR1WoGZg95YCrxgWlLbnDCaI5uWYLA9l/ss7OYNKWrCggl1Bfxh
	 /2MC4rdaD8XO4sPI0pN414gUY+NUp0nhQwJPAaunICom5uRzXiXKtQa0eL2W0q5vxT
	 kJ8UlGWZDBAMe6iz/mIQmb//20aycZ9d1XVZvHVp5sNncJqa79a4o8+O28Mk8KfS6M
	 O2UdjgNGNAg5Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:04 +0100
Subject: [PATCH 17/79] block: rnull: allow specifying the home numa node
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-17-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4428; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hyJWmGhHnYKgGumF3acRrYQ7yD9VZFPwyaRRW4uns7c=;
 b=kA0DAAoB4bgaPnkoY3cByyZiAGmSWCujcbaRtyQ+5c46GUtpYsZLNpV7VYMbAQXDEhY8owFWT
 okCMwQAAQoAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJpklgrAAoJEOG4Gj55KGN3ydkQAInh
 m/4xDjaLWkap0qZVw4kdG+BQcpK/gQBOgCp5aQJ9g6jpMgw7xGymCSWaXegQ/45lRH69A69dmJ9
 YevW/afwAjaK0Gy8+719L2V0WxkeUUbqtPvQP0r6h+O7HwKOEXeBp4svcMpD78XGzcaixFcTM73
 +q3wrysM6xhIEIuFJxU4aPzz5XV6a0i4Am1u+LWbWUulfmD2VQzSH/qit7F7Al2Gh/xLWAaXsz7
 mbeJOcNYaEtkyMwGIuoAAwOjcikxVvUHrAGHDVKgXx1rY7xVSAsw+GdBe+/2qKgSKKxCmiLIVzM
 Qdj9jl32dxV7g7L+SGVXd/XxSziAAft+K4g/ZY9TIw1BGIl1SzTZH+oayKtrCtHyjV45KFZ+Mor
 3A1YvvKSQtwicHPmGYKsNR3neTKoLgAR9O8uHmNol4224yieRMP7lc8HkY6MNV4zI7b/UonXR6b
 WkRDZQmScebq/brfppkcJXOKGDu9tAWj9yp7JNC3fBMGFA6WmSxIXN+cF7/Qur2tofw7IKbsWuz
 EscfebPY9qQ/gPiYBQ21h0h/Wn0Tks5pLQ9TGjlsne3xZW9didm3pGauc/h3TFaEmIsjObi5vBT
 hlLepzDjKUpTaBBiRvm5KUtk7hxb4iqtjjqxihxO7H94YIe8K90FeU4QFctgIu785HWqX6gRMky
 2c514
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to specify the NUMA node for rnull tag set
and CPU map allocations. This allows testing NUMA-aware block device
behavior and optimizing memory placement for specific hardware
configurations.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 19 +++++++++++++++++++
 drivers/block/rnull/rnull.rs    | 18 ++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index b05bfc23090c2..fe00617d2b679 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -5,6 +5,7 @@
     THIS_MODULE, //
 };
 use kernel::{
+    bindings,
     block::mq::gen_disk::{
         GenDisk,
         GenDiskBuilder, //
@@ -92,6 +93,7 @@ fn make_group(
                 memory_backed: 6,
                 submit_queues: 7,
                 use_per_node_hctx: 8,
+                home_node: 9,
             ],
         };
 
@@ -111,6 +113,7 @@ fn make_group(
                     name: name.try_into()?,
                     memory_backed: false,
                     submit_queues: 1,
+                    home_node: bindings::NUMA_NO_NODE,
                 }),
             }),
             core::iter::empty(),
@@ -167,6 +170,7 @@ struct DeviceConfigInner {
     disk: Option<GenDisk<NullBlkDevice>>,
     memory_backed: bool,
     submit_queues: u32,
+    home_node: i32,
 }
 
 #[vtable]
@@ -199,6 +203,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 completion_time: guard.completion_time,
                 memory_backed: guard.memory_backed,
                 submit_queues: guard.submit_queues,
+                home_node: guard.home_node,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -302,3 +307,17 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     })
 );
+
+configfs_simple_field!(
+    DeviceConfig,
+    9,
+    home_node,
+    i32,
+    check | value | {
+        if value == 0 || value >= kernel::num_online_nodes().try_into()? {
+            Err(kernel::error::code::EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 278f75d886fd9..fb3ce272d5bec 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -20,7 +20,10 @@
             TagSet, //
         },
     },
-    error::Result,
+    error::{
+        code,
+        Result, //
+    },
     new_mutex,
     new_xarray,
     page::SafePage,
@@ -95,6 +98,10 @@
             description:
         "Use per-node allocation for hardware context queues, 0-false, 1-true. Default: 0-false",
         },
+        home_node: i32 {
+            default: -1,
+            description: "Home node for the device. Default: -1 (no node)",
+        },
     },
 }
 
@@ -131,6 +138,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     completion_time: Delta::from_nanos(completion_time),
                     memory_backed: *module_parameters::memory_backed.value() != 0,
                     submit_queues,
+                    home_node: *module_parameters::home_node.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -154,6 +162,7 @@ struct NullBlkOptions<'a> {
     completion_time: Delta,
     memory_backed: bool,
     submit_queues: u32,
+    home_node: i32,
 }
 struct NullBlkDevice;
 
@@ -168,6 +177,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             completion_time,
             memory_backed,
             submit_queues,
+            home_node,
         } = options;
 
         let flags = if memory_backed {
@@ -176,8 +186,12 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             mq::tag_set::Flags::default()
         };
 
+        if home_node > kernel::num_online_nodes().try_into()? {
+            return Err(code::EINVAL);
+        }
+
         let tagset = Arc::pin_init(
-            TagSet::new(submit_queues, 256, 1, bindings::NUMA_NO_NODE, flags),
+            TagSet::new(submit_queues, 256, 1, home_node, flags),
             GFP_KERNEL,
         )?;
 

-- 
2.51.2


