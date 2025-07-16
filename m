Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C72F2347;
	Wed, 16 Jul 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656851; cv=none; b=rMlk0xr1CpvoTLh9UUMAnteUxR39leU6A2KEtDtfqhLcLwKm6duTew6TDZYRxUfqDYlwMyHf30csTDSUqVzJnLAfuwXovdXtb+gAQoCXH5OZQ6VEgSD/nVEJnzXYjlHY6AXd4SUvqqsGmPt3ho0Jn/DFT17viclMOZPlxyDkY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656851; c=relaxed/simple;
	bh=5Ptgz3f9+MROL/CBA8PmM/l52N7ZDaPCRTd/bnU6Aik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BomTB3w91TC4aV/KvNg1I+vtxNr+djK/sOSx3Fd+ZnVQxGLwHVEsgI7m5vVQ/Czx0Wqq4pkJFAD8zqAfHHV96BXntv09jOXYSg/ScV9P8RyT53sGFPBWNrmoMaYZMhwD7PHbHm08hAAuXrv6pWbwtmKjUQLQBufA3azAl6/M9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jju/lRLS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jju/lRLS"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so5779216b3a.3;
        Wed, 16 Jul 2025 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656849; x=1753261649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vomQ2XAeV7E4V+uYTp7TsUwfXDHnmYQsX/lVNvXhnH0=;
        b=jju/lRLSxVA555/mXephrgaQA0qXox+6HrsqlPra8D0KKkGzIRrX7qizIh6NUlpBFG
         cemJ3cbmsKPldqa2KLCpWkdyFfIikAawfM03cG8cfJW/vqwkaE6IV7GNKyj+fD3YQdiZ
         A0Hybu0ALX7zIPQhYvqEfqm3plRSSSpwaK2AtNNbyLSZhhbyXdDMnIZABUQuwmAn5zmq
         i8TQzHh7FzS6tN+f8kqi0vvXvB6R/8Gxh8jNiYvNZlOv5NUu7gyRTMYJ0xXe1QmDp7jU
         14Ipsfsgcbm212Vi2abqk6sBAgiKelpXbeejy8hK3t6jJj6i5KLPVEN6Cemr4qSTXNLw
         EKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656849; x=1753261649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vomQ2XAeV7E4V+uYTp7TsUwfXDHnmYQsX/lVNvXhnH0=;
        b=t6wsViAhkcdQb7v6P+qYkwsRJonRCRCwqs1sMZlYqtqRZASYWo1HrS72DBx+8IjUYl
         yvLhoDCj77JveMQFOmAf/LNRi+FrzOmtDkpCqcaabnaF5DsJh0VBiLCigI+6SEGDB3E4
         hoUCnvbjmbB1vlAyFnsLFoPCvE6D27+SGFhGSSdyycjhGrPGYIW5mZgDafL+ltTd8y72
         eCCrBs4tYae0l+BO+bexqrGKZhLDRvMkYxVKL4kNZ3vVWzK+0QwibSUTu5pP9xWboZiT
         Zb001XD6GLRDFHQief7hV4v6oJT9/CDDZ1bhOna3mSRzdJiv1NCZsdWbGtHbM5l714Z7
         eR/w==
X-Forwarded-Encrypted: i=1; AJvYcCVPG6eyIQelPi8Vz8HAGMEPC+OY8c/fZBdATpkVVHEV/zeDc87FOBz5rA5al6U+KQiiq4+mY4mSfnDZ+g==@vger.kernel.org, AJvYcCX4Rt+syVT4AR9x1vmDu2d++L3AufUd2b5rX3b+7+mwTiTAW0wV/ehVDqF3VsKNBuq7SMM5SZn1vog/g4K+3Us=@vger.kernel.org, AJvYcCXl6dehDZhahZL6OBxpEF36vR/LD6NmFh5RAlY7LuIafESoHbK0LsOzWpoClrjmFJWkBK2ZG9xYI7L6jMuQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxczB7qprANWHrFZDXanfM7FXtpCURBWFPzCn8fvJ4wE2i3LFwj
	/QCgNusz8+I3Xeew1cssn7BtZUxxp6QW9fs55guVtU+JB2BjGGx1n4vL
X-Gm-Gg: ASbGncsai0IrQASyd2voJYqP6qgoIqQOE61PrZYK0tr9qANlX8+Wti6bIG15EspMIsc
	RT1NJ3srH8E5OQU/jAQ5YyoebiwTsdbgVWn1LmgU8RjBWHcaL54QDlO2s35mWpImZyeHdmNmFVS
	3L4oTms5eoo8GsaXoez66F95xH0BwOzYth2uispQ3HooCtVMCddu5rE3iSpETlT864VX0eeZ/h4
	xsrYDuLqZITIUszJTxe0qXMtoxr9ok6QibJL7j7zmktItKCQjQxYbGjgXYn3/yCn/x1TCm13TCJ
	J83vvEqGthPK5bbmsrZXqQsgt7oRKn2Dsap0pXHp2jdn/9wpGcyAAR96nLO0mw9nCJdSIhNSYLw
	BAbzc0zfuTJE8M/zM8ZBegwBdOKxwuDnJi0DQMgioOw==
X-Google-Smtp-Source: AGHT+IE+lkGos/eOib4IJ67eb0STRYHcphDfNyAjb9PX948W5/Kn7Y8hVwDkGrkdolb4CGXnvwNc4A==
X-Received: by 2002:a05:6a00:4fc3:b0:757:51d:9a18 with SMTP id d2e1a72fcca58-75724a82eccmr2427724b3a.16.1752656848715;
        Wed, 16 Jul 2025 02:07:28 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:5b3d:132b:96fe:c1fc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73d1sm13738806b3a.10.2025.07.16.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:07:28 -0700 (PDT)
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
Subject: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Wed, 16 Jul 2025 14:37:12 +0530
Message-Id: <20250716090712.809750-1-shankari.ak0208@gmail.com>
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
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.ak0208@gmail.com/

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 drivers/block/rnull.rs             | 3 +--
 rust/kernel/block/mq.rs            | 8 ++++----
 rust/kernel/block/mq/operations.rs | 2 +-
 rust/kernel/block/mq/request.rs    | 3 ++-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..80a0f7aa949e 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -20,8 +20,7 @@
     error::Result,
     new_mutex, pr_info,
     prelude::*,
-    sync::{Arc, Mutex},
-    types::ARef,
+    sync::{aref::ARef, Arc, Mutex},
 };
 
 module! {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..3e7e0de92604 100644
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
@@ -57,12 +57,12 @@
 //!
 //! ```rust
 //! use kernel::{
 //!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
-//!     sync::{Arc, Mutex},
-//!     types::{ARef, ForeignOwnable},
+//!     sync::{aref::ARef, Arc, Mutex},
+//!     types::ForeignOwnable,
 //! };
 //!
 //! struct MyBlkDevice;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index c2b98f507bcb..18d858763e08 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,7 +10,7 @@
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..9cca7852b309 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,7 +8,8 @@
     bindings,
     block::mq::Operations,
     error::Result,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{
     marker::PhantomData,
-- 
2.34.1

