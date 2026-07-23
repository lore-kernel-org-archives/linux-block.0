Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D432347514;
	Thu, 23 Jul 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772683; cv=none; b=pfwkzv3e1/ZdcAVR9Av9f1h71TpPaiK6f1261EfeA2p9oFerj8GUwvxJAJSZP8eyiJSYPHXCYakExwE/Kn56gik09AU2lfcSE7UWXWYr1f/Qh2bfaXKV5lOWf3VzL+lEPCBXJDdWDHvqOsVWdDleYLKX/7yV2iVqALOIMxGJksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772683; c=relaxed/simple;
	bh=Y+g5XGXUpaEPEpNu/2z6EYlrPFXE16lF+w/ttECZ4PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2aR9zjHrkSIDPQkQsaipnzpKs3bM5HsB9bbHuAHzenIE+KhXQsPYieXAMJ9mzQqGvgFkpPlROTCyj5yT045VXGNSLNAlOeapmOS+LFKzsXCDidVQZzOLfD9bW7h3B9UjxYwmZcrUoPoLmF33YRDHG4E8aF59q2CpNjoyblqry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYNvYe0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYNvYe0R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E741EC2BCF7;
	Thu, 23 Jul 2026 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1784772683; bh=Y+g5XGXUpaEPEpNu/2z6EYlrPFXE16lF+w/ttECZ4PY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYNvYe0RUvsPYAGRhDw6q1NgLASdi2GaHVZRr+nnpYYwkRyNgoZMCBCPAAuQOi3vf
	 1j83/s+AndcNzDQkMgLWuZvpYDKhG8/SJpjmeP23xpYs1kWkChERamTejEkx62PxOc
	 jwO8h1oeuDWHZzqi862nREsclb+qHz/jVWTR3D/U=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5057C531C8;
	Thu, 23 Jul 2026 02:11:22 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 23 Jul 2026 10:10:31 +0800
Subject: [PATCH v9 08/10] rust_binder: use `LocalModule` for `THIS_MODULE`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-fix-fops-owner-v9-8-c1c3af7f7bcb@linux.dev>
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784772679; l=1425;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=Y+g5XGXUpaEPEpNu/2z6EYlrPFXE16lF+w/ttECZ4PY=;
 b=B4b7u6KtkI40/woTUYD5H6mrDul6s2qfLFISdlbTRo0/o03h6wBZ90jKOEBGacucKVjUzUEtk
 tyWBvcyuVlqCc2XrmP2l7nPaOux5ez8JPCBwAMGoQP4+pkpUn244pEB
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Replace the `THIS_MODULE` static reference in the binder fops with
`this_module::<LocalModule>()`, consistent with the move of
`THIS_MODULE` into the `ModuleMetadata` trait.

Assisted-by: opencode:glm-5.2
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/android/binder/rust_binder_main.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index dc1941cd2407b..d6ceebbd5f94e 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -17,6 +17,7 @@
     bindings::{self, seq_file},
     fs::File,
     list::{ListArc, ListArcSafe, ListLinksSelfPtr, TryNewListArc},
+    module::this_module,
     prelude::*,
     seq_file::SeqFile,
     seq_print,
@@ -318,7 +319,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
 
     let ops = kernel::bindings::file_operations {
-        owner: THIS_MODULE.as_ptr(),
+        owner: this_module::<LocalModule>().as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
         compat_ioctl: bindings::compat_ptr_ioctl,

-- 
2.43.0


