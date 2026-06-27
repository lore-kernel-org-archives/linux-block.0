Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C83537F9;
	Sat, 27 Jun 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552528; cv=none; b=sDTb6w3H1t2tAKYnvF/8ITTdxPr4ymrPbedhZTBfv8keJkkopT6gxHlQn1Ns9wfD+n7LNsFxs15cnd6HizS67/VbBmq4dHg0hrIaOQvX782EGnEjMlEmXO+H5ZLvU+R0Z1GHtUhAZ/qr0qaBAFZ2y+ugu12rjsvFjnygV5CGQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552528; c=relaxed/simple;
	bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONQnS9wkREwGWzmQ/Y0tl5ll8UmplJkd+PJZ1yUmt1jNXcuSjDrxk8wFU6Pk3dXid7i/teZerwWfqk7myOmT/6A2x4Z1juMx1QR7dNQEmh+38cdg+/kXzrvIrwQhTcQRBc+p6eavydVdKjXpP5Rq4kNWAKHdG6UmpGTkj8EUffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6KXIxuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6KXIxuf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2A31C2BCFB;
	Sat, 27 Jun 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1782552528; bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E6KXIxufvzmDwhJ3B+qiurzKVVe6gkc0mi1RSeDIve4uqyGAhBXlWxMSaP2/tFVEc
	 lZSXf9rE2OLS/2JLFHnZY93ytItEFkZOdg2wM+bD/wvEMgDFwZjBqJhy4FrT9Rv0bG
	 Vu4KHqR3L4CqRw1V1W2VT2uYBjpfNRaVmOaUX7eA=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D9C43458;
	Sat, 27 Jun 2026 09:28:47 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sat, 27 Jun 2026 17:28:41 +0800
Subject: [PATCH v7 03/10] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-fix-fops-owner-v7-3-33cd3990edf0@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782552525; l=1329;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=f19XCtBPrdV1fkgcubKrKRKRYVaBwil44TIB/tWiXTo=;
 b=2U+otmBxVn+NwBtMKrH7zr8lFtkmR40aSlcB22On3uei9QlGjxLiHwGSOBAfq3pZuQE9n/nj7
 E01ggwbXEhzAkaUDs3DyRlmc5kwwz2NyZ9XEH7g72CA8YT/eMIR1sNt
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
in the doctest harness, so that `crate::LocalModule` (auto-inserted
by `#[vtable]`) resolves correctly when there is no `module!` macro.

Assisted-by: opencode:glm-5.2
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 scripts/rustdoc_test_gen.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index ee76e96b41eea..198af4e446c8c 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -239,6 +239,22 @@ macro_rules! assert_eq {{
 
 const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
 
+/// Dummy module type for doctest context.
+struct LocalModule;
+
+use kernel::{{
+    str::CStr,
+    ModuleMetadata,
+    ThisModule, //
+}};
+use core::ptr::null_mut;
+
+impl ModuleMetadata for LocalModule {{
+    const NAME: &'static CStr = c"rust_doctests_kernel";
+    // SAFETY: `try_module_get`/`module_put` handle null module pointers gracefully.
+    const THIS_MODULE: ThisModule = unsafe {{ ThisModule::from_ptr(null_mut()) }};
+}}
+
 {rust_tests}
 "#
     )

-- 
2.43.0


