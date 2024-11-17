Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59319BA6;
	Sun, 17 Nov 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867973; cv=none; b=rSHrpl6/LzLhwkJOyjv5LnPXVau+nhqaVfT6wGiob8P8SqbjYr2kXLVJbo1ikg4c7f8JsO+EK5PISTdWU67w/jMqmmEAfLxq3CghLWwkdyqLLO+cXqp4WfXdUrWX9IYheBoD0Dy76395U04ZP9IibS4uw7TBTJvobQfnKSN3gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867973; c=relaxed/simple;
	bh=L5i67y0gMIms/tG4mdxgZaI1qv/UhvU9JzFgf+I6i88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSTDvGqeWiJ5jhRu/lb4q89VphA4/zIqFzCcInDvXhS34s9BRRegew/IBGtoR+7ugKlrfzsyNcCnYLSPoz+Qq8OIR3d64RAlvte544BX+UAz4pzvfwhrWe03ZnvU94qsATi++whOQI5Exx3tL7iwd0pzGSwN+C5g4BKcQXswvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iKmc/WyX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iKmc/WyX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AGQIXcjAkiejG+UbcSeM9PSqSR0eMXRHAu+HA5Bn4LA=; b=iKmc/WyXkq4taeMNAJmHOcSXjH
	/GykTUb3E61RiPdvqBjNABw+uGUZ5nHM45aWI5DEDBh46uFonHNrmp8eatxogQo2NfBPP+ZgkGMHN
	ll4Wi5nv8fORT8/g3v1S/C0gZ2WZ5SDU+kH9MiD3rPj+ea5PUKVW4IXlRa5iQslMEG0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCjy0-00Db2A-Cq; Sun, 17 Nov 2024 19:25:48 +0100
Date: Sun, 17 Nov 2024 19:25:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
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
Message-ID: <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>

On Sun, Nov 17, 2024 at 08:41:47PM +0530, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> This patch replaces `Result<()>` with `Result`.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1128
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
>  drivers/net/phy/qt2025.rs        | 2 +-
>  rust/kernel/block/mq/gen_disk.rs | 2 +-
>  rust/kernel/uaccess.rs           | 2 +-
>  rust/macros/lib.rs               | 6 +++---


Please split these patches up per subsystem, and submit them
individually to the appropriate subsystems.


    Andrew

---
pw-bot: cr
