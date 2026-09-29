Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E944E3227;
	Tue, 29 Sep 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674520; cv=none; b=FhpfD+RWPT+nLivXlNYJ+kQ8u+HEF3ZXSCcTg6Hu32/tp7puk3pjZhlbNo1fSyHxlComDm06bEkT2k6QI1OlpffwAjYpNHsDAbPrPrHduR8RRth17egSVmcUkZ+1JjlaRCXdEYSk7uTP6OdZ0qlqJjWBzQcJF2CdoTcczqbEbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674520; c=relaxed/simple;
	bh=X6ZYJKElS32qlnlmQ04J1M9//a7Py7nwuwlLRb02Pj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZUGeOj1/HDGmJwbAl5dk4fBm7uIYg9uubYZTOJcYoxYamwoukZljeVH+8Rpt/cJUWNNSmOeYTt4XjEE1ofiSRkm3zsCpJf9kCRmaDrLb9ncjT+4P1GIQRJ3y7/4Lf05ZH0KShVZbT3sJUQCoNRxAuwIKZJ8P1Za0rx72YesM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9aQpW6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9aQpW6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC5F1F0089A;
	Tue, 29 Sep 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674518;
	bh=auGSoO0AFSO51tOlvEsD+tS4wgir9EHDcZCv/bHXClQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N9aQpW6uScmQsqHg7yP35vXX60KLkHLHUaKHj7DOuthJS6g+gNycBbzLsG6PR9NiV
	 tC3hzHCIICFTBeNSl3agQopuwjwrPdVKtWkOAOyLhKAwQ9F9kHBdaqVHe49SIMWeyV
	 0JL27OqbGzowjg0h9b4eD6EQ8uBYGvj9BEFhX1s6aLDe+en0fQDgx9OQRx0Dc1pwir
	 EHcTvPGjRpnYc+uczEiY+71y1E3hcC5zbgk0bZZtJCNSTeokcaPjbzCKACBcD2mrl4
	 eNp7+HKiaOLfFVD3jxmwpl1xb4ue5BglkOy31RvYQ3dRfgftEB/eizCXvKSJuOWz/A
	 Qm3X4acBTXSEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:33:59 +0200
Subject: [PATCH GIT PULL 1/9] rust: block: mq: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-1-642a4c1aebd7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=zVatWscY7uVgw8aVYDc5Tq1DGBmR/3NxnjZVaxAEDmE=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YTqxIpY/fZxuo+gEYUxZuNfRCu3aMJ8MwE2
 WjD7bdxyEeJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGEwAKCRD6UCkIqsW9
 0IEBEACkEkgUoJ5sMwfTR1wTp9zI9hP+i9zlBDpYo4Y3ObdnsEp3TDRxZVZhZLJqZwlV9I1gy3Y
 zzr7USgRHI9Ktfri35ct7IaG76Fnp0ODhvHJwA782QviQ4impl/dY6Ocbhr8LzQpI8QjpfwrjE4
 1jVt7rQrC913SCGK8CSeBgdVwrDhtUa6+TUYT8anvTj3psm1LXa0mIU/pI5naW2xr4mmY87fFLE
 7d510LgE1qj4FOXZ1ZdLgp8sITxFxjIM9TGSuC27jzXbfWD1/bEtwqbrBDtvt64I+FW/kqdbB6L
 gras6qbLDlAqNEWTzQ2UbplCEqbc+QYmxAXlA0GSz/NEr/KUXSQ/duov/4Pk9KAxC3BNLJ9myJW
 eS+lz/dAgyYeEH/HnSPDsPv9uLdyGGIiNqXAsVzS/VCv7Y7v78xkHWS5YDfVI0HTCTnOUaAfR+1
 b9WfzGc7vSzn6C1DI/O5+dvUy6tl6XH2eZ5J5c+77EjqdTaV5s70sRVNtulbw7qAB4ZXJDvywdF
 EMqqy9rUqwDXr0XMPmSlk5uF4bgFJhmJZsvIBJr+SdPK7sMuBOxkb+b1sDsc+U++PfYTq5/9Ceh
 0djIyVClSTotZevQ+3pmkz1Yi6Mq8fl30CeWH4h8MTEut6ZVboNDC+3WKmCZ1XUVgd+noDVYqbk
 pAfag2zKOCu9nWw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Alvin Sun <alvin.sun@linux.dev>

Convert `use` imports to vertical layout for better readability and
maintainability.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Link: https://msgid.link/20260521-miscdev-use-format-v3-4-56240ca70d0c@linux.dev
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs   | 21 +++++++++++++++++----
 rust/kernel/block/mq/operations.rs | 17 +++++++++++++----
 rust/kernel/block/mq/request.rs    | 14 ++++++++++----
 rust/kernel/block/mq/tag_set.rs    | 24 +++++++++++++++++++-----
 4 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..31cc7a77c2b5 100644
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
+    }, //
 };
 
 /// A builder for [`GenDisk`].
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 861903e18fbf..64bcb31666c0 100644
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
index ce3e30c81cb5..66254d02bba6 100644
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
-    types::Opaque,
+    types::Opaque, //
+};
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
 };
-use core::{marker::PhantomData, ptr::NonNull};
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index dae9df408a86..c1fd3e047af5 100644
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
2.54.0


