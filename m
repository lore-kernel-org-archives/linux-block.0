Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89368385514;
	Sun,  5 Apr 2026 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433476; cv=none; b=SqyFMxKKIOkrK12bEU+624qFcmWPp1FE257mTjd7Qf/0TXDrYDQtTAZQw2aaXPIsHYY8NS7RuOImFW/HG23fR/4RENvxM+VZvcb+AE6ZK4p8BJNZyDN6DlpoXEYkC2EnvIFPKD5hFlSTzLuXXJfYCN6H05ESqobt3AxCPWztKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433476; c=relaxed/simple;
	bh=hONqXGkyEohBL0ahIaQ2+zaacCn47+UE6bNDPSd6pjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0WOxJa6ZClNUASZR30mTP0ZyiZdHnfHggS0WNu78NHkr4rN7ewmyXpbkvur9uSv6hFQEQJvIYssNYRo67hZyl/z4XTR6MZLCP302iXWhqjhs4KLPpAS/qRSWszdmVabYDeO2fSBe3WJwtxjgsGP8joVO6acqlTqEM3wvRXeT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiOSfC+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiOSfC+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E81C116C6;
	Sun,  5 Apr 2026 23:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433476;
	bh=hONqXGkyEohBL0ahIaQ2+zaacCn47+UE6bNDPSd6pjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiOSfC+Xv1sTVseVZ+geqBfsHGu2S9tl0gRfo/vbe06Y7lYJl1eZTbQ/jQ+e8PpUz
	 j11NauOb1/DscQFZ/kQ4vUbkyrUztRKZWLClePiLa6/m2CD7IfQr4O8rUe8dAqmc3m
	 DvTZ+r6H6ksBl8QGEjgLMWjH6COz7TCiqTRRUOskvgVYAsLLFh/VUu5IR1qxtGNhuy
	 oIGZWw1pyBfb4s7PXByYBPY8c+02Qdo2xBcvLDNWHjL3PTLliie1ikz9WSA/nF5LA5
	 tGpam/Qo2OdKWQ2nVfh7Y234TT+6AtOA/72q6h8NA84SL53Cl1WJ1aroNaFIgVm+Fu
	 7AemkWrwOJeUA==
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
Subject: [PATCH v2 24/33] docs: rust: quick-start: update minimum Ubuntu version
Date: Mon,  6 Apr 2026 01:53:00 +0200
Message-ID: <20260405235309.418950-25-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ubuntu 25.04 is out of support [1], and Ubuntu 25.10 is the latest
supported one.

Moreover, Ubuntu 25.10 is the first that provides a recent enough Rust
given the minimum bump -- they provide 1.85.1 [2].

Thus update it.

Link: https://ubuntu.com/about/release-cycle [1]
Link: https://packages.ubuntu.com/search?keywords=rustc&searchon=names&exact=1&suite=all&section=all [2]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 54fe491deb7d..34c39f208333 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -90,7 +90,7 @@ they should generally work out of the box, e.g.::
 Ubuntu
 ******
 
-25.04
+25.10
 ~~~~~
 
 The latest Ubuntu releases provide recent Rust releases and thus they should
-- 
2.53.0

