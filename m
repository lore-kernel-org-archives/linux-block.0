Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208D386C13;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=X33RPQpqSzVS1/v3bTquejo/ljcMw3RX2p/wlW5t81PhMbcR+YTfpMIrBiFfJFATijUL9lfbt++iGmKxUXz/K8XVRZ8G41F/8J4tjJA5QN1EDVvZ4rOme78Rc4iuUHSb3VK0Csd8p4bzcy0oih8GYQKR9MnUL4bptUdhWO0yWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=m1EAr4ayyi4PZbyexLDSnvqug8qI7CL7WNOpMU9eF+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GD+3EbZL8c9ztPMd6rwDzoOcL+IJb9UuAEVJtTJkDz6wrFI5LLNOvUea1LPgg0TghBmgajOeZkoSaDLZyHxUhHgacHWX8HQE1n4r+3P5ZMo8HXEIekFJaSzJqxeygbyjjTmY2kLRlZWtjOT5IFHSBGd2NReEAwsaYQ7MQTHksDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YCfU4Elt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YCfU4Elt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55BBEC2BCB9;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=m1EAr4ayyi4PZbyexLDSnvqug8qI7CL7WNOpMU9eF+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YCfU4EltUvfqUCDL8fbQ4IOVXjV6OB9aQo1hX9J0Ok3E/CGTlygSx4MPEZ9elAI8G
	 oIp025a/8yATSONu/zVMc7K+FyIcYerv7szSrR4YDLWqTGBqrgy5Xj1Z6ZX11Cv/pz
	 p2XMXrw44W2I+EHV81clQbIL4BzENlrmRkqc6zjs=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C2CD343F;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:07 +0800
Subject: [PATCH v3 1/7] rust: miscdevice: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-miscdev-use-format-v3-1-56240ca70d0c@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=1454;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=m1EAr4ayyi4PZbyexLDSnvqug8qI7CL7WNOpMU9eF+A=;
 b=8T1vx1s1VmH35F1FrgNNRC6xE9XlmnV7pJAOkySzqQ2GoLAZ37pb3nRmBzuA26PUPfYJlTJCp
 Re7cVT6TddCAgHDS2FQK2dj/2OHnIREGXSsbh3u+/0l0S3Y9HXXxPpd
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Convert `use` imports to vertical layout for better readability and
maintainability.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
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


