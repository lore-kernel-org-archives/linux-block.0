Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE92E92B7;
	Sun, 15 Feb 2026 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199186; cv=none; b=uOauQ4STyU58i6te8QOqgOAEsh8yZ3Zd3V6PWrLhg4ETbZ3Lc2109iROJSaRfXKHAbPb4gBHgYnNxfw9v9LiXITZFy3rALX80ANtkVDwHfNSOfW+pY643t2UWGbx5CN8LDn4FzGDktqilHMJc/XNSPJRJKK4ye1jE7P04UBVUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199186; c=relaxed/simple;
	bh=KwNsjS9BksChOKWlphQ7tBX5Ukevdabgk4N9RSuoPnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cjzn4OtMpHf/vbT7i9S1LCODQtIQcvspfSskhsxdCRB3aW0DYuGS8TUKmu3JxigfIr5rgQoJPHDa8DRZyWWFFSmhBnSHp9zcFEMsSwwRZa/1tHAH/dd7B8RtbZf0DCje2SGvxGpQ41X12GXwvFJIeuFxdYzgPccN+OHp2hMwAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt2dauBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt2dauBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980BCC4CEF7;
	Sun, 15 Feb 2026 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199185;
	bh=KwNsjS9BksChOKWlphQ7tBX5Ukevdabgk4N9RSuoPnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tt2dauBM/91ZcwHIxNjZy56t8ADRDk73M1R5xgyoFIhLuLmwJmT3LGC5PHQHKrRZU
	 UHEMd0NMajM/5cKHDRp50D0h0NngwdfrnD5Gap/LYFz1aW9lktQkW8EPg9j97g9TwP
	 Gcb8+JNOW7U8Gxsr5pJ6Cq+V9Xbmb2v6c6s7Ub6pAzjGLbpJWQ2f1R62YGKpCAVWME
	 ICQIpspC0YXkYRMeFUPjz+mi3UBrNgjteaVDgCAYR7/+xDO0EFkYlXrYxMG8M6XdCX
	 ZLiSWePHfLfXqWmTb9XyN4MPms6F3pxrawtqc67a6UB+m9/r6Vz5lWyEkj8CLW4v1b
	 SGGBfz54SbOew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:28 +0100
Subject: [PATCH 41/79] block: rnull: add blocking queue mode
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-41-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KwNsjS9BksChOKWlphQ7tBX5Ukevdabgk4N9RSuoPnU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhAAmONZuTCFAmTy2QHtO/6KeA3aonRqhccD
 uZyYAiEM3SJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYQAAKCRDhuBo+eShj
 d/SdD/4xA7LPhW3edXP28x48xx8Oy40JA8mu40mUSF5x2Tm15UWJyOC4BFixM90yuvg4wTo2zbM
 5FjABT+A3GA1+BGStHP8qJFkr/LlankpKRWlAp5QS1fwzoNxiFBtmAzXpEppDrjRCdjb5IO+sTn
 0A5pcAJmZCRVPib8vlo5SxL3+A2VBpRxM0BLRiKqgmwDOUoeJxUfMq64NTn21Xyg7QpFKiJuIG1
 U5KaR5sY1hftYG38q+wQr2sVXEClQ1+x26DhrIsrneB9Rfr89n36u1ZtawLYg6R64d9xOgsz5Dy
 CN407ZNK5zGV4OjZVjkHlDK8n950RY/ZRevXXR6IOe07+ymK9yx311faO5rpu+VWEdxBKR6QT+C
 TWIxrxkT60DXJreOUhL8cnuLfgOhMx6hTBZO0ymjY+kULDyHYZ30QgZxVZkFfNywjxSUCGOMGXK
 o3jxI4/LUHD8A0tZF50UjiewRjVny1ZvKe5ToPQsRynbkxfzyJrQR07uq3QraGzA9ePn3bn+nZc
 eFBxwbD2XGyR2cwVAf4hjpQBQjj1GpldPiBqwUSW7Ar7j7kRG0+gGjaB+Vh6HRMAZwRt5Y+Ly6G
 SBJo8EI5oMVDXucaXmjm0FLx6TtARqzZXTGvr5SW1QfCF7UgcJGhNRr+q7FqMGqdJWkl+dMoRif
 og+WAb8NDQS7JeQ==
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
index d369d8b683c61..640e3de230c0a 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -70,7 +70,7 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
-             submit_queues,use_per_node_hctx\n",
+             submit_queues,use_per_node_hctx,discard,blocking\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -106,6 +106,7 @@ fn make_group(
                 badblocks_partial_io: 14,
                 cache_size_mib: 15,
                 mbps: 16,
+                blocking: 17,
             ],
         };
 
@@ -138,6 +139,7 @@ fn make_group(
                     )?,
                     cache_size_mib: 0,
                     mbps: 0,
+                    blocking: false,
                 }),
             }),
             core::iter::empty(),
@@ -203,6 +205,7 @@ struct DeviceConfigInner {
     cache_size_mib: u64,
     disk_storage: Arc<DiskStorage>,
     mbps: u32,
+    blocking: bool,
 }
 
 #[vtable]
@@ -243,6 +246,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 bad_blocks_partial_io: guard.bad_blocks_partial_io,
                 storage: guard.disk_storage.clone(),
                 bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
+                blocking: guard.blocking,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -462,3 +466,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 );
 
 configfs_simple_field!(DeviceConfig, 16, mbps, u32);
+configfs_simple_bool_field!(DeviceConfig, 17, blocking);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 16a4f915e59f4..cfc00c104d9ca 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -141,6 +141,10 @@
             default: 0,
             description: "Max bandwidth in MiB/s. 0 means no limit.",
         },
+        blocking: u8 {
+            default: 0,
+            description: "Register as a blocking blk-mq driver device",
+        },
     },
 }
 
@@ -187,6 +191,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     bad_blocks_partial_io: false,
                     storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
                     bandwidth_limit: u64::from(*module_parameters::mbps.value()) * 2u64.pow(20),
+                    blocking: *module_parameters::blocking.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -218,6 +223,7 @@ struct NullBlkOptions<'a> {
     bad_blocks_partial_io: bool,
     storage: Arc<DiskStorage>,
     bandwidth_limit: u64,
+    blocking: bool,
 }
 
 #[pin_data]
@@ -260,6 +266,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             bad_blocks_partial_io,
             storage,
             bandwidth_limit,
+            blocking,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -267,7 +274,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         // TODO: lim.features |= BLK_FEAT_WRITE_CACHE;
         // if (dev->fua)
         // 	lim.features |= BLK_FEAT_FUA;
-        if memory_backed {
+        if blocking || memory_backed {
             flags |= mq::tag_set::Flag::Blocking;
         }
 

-- 
2.51.2


