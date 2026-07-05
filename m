Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF93749EC
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253581; cv=pass; b=BEVGyaNei/aN9PSVQJY2vL76ckUGFulwGzPayf4b+wSmNOxslkdJYIquxXwRAjXTETmJKyGhPzSbhe/qOURLp8JE083WUh7l6lQzkzHTYFa9YaRIjRdxRfu/6vpy+PgPzD38k3cTSDQ5BO3XHYh4lPwa8feBgiXvEneXvlq5j0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253581; c=relaxed/simple;
	bh=5ISwFpI0UbPRq9FTX8wSAZ5/fVWcYX66lDYusFmfZZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pYMPBTFSXqRCbMBEgTt/FbD6Ogb1Oncw26xaZAq/2Y9U5OG0Lebrux8jbAV0FH7ZWV3/fF6GiKgvUz4CfnWStlQEG1gmPVToFrVrehgvvEZ1pSQ3eTLxAJML+frFv603QibhpwhCyTIpwZB0ziqXHQpYo+Y+fi03XA5XHaGxxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiS8dlOM; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiS8dlOM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7ab2b9dceso4885855ad.2
        for <linux-block@vger.kernel.org>; Sun, 05 Jul 2026 05:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783253579; cv=none;
        d=google.com; s=arc-20260327;
        b=M1MjZd6Zoy2GNMYZXkaY+XFcB1CJSyurFOp6vyhB7Yhzd8/1TDiSBxytv8QW9GY0OL
         FMKESRg9jts8ohUtlhHR41YjhsqfKYPK+vgsIqwQS8dHbFOtSoVbZG2v/lpA/T8c5bzV
         Rw7qRMtYGf4TRdlByVATj3oCliaXQ4SEYOvV6RMLWdcbdSi6zuIoir+SpKYZn80wRrU4
         V4HhTyPIf8GxPXyA5oaveXAThPx/vEXgRUqDXc4QthYj0RYAtSeARJRzFV9XdagDkxe2
         cuijHqcM8afGfzIPvx9k8gECq1aJytHdC3LXmIbCr2dZ0llkcg3r97MkZJpGUo+6p1cG
         UJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        fh=xVcg5vmvIO5PKY2MsanPF8V89yj/P8XjB7Lck7/+YLM=;
        b=GdZocvHb2ahIE38nCEhh8y578cO5U+vXMILToJxLepyCLj4uhKf81Wk6qDiz3+Qse3
         GwJN54Wh/+gBfg0luG0X51tRGEtfASdTjpsiOn6uARJNgjODBOaVltGUs/AN8w8t05d+
         7kdysbyrbKiTvtEKCzR10S0JVn5U229GeDRZGr/uwAf5ZKlsJDUhLrapjp4oDEu31B5I
         b0Ua67+zTMUx7hhwk79XRjrKx0os/obrReMox/wtDhiVieUJVl1bZSSrpDhgYVny4Wjh
         aRf74GJoP4Cy700OYddIlfd+1i7wy+Zn3O4cq4krlIoZV0nMDR9wIn5fvNastDHjjFae
         OA2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783253579; x=1783858379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=EiS8dlOM4eyK6m1HpW3B/2Lk4Ke8vaKmQ1grSKFAJWT3nDgHQp9PHG6jDFJWFMvvPG
         oCku+2dl+HfLBkdKZgSuHLUA7YZqNbbMrZm2TVKZv4KZ45li1mzTsRsicFKWdCN+v+zi
         IdwL4gSU3xdcrd7mNZoZYzHVr3F5FCVUfsFcww01QxO2XIg11BR+z3vKVvWkHs0gbj5I
         2DZJKv0/WQyEQ8Ha6Xu82TGTSYANNStIKhMU5St9tH4npH0B5hAWmCb/g9/YoriaRJzj
         b431tZuxGVTTDaog+QabLoyvZpxKg8nku7BLjtK1/CPlyoToF4FA0vaITOaO05iHBIt5
         lnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783253579; x=1783858379;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U0wpLikbkQ+TMe9JGtyw25kNkY3ZEdsCI94B3LxA6AA=;
        b=n1c1jU4OEjlWFfOY5zn1RVVKJHSoLh59Z2ScmVxNwJsdjHVeqhS3oloP6mjL79li3g
         njoTmF3xaRcZgeuBYr0esNKE/sOhRbs1Z4KKEbwrvvmpClfhdEiTQJoqPbvRNyvAYCmh
         dTM60O5IIV9+wrC8tBupoRss/Sh9kNlxJsJrw2o9apmiG3RumdY+pmRaZXa4hGt1cGSr
         kQFQ8gKdKj54K5GrsMCMbGcqz65l2IiyM/VvJKcjqAWk2qwTwpa0qzasR91xmS/KoUeE
         HAvcVUXAAAPcdchVCWS4XcVjPPoETUyY3ps8ojjXiJN1kOaN1ECejufn8123DOXjC9/b
         aMhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqe37wIlo4VHDz5+RasqGLVrVp8+dbyTfsNiS2IZSnA1RPjKF4RMz7VZpAjsWEhzHHMralfxKInLD1q2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzTyZ+OMfUOqVD+AmaRrephhNnjaXnIWi6ItK4l9dZ9b4uvEz
	vmFxhVE4exTtkFzXsCFc4KYrIPb9RMsQ2UpCxT7QrrJ5NljVsZZnw+oTIgM6tjQb5s3BeQi83Ov
	hmLzEjTL5VKWfDMFyNORbs2py6e+5VbuBvrMs/Pk=
