Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511B18C337;
	Wed,  5 Mar 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166984; cv=none; b=VG+Fg/Fd3jgy4+8U/mSzMY/qao54FQRyTK64od623jCkrJmAJvcrRmaM4Cbqwc8lxF595cZFDy/3VdagfeiocOYljhR4JMXdn06J+9g7yKjgf8jQYnTtkxvdWEqwANrSdgxbK6B0jbl4sUhIxKLPdq+yDkEa4WkPaA2oGiDpNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166984; c=relaxed/simple;
	bh=W2An72+jiqC1FDb6lg/SymgD0wkSx9jpkXLB+exoddQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blPg/aBX5hTwV1S5R2fE1hviCv/jTLjIBS+O/L/JmZMxkK/pszlQT38bDTM1PVP9ZaBosUJJ6G82cTLtA1SzH+k8DX8efQJlsExM0odgrFym6ILtQBstMa+XqmUnGH5CvIJxI4LDMkNqsU66eou2n7yhpXeXCbu5oSHwR35Iqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=pTo/NF9x; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="pTo/NF9x"
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166980; bh=W2An72+jiqC1FDb6lg/SymgD0wkSx9jpkXLB+exoddQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=pTo/NF9xEdbzmlOOLF9hPX9rl9qR1cDHmJWVDOVFcp056tB8H0UutMyMcHbG870LR
	 ontu86cfT4ThKJRg2P1J/227ay6SoHZec42s2ChdYyh+C89Wk3lsyEirNXo2k/YDu9
	 GYH31WK6LzzzIz/3z6xRXU5tNb91U8sJ2fjJ7zu8=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Danilo Krummrich <dakr@kernel.org>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar
 <mingo@redhat.com>,  Will Deacon <will@kernel.org>,  Waiman Long
 <longman@redhat.com>,  linux-kernel@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  linux-block@vger.kernel.org
Subject: Re: [PATCH 15/22] rust: make pin-init its own crate
In-Reply-To: <20250304225245.2033120-16-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:21 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-16-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:29:40 +0100
Message-ID: <m2msdzg70b.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Rename relative paths inside of the crate to still refer to the same
> items, also rename paths inside of the kernel crate and adjust the build
> system to build the crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>
