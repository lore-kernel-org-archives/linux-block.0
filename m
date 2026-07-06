Received: from out-21.smtp.spacemail.com (out-21.smtp.spacemail.com [66.29.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37D1EEA54;
	Mon,  6 Jul 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301819; cv=none; b=I1xKAFzUkNtrBGNU/aNaQt7hlaqzvxEWDweHNdpQQaRNeIEwmch+Zb3CgoIFqIXecsSp3CCyR3r1wLWWtQCvAOcfc6WIgg3PvA1G5lkw7UlDCOEwJPRRes9SHI+nzflbFBzyLtfgmcV0FQ5x8cw7WLxeFLPpWtW5too+o+YLVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301819; c=relaxed/simple;
	bh=HyEqGbayGnvhC9h1TBFxEK9QF1cFOv+6uZ+d8nJ/32U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rlqaVmoCjTnzEioC8uc6JNhIhqxnAgiG5RdY90w1rEXfOBsXRb210SIGhlCYstEKCpAroVMxP/zzoR36mRkgqa2R9yMlJL1dY2FcvkrVurzplJBN/sTvgo6mFjpvWwSQLU8erfgD8W13ugJtymMQwjyy2ms2mfqtSKHPhTKlL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=G2EfseSQ; arc=none smtp.client-ip=66.29.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="G2EfseSQ"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gtn5Y3Yqtz6tkR;
	Mon, 06 Jul 2026 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783301810;
	bh=tM+AcZKfOAoskfcs0wU7letSfehw7FN+lx/KixPmf/k=;
	h=From:Date:Subject:To:Cc:From;
	b=G2EfseSQ0jflfZawScIWDGocVvLr4VQkoRtQ7HyKiCG4KLimBCQ/hzJqTsSX7GTnT
	 1hlXjcuI0avn8kBed/8apUiVnwn+xKIIpISheqqyjg7vPimhwx6LVrQ6vOtZF4ep1N
	 VQg0z8ah1c4YNoe+eSWlSoSRaE+5cZVqHAn4XHYmoFhhdWndGCxjQTYf7dr7H6PvDn
	 Htx/ydkQ4ETfX7yqVb4rCkh+vvrCFWXRZ2O510xJQPoDWAQhQhoD0JS2wgx8Qn4r6V
	 BNbQiXkkg2y6Od0gCsxYe+Bl2dj1U5uO/zUkHiaxno0DhVjwiRvUuT/lC6no7HtFoh
	 9iH+yeMZvW5HQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 05 Jul 2026 18:36:48 -0700
Subject: [PATCH] block: rnull: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-rfl-vert-imp-2-v1-1-e6ab69c55095@gurudas.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5EQBBA0atIraeS0hM6XEVmoammZAapNiIRd
 9dYvsX/OwRW4QBlsoPyKkGmMSJ9JdD09dgxShsNhkxOljJU/8WVdUH5zWiwcK62lvL27QliNCt
 72e5h9Xkc/m7gZrkucBwnmsWDW3IAAAA=
X-Change-ID: 20260705-rfl-vert-imp-2-9bba7706d3f0
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
vertical import style") and found a few more locations that could
benefit from this cleanup. No functional changes.

Separating out patches per-subsystem as per the review feedback in [0].

Tested via:

	$ make LLVM=1 rustfmtcheck || echo "fail"
	$

Initially thought that rust-for-linux/rust-block-next was the right base
branch to use, which is why I didn't group this with [1] based on
rust-next that I sent out a short while ago. Using rust-next as base for
this patch.

[0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
[1]: https://lore.kernel.org/lkml/20260705-rfl-vert-imp-v1-1-2f07946a905f@gurudas.dev/
---
 drivers/block/rnull/configfs.rs | 25 ++++++++++++++++++++-----
 drivers/block/rnull/rnull.rs    | 13 ++++++++++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..2149b47db697 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,15 +1,30 @@
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
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
     sync::Mutex,
 };
 
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..d58d2c4c5f63 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,12 +10,19 @@
         self,
         mq::{
             self,
-            gen_disk::{self, GenDisk},
-            Operations, TagSet,
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Operations,
+            TagSet, //
         },
     },
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 
 module! {

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260705-rfl-vert-imp-2-9bba7706d3f0

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

