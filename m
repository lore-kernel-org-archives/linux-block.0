Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47C3859F8;
	Sun,  5 Apr 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433532; cv=none; b=f8+iY6F3lplP3U4DVTYVLDVvs8mKaewoA7t0QIEzlzjTSRjV2oYHJXADYccBXiRaBRtrsnptM7c4/xx0yrQ88k313m+shf3M2Qb7mLHSQmfvakJ6v5EwM/R1hXkY2Qj0urJZ2md02elb62wrjTPcz0r5kIwqKJATe3ielqiPlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433532; c=relaxed/simple;
	bh=paW6MVyC5RLTn5+ATDoZoKrgzNCf+Tz+wEGksZWPCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9VO2/jfiMf4Gx6o7I1hzxpu2qJDDBeg3D9JqGtdxK/CsT1N6J61nD1ZP7AeEPtOR3k/w8Xy6p45sSE8w6B66YObDW9YzyIK2i61q5p0Hg7BHqIwmcmaZsOKFnifVhttlo4F4I4cJiduVwXGSUT2bg5Acalf7vDXNTdd0z9aR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4G/tCdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4G/tCdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494B1C116C6;
	Sun,  5 Apr 2026 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775433531;
	bh=paW6MVyC5RLTn5+ATDoZoKrgzNCf+Tz+wEGksZWPCME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4G/tCdhMwNTwMVQKUDIDrqWPgkYw0KiJq9u25hGeSPJ/Fo06XMppoxVc3vyC3Zg0
	 SXOrQcKPC52AeI6H6lQE7QRYpx0uRJ5sWvDNnmBL0H0XFaNdd9j2T/Bfi9w8ub7jmC
	 6rduwwEJhBUdftOMJKBE+CncJFa8XaB7TvI7/20GwXEotETkQqvgZF2OjwkfkzHjGF
	 EN4Gw/2Cp9UUQx+5tbW2XMSEMTbGQ9FO9SGecgO/kiWocy8aGKjugZOptUL7F/9KUR
	 4G7K57s+degp7qGSB4gkNZS/usFeLqSef9x3wrQJUa+nKx05VUYRogGivr7rvLNgN+
	 ok6cCQqnaLyOg==
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
Subject: [PATCH v2 29/33] docs: rust: general-information: simplify Kconfig example
Date: Mon,  6 Apr 2026 01:53:05 +0200
Message-ID: <20260405235309.418950-30-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
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

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
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

