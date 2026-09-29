Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75984D1796;
	Tue, 29 Sep 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674512; cv=none; b=ULQHlEuPSjat6/AOy/KTLXOHlGeiKwWHxk/yqh7S1XiqzcYyb15fHEOhubZ4buYbHCifxeU7mN7L54EqZsIeOugHQH32koiHxf9LssEU56wOPL+6FxKXYqn7a3wgY4nQCh1HsrRM6exXy03xHFyilPtagpIXc8x+ouZ9LimtnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674512; c=relaxed/simple;
	bh=lZgonm9Br42Ngigei0b9eur/ChEqB75ARgsISHU0JL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0N61z+coOKm78y+zZxzFDtwFKHYd4FUGur49ZBBy/n46pfLmWbxevrrlu9YpFnEvrolP/fBbm8MOmHFsiJJXHiy5zhz/oJ2FaF5B3RDOxiuSSDu0+FMPqe6o86pIXQsnn/XZsMFgZFHxMq1Ei12sIKwtuSufG++w53mWn7Ed1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQfrgBsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQfrgBsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B511F000FF;
	Tue, 29 Sep 2026 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674510;
	bh=2W3jsYByD2U6l1ZW9gTuVFWx7U24Uts5QsV3Jza+TdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NQfrgBsxvoRGcgIQFWleNE9ClfPaxUqiOUTTM0XTDcWQpNYHQBYr5E28MlmWLbaIh
	 LzFxTzH6LTXLnt0HfHlbBndLheMoMQIzQ5jlWnBYCpkXBfiEJ/sJM2wDP9o5cjnPD/
	 Ur5wuRRWgMrcvQTUpM2gvppcVPcR4WHEGzorYjAk5q64KSaShMT7kOqrP9KWTTNLxf
	 T+1pv0QLl+cNzwWtlnb9xPVL/MbhNG2ImAiuGwLLoXP1k6G/bT5L8imVZPhvDFWUWe
	 5ct9nfgElp0YIuIXNM3XXqnDHXZ/Su/aViPiRZDpY0nholPYYB1XG1/sxlkMgSyM0R
	 iXabAmxgMXyYg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:00 +0200
Subject: [PATCH GIT PULL 2/9] rust: block: mq: remove redundant imports and
 format
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-2-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4619; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZBJ7NxjIHl+tcotBamr7LM0pHbXK0sWawo9+3Z+6ct8=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YUJLyoIbNOv6vzy5H+Tt1DcWc+vg7K7zcCM
 RA3GrgskdCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGFAAKCRD6UCkIqsW9
 0CjoEAC3xe6iPji4tu4o5QlxMkU7mpPYr0sCFSbI8MnUc2TgdpzmNMXhTr+bxZ1+yj/2MfwmRju
 MpNCipD0ncXqFY2dAfIZCU5NGHsUt+7H5ctsV7XzgPw0Y+syAJEgvji6c5v8Niyu4DQsg2eqXyn
 +TIAgS1kVUj2/dfFngONvRbh/3kRJqjwFig1IoL2wJCnBtwVLWuJ6A17mnlBTpBORV6//IBNHJK
 2ooSA/bXCi7lKblzYaiJ79Qozbk0xb2fFBP+BhJ6CJyzSQvMUgKpUhKFZecakM6UQQxCfGoxh7/
 0YhIngZyBOxIIDdxJYITrwsJZllPp5Xs0LyJxSZ4ECBNqmUv9ySrjLHn4GO+LYuy7X0QxVhdE6E
 mWG19BstEAhkNqzukt0TTgWU1YaL0npTKQZu3tp1r2bGmqamq0WS5mtBN/PVjmWIynAvgRjrOcj
 ppCnFblMTC97FiX6vdQ8NgVgnq4ZfXNdMJOlys4se89XsMyQLILmYBqa9oVozX/LDgsljQVVn8K
 F4vMNe6fcmOLWF6Hb+FnCkpvJ/xS/NG3IQwebmDlUiaawgf5DpNhA3SwMJN/uYfj/l7JAULM41x
 a8ycv3n6GALz94qgYgPHn7DwHYy9B8ODld74V15RUD6r/UT8vULNLwNJZaObC6u3vfRHfRaiADa
 0vkHU/zRUfz9GhQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Alvin Sun <alvin.sun@linux.dev>

Drop `Result`, `Pin`, `pin_data`, `pinned_drop`, `PinInit`, and
`try_pin_init` imports already provided by `kernel::prelude`.

Simplify `error` imports and flatten parameters formatting.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://msgid.link/20260521-miscdev-use-format-v3-5-56240ca70d0c@linux.dev
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   |  7 +++----
 rust/kernel/block/mq/operations.rs |  5 +----
 rust/kernel/block/mq/request.rs    |  2 +-
 rust/kernel/block/mq/tag_set.rs    | 22 ++++------------------
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 31cc7a77c2b5..8ec38a7b9815 100644
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
@@ -190,7 +189,7 @@ pub fn build<T: Operations>(
         // operation, so we will not race.
         unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) };
 
-        crate::error::to_result(
+        to_result(
             // SAFETY: `gendisk` points to a valid and initialized instance of
             // `struct gendisk`.
             unsafe {
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 64bcb31666c0..b9ab0e6102a4 100644
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
index 66254d02bba6..6115f9aec228 100644
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
index c1fd3e047af5..df3f90bfbb81 100644
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
2.54.0


