Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360328751B;
	Sun,  5 Apr 2026 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433220; cv=none; b=VeRYExPcxw85g++/ktTZeJsDejrKW4N1i5vVTZBuWQPlsfQFsOVVEXETepAsmpyrAnQzbAIfNuwTqLcYNMe+Z4pRV9i//zAUaSG/gOyAztkoDa6a3cvdJIofoxMcG0BWJMO5kQtBPedzwrNxsc6anjayb/eM2sHSOzGpkPAr53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433220; c=relaxed/simple;
	bh=5sbZC4LmoO0aslETTGIb1afN103Xm/S3EYSfsUuG440=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSEiV0/1EKZ3OlSLxdbCdxfzoahO/VcY7rqew9oOsAHgRph4e0RwXXaWUn1FEV3E8fu2bDvK0FQC+eioxaP7jARRe1x6ljIYLGtEYAQJMkmV35DCJSnhWmVg5h+AvFYukNpp1PLscEexiU8RT00oPiecvaJRdTgdaqxNkaGLnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbAtsUUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbAtsUUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CADBC19425;
	Sun,  5 Apr 2026 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433219;
	bh=5sbZC4LmoO0aslETTGIb1afN103Xm/S3EYSfsUuG440=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbAtsUUbjHdguSI6jhILScIxMOr5j1dFJhwr6cGmnDdLstMcNGvOTz4hy/tTuue7I
	 PO4+sIdljkOukHZWwbd1hKG1frp8wLnJ1vgsLbyAnd7d44sht3YYb9TblhQHVhWSHN
	 TQPybH7Bn2ybT78h5mceT9O7ySO5EjLFRf4FZpJCjaovLWMx54kG+talki7G4eBn9z
	 mO8nX0O+8jb97CqgETBuathbX3zU/gIgkOXgIZ7gnENXuXWZawT6dl4bPTqN9PC/Gd
	 JlPIkorQcEw8NVEf9b+Bd+qyL1ttWeLWAFxNsAAVGBToPmQ6LQ9/KkXqBU8PtZmcND
	 0LqCfQvAd2c/g==
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
Subject: [PATCH v2 01/33] rust: kbuild: remove `--remap-path-prefix` workarounds
Date: Mon,  6 Apr 2026 01:52:37 +0200
Message-ID: <20260405235309.418950-2-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8cf5b3f83614 ("Revert "kbuild, rust: use -fremap-path-prefix
to make paths relative"") removed `--remap-path-prefix` from the build
system, so the workarounds are not needed anymore.

Thus remove them.

Note that the flag has landed again in parallel in this cycle in
commit dda135077ecc ("rust: build: remap path to avoid absolute path"),
together with `--remap-path-scope=macro` [1]. However, they are gated on
`rustc-option-yn, --remap-path-scope=macro`, which means they are both
only passed starting with Rust 1.95.0 [2]:

  `--remap-path-scope` is only stable in Rust 1.95, so use `rustc-option`
  to detect its presence. This feature has been available as
  `-Zremap-path-scope` for all versions that we support; however due to
  bugs in the Rust compiler, it does not work reliably until 1.94. I opted
  to not enable it for 1.94 as it's just a single version that we missed.

In turn, that means the workarounds removed here should not be needed
again (even with the flag added again above), since:

  - `rustdoc` now recognizes the `--remap-path-prefix` flag since Rust
    1.81.0 [3] (even if it is still an unstable feature [4]).

  - The Internal Compiler Error [5] that the comment mentions was fixed in
    Rust 1.87.0 [6]. We tested that was the case in a previous version
    of this series by making the workaround conditional [7][8].

...which are both older versions than Rust 1.95.0.

We will still need to skip `--remap-path-scope` for `rustdoc` though,
since `rustdoc` does not support that one yet [4].

Link: https://github.com/rust-lang/rust/issues/111540 [1]
Link: https://github.com/rust-lang/rust/pull/147611 [2]
Link: https://github.com/rust-lang/rust/pull/107099 [3]
Link: https://doc.rust-lang.org/nightly/rustdoc/unstable-features.html#--remap-path-prefix-remap-source-code-paths-in-output [4]
Link: https://github.com/rust-lang/rust/issues/138520 [5]
Link: https://github.com/rust-lang/rust/pull/138556 [6]
Link: https://lore.kernel.org/rust-for-linux/20260401114540.30108-9-ojeda@kernel.org/ [7]
Link: https://lore.kernel.org/rust-for-linux/20260401114540.30108-10-ojeda@kernel.org/ [8]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 96cd7d8e6ee9..16ea720e0a8e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -145,14 +145,10 @@ rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-a
 # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
 doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
 
-# `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
-# since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
-# 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
-# issues skipping the flag. The former also applies to `RUSTDOC TK`.
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=%,$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
+	$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
@@ -338,7 +334,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) --test $(filter-out --remap-path-prefix=%,$(rust_flags)) \
+	$(RUSTDOC) --test $(rust_flags) \
 		-L$(objtree)/$(obj) --extern ffi --extern pin_init \
 		--extern kernel --extern build_error --extern macros \
 		--extern bindings --extern uapi \
-- 
2.53.0

