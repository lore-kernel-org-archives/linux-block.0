Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89190360;
	Mon, 18 Nov 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891274; cv=none; b=kz8QuFK42IQjC+MKGdREH+2jnQtoBfbIKD6xEQb5P5DAoJbVI4Xx05g7EhCW9MLSxuQ9QzI8/sBs7U6UGIoOG9tQ8hNQBzsKMh7Qauf7ZVtE7yiGKuxLUIbBe47PzKJ2NzKuXKbif1VpsPAQqjweJecnFomeKRp534F6Og14tJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891274; c=relaxed/simple;
	bh=5cayApTr2paonudUm6trrjRWCAbJtB1ywGRYA/HENls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwrROd1bwftRtXHvAdKCZUEpLnhqhPVyV00j20AXmfVflGKOVZovVjtEaf6pO4lzfZ+zHdsNALNZ9FMmovo60YAKmgat5C74IAFHTYurvJZVOSX6zPF/c0JV1Bnt7RXjB7KKyPbBeWUqfIJqDtKA23Vh+cnaZBJ7AVjrsy0BnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdkkoqbE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdkkoqbE"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea85fa4f45so680486a12.2;
        Sun, 17 Nov 2024 16:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731891273; x=1732496073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj5vXREp5Phb5f9hnuV8h6A8ggipr27FdyKL2fmuRYo=;
        b=VdkkoqbEU2/jecRha/FYu7zDrvbFbRIAranpq9hLWrZoOYo3a9lna6inCbzY7Z1ul5
         XY9c58V/NXh2rT89Dkf6HGyBCkkADLpAe8ohHCq/c6vp+YShv6PvEN1nacuEr2sbDwfw
         yYuh/rN67ezyxxiDbmADAGSLFPcEMdMs+k8nimTDNoUN+AJJ8XOyatsC5WjlbDMA5GHr
         3QBDgkM5t8rs/0f+E0SwtqFSIUQohL5kmEJ80FYiHyaAhvf3ATTIkeAvTw9ko2UAGh/R
         vSEsvpszT3EvakxTGdP95jc1u7sndgSHAR64Ghs9f1jqo4gs0lQbndYfu1Oc8RtsSVNc
         6y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731891273; x=1732496073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj5vXREp5Phb5f9hnuV8h6A8ggipr27FdyKL2fmuRYo=;
        b=BnB6xPL90XQ+P56klT7gmFz2XkDQGTQP9u9JjAIqyW0OasbWj7cjt9o/IQles0s+RM
         wrT+4m4VL9hvyY6wuZacYCGMcjIHzsq56p5ihwP+uBMzxuANGWeIobGIZXXNlWKUh8nP
         zoN0F1AXjuw+LZRhDqY81Oy+KJAGWa4mmJAtPGwnv81EpiCFwgp6sRkQd8EGChWEzUvG
         o5Wf1Dnfr6mkGik2olkA6nZBX3Eqx5ev80RVg4qrgLN5WUhfhHn3ZjxZ/Ejh6QPBNdXV
         XFo2dM4P89BTd4TKySO+WVUh95aBb4SoQk4Szd+4Lkzk8HgrF10zaAhKNo2H0JkZ+MTv
         9sNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3rrS2DHUKT3FommznCDT9oQmucHTa7esBr2jeenKLD/dOfeCbrKRKnOCMLReLedB8yNYXCs6zNQTMwLP@vger.kernel.org, AJvYcCUsFAmZmCIW22m2gGJBbLYaSeieO3KRzahMXNf2MkZIziGdcNloXZ326XMmXlce4+th5YlNV+Ul@vger.kernel.org, AJvYcCVFKLfIqbG4szEiwPQvtzTFw5gVH+UqFH8UNk3IHL7Lp73lqwqrvV7Y0YeRKya84xIL0c6+auVKoJKDHzgVNxo=@vger.kernel.org, AJvYcCVsUq6luUBxUTK/AnD8LafU4gQqBLctFQZtRbUwkkgrbIme+7oThatV5FCux2+yW9nCOsj6D74TJeWn5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwdPNxGYQsBwr6tBJpIHuifvcC773vx3iiqzevaODZ0YAdtzw
	SsG3cwYI+Qzvp6eyYtmwdO1c208WiVk5obgjEyu9GGN22KsqLtdEgp8ownvuTWcf6n8BDqXdrsk
	0HlYlR7wnOBOP7sR7f4nu2hHryrI=
X-Google-Smtp-Source: AGHT+IHqGELc5Y+kxz8+Tb9M6VaWYYG3G9aYBazKpHHQIpj4J642GiPW72vDkPeL3k1eBcqk7D4YSidm5OV2b2IWvXk=
X-Received: by 2002:a17:90b:1645:b0:2e2:da69:e3fa with SMTP id
 98e67ed59e1d1-2ea154be694mr5114170a91.2.1731891272805; Sun, 17 Nov 2024
 16:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch> <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
In-Reply-To: <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 01:54:20 +0100
Message-ID: <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com>
Subject: Re: [PATCH] rust: simplify Result<()> uses
To: Manas <manas18244@iiitd.ac.in>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:11=E2=80=AFAM Manas <manas18244@iiitd.ac.in> wrot=
e:
>
> I can split it in the following subsystems:
>
>    rust: block:
>    rust: uaccess:
>    rust: macros:
>    net: phy: qt2025:
>
> Should I do a patch series for first three, and put an individual patch f=
or
> qt2025?

Up to Andrew et al., either way is fine for me.

> Also, I can work on the checkpatch.pl after this.

That is great, thanks a lot!

By the way, for the purposes of the Signed-off-by, is "Manas" a "known
identity" (please see [1])?

[1] https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin

Cheers,
Miguel
