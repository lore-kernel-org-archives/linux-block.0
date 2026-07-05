Received: from out-06.smtp.spacemail.com (out-06.smtp.spacemail.com [66.29.159.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170C4207A;
	Sun,  5 Jul 2026 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213328; cv=none; b=KWeoYsODK9a0kyomA9oA7JvyYBc5V0T8gd/2OlrWIXCwAcSfqoe7ptjmCBrxSs77VzZDF7Q85mEwJ6iEZKI64pTHgxHmBmstvgZgFORnS02345l7JTKmq0zjCIMFode3kw7TSp82s5jCi+nCgWjntyGPyglMvleK8OYHQX6BjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213328; c=relaxed/simple;
	bh=P3lugvHk1nwzrdTe7G8u/RXPAFOq2rNX03Ue4yK1EdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyHFNZfemT/vlp3PLJxCrq+DQZuBicHD6aMh1rONrw0Ltk11SDTmU9SBFrcelcPKOwcNVGldyXBq6rypQr1V4Dx8BmRyTHYFqOtUBFXs7zPVx59vt6YqcrA9YYmruP3P4B97tmWG8SJUIC8EinZNej5M42+7Eieim2P0J8l5WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=gxzDANV1; arc=none smtp.client-ip=66.29.159.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="gxzDANV1"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gt8Mn0CXjz6tkM;
	Sun, 05 Jul 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783213318;
	bh=2qJqLI5cYmY6XssOjT5mS6RQt8tME0zYaMT/RBuKHhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxzDANV1JQoWbSrlTIw2Hbb83lUzmrjW19c3OZvI3lIFLUx0NWjORGAdcrfZ4Iy1r
	 8iyC/nftZCN6RsgyVPXhGqT3xB7lKhDTIYvv4mPgt23HneL2vlZdPZGvj5/AKk5Pfp
	 wZfKzZkjQvogs3VONlJW1oADetqYF+Z1IsjAZyW86GXa/ntxYiqBXIBTcI8TBWs5qC
	 6LphD9AsDF1QQyi7SDc//YsSj4N4PrmToDXekNK0bsPhGwCiGJIgQfdhGPqBLM/i3q
	 aiuUXbswiQh086BPfvu9FQvRyd8BtJCb/XDmrMZaTKsgOjTHbYsMvyE/xBsne6r0RG
	 gHli7e1+IvGdA==
Date: Sat, 4 Jul 2026 18:01:55 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
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
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
Message-ID: <akmtA7EbVBdhRAOq@gurudas.dev>
Mail-Followup-To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
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
	Andrew Lunn <andrew@lunn.ch>,
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
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
 <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
X-Envelope-From: linux@gurudas.dev

On Tue, Jun 30, 2026 at 10:35:00AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 2:43 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
> >
> > If the preferred style is to place each imported item on its own line,
> > shouldn't imports such as
> >
> >      cpu, cpufreq,
> >
> > be formatted similarly as well?
> 
> Indeed, good eyes.
> 
> To do what we want, `rustfmt` needs the `//` at the end of that level
> too (in the future, it will be without the `//`), i.e. the patch
> probably passes `rustfmtcheck`, but it still needs to split that line
> and add the other `//`.

Hi Zhongqiu, Miguel:

Yes, I did run `make LLVM=1 rustfmtcheck` and it passed on this series. I will fix
the missed ones in v2.

While investigating this, I found that that adding this config `imports_layout =
"Vertical"` to the rustfmt options would fix all the imports automatically, including
the ones I missed. I ran it locally on the files touched in this series using rustfmt
nightly and it correctly fixed the imports as desired:

    rustup run nightly rustfmt --unstable-features \
      --config "imports_layout=Vertical" \
      --config-path .rustfmt.toml <file>

But unfortunately, since `imports_layout` is an unstable option currently [1], it
cannot be used straightaway.

However, .rustfmt.toml already has a section of commented-out unstable options kept
as a reference for when they stabilize. Would it make sense to add `#imports_layout =
"Vertical"` there? If so, I can include it in v2.

[1]: https://github.com/rust-lang/rustfmt/issues/3361
