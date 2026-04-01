Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CF407108;
	Wed,  1 Apr 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044294; cv=none; b=RVND+hvkWsvcOWkWotOblCpqCzrwdR/4OcExfH/JTHZZmjHFY4qdx3pKpYXlH+wy980X5bTuOjItvvWjlmkx7sKKnOAEU3IARQxdfVyGU8LfZMC4WTo6e6MtG+4U+ieMeBv67uqficcdfyxJ7jwdYESwPET76YYVeB18kRA1LKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044294; c=relaxed/simple;
	bh=yKvVVQSsm3ADeF9w4UcOYUs55+Yf5zunUU3xGxiWVJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaoP5s7T0f+qZ7jsfXKQlL5ikI5/dUVFLV38w7X6s4gJoVR4wv3N8sUmfPmAWaIg7XMjBKhAbR6L0GcO2T++459VGWR9lmG0rNzSCLA0osABkOVEmAYRQkpK+Wvd1Ze9yBDGdeCkOBXHuI1b+j9RnPym25XE0SVzirdXSpX33LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt9hgTLa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt9hgTLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D57C116C6;
	Wed,  1 Apr 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044294;
	bh=yKvVVQSsm3ADeF9w4UcOYUs55+Yf5zunUU3xGxiWVJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt9hgTLa2Us6ZAkjaDuidhhjBEvQbNdulZHZKXQzC+eR8wTzSc77xJJ4dkBB9WzzC
	 56So1K8x2lvFO5CwxaplRlWHIiDYAL2Mi584X4uRylEkZluCLgYJv7XA2Ib5lu3mp9
	 /0rASa7YRY69ivi92iRCKMtbZ8gRaxDbRECSS/jsbMr266RSERosPt+9kyn9IYS6PO
	 /jrkgOh8JThQ7n5bruoE5xHV1QuoewRsBnEwccKdY1YZRxh5s2PfRgQiU1MSTkVgtN
	 rJ2E7yTdsHe1fmPWtL3F7NSZDISppgJS77qEymsIzNL65GsE84OdkUOCPCwIz7gUv8
	 Z7Ygn1YR5NvuA==
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
Subject: [PATCH 28/33] docs: rust: quick-start: remove GDB/Binutils mention
Date: Wed,  1 Apr 2026 13:45:35 +0200
Message-ID: <20260401114540.30108-29-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The versions provided nowadays by even a distribution like Debian Stable
(and Debian Old Stable) are newer than those mentioned [1].

Thus remove the workaround.

Note that the minimum binutils version in the kernel is still 2.30, so
one could argue part of the note is still relevant, but it is unlikely
a kernel developer using such an old binutils is enabling Rust on a
modern kernel, especially when using distribution toolchains, e.g. the
Rust minimum version is not satisfied by Debian Old Stable.

So we are at the point where keeping the docs short and relevant for
essentially everyone is probably the better trade-off.

Link: https://packages.debian.org/search?suite=all&searchon=names&keywords=binutils [1]
Link: https://lore.kernel.org/all/CANiq72mCpc9=2TN_zC4NeDMpFQtPXAFvyiP+gRApg2vzspPWmw@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 5bbe059a8fa3..a6ec3fa94d33 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -352,12 +352,3 @@ Hacking
 To dive deeper, take a look at the source code of the samples
 at ``samples/rust/``, the Rust support code under ``rust/`` and
 the ``Rust hacking`` menu under ``Kernel hacking``.
-
-If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
-is the toolchain does not support Rust's new v0 mangling scheme yet.
-There are a few ways out:
-
-- Install a newer release (GDB >= 10.2, Binutils >= 2.36).
-
-- Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
-  the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
-- 
2.53.0

