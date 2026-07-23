Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE2347521;
	Thu, 23 Jul 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772683; cv=none; b=D6vMGtvnOxeZryF/lt0FsgUJTs3IpQQPHBU7xL/avgMbnLfdcIYspASXl/900YgCswGUYnuBS7jyVUI9mYoFUHpIuL1VvUqOz9YkhQ6/3KqhCH1M8r4y1zbHpcgtbBoqD0li0HvstXpqmgucZk4jKsI7znS+AqCEWGY9fhFYrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772683; c=relaxed/simple;
	bh=t9D2Px8pUwrEcOg/YTzMXGqqQKBGT5HfYznSBGN9YqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7pUeiDRLGu1cZgmFuVlChF6bFRaVOO6QobM9/dOOwVYsa3zzPnnaR2ojjIlbos6vzNVNyiGZnDH2MvMIeyBqiBRbgUwFNyt/FB0B+Qo1lKhGma7icdvee1Bm6x3fMaZxy+B+acOulQ+JeOSqy/Tt4HH2IiVfP5Ug+Nc90xJR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N+wSgFUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N+wSgFUP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D83A8C2BCFC;
	Thu, 23 Jul 2026 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1784772682; bh=t9D2Px8pUwrEcOg/YTzMXGqqQKBGT5HfYznSBGN9YqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+wSgFUPaBD8171l+J3Xvph9ARrvPMb+adPAc72ucMIdok9l2pihAzvE9AAA2ogVM
	 owO5k6LWXV2Ttrrncp24de7KOXSgWR6jcnDdCdQpLft203ZHFpuoJQ0z9suRdOeBRx
	 90SH7Jx+EZuSRBx5fc6Tb5CSa+1usyV0FU70M8kc=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0704C4453D;
	Thu, 23 Jul 2026 02:11:22 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 23 Jul 2026 10:10:30 +0800
Subject: [PATCH v9 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-fix-fops-owner-v9-7-c1c3af7f7bcb@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784772679; l=2926;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=t9D2Px8pUwrEcOg/YTzMXGqqQKBGT5HfYznSBGN9YqI=;
 b=QZpTbDGCiPyQZWT6ru0P3y8GEoRjWyDK+AFBRqjSgxVq0X4noWfmwaxT70UPXQMMvr7jlF35Z
 vgBLVuANHIaAGbw26r2bwD49K5AuQ3MeM01jwmBqEq0KNl1K5JUsYXA
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
macro with `this_module::<LocalModule>()`, and update
rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
with the move of `THIS_MODULE` into the `ModuleMetadata` trait.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/block/rnull/configfs.rs | 5 +----
 rust/kernel/configfs.rs         | 9 ++++++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index c10a55fc58948..9b28be2150933 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{
-    NullBlkDevice,
-    THIS_MODULE, //
-};
+use super::NullBlkDevice;
 use kernel::{
     block::mq::gen_disk::{
         GenDisk,
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325d..cd082b83e9e74 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -875,13 +875,14 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
 ///                 configfs::Subsystem<Configuration>,
 ///                 Configuration
 ///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
+///             ::kernel::module::this_module::<crate::LocalModule>(),
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
 ///     &CONFIGURATION_TPE
 /// }
 /// ```
+#[allow(clippy::crate_in_macro_def)]
 #[macro_export]
 macro_rules! configfs_attrs {
     (
@@ -1021,7 +1022,8 @@ macro_rules! configfs_attrs {
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
                         $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            $crate::module::this_module::<crate::LocalModule>(),
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1030,7 +1032,8 @@ macro_rules! configfs_attrs {
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
                             new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                                $crate::module::this_module::<crate::LocalModule>(),
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 

-- 
2.43.0


