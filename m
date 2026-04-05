Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FC3859DD;
	Sun,  5 Apr 2026 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433576; cv=none; b=axq8H96OiXgSpTcsozUoVAG2qvyaeJFgc8pCW90a9TKUnsP2Pel05cnAMtzsXHdBihQhjnA9/Rqlrf5ZPJTfGApk55oxhNX1ZGx7CHRpc5nGF42/oyETMgqWrE6esJMKL0bV9yNe2BqJzAfmD+zaHEpj8lGQkQ3Bn2koEPeHjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433576; c=relaxed/simple;
	bh=2Y/2ZsxukLFUeyt5kaUbOgODi2Fd7rXroVSx/UF2oZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uonVEh2RaDa7opq23YcjSZYZURIrGU2rVSSVSrZ7Z+adB5yLbB4cALFupReGtH3UyOSwKCDq64aoBcpZ5+jGLLmTBlusM5p1UuKogoqQ0oKP7P4K0+dZeUuNg/I0abBF8A+Dszuufg/Tw9xRudPmfK+mYDgvzvLw/ASiwhuUapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/niYW5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/niYW5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C50EC116C6;
	Sun,  5 Apr 2026 23:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433576;
	bh=2Y/2ZsxukLFUeyt5kaUbOgODi2Fd7rXroVSx/UF2oZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/niYW5o9kq4CIk+KISZoZr73cBvrFp7xOgl300ftkoj5yEiq4mi9hUZUG9wJrOv+
	 LaGbnyH2cbkgtfwDE2ULrSo70uidF2nRVcyCprr/DU1e1LrxTrWpPSqYOrd/b5v+pI
	 vOJs5KWVWeSegIrtH7pNTmgR4B3f8Em0ddPnhF/0hvNjcmD/GNMNZZR9sO/6pyDC8l
	 J00GH2pYJiTb1LuIWnlKsXbnu5aaWOq5VidlqrS6OtTBgrSnGC29aYauevXa7ZXa5s
	 hvE9DHd51uuzsjeydQ/ToRRg+tMim8vYyTCl+sxSxVJ+3eYGI1FrqpdIrkWkqhUHLN
	 LBKSjFseYSZiw==
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
Subject: [PATCH v2 33/33] rust: kbuild: allow `clippy::precedence` for Rust < 1.86.0
Date: Mon,  6 Apr 2026 01:53:09 +0200
Message-ID: <20260405235309.418950-34-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Clippy `precedence` lint was extended in Rust 1.85.0 to include
bitmasking and shift operations [1]. However, because it generated
many hits, in Rust 1.86.0 it was split into a new `precedence_bits`
lint which is not enabled by default [2].

In other words, only Rust 1.85 has a different behavior. For instance,
it reports:

    warning: operator precedence can trip the unwary
      --> drivers/gpu/nova-core/fb/hal/ga100.rs:16:5
       |
    16 | /     u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
    17 | |         | u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::read(bar).adr_63_40())
    18 | |             << FLUSH_SYSMEM_ADDR_SHIFT_HI
       | |_________________________________________^
       |
       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#precedence
       = note: `-W clippy::precedence` implied by `-W clippy::all`
       = help: to override `-W clippy::all` add `#[allow(clippy::precedence)]`
    help: consider parenthesizing your expression
       |
    16 ~     (u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT) | (u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::read(bar).adr_63_40())
    17 +             << FLUSH_SYSMEM_ADDR_SHIFT_HI)
       |

While so far we try our best to keep all versions Clippy-clean, the
minimum (which is now Rust 1.85.0 after the bump) and the latest stable
are the most important ones; and this may be considered a "false positive"
with respect to the behavior in other versions.

Thus allow this lint for this version using the per-version flags
mechanism introduced in the previous commit.

Link: https://github.com/rust-lang/rust-clippy/issues/14097 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/14115 [2]
Link: https://lore.kernel.org/rust-for-linux/DFVDKMMA7KPC.2DN0951H3H55Y@kernel.org/
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a305ae4be522..b8c38aa49cf4 100644
--- a/Makefile
+++ b/Makefile
@@ -838,7 +838,8 @@ export WARN_ON_UNUSED_TRACEPOINTS
 
 # Per-version Rust flags. These are like `rust_common_flags`, but may
 # depend on the Rust compiler version (e.g. using `rustc-min-version`).
-rust_common_flags_per_version :=
+rust_common_flags_per_version := \
+    $(if $(call rustc-min-version,108600),,-Aclippy::precedence)
 
 rust_common_flags += $(rust_common_flags_per_version)
 KBUILD_HOSTRUSTFLAGS += $(rust_common_flags_per_version) $(HOSTRUSTFLAGS)
-- 
2.53.0

