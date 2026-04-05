Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE385516;
	Sun,  5 Apr 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433454; cv=none; b=jmACj63zlSwnXnZl6S7mdRvmtyHYQ0HdTTuWVV9sjCvIxCw+SWNgYZFaRiCeoq6bJHUj9qf7sPalGiD4qwHvZUr4b3Er9x5UkSrUP2TFPwPi7OSfqaLfe2Vfh6LdE129blH0VWwTYrOuNCnNQwrdHt4SRXPctbBT6L+ojlT2K7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433454; c=relaxed/simple;
	bh=y0xktRKRs5ryJC+G01aE6htP3MJxSFsUvP6UYzkishw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTXSzMKtQfzVjXgvdy0Y6utus6jZ1jDTHlCBJv0OY0jxtE4E5KBu06cjq7ijtdbv8RGW2F1ua/AReBxl7If4A3iDJM3M9YjvTWtbDyE3FRVJPuhnc3vK/7boyWYKEsYTV80cqY2ugMxZY3Ks4GRHyPHEBN/q7AvPT4Ramt53OnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZa94a2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZa94a2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E412C116C6;
	Sun,  5 Apr 2026 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433453;
	bh=y0xktRKRs5ryJC+G01aE6htP3MJxSFsUvP6UYzkishw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZa94a2gUM+1/bUwa8Gk/haFENqG5HQ/kAPWfZKfoOpgs9LPvPn+5SYdTLlTrdqBN
	 KhCyK2P/VjNgBuSBZRXH3t/NjrffsRCHyuBlWMIBQFw1QoF5qZOq0Fan1XeP/C9mwN
	 mSmbpbCFTZr9ULdOVc2ZcG2LEkvGQJ8xFnLh+51z3NbAT8m8LjGsjXlDkeOe8MrFSS
	 pua0Sbcn0dOpLzsRowI5EISEDL74bEj9qX5mI82scX4NoyYe3aG+R/HAcXyIsZeQm+
	 9Z0TPjgH5LdiQErUVz5M6qCBLJlmLC7RcmmO+rD7FdR+Z/0Ev92RuP1DJXKaj2QiNp
	 MCtFh4b1E1+eg==
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
Subject: [PATCH v2 22/33] docs: rust: quick-start: openSUSE provides `rust-src` package nowadays
Date: Mon,  6 Apr 2026 01:52:58 +0200
Message-ID: <20260405235309.418950-23-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both openSUSE Tumbleweed and Slowroll provide the `rust-src` package
nowadays [1].

Thus remove the version-specific one from the Quick Start guide.

Link: https://software.opensuse.org/package/rust-src?search_term=rust-src [1]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 152289f0bed2..642efce04ee8 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -84,7 +84,7 @@ openSUSE
 openSUSE Slowroll and openSUSE Tumbleweed provide recent Rust releases and thus
 they should generally work out of the box, e.g.::
 
-	zypper install rust rust1.79-src rust-bindgen clang
+	zypper install rust rust-src rust-bindgen clang
 
 
 Ubuntu
-- 
2.53.0

