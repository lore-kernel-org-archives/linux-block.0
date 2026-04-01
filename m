Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C8401A3B;
	Wed,  1 Apr 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044164; cv=none; b=TjX4KYpnIR52mcGzD72R1M/Zc1BZyEhDjinXeqiVrk9kmhTQFDT5LsHuVOHowwroPJS4terfUlW15mg8V3U7572Sp7156hc/uS8r0Nq///ENboRcgIpJbXyR7k23pMj55W0vE3YEG9VM9HBOmRy+5DZloiE9awrY6UTCY84hSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044164; c=relaxed/simple;
	bh=6xM/90y2+9K2QK1MXod17VOVsEz3ItyuSJ/mYMv3Drg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8NFQTjyQ79r7L7FCbfsr/HxFcqa7le4QYjQ1y9oYI3D/6Cap1WqcjUpGTbwgFR4Nd2aE1hdpS9dIdx6YlMSiB+JDKr5cpfrGI/lqxbrTimaM3s8yTs67xB9W9RPByreQHJyl8GGxcAVUAnkNKVOzDnFuuZIZoSG1v+G/ZHC8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+OxZYCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+OxZYCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC956C4CEF7;
	Wed,  1 Apr 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044164;
	bh=6xM/90y2+9K2QK1MXod17VOVsEz3ItyuSJ/mYMv3Drg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+OxZYCFK/c+WvN/8/uOPoU8cAIkSEfrgXW012jcw/dHW9HOkQ6wsGFDWswV5/fG3
	 B0v0LpVBICRBJRwhLcK22UNCpDeTVTz+otKNFY+bq42zA8C8SUT8eSa1TFfGqDTxZB
	 nTODkVCQiBhlpeCieK0XT3k7C5zp8u0nP4rLD82LlBz9Y/xfcAU7TJG690uB/2PHds
	 RK8eWxpPbkIam179mN9OeSs4s+oG15cb5Q0wUo46IzCRVHLWdbbP/e1PSThZYL6/sj
	 B+l7o2/JFT40jMHsCpebNWLL1wHDkZfzANZ7s+SGh48/K8TUDw4qSBv5D/fytpVz03
	 jqBcyNZwn2UQA==
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
Subject: [PATCH 17/33] rust: kbuild: update `bindgen --rust-target` version and replace comment
Date: Wed,  1 Apr 2026 13:45:24 +0200
Message-ID: <20260401114540.30108-18-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment in the `Makefile` explains, previously, we needed to
limit ourselves to the list of Rust versions known by `bindgen` for its
`--rust-target` option.

In other words, we needed to consult the versions known by the minimum
version of `bindgen` that we supported.

Now that we bumped the minimum version of `bindgen`, that limitation
does not apply anymore.

Thus replace the comment and simply write our minimum supported Rust
version there, which is much simpler.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 163d2258e93f..34f21b735993 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -446,22 +446,10 @@ endif
 # architecture instead of generating `usize`.
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
 
-# Each `bindgen` release may upgrade the list of Rust target versions. By
-# default, the highest stable release in their list is used. Thus we need to set
-# a `--rust-target` to avoid future `bindgen` releases emitting code that
-# `rustc` may not understand. On top of that, `bindgen` does not support passing
-# an unknown Rust target version.
-#
-# Therefore, the Rust target for `bindgen` can be only as high as the minimum
-# Rust version the kernel supports and only as high as the greatest stable Rust
-# target supported by the minimum `bindgen` version the kernel supports (that
-# is, if we do not test the actual `rustc`/`bindgen` versions running).
-#
-# Starting with `bindgen` 0.71.0, we will be able to set any future Rust version
-# instead, i.e. we will be able to set here our minimum supported Rust version.
+# `--rust-target` points to our minimum supported Rust version.
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
-	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.68 \
+	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.85 \
 		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
 		--no-debug '.*' --enable-function-attribute-detection \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
-- 
2.53.0

