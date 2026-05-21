Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95223955DC;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346634; cv=none; b=b8PGkbotOzWZALACN/g9h9sLwGM6NSRLrc/UWu1mG1Qyscix3axJdZ4Y4dxL4fbEs+v/++KZhSgjlDyftNORFHj4S6KuC3c5dCI35Zze75t1Ge/L6h28cw1PK861FMkg8phmuXMLy7/4x0qY54tLnfiDLBS6FnaudIDTPItBEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346634; c=relaxed/simple;
	bh=7IJwGV9znx3XEDptkR1uEqG+xZjAAVexOo1+orQefiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4wiqGevMdENNZQkWa49tcFCzNqbG3d/SR7Bqs3CoFGPiBjJdWvwnlFAYu9hmvl2V+aeu5veLuXCRsdwMBZPqELqw5cYqy3cnJawv3YKDpmQShN1UpfnUHN9RNIxvATq9RM0pPt2OjQnaSarHKZ5czYCZj+Op9jLWhxdmRcpbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ubVz3HKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ubVz3HKM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BB7DC2BCF5;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=7IJwGV9znx3XEDptkR1uEqG+xZjAAVexOo1+orQefiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ubVz3HKMwCRZmtvS6q+G0vdfbMsGQCY4+pZUmVreY4sLt+7Bs+4XeMn784H2G15i3
	 2onIHUuOoWImogbyQLJlYXZs81blWA+jMR57LnhUG++fS1ac74mrLz3Ly7DGmfl3fV
	 uP1WVh1bMV14ZY3XRqQ8QuekdPUlhvY0CqGBoL0g=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258CCD343F;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:12 +0800
Subject: [PATCH v3 6/7] rust: block: rnull: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-miscdev-use-format-v3-6-56240ca70d0c@linux.dev>
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
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=2062;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=7IJwGV9znx3XEDptkR1uEqG+xZjAAVexOo1+orQefiU=;
 b=VW4g3lvXiWyowuFivxU7IbLLajYd8o8BAFgWb7crAeUbtjkflvdMs9T7Rc/VkqIKiWQUuaXgs
 egrACrudZVDAi1NhecV2jnSq+RmavkXPjQswL1lyDeawend7OCrYqll
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/block/rnull/configfs.rs | 27 +++++++++++++++++++++------
 drivers/block/rnull/rnull.rs    | 15 +++++++++++----
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b7228..c10a55fc58948 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,16 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{NullBlkDevice, THIS_MODULE};
+use super::{
+    NullBlkDevice,
+    THIS_MODULE, //
+};
 use kernel::{
-    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
-    configfs::{self, AttributeOperations},
+    block::mq::gen_disk::{
+        GenDisk,
+        GenDiskBuilder, //
+    },
+    configfs::{
+        self,
+        AttributeOperations, //
+    },
     configfs_attrs,
-    fmt::{self, Write as _},
+    fmt::{
+        self,
+        Write as _, //
+    },
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
-    str::{kstrtobool_bytes, CString},
-    sync::Mutex,
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
+    sync::Mutex, //
 };
 
 pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe83..13048cea8bb0d 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,12 +10,19 @@
         self,
         mq::{
             self,
-            gen_disk::{self, GenDisk},
-            Operations, TagSet,
-        },
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Operations,
+            TagSet, //
+        }, //
     },
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    }, //
 };
 
 module! {

-- 
2.43.0


