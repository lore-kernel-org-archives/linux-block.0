Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500F3570C8;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349978; cv=none; b=d+unlt/Yy8LtxQogRl7s2fG4wVe22HS4LtYgsdNXEkUaLghUwhvay+ivxYeY8ohSqNU7bmZAbZsgt+cGZ4cCWLSNxt/SpKNMHidwlruoUMvqzEv6ozinU8q1cYkoS/f/VQ7mKCJ0yHdOgu1NYA+mfqxnGKQ6MOj8WGkaNM0QnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349978; c=relaxed/simple;
	bh=igfKdO1neJGj7Xg6xYLkNhUmyQWCWGYNm1ghjHlm9Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Px8Sgq7euab1YOwlXhomLlPUAWGu7sZs/D2Y5R33bWLknY4ThIVdI7vYYaDl2S/2TNMoG3OxKl9yF9CItn02k+7YKYp59qwgszp860/yUJl2/mF8i3quuikS+q44D/YofCAHWVnRNzEaOIZONk+LAl0N+s7JNbVsEynsEn4uVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lko8sLPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lko8sLPw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9281CC2BCF5;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779349977; bh=igfKdO1neJGj7Xg6xYLkNhUmyQWCWGYNm1ghjHlm9Ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lko8sLPwkDsoRcgsQrusAof3Keyg2dX6AZDvrMnjoFhmHUNJwIsSRnO4rR9W464rf
	 +32O+5QWwK6iBG023IMHvPftROEIjLtG4RCWfnxWTB/D8ana6ACfhAOhb6h6DZg2Q6
	 lbz3QRKVPw5A2LH/vpbfBVwjkEzTfMqlWtQUsdkw=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F8FCD5BAE;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 15:52:55 +0800
Subject: [PATCH v2 3/7] rust: doctest: add LocalModule fallback for
 #[vtable] ThisModule
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix-fops-owner-v2-3-fd99079c5a04@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779349975; l=1155;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=igfKdO1neJGj7Xg6xYLkNhUmyQWCWGYNm1ghjHlm9Ts=;
 b=Ubb5+DjFaDZl1QG6msYhLYQXO3XoE/obxTPEmhDpWHhkqkskJ/AaP5OP7ETnNf7BNSiQQMVSo
 NiYU21Tty1pCcwjGht3L1od+nJVFQw6SQkngoRE4uCVCx9Xw4fmnGrD
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Add a `LocalModule` struct with a null-pointer `ModuleMetadata` impl
in the doctest harness, so that `crate::LocalModule` (auto-inserted
by `#[vtable]`) resolves correctly when there is no `module!` macro.

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


