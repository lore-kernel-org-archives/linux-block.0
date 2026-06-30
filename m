Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D231E5724
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808516; cv=pass; b=Lyep7xjUV4ntZEqrykTm6GW3zr4QXJv3reIuFN40BtNzGTdverJM/dElO0Ss8IY4AFwvBz2axW0hKDpJFMzdsmdFioOms10WzfsEFgrZOCXh35a4wObHunXxkuC8gNGQvgqBgUjjysW8eLNvFoLqVdmvabbCdUXh6gTd99QDevk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808516; c=relaxed/simple;
	bh=12uAIaSCl7tiswRNJqqBaN64Jz/2PQBPhlMgm7mCoFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpp0HmRgEYupNqGoeO9JFwF1Z+sSeIRZh7hxQpQnLlKZMiOjl/wGJOJtFFegLTiyTH+QWxTp7NKHNyU0e6uKrCsYzsMRpiTuNRluJTFb/T5hGhniOa3uYOQJEiK3nJWhWWoXqJJW1wYIzrXokMNb9mISz+NTetDTM6/ZS8Jgalc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4QDKeSM; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4QDKeSM"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30ca8c693a9so276627eec.3
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 01:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808514; cv=none;
        d=google.com; s=arc-20260327;
        b=qDcNXUpUo5h5ShzLeIsyEqA1AVSghDhVg3JUIWP+bWkkRhtIl1o2DtU9SW8yJAAZQG
         c/DjB42IhSZBr8E6yj/4M9oa4zYTWHCmW/bJG/ubO0LJvTtZgYFHrNUoVLZZO08qqpFk
         m906h5fLVSVQpiKKcvUCPSUFHy3bjojUF0OL1Kn7CbGFFSIQZp28G3mWMxQ++aGO3n9P
         t53l7kjR+pEWHFNiX7tvS3RnxSq4k7dREUCMSUJCxvcmUG0+rsJIzBRlPIeFPGqAmRRm
         9mo847HiSpkHeE9QCCAGHhCmE+A2wyS8LjYoNJcXf+g/zfm1C/o5qlIrY02y66tA4pEg
         AYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        fh=y2nFsmRj25PQBn8JMdrxp0092lbUD9lXB6aTxM7AA8E=;
        b=PPwTn666y0SM8Qh0Vi9fdHnFgbzSU6Qt3PjOpeC6v+fS9nfeBue0nAU84/s2ruAMLP
         ZKfsUYR1zxp4JJnEygF1t+mKTvdUIhDhpE/MbTv2kCIcloGbm40gWoxI4HJF74NF5s4f
         0j9g3B9v/9HoqPAK2mdP0vtcKtZaG2KeYexCCZ5V+F81avPbA/2d6n1hiJgrOgDy6dV2
         Y5UA9Ez5c9ME/JbUZNp5TNkL70XvqU0Pd+0B9J/tGTxlu79L1dvRGaGbJsXqkFYeDNWn
         RS0wzont+nfPEcNEZfLrB8Sf7dYFZNjIxrG+lz0KtEcHm1/okZU1VmCeN6NX2qS5OBRd
         lI0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782808514; x=1783413314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=P4QDKeSMKLnfVsDrpWCuEmR+fde0eSYT8JQqFhe7xLiugA+IX+ZEepZDsU6I5Ie6jm
         EtCDCgp7ZUpLvZdZ9CeeHs1gUu0FxMROHIvFtqAoQDLzY4WLKVd+sF0mn1+zSJcaOOg7
         ivbtAQ3UbteWlBQOZntGY9QsskxDj5hlMxFvEVEvo4HBZvZsK14n0N8BCitTpGtn20mb
         QA2/hDVc2OLBIH9W3JVORw9oy7kYaxNwQxRz/mq6Pak487EKo1e1i7J5CyPThcjxMTpL
         uBwhyWHKVQUOpS4s/mkDiT5cs0YZI553d1UZiED4mLQC2v3AAQ2O+HmyAr+DDIx3cXgg
         pdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808514; x=1783413314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=mu+5JT0GhPdwBCcKoTYHZK9lEFWjWxvO7y87x4Vuw1U7Yz8CsvrPpKYyw2IzFtPUjq
         4byOpWkVkaMnr/9ieS0Biym9/zSJc5kHu5xdYy587FmjT3F3zoY3EPNkkjZSQOzJyO5i
         eTfkdReUtqJj64EyOI9rIK7lLl9aY4bKklD9sOShuHEGbbrjjx/vgqwjMMjYDFPjyK6R
         d4J2o3Hiey8xlktqg8P/4sRnucMOfpmkk+XEwbRYPI1ciqQjVJIW3wwRyoWjXpPM1Y+y
         UzK8QgMzxi8I6z8tbcnyZQO2G4A4SI6ogJcZh3MR4/9HCIl1dfsJ8tdbn97z282z1UKK
         0JUg==
X-Forwarded-Encrypted: i=1; AHgh+RqhBr8f1paGU3lG4r8781Nmuy/QR2gxE8azQKKq2zGR0r8wfh6JfkiHvQkZIO7dCqKmc8k0gR6G/zl8fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjCbTGqucLw684vQaOAcHUbr7UMMdOTpBde1MWwGaLBIfV1ng
	wdBRwnLUwXLUjQOljAAwpYaTrFaMfUx1dMxt0PACYylkxShY68lj/XjsNcWujy5c651ZIaf8An5
	lWgMbmbnk2d+buUi6rp4I0RDjIAGEa90=
X-Gm-Gg: AfdE7cnwoooW2CICgeX68LuB8BG3BMf+x5EChccrfDGjHd63taX/Kb6VN5qN+fbaX07
	NHWqjdPc20URgwyIpVhcu6s2tb9gX4hQThowPleBbzIGpL6m34Q4Z8Vs7JNr+OpL5ywVM1fM1t0
	ib9zh4OqMTGBaQO+c1mocQxCYvDbNEjLDl+BhpKf3j59g/qW/e3emj7kNO2VhexhYuZMtx2SYdJ
	GaApoTqFCBOpHpNv2moh/o1LnsbIdVw+51fUzyONblwUdJaznH/uLI6gy81LhDD3T2MFQAc+U6V
	rjnOOJ25rzd/wJzUKuAHvmOUv9CA9qC1q4aDJyZH1bJ/89rqrXvSYPcvO4x+nUTaTxKziopWPQr
	SBBffMZIFLfSN
X-Received: by 2002:a05:7300:6ca1:b0:30e:dda8:e0ba with SMTP id
 5a478bee46e88-30ee150954cmr1003565eec.6.1782808513710; Tue, 30 Jun 2026
 01:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev> <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
In-Reply-To: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 10:35:00 +0200
X-Gm-Features: AVVi8CdhtqV-BYuDJ7-_rhOqSdDxdGUExu9BuuQ1x0bjmiH_24JXcG_HI6rxurs
Message-ID: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:43=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> If the preferred style is to place each imported item on its own line,
> shouldn't imports such as
>
>      cpu, cpufreq,
>
> be formatted similarly as well?

Indeed, good eyes.

To do what we want, `rustfmt` needs the `//` at the end of that level
too (in the future, it will be without the `//`), i.e. the patch
probably passes `rustfmtcheck`, but it still needs to split that line
and add the other `//`.

Cheers,
Miguel
