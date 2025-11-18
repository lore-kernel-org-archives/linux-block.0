Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0262F8BC8
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456982; cv=none; b=UW1SAh73BGbs+MDFtSwLUA4zWpgc3/MO7WptTaP2hW1/CY3tjzhQlb8EyAI0GsNRpu4p1i/xxOEog2wcrGduHhq4VaqymciEBEFegk5Z63pLFe8DxLOL3xY9B9fTbaKm8sOYiVcypzyAyKVaT1TpxIycoO5QB/pppXwfacgsDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456982; c=relaxed/simple;
	bh=YoHE8hp2i1KX2JI1FOp1afYS6Cs1Km7WJ0bcBoqu2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3SFBlYAhjQlDwvjFVW3pnl2v3PZyvTLU0UmZj4H6QNnOfq4OXk1nI+ESXNDzdfMyVay3ZyDwGvZ3W6loNkzSEUddAL1QYdnrrhudKUo/RWgqCqsbMQZh2ovgzisbouVus+lf2L7cyi7yyP5hsMrbQwwgwbsqOxim6jJ3dLCceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK9Dwd3Y; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK9Dwd3Y"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957e017378so6078118e87.3
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 01:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763456979; x=1764061779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoHE8hp2i1KX2JI1FOp1afYS6Cs1Km7WJ0bcBoqu2UE=;
        b=PK9Dwd3YCAyrqYCvMXH4j5AORZfF8eH5QlgPh7t/U5KzcFyRALvRH0JJRXQJ5CxM+c
         SntCkhUQmeJzLZ+UF2g1l9EF+Y5sseW61C+Q8zaw1MyRkUz1B/CHN5cKduwPaW9uqr0I
         rOsDgYUQWlImqzrWEtqZzx3/odr4E1qOJzTX0d+bMrvaoGjTS39hbzHD0xIboLuUv7m3
         4qOEhL1x+qCFm24YIPTNg3ckjI7C4BrdNNJb6fXa1HPdn+OHQEdyRichA75UsurJS9t5
         g6U7wnhsT6Vf5zTw/aQWhBeAyLClC6siLTuACYcClrXIK60wiwZ66omsUrho1uWN8/cr
         /xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456979; x=1764061779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoHE8hp2i1KX2JI1FOp1afYS6Cs1Km7WJ0bcBoqu2UE=;
        b=JCLhT7/t4I/C1n0b3nG69GK1k5U4b1DUawpZtYKoM0vUhq2QvT4fYZT/QyCIDyrVjh
         TdW5PwqURsjNGnWHz2rB9h/xVipOKPjlULOqRrrui1fk8R7mEZPChPxbM/1OlEzkH1kN
         5bjHcDgzjtM97D2X9OF6+i5vdfJ+hq7fQuD4P8k9VQEcj0yNbRMqVvVkXqHRzGXfoHyz
         JjWrHsjNtTXterPOfM9ZpJMWXkZ7Eeh0oRlNjAFiib7+baS4YG+bbe5vt290PX0QoOL2
         Kwuz5bMy2btriDni1aZhK7uQX358WGGhSgkdgdUPznF8J56S893As+3JWhlT0kGoPhx4
         X1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wxnaroIYNKTMWUkeV1PzEivP0tKsT4EnUIvbWa8WbuMxcUZm35V1BHvM7vhbvL9lWlUtxYFptbKYTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxsRDgvQn4OIdLb6nunned23jGjoIi3yf7n23vWEO6CcuwvSo
	Jf+05dpu0OFre1ryAfgWQ3MoJIOtI/1DwqToToKoW1EipTtkJEoOt2FaJooeHg2Fokde9DSsVoW
	HziIY4n0yGYQ3SH1BGVqzyZ9aQHkm0NU=
X-Gm-Gg: ASbGncsHvSkykI7D5Cme9GCoQkUUifWCzG/QpdVdC7cFKwxN8OJJVfGd62v6wHsK1u4
	C/GB8+iL0jZfqQjIwnPH21Nzh6MxLkUNK7jn5Yp87HC6OzoLu922fM3JncXgBDm9sgDdXJMG9lg
	bc1psSWcIysNzOHUQKo108MG7pCUyNygYWTffIOwUVN3JY2p078GZ1Qrup1T7is8i5gfFkeBLTA
	1HrhCvppt8NfjieK8qvyG0KxKnGLkSNylvRG800eRcakoi7zNNe+EC5TVUsU8Q32lJiTyCT9/J7
	lbKFVVzgx0+1zj012nAQ9rUCgmMLow0vpI4o1lA=
X-Google-Smtp-Source: AGHT+IE/uU2RhskqEwCPV5Xh65lsa6xSHbo8Buss+DjCMC8KyUkuat+m6Bi999yJJzhXnwmrobG75Ra704tETyHlW38=
X-Received: by 2002:a05:6512:3b0d:b0:594:5685:94ce with SMTP id
 2adb3069b0e04-59584213a5dmr5447072e87.48.1763456978696; Tue, 18 Nov 2025
 01:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117172557.355797-1-hsukrut3@gmail.com> <aRwNfiIWUVl5G0eX@infradead.org>
In-Reply-To: <aRwNfiIWUVl5G0eX@infradead.org>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Tue, 18 Nov 2025 14:39:26 +0530
X-Gm-Features: AWmQ_bmSzlm8tpSKHFvMtfS5Kpi5L2PYKuN0eQgo0wyXv88tq_m9EqbpBxWv0QQ
Message-ID: <CAHCkknrzdT1NkD1EGMPBGkamrg8fJY7Xu1GX6WjjPhquCyGQrg@mail.gmail.com>
Subject: Re: [PATCH] drbd: add missing kernel-doc for peer_device parameter
To: Christoph Hellwig <hch@infradead.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, "open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:39=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Nov 17, 2025 at 10:55:56PM +0530, Sukrut Heroorkar wrote:
> > W=3D1 build warns that peer_device is undocumented in the bitmap I/O
> > handlers. This parameter was introduced in commit 8164dd6c8ae1
> > ("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
> > the kernel-doc was not updated.
> >
> > Add the missing @peer_device entry.
>
> Or just make it a non-kerneldoc comment as it doesn't document an
> external API to start with.
>
Thank you. I have sent another patch adhering to this suggestion.
