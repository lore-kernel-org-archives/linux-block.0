Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335E39D6E8;
	Thu, 21 May 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349978; cv=none; b=fYRsL4uttJoiLnG8l2VvZPds5EhDNRLoi/OamfCTY2554GpPe6ul//gfm+Dmk2qzkoBkWiyJi+8h+/qZNP/01IlCuQJpRgecnccVrNO8YxQ39PBgAzYsJzfoR/ic6p+5xwuc1kzlTui/Vaydh812i3wj2KPanKRfA77qfPGiCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349978; c=relaxed/simple;
	bh=IhDcgM1opHQeEW8Lhx3ILcfCCuQubakT0ILbtE8LP9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRl9OuQuy+fcprx6ioJ87lZsqrQn3dDjl+46NreiIzx+FtONlj8qOWhDk+pY9XRggfr1rp/rckv5ZapK7wxzpxKRxP7mE9cmHBzWIiybB0mjsJg3adgjPNcld1PtK0XPGBWv45ZHHUa8gS8MquMXTY1A6MrAYbEpdYaWc//FLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWlSCKvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWlSCKvu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5E8AC2BCB7;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779349977; bh=IhDcgM1opHQeEW8Lhx3ILcfCCuQubakT0ILbtE8LP9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FWlSCKvuJDPYLkC44Cysam4hJdbuocMZqt0GTqvStv4m70h6C+/l2VxwuRc99cOm7
	 VHC8kj2kO3xDN/ZulFll8h49EDtg+6b+uyq6HwoQEso3Ns7w4/kvQs94iQbncwDjV5
	 1TRWsfVD3awlJNY6A4M4bWvwOinxzxe5dIk+8ATY=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D5CD4F3C;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 15:52:58 +0800
Subject: [PATCH v2 6/7] rust: configfs: use `LocalModule` for `THIS_MODULE`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix-fops-owner-v2-6-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
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
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779349975; l=1996;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=IhDcgM1opHQeEW8Lhx3ILcfCCuQubakT0ILbtE8LP9Q=;
 b=xu7fCCb/X5SIsHPhPGu9B415jM0ngv4cFvYDJedOxZLgAglNfbavmx+H5SJ/7zGEINxd+Txdg
 uO3ilrLZMqRDD0SOxi9FUK+DUTpUcvFD0DSJIdqnk3/NIwKv7PrqhdA
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
macro with `<LocalModule as ModuleMetadata>::THIS_MODULE`, consistent
with the move of `THIS_MODULE` into the `ModuleMetadata` trait.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/configfs.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325d..cc60297f11551 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
 ///                 configfs::Subsystem<Configuration>,
 ///                 Configuration
 ///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
+///             &<LocalModule as ::kernel::ModuleMetadata>::THIS_MODULE,
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
@@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
                         $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            &<LocalModule as ::kernel::ModuleMetadata>::THIS_MODULE,
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1030,7 +1031,8 @@ macro_rules! configfs_attrs {
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
                             new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                                &<LocalModule as ::kernel::ModuleMetadata>::THIS_MODULE,
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 

-- 
2.43.0


