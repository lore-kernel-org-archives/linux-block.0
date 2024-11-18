Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3D192B79;
	Mon, 18 Nov 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936580; cv=none; b=bSiqCTfsPiLJ0b6EVJvnacDMLJm17DyEwd/cXwIUi0hBHW6F7Zmt0b0ZDp8wG6dLMa3Xw5uBE/fckGKR6NJix5XQob8Xc4lkm3R3baf7diH8t+BISQavgPtGHQW3eUXzuOJKBQKyK/8tI7i2er9ymrRGRImWL5QYWU3wMU0Gtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936580; c=relaxed/simple;
	bh=o5yRj6ec6bqaOr1zzgQxaJkN66tIADmWesURV2bEvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8pXnStz3CgNQwJyRjl7QHNFxh83njbq6bAuKCGOggLLJR2y0/6Yc+jHeszHQ2CmsZoR7Ed96b/klM5l/yachr9YU5U0vBy/URVXoPlDa7L5RIdiHubZqF8+8IVoJ+XG9LDkU+xS4opvHtTAjcQCFiFJHLiIfRkAwa45MoLU7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=21/KH2GX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="21/KH2GX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nbUCIrXWkfu2j4KghMIOK3GN+uHxW4/oMh10nEOsiSs=; b=21/KH2GXremB7+5Cri8XOZ3xMw
	Q4CTV45rGLG6NaRo5kKap37rvizvUjKMaGW151+fyLZJ2/gamN637Xma2omiqJuIv4+svv0aTIFSK
	Vl4TnRoi+SFUqgKVVnSoqN5vDskGov9RXY7o9oWleaBqhEW3YzSf8I6kqXacEmJdBNS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tD1oe-00Dfln-27; Mon, 18 Nov 2024 14:29:20 +0100
Date: Mon, 18 Nov 2024 14:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Manas <manas18244@iiitd.ac.in>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: simplify Result<()> uses
Message-ID: <ea0ee999-06ad-40d7-9118-695859fa9afd@lunn.ch>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>

> Andrew, Miguel:
> 
> I can split it in the following subsystems:
> 
>   rust: block:
>   rust: uaccess:
>   rust: macros:
>   net: phy: qt2025:
> 
> Should I do a patch series for first three, and put an individual patch for
> qt2025?

qt2025 should be an individual patch. How active is the block
Maintainer with Rust patches? It might be he also wants an individual
patch.

Please also note that the merge window just opened, so no patches will
be accepted for the next two weeks.

	Andrew
