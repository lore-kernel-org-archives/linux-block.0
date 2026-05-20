Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48675302767;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244813; cv=none; b=gpjMp6A9rvXfUIh9p0pOUcAXdF3rNjsTQCtV8vGBlaf7pSQ2l8+g8P78jQIg7wDmdO85pl6kzgOJt6UPwDmaoYJBZlWADOXMlGz18g7XFzZ7HkRQZ5WyykNi2po6lBk9cM47VfDOD1yxXT9SCJxFcUvXJ+tOD38jxNbCM/K89LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244813; c=relaxed/simple;
	bh=MzOQ5Pt5s4zhpYWvG5X1Gx7JCP+doFfRKRAXWizMD0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpqvWW3QXuBTmGI92DHgGkhMwKbcM9l/Q9QvAdGhzFBmr+5LoeV5PnU2JbNRRz39R9hnfCIEgIS72TlbY43CYg8I4uDkJR9sEIRan0SENoJnCxiOd4UgI0fga/+GBHW7p92p7RsJI9NHiHtzJW1RrP6VrQlSSN+1yDahBBYXMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkgXzqe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkgXzqe+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5925C2BCC7;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779244813; bh=MzOQ5Pt5s4zhpYWvG5X1Gx7JCP+doFfRKRAXWizMD0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wkgXzqe+kev3VD0acS5RCp4Ex7JPqa8ifdBxZuUHpXUzyxLUhaQos4+Fqm4Rq/u1V
	 VDFh702nKYQxhhHSX8iriS1RNaXOoxoN8F3KXoXEWsojKeydHIBgfRTkWDr+B2AZX9
	 EBkk254uonqCRzY/EUn3BZ7UdQZZ0mHKKTM7F2YE=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1592CD5BAC;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 20 May 2026 10:40:09 +0800
Subject: [PATCH v2 2/5] samples: rust_misc_device: use vertical import
 style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-miscdev-use-format-v2-2-64dc48fc1345@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779244810; l=1443;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=MzOQ5Pt5s4zhpYWvG5X1Gx7JCP+doFfRKRAXWizMD0s=;
 b=7j21eCYWyyxZxanuzpBiIKhrTgSOV1G9OPU/XinnQvmGMPYYl0oB5SVev1C/Z1VmgI2KjXtjH
 gwvejn59cvXCmLCrfyR/lN8HzdXA8foSEQMxexQ8lEKZn50o4vlVNvE
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 samples/rust/rust_misc_device.rs | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 87a1fe63533ae..41e26c825060b 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -97,14 +97,36 @@
 
 use kernel::{
     device::Device,
-    fs::{File, Kiocb},
-    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
-    iov::{IovIterDest, IovIterSource},
-    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    fs::{
+        File,
+        Kiocb, //
+    },
+    ioctl::{
+        _IO,
+        _IOC_SIZE,
+        _IOR,
+        _IOW, //
+    },
+    iov::{
+        IovIterDest,
+        IovIterSource, //
+    },
+    miscdevice::{
+        MiscDevice,
+        MiscDeviceOptions,
+        MiscDeviceRegistration, //
+    },
     new_mutex,
     prelude::*,
-    sync::{aref::ARef, Mutex},
-    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
+    sync::{
+        aref::ARef,
+        Mutex, //
+    },
+    uaccess::{
+        UserSlice,
+        UserSliceReader,
+        UserSliceWriter, //
+    },
 };
 
 const RUST_MISC_DEV_HELLO: u32 = _IO('|' as u32, 0x80);

-- 
2.43.0


