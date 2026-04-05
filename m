Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C853381B15;
	Sun,  5 Apr 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433565; cv=none; b=EMJLxzPjx0V5q3MmgmHkX7Lbxh3Me8Rvol5+xhCagbjm0hoXi9iKQzbPn32id94ZJH+ixbms/B357EZ3ZN9JOM5eoglCwLLsednB7ztK11ExKatzf6UEJ/4f2F3KGlsAqnmezQI6zPNvC6NKow+KTJe+fLutuiXLIPHlbcUcFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433565; c=relaxed/simple;
	bh=SkaD63e7WNKd6l91xAXN7lZ/j1nQk4rCvj18hUBSP2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX99vRt07xNion4aV6XgQG/tR3fjCBINq5T80jT9n9whnYJh3GUPUuCZZcZXVGE4PUHIBsJ4SrnOO12EwqXbJBi+xzcGS9eiRjoW5svvyWi0P6LiE75NCuURPUltWbQVUAAuGlMAPjmLp7lmJpyeA01NeUNJqk3tDTU7XzZzb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT7JjEap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT7JjEap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88702C19425;
	Sun,  5 Apr 2026 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433565;
	bh=SkaD63e7WNKd6l91xAXN7lZ/j1nQk4rCvj18hUBSP2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qT7JjEapMwwAMStY/OKyLpjkMSWC7l6AOMUAZbTuYsHMIjvY52xXT85zs7eiB2Xgl
	 AFDdh6mgB5Gydna3yU3wXgcpzwkDs4aSx6cNQNZ0e1dTpqYMIIMBkWAii7IHMnAqD8
	 4ysIbgfHPEpw1hwGDIIPRcQLCBrALBijyFC5WmtB4fJ3hm8XzcF/O2djDlnQ/6Tq7T
	 yydjpMBgbjPHzTZ4TFBHyMC9a19+nwOb4Oe5Oc5/Tu8VHIAq9E+LQPpOCzM3N3nhss
	 Xv1nwHfD2DDvzNoVXZQOUwxdGXUViwDb3/t98q3LlFDEp7h4+87E6nc6Z94GB3nHAM
	 SaHAgTLaFtuHg==
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
Subject: [PATCH v2 32/33] rust: kbuild: support global per-version flags
Date: Mon,  6 Apr 2026 01:53:08 +0200
Message-ID: <20260405235309.418950-33-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
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

In addition, move the expansion of `HOSTRUSTFLAGS` to the same place,
so that users can also override per-version flags [2].

Link: https://lore.kernel.org/rust-for-linux/CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/rust-for-linux/CANiq72mTaA2tjhkLKf0-2hrrrt9rxWPgy6SfNSbponbGOegQvA@mail.gmail.com/ [2]
Link: https://patch.msgid.link/20260307170929.153892-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 78f5ee173eda..a305ae4be522 100644
--- a/Makefile
+++ b/Makefile
@@ -506,7 +506,7 @@ KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) \
 KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS) \
 		       -I $(srctree)/scripts/include
 KBUILD_HOSTRUSTFLAGS := $(rust_common_flags) -O -Cstrip=debuginfo \
-			-Zallow-features= $(HOSTRUSTFLAGS)
+			-Zallow-features=
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 KBUILD_PROCMACROLDFLAGS := $(or $(PROCMACROLDFLAGS),$(KBUILD_HOSTLDFLAGS))
@@ -836,6 +836,14 @@ endif # CONFIG_TRACEPOINTS
 
 export WARN_ON_UNUSED_TRACEPOINTS
 
+# Per-version Rust flags. These are like `rust_common_flags`, but may
+# depend on the Rust compiler version (e.g. using `rustc-min-version`).
+rust_common_flags_per_version :=
+
+rust_common_flags += $(rust_common_flags_per_version)
+KBUILD_HOSTRUSTFLAGS += $(rust_common_flags_per_version) $(HOSTRUSTFLAGS)
+KBUILD_RUSTFLAGS += $(rust_common_flags_per_version)
+
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef need-config
-- 
2.53.0

