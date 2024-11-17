Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE25CA64;
	Sun, 17 Nov 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869829; cv=none; b=jupLGnXbyd9mgZJ5Qr+iaDpFP2HFzWV6Vmcn0mi33IEDvkKSvhdFfpxVCeu8Bn5KQlEa64GlCCvrBtueeO/faULoGj4sDSpbzFU8/2AH7S30zD/j1Xsc9PHsON0UJ6e/ri9e/uPYzjtdd9ZIGr7pLubViYA8dTDcz+g8yk0elz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869829; c=relaxed/simple;
	bh=SEOIgTCUy4+HOH8UQKeT6frqBa7iPvkcDq9wa8F7ROo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+59pKzq1W9Xaf2LlmWEVWebdFSQw10wE6Jl41f+CkLXTRAiUR65vL4KSC4LgHPi0SbLH9yUoytJ9Ozs/aqfFOVX+rWu51Qc/Ho4GF6K28wAEHYMAM2dkP/N0XoKO0uzlEApUdUw2RuLvkeycWxrULyiT832hnU99T38n/+ehJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g5ezFbgq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g5ezFbgq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NHVg2E/H5YCAy5+1o4Vz0LNrbxQqYDDkxHcc+tN/8GI=; b=g5ezFbgqIcrjJdkml8RtQoMld6
	FLfqJx0j7ZqhcgH8EMczXQs2L0/GSXkrQm3nHFOHX8qnaXDpCq4NGQn8NnQPuADHtRKTSCUMr1irQ
	wNmu3Hl0Tum/GzT1b48gxov6tGZNxCXx0KjTk3MGESB0wpbT5q2YDNqPB2yvZac62sEONtCry7Yl9
	tNG08/RdPqnHzE21kLUOtd7mnzn8iVngN14Mwf17vZyvTSOYb9elnl/KCjbcyU8HVJuse++7y+A2b
	b8GLk77GeAe01HPcRwt5HlHnqWsShhNrHNiH8rnKU1eUgsbOEidp5Rn9PUfRtDpdvAjMFTziOAJz1
	gD/SNi/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50362)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tCkRo-0000Yb-1Q;
	Sun, 17 Nov 2024 18:56:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tCkRj-0004K9-2Q;
	Sun, 17 Nov 2024 18:56:31 +0000
Date: Sun, 17 Nov 2024 18:56:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Amanas18244@iiitd.ac.in, ndrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <Zzo8Xx9tJdvEO1Q1@shell.armlinux.org.uk>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 17, 2024 at 07:25:48PM +0100, Andrew Lunn wrote:
> On Sun, Nov 17, 2024 at 08:41:47PM +0530, Manas via B4 Relay wrote:
> > From: Manas <manas18244@iiitd.ac.in>
> > 
> > This patch replaces `Result<()>` with `Result`.
> > 
> > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1128
> > Signed-off-by: Manas <manas18244@iiitd.ac.in>
> > ---
> >  drivers/net/phy/qt2025.rs        | 2 +-
> >  rust/kernel/block/mq/gen_disk.rs | 2 +-
> >  rust/kernel/uaccess.rs           | 2 +-
> >  rust/macros/lib.rs               | 6 +++---
> 
> Please split these patches up per subsystem, and submit them
> individually to the appropriate subsystems.

In addition, it would be good if the commit stated the rationale for
the change, rather than what the change is (which we can see from the
patch itself.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
