Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC24BCAA2;
	Tue,  9 Jun 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032229; cv=none; b=QJC7gugGXpX2iWqFAcQ6QwIrfA/ySwCiuXTQLI5XcVGHu0P5HUvlvyDC5WZpGJ0M2WwrrvPZZgJk75w2HFJfHtsRC4UuLjvWOI0GYalxsn9wPlhJf90oU7dfdOIm2TBhCjNxnt2hl1851oZw2wMt3cUcHZ3UkO5RlyhgMoMsRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032229; c=relaxed/simple;
	bh=YZ/AfN8Kndq1dH1klIaGEGbAb5qaoYZQKEwqGVYQjkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/p0NCzPPFmjObgl07b9k3H039+oRzadJWuVTCezg5Rinjj7rasGFdLDIWupy4tl0sf9FWwRLj0Xpk2BmNwsKkroOupQQNaHplPl3KFi60up3UlTEtY3+ciNhLI+oPWkL5ZkD1NSnkQY6gUhIe4/VPJj1hqAZymG3Px6RROyqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyVfnxIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyVfnxIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B611F00898;
	Tue,  9 Jun 2026 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032228;
	bh=a/0/Vaq6P+ehn9fD0MH6e+Cla87NJ0pjAGFS/FD6Uz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iyVfnxITOTX17YdbikJ+OjiLKUylrJ+piLYQesB6V3/nNJ0TcR04Wh1F7wRvaDNTP
	 pbnXpydkDDpZm7HBeQKMVRrpWxoueQTtoYjkddxqV4k8yy0l5xZXuaVzvwaiJhTWya
	 vvokoPwjXD2EW+F/buj61BNjGL7VQ/XR2xMfWZNMTRKikwaHeF1jKNPBOJvChU1KuI
	 hhIooOt9bYl3ZbzXzBu+Iecm7FTafUB8N1sIleSSyQIPsBI1V9aV0tcJHdwod3kEQd
	 BOxPGksCSQqXwLLUwL87RVDIdNc/sV5JoEIj/orDNnRw8sGq9T9AHMbEhyxRB6/jrZ
	 /ZCQavcFjWhug==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:24 +0200
Subject: [PATCH v2 45/83] block: rnull: add blocking queue mode
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-45-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3831; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=YZ/AfN8Kndq1dH1klIaGEGbAb5qaoYZQKEwqGVYQjkM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTdp0x0IRIof4+hYdVikG2ZXkHe5WzQAFj+a
 fipjeP29fKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk3QAKCRD6UCkIqsW9
 0AeeD/9aLlgjZ/YxFTP6ATkG1QnKkssNiKjananf2paDujmui75oDOJ3XtOQ2+e6g0zWLX2kcr1
 UpmZ8N2wd0jDgTVnsWobBsGfGVPpbRt2UH42VQQTZARKg9PF7RxBZPOJdAFRdervRPIVVRjhd9r
 O0JF5jOwKslo9hb8uu/Cdj1rL8PMXEx6TMPUE5OwFjoR4wP21AI9vAVPvKOkdZEf1Zec5+nboXb
 4JdPTKYAdSIFEalOguSL3KTPMljFp0FKDBEAcSXvVudk2rrcSpidVhuek7Knoe1uojyFFVaj8jJ
 woGhhNWlnntQyVcGCdbkV+pDgfhEqrDF6Q8g7d8Nn1P1VbDWcMgt5ws83KUyS4Jgwg4YUUUH2gI
 bWlfm+OnGjNqTbd0o+h0gsKMXikkvLj5T6An3TeVaw7OWSLl8GuQVe+Ely/KppzmhGZgdHQHKSR
 BKYcTSWemqX+aFp5pj3IAvmhaqJD4xfZyoIuUJKV1Rn22pPecj0AcCpE70s6t3DXDsiYv/1Zptj
 Q8SXFlAqzvqpOk5zy5sXxcyY9Y0VsKWJrRbekkMZ9tmcefsc/C+snQhnBKpCbESQ4kqRULDn+tz
 yd9L2IkSk22YqTmmQDGEeTjDxLy+C6in/VrSNgQb5mtkjskynCMyCZvg6vGTPkDaBGdPyjqct7N
 Jjs6wnX/pYuGKZQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for blocking queue mode via the `blocking` configfs
attribute. When enabled, the tag set is created with the
`BLK_MQ_F_BLOCKING` flag.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 7 ++++++-
 drivers/block/rnull/rnull.rs    | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 59217d75f46b..5e6bcf9d31d8 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -69,7 +69,7 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed,\
-             submit_queues,use_per_node_hctx\n",
+             submit_queues,use_per_node_hctx,discard,blocking\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -105,6 +105,7 @@ fn make_group(
                 badblocks_partial_io: 14,
                 cache_size_mib: 15,
                 mbps: 16,
+                blocking: 17,
             ],
         };
 
@@ -137,6 +138,7 @@ fn make_group(
                     )?,
                     cache_size_mib: 0,
                     mbps: 0,
+                    blocking: false,
                 }),
             }),
             core::iter::empty(),
@@ -212,6 +214,7 @@ struct DeviceConfigInner {
     cache_size_mib: u64,
     disk_storage: Arc<DiskStorage>,
     mbps: u32,
+    blocking: bool,
 }
 
 #[vtable]
@@ -252,6 +255,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 bad_blocks_partial_io: guard.bad_blocks_partial_io,
                 storage: guard.disk_storage.clone(),
                 bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
+                blocking: guard.blocking,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -422,3 +426,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 );
 
 configfs_simple_field!(DeviceConfig, 16, mbps, u32);
+configfs_simple_bool_field!(DeviceConfig, 17, blocking);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 1dda8d717b95..181fce551a91 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -139,6 +139,10 @@
             default: 0,
             description: "Max bandwidth in MiB/s. 0 means no limit.",
         },
+        blocking: bool {
+            default: false,
+            description: "Register as a blocking blk-mq driver device",
+        },
     },
 }
 
@@ -185,6 +189,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     bad_blocks_partial_io: false,
                     storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
                     bandwidth_limit: u64::from(module_parameters::mbps.value()) * 2u64.pow(20),
+                    blocking: module_parameters::blocking.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -216,6 +221,7 @@ struct NullBlkOptions<'a> {
     bad_blocks_partial_io: bool,
     storage: Arc<DiskStorage>,
     bandwidth_limit: u64,
+    blocking: bool,
 }
 
 #[pin_data]
@@ -258,11 +264,12 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             bad_blocks_partial_io,
             storage,
             bandwidth_limit,
+            blocking,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
 
-        if memory_backed {
+        if blocking || memory_backed {
             flags |= mq::tag_set::Flag::Blocking;
         }
 

-- 
2.51.2


