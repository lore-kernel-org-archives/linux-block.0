Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725040C22B;
	Tue,  9 Jun 2026 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032483; cv=none; b=b8ppvdZH9isyKUwE1zdsNnEostXKKHiDUswjm++AIX/3PPhh+wDl6GOYTyK8+6s4su3aDEQu27anjEw7wrtBa5bbM2d2QQ3Ta8ctHp8nOPW42ABz9s68q1As9e8/Zd63ZtyWHJlYqp6gLhJ2j3cHjpED/vKCFJ0rFHb7XRflw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032483; c=relaxed/simple;
	bh=RiK2MFDfZueTIoC29KqxTo1erC5StZym/slB3abdziY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Clg6hyz0j70EdU6iLJykQHXgocOzy5sBSl2LcvZibiGp+30qSCOZNZhf9dIDtS6wmLPHg0ylDawai2IKALNu+8vZNkHerlYQYpM/mZ5H+zrkznlFt35utodd6nhTQwsW3bM9vfCYZqb3zuOV1bhtLkt4xhcHSdp4LCx33mdquxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6F0lnJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6F0lnJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EC61F00893;
	Tue,  9 Jun 2026 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032482;
	bh=yh/dWdgKvT0zkP6Uc7e51/m9fxvSh52AeREuWUz3HD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m6F0lnJAGS/NLRHer47scYdfbR7jhR0fJPP8y9mzicldIup+EVOxTgoiHv3hOReei
	 iNCg0ypYBdJTCsIg5js6JoOQE0YWIezzBCRQM2w95OIieOipKY1xsA81zzAaTzH81Z
	 iJW1UEHtzD7v1ZHHjKK7py8KD9lHnDvUiNcGOJQVnUsCPdLqAWoCbjNbDBYcmMEcvC
	 Yy5rAilaH1QQM7iYFNfMZoTsRIld6dZXm5eNZv74k+fZmt+bV0hKPbpQ5bfVnbX+4L
	 /j+UVHQIR2nsWsMHO+F0slrgeSE5y0aOfn+bStGbRixytYc/7CudYimCUwlmIbI1gp
	 FVTSpmMZ6ZNWg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:26 +0200
Subject: [PATCH v2 47/83] block: rnull: add queue depth config option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-47-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=RiK2MFDfZueTIoC29KqxTo1erC5StZym/slB3abdziY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTfmemXeroNyNXumJBaGxIPH3vPurRUz3Bt/
 aFVV1AUQoiJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk3wAKCRD6UCkIqsW9
 0OVPEAC1vgGJz1ZISUXdjGr19xkHpGJq9tLAlpJ+QS1EMUsAC+PCYIi91hDyDYZIJ5Xi/ppekge
 4RvZDlVOQTvD8UzQMx14InQPciiuSo1izTTyv8VCBoaNLpL6/stmmZpRwqOoGDwZcAcftl9e01r
 oB157JRV7quK8BuYsE7TpkDqZpw0CP6tqrRG+iCCAdQ0/nwmIiHLQnQfJsqSl3+uz0KbzimP2fX
 txU7vr9Ua1zV9trOfeq9I6td5NXKxdiCHqf2UUMO3qNG8/d+E/lNFYxbPj+v7Z4v/+Mo0ih+uF0
 eL2C1Hdq2DngCceeMc/FytdwQcs9PUr9EF4bqOHdr0dyavntauC335TpOPjuWwP954JGl2nK8i3
 PE3kg1gIq9TDzIowvz7aN/a4n9PMCeMcyDPUKlf0M4yX/BsDSfUIjyXeEaP52idAmtxPFUb/JIw
 HeXak9dimV1Yp56H1JQ8c86LJq0XrhLiGZxQeIW/69R0UCy4HqP7PN+XwP2K4fk0ake1G4djGi1
 TWdTJaB/02NzQyC1ZFR2fkhVf2fVZf/x5hYLA25MEskOF5JVY4YerRa0x3iAV0l8BF94zYDDFQ1
 QWZgXeq1/j/N/wTiyHPJSNSfefCKl40g+4pCjN8n30UEHVvYVeG47NJwvrwn4v6Ag6nT5EjTpde
 cInJmkYZ4C2fsWw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to configure the queue depth (number of tags)
for the rnull block device.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  5 +++++
 drivers/block/rnull/rnull.rs    | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index a84854e7c358..2dfc87dff66a 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -118,6 +118,7 @@ fn make_group(
                 mbps: 16,
                 blocking: 17,
                 shared_tags: 18,
+                hw_queue_depth: 19
             ],
         };
 
@@ -153,6 +154,7 @@ fn make_group(
                     blocking: false,
                     shared_tags: false,
                     shared_tag_set: self.shared_tag_set.clone(),
+                    hw_queue_depth: 64,
                 }),
             }),
             core::iter::empty(),
@@ -231,6 +233,7 @@ struct DeviceConfigInner {
     blocking: bool,
     shared_tags: bool,
     shared_tag_set: Arc<TagSet<NullBlkDevice>>,
+    hw_queue_depth: u32,
 }
 
 #[vtable]
@@ -274,6 +277,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                     blocking: guard.blocking,
                     memory_backed: guard.memory_backed,
                     no_sched: guard.no_sched,
+                    hw_queue_depth: guard.hw_queue_depth,
                 },
             })?);
             guard.powered = true;
@@ -447,3 +451,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_field!(DeviceConfig, 16, mbps, u32);
 configfs_simple_bool_field!(DeviceConfig, 17, blocking);
 configfs_simple_bool_field!(DeviceConfig, 18, shared_tags);
+configfs_simple_field!(DeviceConfig, 19, hw_queue_depth, u32);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index bcf6a85f1cbc..491979daa50e 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -147,6 +147,10 @@
             default: false,
             description: "Share tag set between devices for blk-mq",
         },
+        hw_queue_depth: u32 {
+            default: 64,
+            description:  "Queue depth for each hardware queue. Default: 64",
+        },
     },
 }
 
@@ -172,6 +176,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             let blocking = module_parameters::blocking.value();
             let memory_backed = module_parameters::memory_backed.value();
             let no_sched = module_parameters::no_sched.value();
+            let hw_queue_depth = module_parameters::hw_queue_depth.value();
 
             let shared_tag_set = NullBlkDevice::build_tag_set(TagSetOptions {
                 submit_queues,
@@ -179,6 +184,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 blocking,
                 memory_backed,
                 no_sched,
+                hw_queue_depth,
             })?;
 
             let mut disks = KVec::new();
@@ -209,6 +215,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         blocking,
                         memory_backed,
                         no_sched,
+                        hw_queue_depth,
                     },
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
@@ -264,6 +271,7 @@ struct TagSetOptions {
     blocking: bool,
     memory_backed: bool,
     no_sched: bool,
+    hw_queue_depth: u32,
 }
 
 impl NullBlkDevice {
@@ -276,6 +284,7 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
             blocking,
             memory_backed,
             no_sched,
+            hw_queue_depth,
         } = options;
 
         if home_node > kernel::numa::num_online_nodes().try_into()? {
@@ -297,7 +306,7 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
         }
 
         Arc::pin_init(
-            TagSet::new(submit_queues, (), 256, 1, numa_node, flags),
+            TagSet::new(submit_queues, (), hw_queue_depth, 1, numa_node, flags),
             GFP_KERNEL,
         )
     }

-- 
2.51.2


