Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F33019A9;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244813; cv=none; b=AWG3HxbvKw6xmhTqmy5RDp2Riq+T98kq3aMaGPdUslgJ9JOosvlHjDv5/q+T6J3MQJaArD6BOtMvcQum8oMJ3mKw4hTjQ0QxvJuQw7vKBn9g8Uz2XcNBitFYEnbgiysM0qlEU1Xy50ivsfnxylfLYFM4NjOI3qTdhvkPDnVVtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244813; c=relaxed/simple;
	bh=AV47rjXFO0/wbv6GFtBokp+VX/PNUmOVVoRmvyG9Rk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptTJYPi0YuDK5woWaWdsr3KsIvhgjMhkaGhYDxB4hEV5oUpTXwCS7RhToW2BAxN7gSUfF/dny03rJeG6bBL1B8Kl8DODjAVVitys+e9H5vVgAieQ1f3s8lpqzsTWLrWyIi9DL04zXxAq8dx3EmZayf3WgX+r5mHlj1PGG+8k+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YYmvm2c+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YYmvm2c+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D85A0C2BCC9;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779244812; bh=AV47rjXFO0/wbv6GFtBokp+VX/PNUmOVVoRmvyG9Rk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YYmvm2c+rMGXS2bGoLNhLk2XEbdoWpFCD3A6+GENxNiuz7PMsehZAJ4LyMsMsLGOR
	 mWXU4EgP7b0S/ySw7WiLnyd5nRtk0/Vy7kPzqlFE7+WjYw4p+1zGynHLIp3gABU8Pt
	 /11lgO6gbOrrOXiU1a4JkSoVmhPOC3dYFdcQ2zhA=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDFCD4F5E;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 20 May 2026 10:40:08 +0800
Subject: [PATCH v2 1/5] rust: miscdevice: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-miscdev-use-format-v2-1-64dc48fc1345@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779244810; l=1407;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=AV47rjXFO0/wbv6GFtBokp+VX/PNUmOVVoRmvyG9Rk0=;
 b=Y8NNa56XyGddhSgiCnHOYa6pUuDvdRuXERWzmHnIOFWiCOkPF45AhmTP+/rst9PGYpFMx7D6u
 daSItOnSsTaBs+igs6QSfcdNhEFhEtTQVySpFaJ0Xx5ppcdjFEbxbdU
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index c3c2052c92069..05a6b6b9770f2 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,16 +11,38 @@
 use crate::{
     bindings,
     device::Device,
-    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
-    ffi::{c_int, c_long, c_uint, c_ulong},
-    fs::{File, Kiocb},
-    iov::{IovIterDest, IovIterSource},
+    error::{
+        to_result,
+        Error,
+        Result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    ffi::{
+        c_int,
+        c_long,
+        c_uint,
+        c_ulong, //
+    },
+    fs::{
+        File,
+        Kiocb, //
+    },
+    iov::{
+        IovIterDest,
+        IovIterSource, //
+    },
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
-    types::{ForeignOwnable, Opaque},
+    types::{
+        ForeignOwnable,
+        Opaque, //
+    },
+};
+use core::{
+    marker::PhantomData,
+    pin::Pin, //
 };
-use core::{marker::PhantomData, pin::Pin};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]

-- 
2.43.0


