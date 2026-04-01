Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C23DCDA9;
	Wed,  1 Apr 2026 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044306; cv=none; b=NWeRN6PMdF2YG0s9CnKwsR5Xx06tMl/dw7k0pQJ9jh+ZIQcnYRDVNmgnjvUafinL/PzdLYigN+6fGMzybuBSkKEgdM64S093lF+aZblreHTAUpwVqwbhg8UtaYjCgVqUJ1xoKqH8Kpp2PcBn88J8WHhoPr84dU4WlhP7Sl29V+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044306; c=relaxed/simple;
	bh=hwrpFVeGAL5GC09atZjTVNJE6Ow3imO9X2morwqR56Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgL3rUAkoMhV2AHwPKwpJgkyMOE7uWBZrFK+OxoQFpmHQIjgkcd8enrt10bkcSkrVMmFXt4jEY2sm5vicDXDdtgrRXsfmuT18yuEQEH3Ox+blpU5qsKI+suULakQ50S09jYmgyxWmcXWIkOt0ZkLD3xzYNV5YWmA6Hx9m0n7PjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzw1kaCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzw1kaCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC33FC4CEF7;
	Wed,  1 Apr 2026 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044306;
	bh=hwrpFVeGAL5GC09atZjTVNJE6Ow3imO9X2morwqR56Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rzw1kaCEQHUMV8e2JhQRZ0slowyGy7FMm4tP6h9JKv2f1/pjKA/CgbLPmqJSfwYW9
	 XpjqdVAQSA7tGhxbEGXHSOp/b4ykgFgY9+afWac2nDN+7rfydkcDZpWR8hxb/XS02j
	 LNBRkTa0ZCJ8Ct7VSdEoSy0AjoAeVUdW2NIf9cHqHXqPRJVw10D2vW/WD8KAcd4+X9
	 adeYuW0+L8tLudnViZX5MEfIqqFc301C2pW4Ki+5taOqHHUTBnQwc2GJaFeET7o+/8
	 HquRyfA0XF2MWJo5hgtDXCWTUfmcnrUxW/us7Td3H6gTg1P4obsqnA35gxHSgJmIa7
	 NPNA/tvRJKfsA==
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
Subject: [PATCH 29/33] docs: rust: general-information: simplify Kconfig example
Date: Wed,  1 Apr 2026 13:45:36 +0200
Message-ID: <20260401114540.30108-30-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to use `def_bool y if <expr>` -- one can simply write
`def_bool <expr>`.

In fact, the simpler form is how we actually use them in practice in
`init/Kconfig`.

Thus simplify the example.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/general-information.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
index 6146b49b6a98..91535b2306ed 100644
--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -158,4 +158,4 @@ numerical comparisons, one may define a new Kconfig symbol:
 .. code-block:: kconfig
 
 	config RUSTC_VERSION_MIN_107900
-		def_bool y if RUSTC_VERSION >= 107900
+		def_bool RUSTC_VERSION >= 107900
-- 
2.53.0