X-Gm-Gg: AfdE7ckcT9SoihGB/HAoJBQ8gKXjcmr3qsl4TKIr3I77eZJhxju8h4u1zGK6enaN1Es
	Bxr3PyD1L1r60MHJvJisVM/MHiQENvNOBO2BiX0/6bxMKvB3JTLz8OLOS9aJP68ROEVnvF4G5y5
	bOwq9EX7gkfVqj0GP+kzTnbB1k2fsRDd3SjmTNk7s6y1fKA4LDVpACl0ehi/0fe/anDZPi/L2TK
	avCzDZ1wlSnWTUM3kUnnZdvSISDXOwuKu2t6Rrs4g3NU1Ho2gR9UvQsOmFIzFVj1jrz+P/Ma1Tf
	0xdpeN0bX4W1pXsHj5/tEsepdYYJSWeX2zLx0KncOrqgxlkhKtY+Tk+zHvIZpZxY+9jiGleZkGU
	e46Ig0h5wshOn
X-Received: by 2002:a17:90b:268f:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-382802beaa9mr4128789a91.1.1783253579563; Sun, 05 Jul 2026
 05:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com> <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
 <akmtA7EbVBdhRAOq@gurudas.dev>
In-Reply-To: <akmtA7EbVBdhRAOq@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:12:47 +0200
X-Gm-Features: AVVi8Cfl7DMeNQYuJP9tYThrU-TabLAul_khYoWVx5WCyAQG55ujZm7jKpKar4U
Message-ID: <CANiq72nESZyX95XSKC3zaog=XSQF09bYJmre0mUbtQ42-Ly6tA@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Sun, Jul 5, 2026 at 3:02=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> But unfortunately, since `imports_layout` is an unstable option currently=
 [1], it
> cannot be used straightaway.

Yeah, we are trying to get that one stabilized -- upstream `rustfmt`
is aware and working on it. More context at:

  https://github.com/rust-lang/rustfmt/issues/6829
  https://github.com/Rust-for-Linux/linux/issues/398

> However, .rustfmt.toml already has a section of commented-out unstable op=
tions kept
> as a reference for when they stabilize. Would it make sense to add `#impo=
rts_layout =3D
> "Vertical"` there? If so, I can include it in v2.

That may be a bit confusing, because we still need to add the `//`
comments. And if you add them, then `rustfmt` will format properly,
i.e. you don't need the unstable option.

Put another way: the intended workflow is to add the `//` and then to
run `make ... rustfmt`.

I hope that clarifies!

Cheers,
Miguel
