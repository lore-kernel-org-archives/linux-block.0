Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9B395AC4;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=L9Es4/oeMCx4wIdEMb6ykfqFZiIa507oW1Nq4Qk53Ht6LJpRRYcxVkWZURFn3wA7x3PSFQ32d8aCQkL9EF88244wCbkyqv++TDhBAFcSTwSnbPXCbGEi/WoUEC4v46zjQpUAcSt5lIu+pw49NQDjZV/O/to0VkBAYJtJqgReUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=kSKWcnXocXH7lUum/RBW8lz8IDl63EuDX9Jmke1guTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jO2A3OIQ+0TIzqXvV8OyynyRcZNccf+8QkvdkFX9S2coqRRmYtFVrLkQORLyGudx4rKcQ/vErPozZqG80ucnnaGbzhelaQNduqGCPTAGPi18RG1iO35UCSsd2PIi6//p1sgfIGWuNaLsaJgTLmXvyZGms9K8wbqrWBamCRsRr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=zrsra13H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="zrsra13H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92069C2BCF4;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=kSKWcnXocXH7lUum/RBW8lz8IDl63EuDX9Jmke1guTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zrsra13HCzpNAoomFNVtD5s5y93q+6kjP3RDSLknJDHbm55IX5hqel5d60q1tKCjk
	 bdA/eo0f/wh8QXkUXWXK6zM/i9J2bWug+wY5aeknoH8GtHLi4WZR455ToRAcQgakl7
	 zIuv2hOV1xqEObIm7vvfu0BAkC6kpKVmL77RONEI=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AFACD4F3C;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:11 +0800
Subject: [PATCH v3 5/7] rust: block: mq: remove redundant imports and
 format
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-miscdev-use-format-v3-5-56240ca70d0c@linux.dev>
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
In-Reply-To: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Alvin Sun <alvin.sun@linux.dev>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=4436;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=kSKWcnXocXH7lUum/RBW8lz8IDl63EuDX9Jmke1guTY=;
 b=I96JC57sPee49oEucf9G3xyuJuLQOAFwMxMJwuBKB4vDxC+mFdlqcSAeS0931y1YqFWZ8yAAa
 +pAkIK9T9FEDna508DvTC7onbOjVcWaZKgl6AL0+z+OE9kiGzI0UqP9
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Drop `Result`, `Pin`, `pin_data`, `pinned_drop`, `PinInit`, and
`try_pin_init` imports already provided by `kernel::prelude`.

Simplify `error` imports and flatten parameters formatting.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/block/mq/gen_disk.rs   |  7 +++----
 rust/kernel/block/mq/operations.rs |  5 +----
 rust/kernel/block/mq/request.rs    |  2 +-
 rust/kernel/block/mq/tag_set.rs    | 22 ++++------------------
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index aac8ece10ae7c..b9653537cb44f 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -12,9 +12,8 @@
         TagSet, //
     },
     error::{
-        self,
         from_err_ptr,
-        Result, //
+        to_result, //
     },
     fmt::{
         self,
@@ -67,7 +66,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
     /// and that it is a power of two.
     pub fn validate_block_size(size: u32) -> Result {
         if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
-            Err(error::code::EINVAL)
+            Err(EINVAL)
         } else {
             Ok(())
         }
@@ -177,7 +176,7 @@ pub fn build<T: Operations>(
         // operation, so we will not race.
         unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) };
 
-        crate::error::to_result(
+        to_result(
             // SAFETY: `gendisk` points to a valid and initialized instance of
             // `struct gendisk`.
             unsafe {
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 187b0b7791db9..0343069b373c7 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,10 +10,7 @@
         request::RequestDataWrapper,
         Request, //
     },
-    error::{
-        from_result,
-        Result, //
-    },
+    error::from_result,
     prelude::*,
     sync::{
         aref::ARef,
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 66254d02bba65..6115f9aec2285 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -7,7 +7,7 @@
 use crate::{
     bindings,
     block::mq::Operations,
-    error::Result,
+    prelude::*,
     sync::{
         aref::{
             ARef,
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c1fd3e047af50..df3f90bfbb817 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -4,8 +4,6 @@
 //!
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
-use core::pin::Pin;
-
 use crate::{
     bindings,
     block::mq::{
@@ -13,22 +11,14 @@
         request::RequestDataWrapper,
         Operations, //
     },
-    error::{
-        self,
-        Result, //
-    },
-    prelude::try_pin_init,
+    error::to_result,
+    prelude::*,
     types::Opaque, //
 };
 use core::{
     convert::TryInto,
     marker::PhantomData, //
 };
-use pin_init::{
-    pin_data,
-    pinned_drop,
-    PinInit, //
-};
 
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
@@ -47,11 +37,7 @@ pub struct TagSet<T: Operations> {
 
 impl<T: Operations> TagSet<T> {
     /// Try to create a new tag set
-    pub fn new(
-        nr_hw_queues: u32,
-        num_tags: u32,
-        num_maps: u32,
-    ) -> impl PinInit<Self, error::Error> {
+    pub fn new(nr_hw_queues: u32, num_tags: u32, num_maps: u32) -> impl PinInit<Self, Error> {
         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
@@ -77,7 +63,7 @@ pub fn new(
                 // SAFETY: we do not move out of `tag_set`.
                 let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
-                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+                to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
             }),
             _p: PhantomData,
         })

-- 
2.43.0


