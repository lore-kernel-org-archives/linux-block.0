Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACB18DB1A;
	Sun,  5 Jul 2026 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783211925; cv=none; b=pEUsoh9k8nDpcccw9eJlG/qCfiIKz1hIp4rptKVm+tTCoSYXSttDdICY9r9bVRrSz2o5SZqpNSLSCbJvqnXSqjGdNKlFxWjWcywWhlDq0hpwjPuhY4Zr/nEQlX+C3aCH7gW0TUyoUGpYfv9KKxzs8oljVyZxRBXL/bqD++SdH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783211925; c=relaxed/simple;
	bh=7SA06ppJXAjnwTFQhfShgMBi+M6CQvRcfOhns8TQ+vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn5A0pQ254s9MVg9JBMTJoctZak/sABmEgPpJFFWgIMbKHMatQwzG6xYGTxQVdYWpKUydq55FvV1HdFnf3x3m2cQ/sdVixYtpk9Hn0U+gAXhUPjl4OwOrB1z9kw8jbe3HCXiPQ9hHFcy2M+MlPdxxi4ev5mxcnuTMwIYWBpn9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=NSAOyNTL; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="NSAOyNTL"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gt7rn4SRMz2x99;
	Sun, 05 Jul 2026 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783211915;
	bh=M633SL93BCN0PrL2e/cwx2xlbDs4y1U/AlCmHMhb3AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSAOyNTLPtXZ/k1vM23d4mp6kcF0MfY7hjEozE9ESHWUStbSSsqzbmiiD9bT9KmME
	 xnAufNEJYHbKrfK7MERrVnvmbFeMgkIx6GxHLHSyiCFyy3RCzqYObOgb2IM2gkSkEl
	 n5ETauFMijv8KmS/jXdluLdYQvgxUilcbOPVqAPT8FXUj6yRzgydyIO9gJ4MdAtdnt
	 cxQgrF191paqd10Z5zniDfAmO76GJCGEoWxy3mQV3UO+ca0IHbz6G7bc9o/6KLFbTN
	 eEaQWUGbFQiNK5sG4hbYbqVp7dDxT5pfkoyvnPCLpGPi6eDF8GCzqSTJ/ZeBQ4F+xV
	 T2FbStM6b4UEQ==
Date: Sat, 4 Jul 2026 17:38:31 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <akmnh0AKFfu9-OYn@gurudas.dev>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
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
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch>
X-Envelope-From: linux@gurudas.dev

On Mon, Jun 29, 2026 at 04:06:36PM +0200, Andrew Lunn wrote:
> On Sun, Jun 28, 2026 at 08:38:14PM -0700, Guru Das Srinagesh wrote:
> > Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> > vertical import style") and found a few more locations that could
> > benefit from this cleanup. No functional changes.
> > 
> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> > ---
> > Guru Das Srinagesh (7):
> >       samples: rust_dma: use vertical import style
> >       pwm: th1520: use vertical import style
> >       cpufreq: rcpufreq_dt: use vertical import style
> >       block: rnull: use vertical import style
> >       net: phy: ax88796b: use vertical import style
> >       net: phy: qt2025: use vertical import style
> >       drm/nova: use vertical import style
> 
> You have multiple subsystems here, so you need to split this patch
> setup, per subsystem, and submit them separately. Maintainers only
> accept patchsets for their own subsystems.
> 
> For netdev, please take a read of:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> You need to get the correct tree, and set the Subject: line correctly.
> 
>     Andrew

Hi Andrew,

Thanks for the feedback.

I was aware of the per-subsystem rule, but reasoned that since these changes are
purely about Rust import formatting coding style with no functional impact on any
subsystem, they might go through the rust-for-linux tree with acks from the
respective subsystem maintainers. The Rust coding style is independent of any
subsystem-specific guidelines.

Is that reasoning off-base, or is the right path to split these out per subsystem
regardless?

Miguel, could you please indicate if you have a preference here?

Thank you.
