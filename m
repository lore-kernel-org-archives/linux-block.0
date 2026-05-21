Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2110386C2C;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=LsmwnSEEwbgg5/4ykzjAuW1xNVO15vDhvRun1Am3jhSbBW5hB64H7zwYZzUYgPWwz27NyRO58fQvVrVOF2pi27RC2JQDSpdJvk5/Pd+RO2D0mRWGotM1LlS/2/1RFKOZG0jbtKTdorfU4pn/ciKG+Fj2WlSAbhNLkbfgXylGZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=puXfGCYwKj9KZoqq4lAslLMOxSLli8QKF89rbO5bupk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EALroT+ZzWqJiwqWOF34LiQfQZ0ZhZPfONV06Ujnh5VUi2Scum8jKr7AOKzTG8wMohWZlzl1m2ZtmNES8whdS6rFZqzxCzDZOjXblTI41pxMD2mFL9MIYhi314pOJbR1Sy9Tqq+BPuggkAoQ4SvYAHgQ+sh1JI6Rb67WRuatiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pHQJI6cQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pHQJI6cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F49C2BCB7;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=puXfGCYwKj9KZoqq4lAslLMOxSLli8QKF89rbO5bupk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pHQJI6cQGFIvRYNIbAgbxvXZA/uT6ba9hWaz8lzgtpeltkbBkP6a7FN6kmPV0QZFp
	 k5sa+LFnpFfUVooZDHZh2+AMVWos3DXG86WlK2qZidmGw6VtchfqzztqSPAQXa1uH/
	 5moK/vr0Nbq1DP2IusWNMbH3y80srYWsxIcO01k4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517E7CD5BAB;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:08 +0800
Subject: [PATCH v3 2/7] samples: rust_misc_device: use vertical import
 style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-miscdev-use-format-v3-2-56240ca70d0c@linux.dev>
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
 Alvin Sun <alvin.sun@linux.dev>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=1490;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=puXfGCYwKj9KZoqq4lAslLMOxSLli8QKF89rbO5bupk=;
 b=AHgTxDJT97Y3J5pfw7L4ai9jDzXQPeuD8oxvnNpuHwocaCFUY9cWa78C33eUNr5/SwKw8TUGb
 duAVp36AC8eDUZ18UbQSfyrRvO36UgWBjNI+JapNeyZZhjXX8juPNhk
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
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


