Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0822423A62;
	Wed,  1 Apr 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044354; cv=none; b=AS3PdwR8qa52ezhTI9OehUPBHm45GH2MjcOIWgF531JOb4RNnXMAArj8vdj/ooucmbOVsixSoluAqt68kiu23d93kSmcwXj4YAUUANUP/TELa+6WJCCm9ZYvw8+6cr81FlgXORJKk3aPw47aAv8KKr7KIJvhgTNgZo4jN4FQmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044354; c=relaxed/simple;
	bh=63eNaBb7HhBHNGZHs2ck4m5j8n+byLJscGHPx3NKsmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKHFY72YrY4qP3mToOVqJwJ2/ZF4AIu+QNBhJ6PGfn0IEsfUdYDTNjzXVXFEXo4gn+pAhDxRwaUSylnbhU8i21pW7EkZMF4Kxt0UR4QqLm2lcpwTOpGF4bv1/tWloeUTrK5cb8WErSBwTBkzOKxftjeRm+R6vtE0vdJecKYy13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4KiRkYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4KiRkYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D18AC116C6;
	Wed,  1 Apr 2026 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044353;
	bh=63eNaBb7HhBHNGZHs2ck4m5j8n+byLJscGHPx3NKsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4KiRkYx+9pR8FcDn58eZ58Tl+l8DaXIaKnBFFMxFh3P+IXQUnqgEGZH8vAunNvs4
	 BLd1TybjNwHbXADCPR4z7Vj6dtmKy7ji1oU2bzwWLnPbbnFVZYCEMjSB2UQpls/Ouo
	 pYPJfGFA7EPUSZecOxj+EVb7CtgpF1zN5Tw8IewblUNyc/Ie7LYX5Lt+C5FMZplSJ6
	 xbIWlfeyv6YRSlqqa7C9IoWKbjP/NbQH9T4QOWe/CgvypooqpdHo0TWO2wHyf2zcvI
	 RVJtUt/y5WBbMgeocVhCwVhlVD3aiintQfQGjzicRa8XTpUjFXmucwr/KWim4JVpaV
	 E6XIy24XYnOiA==
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
	linux-doc@vger.kernel.org
Subject: [PATCH 33/33] rust: kbuild: allow `clippy::precedence` for Rust < 1.86.0
Date: Wed,  1 Apr 2026 13:45:40 +0200
Message-ID: <20260401114540.30108-34-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
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

    warning: operator precedence can trip the unwary
       --> drivers/gpu/nova-core/vbios.rs:511:17
        |
    511 | /                 u32::from(data[29]) << 24
    512 | |                     | u32::from(data[28]) << 16
    513 | |                     | u32::from(data[27]) << 8
        | |______________________________________________^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#precedence
    help: consider parenthesizing your expression
        |
    511 ~                 u32::from(data[29]) << 24
    512 +                     | u32::from(data[28]) << 16 | (u32::from(data[27]) << 8)
        |

    warning: operator precedence can trip the unwary
       --> drivers/gpu/nova-core/vbios.rs:511:17
        |
    511 | /                 u32::from(data[29]) << 24
    512 | |                     | u32::from(data[28]) << 16
        | |_______________________________________________^ help: consider parenthesizing your expression: `(u32::from(data[29]) << 24) | (u32::from(data[28]) << 16)`
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#precedence

While so far we try our best to keep all versions Clippy-clean, the
minimum (which is now Rust 1.85.0 after the bump) and the latest stable
are the most important ones; and this may be considered "false positives"
with respect to the behavior in other versions.

Thus allow this lint for this version using the per-version flags
mechanism introduced in the previous commit.

Link: https://github.com/rust-lang/rust-clippy/issues/14097 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/14115 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 20c8179d96ee..a0d6ed050c8a 100644
--- a/Makefile
+++ b/Makefile
@@ -836,7 +836,8 @@ export WARN_ON_UNUSED_TRACEPOINTS
 
 # Per-version Rust flags. These are like `rust_common_flags`, but may
 # depend on the Rust compiler version (e.g. using `rustc-min-version`).
-rust_common_flags_per_version :=
+rust_common_flags_per_version := \
+    $(if $(call rustc-min-version,108600),,-Aclippy::precedence)
 
 rust_common_flags += $(rust_common_flags_per_version)
 KBUILD_HOSTRUSTFLAGS += $(rust_common_flags_per_version)
-- 
2.53.0

