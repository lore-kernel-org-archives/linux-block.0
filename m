Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB6305667;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244813; cv=none; b=Qw3kBO9AQaNE6ha0bujBxWlS9kfg5wc/O1mStbh63m2DkJKpBk8KZ88QmjxyorWI46HcdX6ouP8JRTqiuf7AzKEHnAHKIUcEIaifddndBmkvlvRgv/rxKylP5cJZfMaP7YAmdX6F9pp4lPG1AY6fygloYECm1G3xOezlmzxrlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244813; c=relaxed/simple;
	bh=wiO7iyhHfLyGpv0buLwsG/5qqS2wwdihoSLmjujf66I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slEB+7p6xux0ZUk00/Ypc+Zswrk8Z3o5oT5G44B7zBILwfpnn6k9BimvlAnfAhn2tuzFBt5zf673eZETAnrgmrW88nVPlFarYq39uwwapu8oeVO0vaw6SzKpITvxJNiY6YXv2y7OecEba4hfEmSKeHhoqwps+igZvZB9b+fu/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lV72wYBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lV72wYBd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06E75C2BCF5;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779244813; bh=wiO7iyhHfLyGpv0buLwsG/5qqS2wwdihoSLmjujf66I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lV72wYBd4V5HD/7EhoP7rEmA0HllbwTK0c6e1acw+yePwYpf9m5JBqGZOwB5/l+qR
	 IsxB4Gqwjm24I5iffve9XY+dtN4czNQ5L8o7G/RUgdn8Aovo1zF4g68LgoKDpF+LX6
	 ziD2/V5lSHKs+xG8gpwnuP0KgJHfKZ1NB16geNwA=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F3CD5BAE;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 20 May 2026 10:40:11 +0800
Subject: [PATCH v2 4/5] rust: block: mq: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-miscdev-use-format-v2-4-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
In-Reply-To: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779244810; l=3717;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=wiO7iyhHfLyGpv0buLwsG/5qqS2wwdihoSLmjujf66I=;
 b=dtYXcvWegoNliujC2APjX9vTQcRBhjObulJBI6+RURyh6Y5A9HrYCSE0NLpXH6WSOCwDwVZE7
 xPJD8FUDM69CCf2BEm8n7jl04xCb5GV1pwV7R94ZXEWU+upPIs4+XM4
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/block/mq/gen_disk.rs   | 21 +++++++++++++++++----
 rust/kernel/block/mq/operations.rs | 17 +++++++++++++----
 rust/kernel/block/mq/request.rs    | 12 +++++++++---
 rust/kernel/block/mq/tag_set.rs    | 24 +++++++++++++++++++-----
 4 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf51..6f599f654f37f 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,14 +7,27 @@
 
 use crate::{
     bindings,
-    block::mq::{Operations, TagSet},
-    error::{self, from_err_ptr, Result},
-    fmt::{self, Write},
+    block::mq::{
+        Operations,
+        TagSet, //
+    },
+    error::{
+        self,
+        from_err_ptr,
+        Result, //
+    },
+    fmt::{
+        self,
+        Write, //
+    },
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,
     sync::Arc,
-    types::{ForeignOwnable, ScopeGuard},
+    types::{
+        ForeignOwnable,
+        ScopeGuard, //
+    },
 };
 
 /// A builder for [`GenDisk`].
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 8ad46129a52c4..187b0b7791db9 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -6,11 +6,20 @@
 
 use crate::{
     bindings,
-    block::mq::{request::RequestDataWrapper, Request},
-    error::{from_result, Result},
+    block::mq::{
+        request::RequestDataWrapper,
+        Request, //
+    },
+    error::{
+        from_result,
+        Result, //
+    },
     prelude::*,
-    sync::{aref::ARef, Refcount},
-    types::ForeignOwnable,
+    sync::{
+        aref::ARef,
+        Refcount, //
+    },
+    types::ForeignOwnable, //
 };
 use core::marker::PhantomData;
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index ce3e30c81cb5e..4e0579660e906 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -9,13 +9,19 @@
     block::mq::Operations,
     error::Result,
     sync::{
-        aref::{ARef, AlwaysRefCounted},
+        aref::{
+            ARef,
+            AlwaysRefCounted, //
+        },
         atomic::Relaxed,
-        Refcount,
+        Refcount, //
     },
     types::Opaque,
 };
-use core::{marker::PhantomData, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index dae9df408a862..c1fd3e047af50 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -8,13 +8,27 @@
 
 use crate::{
     bindings,
-    block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
-    error::{self, Result},
+    block::mq::{
+        operations::OperationsVTable,
+        request::RequestDataWrapper,
+        Operations, //
+    },
+    error::{
+        self,
+        Result, //
+    },
     prelude::try_pin_init,
-    types::Opaque,
+    types::Opaque, //
+};
+use core::{
+    convert::TryInto,
+    marker::PhantomData, //
+};
+use pin_init::{
+    pin_data,
+    pinned_drop,
+    PinInit, //
 };
-use core::{convert::TryInto, marker::PhantomData};
-use pin_init::{pin_data, pinned_drop, PinInit};
 
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///

-- 
2.43.0


