Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795B3845CB;
	Sun,  5 Apr 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433331; cv=none; b=r1uYyzux0VLdKyZo1XnwNcFiArcb2quHNw4/KJvqj9mTA/fD2d5Ir3DzsVBLb5bV0lc8qvhPWUelV9X/n9AcpE0RGjRtHpuPpAwquT3AVPUDR7nME670pDY6c3kXjoBYtzhXCOfWFsdbim4fx2EZR634Whxb52kiCScBsF2T3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433331; c=relaxed/simple;
	bh=y9tHNT9LLwvCnIp2g8KfzIzoqrv/gM7tQZbqTUN0GxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URuckKw5wV9u8gUxH76Kq+65Zax9e4E96EXF9g8CwvkUFcazXKqfcZMnPIehrlPuRE8ZM5Tgl6dmTkIQVIVWs3Cc6qhRlktfDoV4ggK1FnMd9xSPmBy29Q3chP8e7rdFR5NudURbpDMOtgTawnoWnOUIqIqP/yCNZFSpBm5Z1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWyM8OyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWyM8OyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E1C2BCB0;
	Sun,  5 Apr 2026 23:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433331;
	bh=y9tHNT9LLwvCnIp2g8KfzIzoqrv/gM7tQZbqTUN0GxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWyM8OyKxUz2TNjL8+e0G5SaNub5kKLoxTD9YqzS8KN12eDUh3ZxxS1ZwAzbPmbfi
	 nDroB+Dw6RlYMaIL1hnynDku4rObXrjTriUfRg/LjdBlpJ5OogQ+hXxDqZ5iAO3GAK
	 e23RwquOxN6ersxOC2v4Ca/qVybz5FXHmP0vq4U7f/+JsRHgs3qrHbTqzV1ypTAys0
	 UfpfwtLB8OR4qY8z6MRfaqIIuEmSd/QnTRo3ZGXmJFgkIE5hy3PpAGlENeQma7W6Kh
	 TbGlWD7OxbQ+ffRD4Uktwmuh8O2wehF4rKRblvXpaWPq7wb8e0PQQD7ybIk0+Jhh7V
	 ALQrawJ7O1w1A==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 11/33] rust: kbuild: remove skipping of `-Wrustdoc::unescaped_backticks`
Date: Mon,  6 Apr 2026 01:52:47 +0200
Message-ID: <20260405235309.418950-12-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in Rust 1.82.0, I cleaned the `rustdoc::unescaped_backticks` lint in
upstream Rust and added tests so that hopefully it would not regress [1].

Thus we can remove it from our side given the Rust minimum version bump.

Link: https://github.com/rust-lang/rust/pull/128307 [1]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 16ea720e0a8e..5dc8b4cc89d1 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -75,8 +75,7 @@ core-edition := $(if $(call rustc-min-version,108700),2024,2021)
 
 core-skip_flags := \
     --edition=2021 \
-    -Wunreachable_pub \
-    -Wrustdoc::unescaped_backticks
+    -Wunreachable_pub
 
 core-flags := \
     --edition=$(core-edition) \
@@ -209,8 +208,6 @@ rustdoc-macros: $(src)/macros/lib.rs rustdoc-clean rustdoc-proc_macro2 \
     rustdoc-quote rustdoc-syn FORCE
 	+$(call if_changed,rustdoc)
 
-# Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
-# not be needed -- see https://github.com/rust-lang/rust/pull/128307.
 rustdoc-core: private skip_flags = $(core-skip_flags)
 rustdoc-core: private rustc_target_flags = $(core-flags)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs rustdoc-clean FORCE
-- 
2.53.0

