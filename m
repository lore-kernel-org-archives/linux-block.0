Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CFB672;
	Sun,  5 Jul 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783263845; cv=none; b=uEuTgJm8mZUIXfhxr3YJY8+sMwIEqECabpD7NvCE5jksnVT9ZzTyUKlI7CyiLX5/96aDuK8SqdBqzLwdIxnpAFjA3FO0LFbaGk1lSkUtFsTD12dEWC3lazCn89Ymi1rxaWwIUPR8yjafyuLt1u9VHApVZKD5/59SCc+5DLanfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783263845; c=relaxed/simple;
	bh=wo4lqtA47GkxIAmoMhie9KkYyvnhazyJKrtTvigul0M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh0/Gu9Q/f0WMtOIm7rMg2DFAtdz5mFuV99VaT9+ILzau34agBSmNEIzvpMMrVhpgKuwm6/rHKA2IGvtYsKIvSYa0MdbDrVG/cMoGvWg5v/MkddQg6Jnny34ehEWvheI0Y4shUbeuoYlFVHk/MZZNHXtqNrxIMToXAYHuv7LA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u7Fb4+hm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u7Fb4+hm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MjFyE/GuY4zCXOCWmZjS9nf5WEwFKlMosakxlzzhgKA=; b=u7Fb4+hmzFx3UipHSwoWedWBaU
	KSTZCMZWLVdMdrU31XEcUPWdZlHdz0ghtvmlN3vYOq03ljvEGr7J1v8LIogoINE9dgA7GCnG4mXCJ
	WS9CcL5vZF6JVFEG5lvN5eyR1iIHx3Uu1oP70Kxkp4a5WTenUj/5s6GW+Oe8Akb6oPZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgONV-00AqQj-DU; Sun, 05 Jul 2026 17:03:29 +0200
Date: Sun, 5 Jul 2026 17:03:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	driver-core@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, netdev@vger.kernel.org,
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various
 drivers
Message-ID: <66d3d69d-0974-49e1-ad93-9295407f4b78@lunn.ch>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch>
 <akmnh0AKFfu9-OYn@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>

> Is that reasoning off-base, or is the right path to split these out per subsystem
> regardless?

Adding to what others have said, some subsystems have there own CI
system which tests every patch. Does it build? Does it add new
warning, is sparse happy, are there more self test failures. What do
different AIs think of the patch etc. Cross subsystem patches don't
always hit the per subsystem CI tests.

So in general, it is better to submit per subsystem.

       Andrew
