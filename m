Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94539DBCC
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613576; cv=pass; b=UoMakRA5oymMJirupKf6RCaROulqmCjAflm6Z1ActS8nchzphar6VXPSJivDv5xbBfzCduNov9Fqwl+ywz6vGSFOCTkVSqgBf19X7FBHzGFwJ2dZtXgVl//MAsOQi9YN6T0vORcOnZ7re8bow8eQuYWk3GXOlar8vcbrZuhxGnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613576; c=relaxed/simple;
	bh=hxPH+ehBPzRCWk6w7xeKnqdyk50jcH5XyZCkn0NKK1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m49OOsg+5IF5NCCrDY+g+DNpvxcnJwGPWsL3mZGFIt6T9W99v2br13o2h5Y1D1PR85mL5PCREiEd+uDToFb1CGzd7/Nfh6rN/ttqn+k71EmkxA/qRfckedSMcSKoXJafgLA+mi2aaDBGBsbwJ7HzPPSe5dBCO98wqzY3WFUNubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki0S4C8W; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki0S4C8W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf110997efso5122025ad.2
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613575; cv=none;
        d=google.com; s=arc-20260327;
        b=JOa1HOnmeR9da8S1Gp/deTzf7sVlm13gz25IOt+VrMRpDH41TYzYqrcWrbrz6B5iIT
         sF3dtsm2X5UxEeSuTWDukDEXhF8ZijHgIldnnfLt3jxt3yg4Mrb51UhVvLHuDb7j6iOe
         WWI2elTKCo9jRaLBp2UuH0CEWagIFlL6MQsMZH8mOvNVrghaWfstZZSaGHbNR6a54rX9
         Ur1nlrRXyWjr2qzyOvlJTHqFy6E/3qAr0TtmgXl0LhN38Xn+pT/R0r+p3VuCE7LRJSc7
         Oi4eiC9MGbYbr3msGOM9ESno5OYbmNT+0kMlnEs+d2hYJnYM9h7vQDhjghfzQ9h2Y1NU
         odhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        fh=TYN+56ZjI67E4lfKMcKZvqDZrpAyDoobQkmf/ogH6ys=;
        b=KoWrOyYmOUDmldL5ayRlVY/SjXTZtlG1/O74jpxTskM90Y1b6E84x6yqz3aW4vFQPa
         iEieN0N3xY8Vw0Z9Wlr1OD89RdHPPmo7JCT7e7NI7LnlEk1dCrSpAOqlELC2eAWXFdCa
         iBz4v013JeWRzKJjzcCufT1k7CaK8EVfnEj/IeqozIffDidWCz86pHqV6qjAgAnxf2I+
         bMoZqJ+bdO34Tdk9i6j8A+CuL6y04q1H2+ryAqAGkcljC1AHJbgrsv6Ie5hstzfMMDWT
         MP9+8qcVb4n4eDqDuLScEKWW3e4a57Q8igf6T1J0AKD37qAjK30v4wjvix5Dr8sfS8o5
         GgAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613575; x=1787218375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=Ki0S4C8WDWmasGaotvQ0nFof4wEoVQlo7An0ov6Gl0rUwXMSgg6XVEXZo6N2Goo3So
         O3/FgHe2UfkWJy/r6cN/eGa9shVxGjV8+Bh0wg8UFrL+p1qKMHJ28Yi8H4mkSOrl47YM
         3nAsY5Jw5yPDE6Tl6+UUx8L50Nw2GceIHZWxlSifOIY0qi81DPGXV1vCFZR4MyImM3S0
         9XraUocr2791q7nmxmZZxmE2r7aJ7qIEatOVqrjx2Orojbo0aklqiZABVkTYQ5o/JT0+
         DMg+Ns+B/w++Om6XoscYdrCTs/9WeCwcfWy+JqozQyENao+7695ruzUgy5KCSXK8V5Em
         h96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613575; x=1787218375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=VaCY2+Exsl+4QmqyYoMWAu6KuWewsCB80ioibHTBOm3hU2yrgF0AWVM7xnrNSO1TS1
         L/s3CH17mYDI/Szu6izehCY62j2+Jv8eOoWSH1cXLO2jbDA//SIjEo8yrX+J6UYUyRQe
         SoC94gFZK0v6ZpBrZctuzpHsS6uHbhviPR7hIy7TXohsW5vEkteKgGYodKjo8bFg8K5P
         2ypmamh0icAIH/rg0qhXoDXh57DhXy9dB+OmQn/cs3aF+i7ecfstzcOfjIbVNWc61i1S
         h8R/oFetJ9C4fEkFLgHS/waPOK7dW0NyL7xw2XyixyNB0bSaGg36EPrnk/cW6bQ4kwB2
         /shg==
X-Forwarded-Encrypted: i=1; AHgh+RpPvCj13ssIJC6Va83zvDRU2/Ssujow6GEn0EnjrxCmniMuW7bN3GAsckmd1iPIHuXnAvprCl4A4i4Twg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dq54fuZXU7Vwkg8J96YJVim022921D5igQZ0NW9DfydlH6/4
	yMGeEppl4YQBRiRHPKgbImXIgSeEufu01Qqa9WSOM39s/KWK8XWsPrGZg4KTbDMde/CgDGeQ4pU
	axIWe/58ZowR9cDBk1Y5GwLhpor4iMF8=
X-Gm-Gg: AR+sD10MvMPytBWP2+5BZ9I6xZNjcxxWSa/sHm6bp2qrwKZG+JObOw2fZ7AZHBfKY5h
	CaTXE57OetQuCOrfn509zup0Vxd/JmVOK8cZfvBladAzmaJ3j2h8tJf7h0ntcyk74rcs+U6YCUg
	4vIZ03f7TPevu2BmHoiZ5rM3shlDS+8bdYULnzqsb+Pinn6dC8YTXSTK52IgTN88aplghX5eXb8
	Wx7SHI/aZn6NcRrx54JmaLwNjFkIQSRf+4PpISMEOSI6F69xY41dWI+1FcHg31wKDECi2UiIUd0
	PI0j0abiBE9Qac2Wkq0QgNj7zeOlY99GrNdok0j/e/Qb+xrw3AEB58Auzci0Cqk/eH82V6ecOTn
	vfIzZ72Rul1LG28aGAbhjux7tKKtO9PznozgCfswI3o6dPcXDdoHxwrdk9MU8YA==
X-Received: by 2002:a17:902:d4c1:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d389a366b2mr27617905ad.2.1786613574868; Thu, 13 Aug 2026
 02:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
In-Reply-To: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:32:42 +0200
X-Gm-Features: AUfX_mwSjTSmX5g9cpyULDa32fuXt2Yd5-MIkCd-iXvVUBlQKiet4rzS7F5uPZo
Message-ID: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:57=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> IMO this is the correct way, also consistent with
>
> https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e71=
776f9dbe@linux.dev/
>
> It might make sense to add this to rust-next.

Yeah, it is also consistent (in the sense of adding a fallback) with
the other fix I added when applying the series for the `macros`
doctest; and the `kernel` crate is not an actual module yet.

I guess yet another solution would be to have an even more local
fallback, but that would be too local in my opinion, i.e. we will want
to use it elsewhere sooner or later.

So I could fold [2] into commit 98f256e27262, but a commit on top is
fine, I will reference that commit from the new one instead.

Ok, done -- Danilo, I took your diff and converted it into a proper
commit, please double-check you are OK with the Signed-off-by:

  ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
`#[vtable]` `impl`s")

Thanks!

Cheers,
Miguel
