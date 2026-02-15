Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E82EA732;
	Sun, 15 Feb 2026 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199230; cv=none; b=Jyhjd79JSG6OPEhfI4Kwqj0MsJNrR5uoXeKSIVO5qewiiehuOa9YjQMcB8Ui4S+4ChTCS2ME3b7gQdHJ9pd1Ix+Eq3EJXcuBCW5ggFyqRahTOvtxaaY1tbIuH4gASCca8BgUb1M5NZol5wR2p3iEKLfc7xYZxQFej+bMf0MfDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199230; c=relaxed/simple;
	bh=0D920SHw42YiR49yYlbJhJD7PJMrwKoVYcH+BNnX7MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcJ+db5u2T/4zot72MWTV/nqMR9+qROwqnt5/ErsUrydg/mLv25SVRDWVqU+UfTynGjfvUQOEeUxI4cgRSFlrnNjyK1Xi0GZuRuXSTnkopmoBsU4jyApEz7pUJHIvsz1I9OeuIGsm5U5UND/cjyjoeUbn7x+7dOUxPOOL+a51cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEShHWH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEShHWH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE5C4CEF7;
	Sun, 15 Feb 2026 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199230;
	bh=0D920SHw42YiR49yYlbJhJD7PJMrwKoVYcH+BNnX7MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fEShHWH1UvscSbdGktUgMloxWJWkyUCQj3znuqiDrFTbtn6av7N2wWRjQLUxyE9rb
	 jy9mjY8bK3oaMtiuEnib6D/O6wthIYzd+5PMm+ou7WJexXr8qk8T6vGwvDQ+ueciPC
	 imNE5o+5NO39dH8E5UssFNyMSsabrmiR5UU6QKOI4eLN10q/4jEWCzfNNCiZ1E4Y7S
	 ucnRpLXck5OjLMwjgMl89cse59c1ZZ2nWyGG+zYdDidkOigAw+4SxPNvz1I0RBlOh4
	 rB3fum8FwTBjF8wj0QEsF6qZDl9tXT2ajlbM5mnmQJGTOzOv1BuE5mG7fG8NifUg3O
	 dZotY7KQa6uLQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:05 +0100
Subject: [PATCH 78/79] block: rnull: add `shared_tag_bitmap` config option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-78-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4667; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=0D920SHw42YiR49yYlbJhJD7PJMrwKoVYcH+BNnX7MQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhiKZrX3/G4pA3JkHu1CIOx58kApLAWljhDP
 YWOJYIICo6JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYYgAKCRDhuBo+eShj
 d9SlD/9RmbXJFOgg9x0t/IP45eYn4VRYOpP8Ba54ODjKjkD838myUazuaXpFlcFQXsHueu8qRmy
 7vh7NOH2AWPtw8AzQWr05CAjaM4NYWoCMtyr3+nufR4dMnWXLvYi3gxoXla2QriJWBlzlP6vuF3
 3U4mAivhbzhQOVyfNF3ZFP0hd9mGj7MLd37B4CePJaQb7eNRjp1liLDNSm28QZb73E0wrAGEYiv
 gfA5b8Q+DHEoRn9rF22rzxwJ6XouTsZ9iA/48QHS8iE7w+AhOCpAfxDwk2rqX6wH6NPLklduGV9
 jq8ar4HB/jervqMppRZNtIv4/qwwGybA0TEP/gEzKO8qu3ScUqEtaWlIZrz9vyUxDV7voQZybPd
 3ZSS/StzDmlux6ZmM/tBJDxyHh9kDRIFMqMhroe40bPk2HaedNo93JJOu56JylGRvGLDBeAJ2KR
 0rsTkdh1rbLBpxH8/UikssDCRmti5wvgxOzzhW5dv/icaTXJqcbwN87USsY5tlGqUQ22jqdxtEl
 VmN1pUHOJrWPaLx5yUFlTPY6c0EW+dwmj6H9GqsqXXUnD2s7nyJDfkkz4g7oyVg5mP7QM8Yix8j
 ocWTju9O6PISgpRNPZJYKht9iULsjgpcnJe2hcHeGtFYQLHp9Dy+YRTdxes9hO1W8sZgbI3fymU
 KhBc3lLbvPB0bFw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute and module parameter to enable the
`BLK_MQ_F_TAG_HCTX_SHARED` flag for the rnull tag set. When enabled,
a tag bitmap is shared across all hardware queues.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs       |  5 +++++
 drivers/block/rnull/rnull.rs          | 11 +++++++++++
 rust/kernel/block/mq/tag_set/flags.rs |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8b9ad8a1a243b..395da68d96dc6 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -124,6 +124,7 @@ fn make_group(
                 fua: 28,
                 max_sectors: 29,
                 virt_boundary: 30,
+                shared_tag_bitmap: 31,
             ],
         };
 
@@ -212,6 +213,7 @@ fn make_group(
                     init_hctx_inject,
                     max_sectors: 0,
                     virt_boundary: false,
+                    shared_tag_bitmap: false,
                 }),
             }),
             default_groups,
@@ -296,6 +298,7 @@ struct DeviceConfigInner {
     init_hctx_inject: Arc<FaultConfig>,
     max_sectors: u32,
     virt_boundary: bool,
+    shared_tag_bitmap: bool,
 }
 
 #[vtable]
@@ -355,6 +358,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 timeout_inject: guard.timeout_inject.clone(),
                 max_sectors: guard.max_sectors,
                 virt_boundary: guard.virt_boundary,
+                shared_tag_bitmap: guard.shared_tag_bitmap,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -634,3 +638,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
 configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
 configfs_simple_bool_field!(DeviceConfig, 30, virt_boundary);
+configfs_simple_bool_field!(DeviceConfig, 31, shared_tag_bitmap);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index dfdb56bd76f52..5bf965908ef63 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -218,6 +218,10 @@
             default: 0,
             description: "Set alignment requirement for IO buffers to be page size.",
         },
+        shared_tag_bitmap: u8 {
+            default: 0,
+            description: "Use shared tag bitmap for all submission queues for blk-mq.",
+        },
     },
 }
 
@@ -296,6 +300,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
                     max_sectors: *module_parameters::max_sectors.value(),
                     virt_boundary: *module_parameters::virt_boundary.value() != 0,
+                    shared_tag_bitmap: *module_parameters::shared_tag_bitmap.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -352,6 +357,7 @@ struct NullBlkOptions<'a> {
     timeout_inject: Arc<FaultConfig>,
     max_sectors: u32,
     virt_boundary: bool,
+    shared_tag_bitmap: bool,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -425,6 +431,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             timeout_inject,
             max_sectors,
             virt_boundary,
+            shared_tag_bitmap,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -437,6 +444,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             flags |= mq::tag_set::Flag::NoDefaultScheduler;
         }
 
+        if shared_tag_bitmap {
+            flags |= mq::tag_set::Flag::TagHctxShared;
+        }
+
         if home_node > kernel::num_online_nodes().try_into()? {
             return Err(code::EINVAL);
         }
diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
index 1fca4fcb4dd20..cc5f54781cfd8 100644
--- a/rust/kernel/block/mq/tag_set/flags.rs
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -19,5 +19,9 @@ pub enum Flag {
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


