Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B401D0E36;
	Sun, 17 Nov 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870765; cv=none; b=GmHWWbJLFcKbliBjYxvRUHWiIuC9D5mzdwE6jRswYc8DK4Ci5AkLWzG6pyo2cMsTxiCTD79n6wlcUiQSX3fD+5iHpjjjkNEaQOkJ4q7YcmNr2Daash6Fyxr8JP6RgUrvTdk7lITlMpMlLS+7W/n+a+h36apfH6fAYX/XkJMHO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870765; c=relaxed/simple;
	bh=ASVA2amIFW5FENrDgEkM966w+kxcrbmrpSymk781uHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQPKz766eC5IuI1G5od1dKodpynuceL6ZuWcXKCsY8uqGZhKILQFNFW2eZchhK6HtB+fO7SzgrtJa2inZm/lbZc5eCxpaJKJ7q7lDyx+Ok81YAhDbXa5RXub2Em9VYvMAAHgJfKo+cNatdwh+yQKAT9fgsSkA4DShwTJWm/vJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=19/3aQGa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="19/3aQGa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HMfIEADOugcgiUAodv2gG493oC36UfBBY61jIgLvjF0=; b=19/3aQGa00zPOvQCtrhHc3HBuv
	iE//3305Fi5/JLnYjfcmmoVRuTIL6G7KXc467yHydhoxGaGyqTEFARe2dj/fQraInPA7+pfP6+r5G
	ThaKvzLBcumvvPd9dLoDYy8++1AKW8ZMp4mJsnYXRoEwJbE78/QhtnK2NQ1V3DL4DPKKY+KqIzq9H
	imEJTa7IqtjNybIWsB8eDKilg3MI4f8kseKLQfwPy9tD1b4MAn3+bPYradiUnv0JYPbvdphGMxp0j
	z9QHodNmPu4VdmidUhn2wzgcLUq3TF/ETexBcrxTm14Wwzmj4wrkyEbKxRMlSEnAdhuceEw3JFiOw
	e14tmcow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tCkhA-0000Zm-0Y;
	Sun, 17 Nov 2024 19:12:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tCkh7-0004Lt-2f;
	Sun, 17 Nov 2024 19:12:25 +0000
Date: Sun, 17 Nov 2024 19:12:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: manas18244@iiitd.ac.in, Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <ZzpAGXVfBkJ23gCD@shell.armlinux.org.uk>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <Zzo8Xx9tJdvEO1Q1@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzo8Xx9tJdvEO1Q1@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Let's try that again... with Manas' address pasted in _before_ Andrew's
"A" !

On Sun, Nov 17, 2024 at 06:56:31PM +0000, Russell King (Oracle) wrote:
> On Sun, Nov 17, 2024 at 07:25:48PM +0100, Andrew Lunn wrote:
> > On Sun, Nov 17, 2024 at 08:41:47PM +0530, Manas via B4 Relay wrote:
> > > From: Manas <manas18244@iiitd.ac.in>
> > > 
> > > This patch replaces `Result<()>` with `Result`.
> > > 
> > > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1128
> > > Signed-off-by: Manas <manas18244@iiitd.ac.in>
> > > ---
> > >  drivers/net/phy/qt2025.rs        | 2 +-
> > >  rust/kernel/block/mq/gen_disk.rs | 2 +-
> > >  rust/kernel/uaccess.rs           | 2 +-
> > >  rust/macros/lib.rs               | 6 +++---
> > 
> > Please split these patches up per subsystem, and submit them
> > individually to the appropriate subsystems.
> 
> In addition, it would be good if the commit stated the rationale for
> the change, rather than what the change is (which we can see from the
> patch itself.)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
