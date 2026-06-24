Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3673B6340;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305855; cv=none; b=S53NIhtYwdRZkcj9qYZ0yk6NL/dnBQk9kP3S7da/JPKC6TDCpqtJ0JaYxpawLuXuLDtgLAUDmPCHlU/D7y0SN/63Cj66F6h251e4qULF0wj31G+Jciphxpuot2CfGT64gWjBhSJ2CTh/R6wlFvfsjybRC4y9WaVpAEWU0BhoDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305855; c=relaxed/simple;
	bh=4rqp7Mtw+lLM+FKB47PogTfFETV0pjaExLBQOXFyKJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiPuy1oEN02C+dqZCxpsE0HCmHsoZ3828v9sL5KBJOsvq+l6X3oGKDkJritcxLzUEiC0FwVWRRtoPF7e56bcB4sy/KqTtQwOmWzJQOLeIjLwnaHCr+FluVoFpH2q0cJ3mz8DqkbK61BTcBnUez6PU66ICqk5cOSSIcH6rSLDEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOXUDv/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOXUDv/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE4DC2BCB7;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782305855; bh=4rqp7Mtw+lLM+FKB47PogTfFETV0pjaExLBQOXFyKJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sOXUDv/QB55ECoFc51FmelFJGYHz5mi0jk2BcWTDtTceisy/dXdU1Kz1N2hCn97wl
	 6cceyImolNrd7OqLwSS2nLHaRBGudwoJRpJRcEdk4PdiyIsmV29OIbBB9mAmpEgmxE
	 JkvrSPyfVt9sW085rTUku9hIrkHx1UBq3fzu76Vw=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A1CCDB481;
	Wed, 24 Jun 2026 12:57:35 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 24 Jun 2026 20:57:32 +0800
Subject: [PATCH v5 9/9] rust: macros: remove `THIS_MODULE` static from
 `module!`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-fix-fops-owner-v5-9-aa1cba242f05@linux.dev>
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782305851; l=1762;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=4rqp7Mtw+lLM+FKB47PogTfFETV0pjaExLBQOXFyKJo=;
 b=MhJ332sYXG8TbDqMOH4VaZYWiCkguj7jCz0K1LQzpfaPp4DB5kuNGDpPrR+tsttf9XMlF0p5J
 7sDR2hmnqCoDMYyyOKBxNR6cL0lEKBQsLXA1+O3S9eTcDPjsOUylYCZ
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


