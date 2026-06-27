Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860D395AF0;
	Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552528; cv=none; b=f8end0VO4kVkX2hbbJxmC2b1k/MrtDZABR6WJYppLKvEurUau6DvXgk5fPxC7KESP1BLM55nlKCjW0KCcFSMf6WqfaWrDnWZZIEXMPkg+r8o4D5RVnpdwLjsz0/Fv4f9eTIx4V5chudI27aIVanXRuOKBzF+IPWK96gZYkHWh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552528; c=relaxed/simple;
	bh=E3Ff9Mu94arzOwgDcoZ08rcTHdfO49LWEAJKitCAuDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcxrYMWsgjjBSaeROdnrb/Z/cEf/VdG4JxXpkRn+jEN8K7wVP0qkBVkqCSWXe4cVFH1PJlthSVvvc0beEKReUugmurk0XezWkXig8IvxQsbTDDm9lUQHvFfexcpdmffvSvj9GIME72wRJUhb3iMJ3HiRmqdpO4TG1la+Fgu816k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XC3Aszvb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XC3Aszvb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F1D2C32781;
	Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782552528; bh=E3Ff9Mu94arzOwgDcoZ08rcTHdfO49LWEAJKitCAuDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XC3Aszvb4Nmjv1+MTv52tWr+/794yJaGNYKNiY1Zgx27g419NozrqNr2RoysJcgPX
	 LcyZO90Ega99/7o349UtHnlVpRmchfSRE/c0l1vKepZHPUbXai75kQ360K6YFJ6nbR
	 4FYVgOSBeZ7iYLySaF3QqkzBakUjXTiA/3Htknlg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349BCC43327;
	Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sat, 27 Jun 2026 17:28:45 +0800
Subject: [PATCH v7 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-fix-fops-owner-v7-7-33cd3990edf0@linux.dev>
References: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
In-Reply-To: <20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782552525; l=2811;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=E3Ff9Mu94arzOwgDcoZ08rcTHdfO49LWEAJKitCAuDc=;
 b=p3Wo2nElrTlBvlkjupMtKaf26cAiim2UaK2YHxd0IEQzdwKS2aoXmoqcoYMwNeDSvCXA3naI8
 MH5hRrZOTkwALQU4N/SPpwS9c0bD7lfj8IUFvvObjIvHOraDyevoC/o
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
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/block/rnull/configfs.rs | 6 ++----
 rust/kernel/configfs.rs         | 9 ++++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index c10a55fc58948..b2547ad1e5ddd 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{
-    NullBlkDevice,
-    THIS_MODULE, //
-};
+use super::NullBlkDevice;
+use crate::LocalModule;
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


