Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEA264A65;
	Sun,  5 Apr 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433343; cv=none; b=BLKu+t13uTEys+8nzMIjzI66/jSz5qNUFZG402dxTBid+mHxt+U3M3gVToP0SgVNOJOQF0ovPAVRTN+9D6mrq35IzTRvjbI2XtqVwKnuYJnH5PXDkQZ71entVUvmbxvj4ixtyneKQxc2ezw0Q12jhCxigKcaN2hxfm1Iyo5aVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433343; c=relaxed/simple;
	bh=rhX3GqYQx8Jl+4tNpW2dKwQfeZlDw97dCDSWyN1kX4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvP8n/BDZmDPHGEmXrqFwW/wTYZ0YtcLdTyjBvTdd3uBv1W7BNA5ugiNvYFDJnWP7hmc+N/NN+h+7p4a2GlfAwfcPaNeaO60sFSYu9Z9zB54PB8jt8ng7b5rcvBiZ5F2YAAX+/jwhB701ngSRGYSNbRhSyXiSgf2D8ejP0R058w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9uNPKIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9uNPKIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C13C19425;
	Sun,  5 Apr 2026 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433342;
	bh=rhX3GqYQx8Jl+4tNpW2dKwQfeZlDw97dCDSWyN1kX4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9uNPKIn7BIlbZBmyZCrn8YA4s8vt211ZS4DryUsRUPtxc5Ce8n1gRoz4IJwAZAOM
	 Dqp6WAkHoyNQ5zLX/rFldY3wmp5C0ZX9hMiMmyPCl23fRGYclj6I0liqouATnE4LD5
	 pcFG9FLiF8HJvJFDEPMbFqVuOs1Sev37pt+zIjJGlujkwagUUjAkqve/cRsglEd1ZT
	 YiS3IliuGDO6QuzIfUhTNpdbpp9ewjzWfepATKG30fXTF2uazRnxese4dQeQwSvagT
	 fgaN2tp5c1O58eBWINvTswa4V0NA7jTUtPANRuwj1H8I0rNnXGdb+lFXnGYIzYtfvK
	 caK/MHh2zv9WQ==
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
Subject: [PATCH v2 12/33] rust: kbuild: remove `feature(...)`s that are now stable
Date: Mon,  6 Apr 2026 01:52:48 +0200
Message-ID: <20260405235309.418950-13-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the Rust minimum version is 1.85.0, there is no need to enable
certain features that are stable.

Thus clean them up.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile          |  2 --
 rust/kernel/lib.rs     | 21 ---------------------
 scripts/Makefile.build |  6 +-----
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 5dc8b4cc89d1..54498cb5b851 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -86,10 +86,8 @@ proc_macro2-cfgs := \
     wrap_proc_macro \
     $(if $(call rustc-min-version,108800),proc_macro_span_file proc_macro_span_location)
 
-# Stable since Rust 1.79.0: `feature(proc_macro_byte_character,proc_macro_c_str_literals)`.
 proc_macro2-flags := \
     --cap-lints=allow \
-    -Zcrate-attr='feature(proc_macro_byte_character,proc_macro_c_str_literals)' \
     $(call cfgs-to-flags,$(proc_macro2-cfgs))
 
 quote-cfgs := \
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 66a09d77a2c4..b48221a5b4ec 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,27 +16,6 @@
 // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 // the unstable features in use.
 //
-// Stable since Rust 1.79.0.
-#![feature(generic_nonzero)]
-#![feature(inline_const)]
-#![feature(pointer_is_aligned)]
-//
-// Stable since Rust 1.80.0.
-#![feature(slice_flatten)]
-//
-// Stable since Rust 1.81.0.
-#![feature(lint_reasons)]
-//
-// Stable since Rust 1.82.0.
-#![feature(raw_ref_op)]
-//
-// Stable since Rust 1.83.0.
-#![feature(const_maybe_uninit_as_mut_ptr)]
-#![feature(const_mut_refs)]
-#![feature(const_option)]
-#![feature(const_ptr_write)]
-#![feature(const_refs_to_cell)]
-//
 // Expected to become stable.
 #![feature(arbitrary_self_types)]
 #![feature(derive_coerce_pointee)]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0b0245106d01..57cff77c2897 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -310,17 +310,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 
 # The features in this list are the ones allowed for non-`rust/` code.
 #
-#   - Stable since Rust 1.79.0: `feature(inline_const)`.
-#   - Stable since Rust 1.81.0: `feature(lint_reasons)`.
-#   - Stable since Rust 1.82.0: `feature(asm_const)`,
-#     `feature(offset_of_nested)`, `feature(raw_ref_op)`.
 #   - Stable since Rust 1.87.0: `feature(asm_goto)`.
 #   - Expected to become stable: `feature(arbitrary_self_types)`.
 #   - To be determined: `feature(used_with_arg)`.
 #
 # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 # the unstable features in use.
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,inline_const,lint_reasons,offset_of_nested,raw_ref_op,used_with_arg
+rust_allowed_features := arbitrary_self_types,asm_goto,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.53.0

