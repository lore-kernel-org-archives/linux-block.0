Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805434E75A;
	Thu, 23 Jul 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772683; cv=none; b=GF/6uWv9GujnJ9qriFMBqHpxZ4xkf2HBbC+xoU6xvpZ3+EcGii1/fG9hvVLJZaQr2eJpfxFpm/TpRTW1Lb7We/2OjU2qdv/gBCDj6UTsT3CkLa5a+p0Qlho+WL2/xJ629mCwwv+/5Xen8fZz4K1SHGFa4CMCE/q1mvzFTGKdd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772683; c=relaxed/simple;
	bh=b7bgA4GS9lfKOXMTzjt9PgQ7i+Hg/NN96aHcSylK5wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmVqimW+oL/2+CRAKVIt4EUpUK/VF3stfAjRz5iVxZXugTPrbOI+XS6MH6+MZnIp3hZRsTM7kUYjJjyP6SConX3KPyjsTjX4mdfIcKOa4Wo8VbYLLnoPtQXNpp9eXkP46VnxEXNtDMFjy63ux7J9N5YEzBbN1Zim5KAmeoOUU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=trMrDaTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="trMrDaTU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C57CC19425;
	Thu, 23 Jul 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1784772683; bh=b7bgA4GS9lfKOXMTzjt9PgQ7i+Hg/NN96aHcSylK5wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=trMrDaTU9oGMpWKQv3StYauGZvFQGni9gGjJprxxwViNz+ngzk0i6E/qzFl21akXt
	 Y5j9kkJ9OG1v5AmIe8T6sXWUiqc+H0XvHHitamFcknVTvuQwpsDXt9GkuRZkQM7L2x
	 UpwINa+wnJFjarMDzhnBISO5zuIqy9lQXiRAYcuM=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82DC531C7;
	Thu, 23 Jul 2026 02:11:22 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 23 Jul 2026 10:10:32 +0800
Subject: [PATCH v9 09/10] rust: macros: remove `THIS_MODULE` static from
 `module!`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-fix-fops-owner-v9-9-c1c3af7f7bcb@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784772679; l=1856;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=b7bgA4GS9lfKOXMTzjt9PgQ7i+Hg/NN96aHcSylK5wQ=;
 b=XZI9XPcXFxW6ssnwu4RjhBeXuypNQUNTuRBLu+ygEQQcqK4O5f5EZ9xXYVaZ0tSYL3E4VYAqA
 kQqOLDz0hgIBLPSVtrfyYU82hXV4JZXZ6HWkCmNGPBS3X3KR6l5/Bur
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
`this_module::<LocalModule>()` helper. The `static THIS_MODULE`
generated by the `module!` macro is no longer referenced anywhere,
so remove it to avoid having two sources of the same `ThisModule`
pointer.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/macros/module.rs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index aa9a618d5d19e..23b6a1b456b80 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -497,22 +497,6 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         /// Used by the printing macros, e.g. [`info!`].
         const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
 
-        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-        // freed until the module is unloaded.
-        #[cfg(MODULE)]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            extern "C" {
-                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-            };
-
-            ::kernel::ThisModule::from_ptr(__this_module.get())
-        };
-
-        #[cfg(not(MODULE))]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-        };
-
         /// The `LocalModule` type is the type of the module created by `module!`,
         /// `module_pci_driver!`, `module_platform_driver!`, etc.
         type LocalModule = #type_;

-- 
2.43.0


