Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15A283CB8
	for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278826; cv=none; b=d2s/Dt6aUiRod5QR/ayRPSwyPgj0fA/Gmhh9dOlsye4q6UB4EB6zhsgEHtJr6kD2OcUnm3GhWxBiCYDFLpojoNuuaG3RUo05w9l3vAB8KL2v5QeQIHWdS3hmvQPfVdD4GgEbPrsovhnWZG3/iVgSY/Ab7+GlGDkf5aTzaH9hnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278826; c=relaxed/simple;
	bh=2k6zfbV5v2cf+4wgu/XCSpdhWf+Wu46HVvzRy5EuNf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=adr5QiHHYNokpWmN/Ec3wFvgcuCyzB2gtjadngWHb7W1T0/dnJ4LlWIl6OE3MKLkyKAU3n1FqZAJl8TNZLK8NELjA5atYeV3mD0O2lEMO9cHSK1+ZzgYTxtnWaZvG2ASRdKvlZPut1nNixp3nU+YRuunapIit9KgNrfzlL0dy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co8vOhR4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co8vOhR4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so47962305ad.2
        for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760278824; x=1760883624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfkmdzafh7+VHjG0RAeg5sF4FBAljqq3jIvcOzngZlg=;
        b=Co8vOhR4jNm0dn3Aoz4mtvMDX+V3QoxoynHZgrs3wbB7HQ2mTAI/77rJPCTa3ldC2J
         o9HkYQfL7s7fD/xprG06pkSlybgXnnbF+aTXrt6is8hrCOcfgE76euD/tQ1+TDld5Qcf
         PmFIeiCp/EgefscWXP9AKCQKLDUcD3EFmwmiXwL1LlPLxKGVP7lWFpRyMFvD/0qcJA5q
         mu2Jrbd7cVWTRQQRC4ZU/ggQUPBf7AkyLmT0XqtyHgsyQGBWsXeNfPW14TmRmwhQR7p/
         ii7Aib7KVOI7wG0dc7eYhwLShseVFT+/eiHLlriKcIrnONnokn84BNUe/e/3N5V6V7mF
         4ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278824; x=1760883624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfkmdzafh7+VHjG0RAeg5sF4FBAljqq3jIvcOzngZlg=;
        b=iKsfUjzuzLEcLgqz6ImGkLhJFhdiQl7TwFspZlC5TqEmL4GsQbrIJvoxGdqRmKLf4R
         OkynRB5NtjH6XxWPaxIr5iDnFmY8jyONnhJZSBVyJrHj45kuZFo+9qApVZosdvRynLQ5
         xtHc3ACIZ3uF8sxubWfFHlS/wMGDoY8c3uN6nJ0IZmy87QOrzso8ypCwJX+nfVT7V3S8
         8mNMSV2hQTF7GlnnHqZrFelRIqYIBTnLurAHKjUKGHH5gWCy7UDOQjS6/RuIw/eyBijC
         gHugYDJVW2V53KMI04gIAC/zEOfrDJdK/PsBzqb32KBJg6QrQVpi07QS/aHze4zoAerz
         kXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHE4B/jjKqz5/EkV4SFobI0mej2BIvUiXjMOHgebddEULQBPpsNmwr/d3rv1npxB4p7UeWNln0nM6LFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTLeDuhbpSQWnnA3Qi3sAWEH0Ugrer9MwjHTtBKn0/KTS7qsoA
	JCjxpyVZadwM1JjCUuenWlCn4cJXR2lqzv3iJfXSUA1JF3hx1WztIjQC
X-Gm-Gg: ASbGncugXoQLej3Nmx/aBQTom8ntVH7qBGxpD8jb78SfOQNjOpU8Gv3j3HK42i/Sbk0
	7n58Tvs22+XdjNPTJh7Z9rOZ5M0g2qQ/1LjHyxfmClxK+MSi6Rjd/ax4kjxdpT4lgVt0h5QHEbd
	qZ/CsgVK2ub2SBR8UhWp2PqInmKQYSC9rzG/MNaPeveQI0WmipOOQmq0kAlS9e2NeMcvcN6Uqi8
	/y2rEJYEN7ufDct0dzq1FG7uDZRcZ+NCgBSBG8N5gMnyfcAXAdmoSypfEcg45gn1ThxLJPYVsO1
	Uj0JMFFILG/njn4YrJGI3KqJRwNqDGpxgpND2jxzXgPhqrN5Z/rvsRHYmnIJAzrjj8ed4Eb81Cx
	Grbc/RDdPw8R6DGDS7m0HlNmqgthc1A+ZqWQ+SAED7mPaYs0hXgZTJaJGsw==
X-Google-Smtp-Source: AGHT+IFjutP7obK0TADVT6/jr5reX7v34JHSR9gBVaHhK88qEC2UiRaBIKkiBy1t0yjPHCjcIVALCw==
X-Received: by 2002:a17:902:e786:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290272c18e1mr224136745ad.36.1760278824509;
        Sun, 12 Oct 2025 07:20:24 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f089a3sm108167325ad.76.2025.10.12.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:20:24 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v2] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Sun, 12 Oct 2025 19:50:12 +0530
Message-Id: <20251012142012.166230-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the block subsystem to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Changelog:
v1 -> v2:
Rebased it on top of the latest linux-next upstream commit
Dropped 1/7 from the subject as it might lead to confusion of it being a series
Link of v1: https://lore.kernel.org/lkml/20250716090712.809750-1-shankari.ak0208@gmail.com/

The original patch of moving ARef and AlwaysRefCounted to sync::aref is here:
(commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440


Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 
 drivers/block/rnull/rnull.rs       | 3 +--
 rust/kernel/block/mq.rs            | 5 ++---
 rust/kernel/block/mq/operations.rs | 4 ++--
 rust/kernel/block/mq/request.rs    | 8 ++++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 1ec694d7f1a6..a9d5e575a2c4 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -17,8 +17,7 @@
     error::Result,
     pr_info,
     prelude::*,
-    sync::Arc,
-    types::ARef,
+    sync::{aref::ARef, Arc},
 };
 use pin_init::PinInit;
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 637018ead0ab..1fd0d54dd549 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -20,7 +20,7 @@
 //! The kernel will interface with the block device driver by calling the method
 //! implementations of the `Operations` trait.
 //!
-//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
+//! IO requests are passed to the driver as [`kernel::sync::aref::ARef<Request>`]
 //! instances. The `Request` type is a wrapper around the C `struct request`.
 //! The driver must mark end of processing by calling one of the
 //! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
@@ -61,8 +61,7 @@
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
-//!     sync::{Arc, Mutex},
-//!     types::{ARef, ForeignOwnable},
+//!     sync::{aref::ARef, Arc, Mutex},
 //! };
 //!
 //! struct MyBlkDevice;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index f91a1719886c..8ad46129a52c 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -9,8 +9,8 @@
     block::mq::{request::RequestDataWrapper, Request},
     error::{from_result, Result},
     prelude::*,
-    sync::Refcount,
-    types::{ARef, ForeignOwnable},
+    sync::{aref::ARef, Refcount},
+    types::ForeignOwnable,
 };
 use core::marker::PhantomData;
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index c5f1f6b1ccfb..ce3e30c81cb5 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,8 +8,12 @@
     bindings,
     block::mq::Operations,
     error::Result,
-    sync::{atomic::Relaxed, Refcount},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::{
+        aref::{ARef, AlwaysRefCounted},
+        atomic::Relaxed,
+        Refcount,
+    },
+    types::Opaque,
 };
 use core::{marker::PhantomData, ptr::NonNull};

base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae 
-- 
2.34.1

