Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533848E0DF;
	Tue, 29 Sep 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674507; cv=none; b=DW1R4iA8l0mzMK3HkzoHIIdDXyxZdb6A45KWeYbGNIIlXVhYT0N48wG3DWuvsV3eRk38p7JVlGkkX0UBn3vbYiL8EYVWgQL6VUlLM/AGX+CSGo6STqBJYhp0TA7qlrtwh72eDWph4TSGZ5LPh/8XCpWIJlaWsVBOagugys5E+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674507; c=relaxed/simple;
	bh=vYEYCbCErIjQydhSHmfl6bZP+IHmrXc3/8GGnStAr1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usgJbEZh8Q2B8RSdxkg9AOMMzZ08F8Q3CLG8kdotvy0l0+2Tce6beOCcOvxzvou00v9P1/K6GjqHGLc1tdmglKQsdk40dz8nwPzFU9iwir29pbQgXdP6EY2/OdcMEv7X5jejufmMNUxtkscU6+lpFE7lK/rSvQeX6w3uKHoOjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXJ1K68G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXJ1K68G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382711F00893;
	Tue, 29 Sep 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674505;
	bh=P5/5QKj5sSlw/iC/GDGwLdKweII5wIVHSwvDK8xDxzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kXJ1K68G835pEZJbWLPazpOWc7gtCp2rJx3gkMfRrJVptDk8TL58/8Dza38G1YTCd
	 1xlpCqr3s5LrFpxutI5Ua/OjxFq1DlW1+Su4vjbwlgTS3EXeFKFQd7GKrLvdwhmQvO
	 zJbMvKi1YMRORUGZCcVhvQfs1JoadCzInzFIRMl6k8qQRIAR11l3b2sK4mkSZUV4UN
	 9xQH+6eNLjLpaYcBLG+/BcqeymO1yE1h8Qy6vTZKC7GBpELOWY2FJEZIx5tmj1j6JP
	 XMtdcZXLsyRM+bkpWuieMwi/ATo9DhU2h1BFtgQrW46WGaQOeK8D0BqFxKC0CBe2RP
	 v3eMANEK8Do+g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:01 +0200
Subject: [PATCH GIT PULL 3/9] rust: block: rnull: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-3-642a4c1aebd7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KQk+C40FnT5atkKayvNJ0LS4WhtlO7QzkIuajyLLa34=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YVTQXCNyu4B3U0Qrl4o3iYeKvQimx6NUOhl
 dUQL2Ooq9GJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGFQAKCRD6UCkIqsW9
 0BztEACneqR7X6S6yMI0Kz0J2rNz5KUJOBYiLM9YvLkmfiDwP3vUtWVgOxSanZT5bnXrtnQds+5
 jLcksRKbeCyigIJnKQXXQ92wYf4QAbxC5KUUMX7D6AidMMB1xZGBEbyOuMIH8KElGI+0LhQ3TlN
 XFL6NXTkIu7sXnOFoD8WdGLM6Q/PeVfsN2B5OHxhLEyd4Xgqqw+J5RMOHrOP5fhsDD40lwrIGWc
 WkelXbeMHTTYhPnl5bFQgLymaGcIW2Ar81BQsqxZpbgUi/ZfCo6srpuh6JNDhpyUrKox2H7+Xo2
 7juKHc7AhLhJ7J390v60/2OiPCACmUVC0Z8l4rhsAzbRZ3840qt/uPy/qwJ3y14Q9KAf15qc1fS
 yXBUJpIbu0oCTzXG5IF9IC1PPsIdTqzG3m4gGzuxPdtK5aRd8zY98QqOp75QTD37c0xBUfRh/xV
 L0+Dk3U4Pz1N4YSTziN2le1pJX4AFyx2pPBNqhy997XBF20SOp5kK5MforXy3AnIga9Ul6Nk5dz
 snTd0FvAwcW+yD2e34TWyTm+tm4fmLYSKiGEBKGIzDwlNOP8SVX65C0xT7ob4Ek1iX5VbZQohdV
 Xv/uggimJ38ODzG0RDvkCnufGU19Ws2f5SmEd4fxBLPkEtCyti8jViNJiDmqGhr1zQZFsiXXBuK
 YhPeEpoLl5w6Asw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Alvin Sun <alvin.sun@linux.dev>

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Link: https://msgid.link/20260521-miscdev-use-format-v3-6-56240ca70d0c@linux.dev
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 22 +++++++++++++++++-----
 drivers/block/rnull/rnull.rs    | 15 +++++++++++----
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 32c10c3f4d0f..9b28be215093 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -2,15 +2,27 @@
 
 use super::NullBlkDevice;
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
index 0ca8715febe8..13048cea8bb0 100644
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
2.54.0


