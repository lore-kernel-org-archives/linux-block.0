Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464175;
	b=zQIh9YGrfnXoLGVa2rLYIA3dDvNEoHwzJIn/xoj/qPjLT3IsNMtu66eJNTSQ88R8A6JB
	 cGq1gSnC37wc0Xx7V9vF32yhaycLA9GVv0YBT3GZj44Dk+ESuR+R/s7sZFcTgIvj5DdBU
	 9umIVaVBly2e50mSKnODnZ4JIqmy7qnsE93GfXHos6dj+Nx/zkBCvH6oBXzpRLO2iR8oO
	 l8WJaCa7MAef2VxXpZ5Ym+2A4bbJ2ruRVxivPqi+qbZzSWLMo/975sWIzm68Sgbi+4Uxz
	 nTskdtGmdsbpD/o8JVYnbtJyc65URgbfKFyOTbjMBp7Cls721DYcsXx2sYM504tkbkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9zgZOaH/pTrBga2uIvgJ+J3Jf4YGUIVSNOYm7+FX/ow=;
	b=OQE0sHCg2+09WJf1l+6MO/TMXkQQsSkhtltzMIXJOFM1QSJZr1SE7P4ybps9ISBJnkDU
	 PS5ZhWgVURqbS2Su6WfZ4cASPjKnYl1CjHu9p4zJ+uLUI8f+s7d+m6OUqCIqYIskkBmPO
	 /Mbasm3TPYUXGNGQHENOJtKOUfFix4SAhIxIONuTHSwb/ee5h6EQ5x8pmPmDUNR1RyQqK
	 felOEdmEpUxHZoHyi5g6jsFWwUAhsAB02qG0KtIYk1XnI+qepb7ynDs3OUmhcLPlU0hgJ
	 saaQm34fZf1zoUO6lTwKJ/FymUw9t2WBec94EGsLtqn5ZohS/xyWcNViAVoDspFCaBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzm+pKMH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF7606A31D;
	Sat, 31 Oct 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzm+pKMH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277081F000C1;
	Sat, 31 Oct 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793464174;
	bh=9zgZOaH/pTrBga2uIvgJ+J3Jf4YGUIVSNOYm7+FX/ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzm+pKMHA1jaM18c4ND1UjKuZfxRb4bPpgPqB8XcO3wLDNySsaGQJMp6Ec3jObCMl
	 5n5V/Rgrk1QMpOxj2tshy14MN8hhoCx9cPHJT503nY9pN2Tv0tvltifKiJBm1LNSTg
	 0eLR9MYc1gy21MkTh7aka5kx1Gwdhbbr+9kIbG5Ye61VPhk8JhbBMstknYNSYgpdi9
	 MdYEOQipsoBD2MMjVuTwdRZ6h0d03j3xGBa0dES4aplajt2KoK/QQVeY0Zi2sXGWcL
	 WCaksiE2bspJ9pkMs/8sGpVIhZHS+RDg3m4zBlPclmNSzHcJvKtqOXS4qqw1b1wOag
	 VxQZk+r9CJz5g==
From: Sasha Levin <sashal@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque array wrappers
Date: Sat, 31 Oct 2026 12:29:31 -0400
Message-ID: <20261031162931.792607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH5fLgiSOae48jr65rv6ynLWUhT7xVCjjCEK=9oKXvSxKpdq6g@mail.gmail.com>
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk> <20261031152846.746656-1-sashal@kernel.org> <CAH5fLgiSOae48jr65rv6ynLWUhT7xVCjjCEK=9oKXvSxKpdq6g@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 31, 2026 at 05:17:46PM +0100, Alice Ryhl wrote:
>Is it possible to instead fix this by adding the impl of Zeroable in
>rust/bindings/lib.rs, similar to this piece of code that we already
>have:
>
>unsafe impl<Storage> Zeroable for __BindgenBitfieldUnit<Storage> where
>Storage: Zeroable {}

I looked at doing it that way, but the wrapper types don't always exist,
so a fixed impl in lib.rs won't build everywhere:

 - bindgen 0.71 and 0.72 (we still support 0.71.1) don't generate them
   at all, the blob is a plain array there.

 - 0.73 only emits the alignments a config actually needs. On x86_64,
   allmodconfig gets __BindgenOpaqueArray, __BindgenOpaqueArray8,
   __BindgenOpaqueArray64 and __BindgenOpaqueArray4096, but defconfig
   with Rust enabled has no __BindgenOpaqueArray4096, so an impl for it
   would break the build there.

__BindgenBitfieldUnit works because it's always generated. We could do it
in lib.rs with a Kconfig symbol for the bindgen version plus some way to
know which alignments a config ends up with, but tagging the wrappers
right after bindgen runs seemed simpler.

--
Thanks,
Sasha
