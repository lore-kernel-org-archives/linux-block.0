Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D334253B;
	Sun,  5 Apr 2026 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433231; cv=none; b=BMsPwPkq8PWO9hrvIK7gDP2bLGoMzDQD7w0UPuk9VJLsZrGi/+g6zygH4NHCuHO/OhrbBXW/+H48Klsm3g3IWxK4S1RG4QQxQwgOqnyfmRfHjui6lcDiPj+ShxqUa9yzgGia56tYdl4j2aPrsBZC6Cn115AHZ+oQ4yX9hd+qWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433231; c=relaxed/simple;
	bh=3AJRnAyEU2suxXGqceHWmfrdhCBJgg/viD//VN5No4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iki9xENGOwDIXkaR8KayU1ZYXesqrgzW7Og/fJpkhJ4wF8kqymZ1rJ+b2gJT5e38dcUtOYOm5h90JlUdeCtXh0iLNSUv4DYqTR+rCU0WFzqP3G/i/0ql/ttA5OJm8xUd8y63lwdjwQVeiZcCsU7dAL2DMQupMoGuNlSi4VCt+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwAXuYA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwAXuYA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792AC116C6;
	Sun,  5 Apr 2026 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433231;
	bh=3AJRnAyEU2suxXGqceHWmfrdhCBJgg/viD//VN5No4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwAXuYA25JGS9wsvKoXsGN6sAEKslnUZh5D1dRotUu99nhYgcoqpY6WYoCLhunn5n
	 xHVYrx8rpK1rU+25XoZCWXvldDnU50XFCE9J47vhT2ZBF0UGNIKn4LeZfLphQ37F6o
	 N1lVtDyk0UuzGU0HE91nvri0/O0pl3Q1uBMBgMuqqJFjAGhMQ/Ha1VCv/QoDDqC+Cx
	 MRKnQoRQilcWK9zZs34qU1c15lT5egG9V0Rp4ouFrAMfz8ogTTbM8rXPpqWj7JccvG
	 ZkUDGF0siAS7QeLkDf2sedkNJlP+8fmXP7k5sjXvvE3+l8wPpUZ/4xCTRIOfLlFB1U
	 2IJKROs43C4iQ==
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
Subject: [PATCH v2 02/33] rust: kbuild: remove "`try` keyword" workaround for `bindgen` < 0.59.2
Date: Mon,  6 Apr 2026 01:52:38 +0200
Message-ID: <20260405235309.418950-3-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a workaround that has not been needed, even already after commit
08ab786556ff ("rust: bindgen: upgrade to 0.65.1"), but it does not hurt.

Thus remove it.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindgen_parameters | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index fd2fd1c3cb9a..112ec197ef0a 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -15,10 +15,6 @@
 --opaque-type x86_msi_data
 --opaque-type x86_msi_addr_lo
 
-# `try` is a reserved keyword since Rust 2018; solved in `bindgen` v0.59.2,
-# commit 2aed6b021680 ("context: Escape the try keyword properly").
---opaque-type kunit_try_catch
-
 # If SMP is disabled, `arch_spinlock_t` is defined as a ZST which triggers a Rust
 # warning. We don't need to peek into it anyway.
 --opaque-type spinlock
-- 
2.53.0

