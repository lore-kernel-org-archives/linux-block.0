Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF5386C12;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346633; cv=none; b=lIPT3TYT99T0xwPLe+b76ZX3q65pq2ZdZQNTPe9e4hBMReL5V5A/pCI+GYbFgE9jaGlrrFiiX9Ib3wIhfSXAW2mG8yN0CAnPMUikpkBzKupyycCOxIMSR1fIM+J2IVVHEy0h+3Bm1no0RGEEQzmH2XVfLnr+2Gqq1wpsy5xXDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346633; c=relaxed/simple;
	bh=tsWNoLHw5b6lswTiwoRM6WM3/YV8g2mxjpA+1r3XPy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tITjcZtWNEEnvWhzNMBEwZwg+ZytVCEqJWpDbEsBDDEmUPJL1+3deMqVgd0gQ2s1AhIU0J+sQUPpfs+3NLaUMpS3YKlp2g7JL3/En8C19IEANI8T2DljrkzNktwyMtOmg8K0wL3nK46Ru6alftNqqnCdO7MAtaaWwF7F6rFP1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8rGckOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8rGckOU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E818C2BCC6;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779346633; bh=tsWNoLHw5b6lswTiwoRM6WM3/YV8g2mxjpA+1r3XPy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m8rGckOUSIF2ISHfN7Ohb7lArwd3+qB2fJ3upym2LWWM09001RWgpkuy3MykGJ4Yp
	 hhP02JgcMA/2pmbRe8MqmAKtKNeaPOVyA9psMkyfdcYTmYTgqg98MISqJY0WPUGhrl
	 pTfqRmUhhHkzcIesTIKOxkwU8CDSCJluMS5ucyWY=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D8CD4F3D;
	Thu, 21 May 2026 06:57:13 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 14:57:09 +0800
Subject: [PATCH v3 3/7] rust: miscdevice: remove redundant imports
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-miscdev-use-format-v3-3-56240ca70d0c@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779346631; l=1041;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=tsWNoLHw5b6lswTiwoRM6WM3/YV8g2mxjpA+1r3XPy8=;
 b=SuB44xDjNhUmmiYYSpJg2x38ZLTc6hj2S+VHHJiHCkFL3XRZepnVr26E7c492+gBSc/5ofRY2
 y+m9C0eh4LGB5XCXDDna6xY9tVrCLw2XNGsUKdp2n76yoVgZxGgfYsY
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Drop `Error`, `Result`, `Pin`, `c_int`, `c_long`, `c_uint`, and
`c_ulong` imports already provided by `kernel::prelude`.

Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 05a6b6b9770f2..83ce50def5ac9 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -13,16 +13,8 @@
     device::Device,
     error::{
         to_result,
-        Error,
-        Result,
         VTABLE_DEFAULT_ERROR, //
     },
-    ffi::{
-        c_int,
-        c_long,
-        c_uint,
-        c_ulong, //
-    },
     fs::{
         File,
         Kiocb, //
@@ -39,10 +31,7 @@
         Opaque, //
     },
 };
-use core::{
-    marker::PhantomData,
-    pin::Pin, //
-};
+use core::marker::PhantomData;
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]

-- 
2.43.0


