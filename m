Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5D372B4F;
	Mon, 29 Jun 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742048; cv=none; b=tYJghlsXhPQDR+v6q64MymrJdwFqLeIib2XsSvz2v5OSubWBlmVLmWo/mKfXJoDcRz+BDbj2WGpcR/UOzIwJ+zokynKLP5oMKT4AqnZDWTpP8TRSOIzrPBIk+6/gR6BjJG9/CrReJ2Ewa8S5Htmbzd0BDqTEE3fCtUSUyGWfs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742048; c=relaxed/simple;
	bh=QoLTJ57tMoqWinR7HP1trdAaWAx87URKv1Q4ZqAnHvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2QZhXTeZzLw1l7yPiJC7OgJ/OVN/ARA06Rxodh8uNjXwzR3aYTgZoWL4pwbIHov/MLOE7yDC3r4H5ALk/fQR7VS+jDAWm6ZgXBfoXF0a/Vm+R/V7xgmEmdCM01/Il2PG8t8jsDNHsiHiDsj/25Jz+FtdwPv47RPotz2w+AziKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sPe3Iq+2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sPe3Iq+2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AK6FrYtKSIh8cngqIV8WnN9GXpQxjhIF++nUuJZfwbU=; b=sPe3Iq+2B0cNSg858/MXj17mqs
	nGlNw4jzWt1Blm83SZhOTLuScCneipEQxYrk7fXoJmwYNeCbx8QSg1zGqipMB+jk5FPKkzUkyFMIs
	HpGichrCIBqHOm8y6SCjU5HgKkXaATkMgoXLLY+KqvXdNOnkRWFnviWgOcyKmCa5rfCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weCdA-009lYC-UB; Mon, 29 Jun 2026 16:06:36 +0200
Date: Mon, 29 Jun 2026 16:06:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
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
Message-ID: <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>

On Sun, Jun 28, 2026 at 08:38:14PM -0700, Guru Das Srinagesh wrote:
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Guru Das Srinagesh (7):
>       samples: rust_dma: use vertical import style
>       pwm: th1520: use vertical import style
>       cpufreq: rcpufreq_dt: use vertical import style
>       block: rnull: use vertical import style
>       net: phy: ax88796b: use vertical import style
>       net: phy: qt2025: use vertical import style
>       drm/nova: use vertical import style

You have multiple subsystems here, so you need to split this patch
setup, per subsystem, and submit them separately. Maintainers only
accept patchsets for their own subsystems.

For netdev, please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to get the correct tree, and set the Subject: line correctly.

    Andrew

---
pw-bot: cr
