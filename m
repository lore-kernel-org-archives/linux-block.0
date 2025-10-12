Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42D41A8F
	for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292095; cv=none; b=rP92Hy+ghBwJPzjoPsEuP33dOLPvQNFKN4DkcbRnjRn30yVlUhWzSkNF0BoES/VKlsgVZtwcDuu5oheXZa8alpSKWOo+PXARwz5UZxTBs6AaCEtuz1CFzpa7yC1By//Wqd/DYgEcWK02jqunO06ENSz+qFHi7zHokEM+axKT7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292095; c=relaxed/simple;
	bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjv6DUbxa3Webp3U+2Mm9VNdYDGNKSwtLhk9wJiYRPhtKOj2uphHuLUXqzkSksvx3tehLQcmzQRlKiN2YEriOngPJhOE357rOUx5MBkCobaf73qJd4QlxWRupIU3w7m49pngM39oJEbXxbPHVQjYEVYuAarAYOkxZjwFAGdRgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOwgGBbw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOwgGBbw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26e81c17d60so7854845ad.0
        for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292092; x=1760896892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
        b=KOwgGBbwqNWEeHxP/ZMjx2TuWDiRiVnut5hGcNGRblR4r7qC26m97EL0/LM5DwxLLx
         0+ASJqz9LrjseUtmTtV903OQyg2WH5bDmo5IeaCLY/dHK+8BRnVNGQFreiTHQabvrq5Y
         QaOh/o7K+zojYNHDBNVAP5Mwl1N15Olw7cCdVXbez1SZ2BgaC9r/Ynvr1iNlSrqs+5sv
         gEad0pnv5ldo4tYa4wcMuVbJSC388Z/2Pw6Q0ryBXBHeERGKFlmOvypcqy4TNx1uPXjS
         k1EDkgtDKd1V2PWQuxPrQd2mBO//nSpGsLrWQVD0Hr26lMMbA38MeqzwrLYShX3VbTcv
         wFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292092; x=1760896892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
        b=OWU3BSw/3j3U/520Sg2qRSpiXnJwpbd0Me7cAZhFlaZ52/oNKGFrDbumnVG7vwVmQD
         +NUlQX6Cg5eyfYF/VbHtvr9V/scRRkOWGBxhhHlTdc+eSlig7OcvY/TGbjIj8AZhv9HC
         cqJVbJsPLDCiNwJhjjYrvc82a9Xvnq2HSkJRhfY3upXd2CgigchPlkvC83c0B6wOTsqg
         /ABKc+/gws70hgQhffwIFUxGH3znIfAoPf/e+Ml5egH5glWyIpNYMKWLFBcntag04V+Z
         35Snb/T5L8cZjl1Zaew3DG9RoJ1NTWjAtyWI7irT+DKf7tr+iZWqbX8ymKMMXn1niluo
         IDig==
X-Forwarded-Encrypted: i=1; AJvYcCVc7lpnmURBdRsO6BLp9jjhNbgup3d6756QLgtosbhHr9sk6uRrIwX0puNiNksnKbR8Ov/gYUdYbjbNkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZyOEaPh2GA3oCpqYnvF8VQww9zbFqp3Oet1Pj/ICynGIRBcy
	J9WU10U0Ve23wHFS5Au0oThR8c3MFo1LhWuGtCz+8FGSK0r0WFRXriPP8H3PdHTojyU1oaOvIVI
	nbBj5yTksZGG6iOsRTFP7COlUY5iNsgU=
X-Gm-Gg: ASbGncsU1oO4GkUyYImGRpOj6/5qgmjm4KGDy0mcYLf3Opw5L5k0MJVq5EYMJXVRvTS
	nawezMBZnv3yEacMw1WWGsawann/6W70kJEEgFoMR3tviSS4J/cPzMrFoztqs50/VkK0dNpOphg
	P8ViN2MT1ds6igK3/i5F8jw04iuDi34ZPg5Yl8wuNU5SlVr4yx3ndbKnXmkPQ8RcyrBKZON/xT0
	YJW7YAn2Wq+YUQwwc6KHL37/TcWKyQLjOkosYXSF6Ghn3RI49O/Iqg6qdKKIlScA+wpM4SGhzr+
	tdSCqn8nbFNL6VHGXyEiBwxETotvB2A3tkPpDZqNa1H2
X-Google-Smtp-Source: AGHT+IHYH8KB551DFy/1CS7sVwLsfOMU6Z0zgv1Of6oPsAllrb8RWF6/5SDkS+dRRNp5FM5qU9kgMEXU6hEBhHvJ/v0=
X-Received: by 2002:a17:902:d2c4:b0:273:a653:bacf with SMTP id
 d9443c01a7336-2902725d2ebmr144860115ad.0.1760292091934; Sun, 12 Oct 2025
 11:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
 <20251012140451.155219-1-shankari.ak0208@gmail.com>
In-Reply-To: <20251012140451.155219-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 12 Oct 2025 20:01:19 +0200
X-Gm-Features: AS18NWDeTKrh-JDZioC1DogND9yn9-Ck_Lq9XxawqjsuxcO889ag6EhHA-dF5Qk
Message-ID: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 4:05=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> I'll resend it on top of -rc1.

Yeah, please, thanks! (in v2 I think you say it is on top of
linux-next -- did you mean -rc1?).

> I also noticed that several files have received new commits using
> types::ARef or types::AlwaysRefCounted.
> I wanted to check if it would make sense to update the documentation
> to reflect their new file location.
> Without clear documentation, it might become increasingly difficult
> to remove the re-export as soon as possible, especially as more such comm=
its are added.
>
> Let me know what you think.

I think it is simpler if I apply (even if temporarily) a commit that
moves everything and removes the re-export in linux-next -- that way
people will notice when they try to introduce the code during the
cycle.

Cheers,
Miguel
