Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B92405ACD;
	Wed,  1 Apr 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044247; cv=none; b=h/ge4FqojgXlMZhRq0OUz5FSyB+ht4wvzoovtU1aBkZ2E98SIybOr0gX7sw26Yabt9x74C5EsmxMqOXUGjGPdsW6MV1H8qve0T5zSz8ywxaSi9KJfDxlUYqrBOBKlOgBagGJmKEAl+uLSXHiWpf8WNnrxY7uBKy1SkHk92f4Fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044247; c=relaxed/simple;
	bh=gdqep/CIy3f2tHlGVIduJ54heItiKNgLxJWrndWddZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2qXi0PvexWWLmSaZun8h3k3pkCVAl1azbrCRFwUDvFtNpW/W5UUgod2uAA5nKH0PDYQAfci8VxW33AP0mJWSxR9A9EH/YqBOxx4kBotdHXDQuonGXiFsQ5mYA60gcb6HfDOD4w0TntzqwaESTMunWWEgfwBHkSBFU76Nzs8UtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Hhh1an; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Hhh1an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DB0C4CEF7;
	Wed,  1 Apr 2026 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044247;
	bh=gdqep/CIy3f2tHlGVIduJ54heItiKNgLxJWrndWddZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+Hhh1anJc+19GFocBbrXlmEQQSkj943VY8/0XHji23fuRQZsWqQAH+1TSazaKmiL
	 qIo6GTr7gQXcIVZ17+Mt5jLGu8cpZaFYiedii3pg0W6olOnWbfza9XhlEVRwZ98yx0
	 LcXVWwJgYRdsT/s5pj5faIm2xA8SiH42BTO7/qQTMkiUf3alp8Cdu8qqXXHghDJdG/
	 ZqKeehF27SbWaYSWGlBEsyIr+orFdLth2J7uIk+9AfP92IrtdGMKAQRdG/dhvr8O8B
	 TOGYY/rqEnbd4s7uEUlRNJC+4aYbShoioRKpA/J5CM4OvzM/TxjoPZsAOk1Hqu0iFq
	 UYI5ugbEIjfxg==
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
Subject: [PATCH 24/33] docs: rust: quick-start: update minimum Ubuntu version
Date: Wed,  1 Apr 2026 13:45:31 +0200
Message-ID: <20260401114540.30108-25-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
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

