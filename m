Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A97421EEA;
	Wed,  1 Apr 2026 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044341; cv=none; b=pmVJKa7MHnPU1XdskoWN54l4I9pvLfvhgN+MEZ63+7Wb7Da0F2T1/OWi6no94axl1F2sAfcCaT+hhqqBUYfwuCA8qfxIqpmqLu79kkwu6PBsXhIO5Yd+POFIwWHleVrlEyrXoLEsVFzuXUBX10m9c7wg83LsC7OpIYmQ9mW95K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044341; c=relaxed/simple;
	bh=rmbcm0lGdPnutdStnqg0waumItTikO0U9rMNdtnv3yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Puot5NmiKlzST5EjfVGdkYikXoedd9EhHaWEt14fox1ieSP9Kd1ojhpl+3BOEz3dcfteJwSbQ2SO6RUHaaRnGI5Mqnwhc+tH8kmcKxbwmSI1gdaKoOhH0cmIsrpP9BUNdZMfNCOKQ+qIlYtWlfxytTaRpkjqDpiDVHq8/J6RUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcBvoubs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcBvoubs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C32C2BCB2;
	Wed,  1 Apr 2026 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044341;
	bh=rmbcm0lGdPnutdStnqg0waumItTikO0U9rMNdtnv3yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcBvoubspcdQyo/6SD8RpK23KLdBlZmlyr+Q8oe4E3dFkmpEEorBsmt3GesO7Nl9q
	 YWS4m1in4cZ+dOT++Q1J8Ig3gXZ3l/Hig5Eq0rMW9FYKtKQyhyMus1JqK0WZx6+cBF
	 JUayEvXxkm9IOj16k6bywJiawbKZPnONK55YY01FSqb/NrgkEyVGWBIPdo/SvIYWic
	 U4AVc/BrZqDX7suU+KqtSQ4Q52UqYwQ2LYV11NVcOdsn5R4QiS61WDhULH+KewBvAe
	 /h+DQTiY+hPt11we7Vp7ycNYeVm2Tn/oACaSi3eP098GkbftxBkTZa4EkAWaXiFg9t
	 Bec4c3Sfzej1A==
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
Subject: [PATCH 32/33] rust: kbuild: support global per-version flags
Date: Wed,  1 Apr 2026 13:45:39 +0200
Message-ID: <20260401114540.30108-33-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes it is useful to gate global Rust flags per compiler version.
For instance, we may want to disable a lint that has false positives in
a single version [1].

We already had helpers like `rustc-min-version` for that, which we use
elsewhere, but we cannot currently use them for `rust_common_flags`,
which contains the global flags for all Rust code (kernel and host),
because `rustc-min-version` depends on `CONFIG_RUSTC_VERSION`, which
does not exist when `rust_common_flags` is defined.

Thus, to support that, introduce `rust_common_flags_per_version`,
defined after the `include/config/auto.conf` inclusion (where
`CONFIG_RUSTC_VERSION` becomes available), and append it to
`rust_common_flags`, `KBUILD_HOSTRUSTFLAGS` and `KBUILD_RUSTFLAGS`.

An alternative is moving all those three down, but that would mean
separating them from the other `KBUILD_*` variables.

Link: https://lore.kernel.org/rust-for-linux/CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com/ [1]
Link: https://patch.msgid.link/20260307170929.153892-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 1a219bf1c771..20c8179d96ee 100644
--- a/Makefile
+++ b/Makefile
@@ -834,6 +834,14 @@ endif # CONFIG_TRACEPOINTS
 
 export WARN_ON_UNUSED_TRACEPOINTS
 
+# Per-version Rust flags. These are like `rust_common_flags`, but may
+# depend on the Rust compiler version (e.g. using `rustc-min-version`).
+rust_common_flags_per_version :=
+
+rust_common_flags += $(rust_common_flags_per_version)
+KBUILD_HOSTRUSTFLAGS += $(rust_common_flags_per_version)
+KBUILD_RUSTFLAGS += $(rust_common_flags_per_version)
+
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef need-config
-- 
2.53.0

