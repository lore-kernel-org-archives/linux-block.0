Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9A8462
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731381; cv=pass; b=fNFsTpmbJeEEg2efe714SPNounGQ2Kbntp3DDXQ6ExSIAqvBLSXXcfjliBJj8ZPsL/K2/Qijnii00+dREgzuIoDd2Me/KJNwYnguIfpm18RcRun7ajthKpTGlU2qQ/M0U6bkZRWkEOEg3ryN80kY3npmb+Cm7foAaQFnKR8hYLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731381; c=relaxed/simple;
	bh=nPfNZiC1zD9OomRhDPiPn4VIi53lb5Y/DjjaFyfn8Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvQlzlKyzlLGiLxNs9asblJmpcJ2TR7aWD7P2Fzw44NKSRUAjnGzMKvXgE1EpRdr8qUdWaaZ3tUo0TkVV+1tyzmoR0Rsbx8Zi/sTXWSgGMotL3ROvVqRGtlLbsx52hZ0wkf73SkGS/Ja9UV4mzhhRFOz9rEWGEs5rzn0bQkzdTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQO66wcL; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQO66wcL"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3047a628b34so98957eec.3
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 10:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779731379; cv=none;
        d=google.com; s=arc-20240605;
        b=L+KzjfJtrJc72domPpkHv1L3cm/61Tm8q1J7sTPlD5gpIvakIu9incQVod7p7syQEB
         5c15AoS2VrxOHk2w36y6ta9pCm7hf+MLbsR5l3NTUPv0C4+gw9m5yOFhPKAlQr+a53Cc
         bqApbrx4aMDwyVed++dlrOJRbX/85a74AThfOUhdbidqpcMI4SLdNaaTyJcbvBCAiLKJ
         7BTx6tC0W/0aiPxDjnaZckYjRjQ+kBrJc+w8qVDdY9A7fnharvaUQiX8FIq8N+kmQ9gc
         I49pjoM/Hi2fWqUFRyZEWUErFJyCHCq3CiAX6Nch+65iyi13+WGRMVypVo0cgXKvt2Cs
         u82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nPfNZiC1zD9OomRhDPiPn4VIi53lb5Y/DjjaFyfn8Lc=;
        fh=dbo2R+L+QS4qWkIUeicvcIgvz9Pdg6JfJnARXaWfBzg=;
        b=aWVxS8bjBuOlUq5vOIHIM4wdTdyWpm48TLMJxT5yJ1MYX3QttR30B5nWH0KN2exIRm
         1RB41hFPJpg2CSu0bY5oopoykIa+YovOp+6CcP5aS1riCU9gMBDbOykL0RbssF2a+HTC
         vrenXBqJQ2m4DUH53eVrcugEQuIAbvjn6c78dPe3eWyrf1b0z6BGNtMG/z2J68s08Aqk
         TRxCFWnp0OUnyVIuUw42msLyVo7Ed2aHWbC3B8fNDMgGezX2ScuoE4bUARQx0EiknSCf
         xkXVNjmV5y/79SKG9VsA3lu2Cee4NAR5Y5w6kd/hSSoDIkS0eEHu3QdWx7c23N9P1T5D
         BsNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779731379; x=1780336179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPfNZiC1zD9OomRhDPiPn4VIi53lb5Y/DjjaFyfn8Lc=;
        b=bQO66wcL0z5zIcTViNJ6I+iYlBR2dPiXphTnVWtmozZfsrcMcdzzAJMPyi/GvWzVz2
         TpQ7owXGqOJp+jQn7YVo1gEZohNSSdN9ICna16a2FvH2O4cdNpYaSlBcmCzj40Xd+7dB
         SkJQAFGd3EwiaELikkJ3gTg5uUf172Mdbr6WpGXfn3Kxdk2LA08LPtaYhkQ7Mtd+zwih
         XE8hnA4xzaIWawMqGXGYggXeuCAD87RjZ6s4hkaVGcMkNF0fN+ch5BTic8gy4uR68WPA
         x78IgDifhAvgfh8cDpIeYLrAr9idfp0UQLBKuB9eFAp/nztVgjLYzbBZCh377XUZ/UNu
         +nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779731379; x=1780336179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPfNZiC1zD9OomRhDPiPn4VIi53lb5Y/DjjaFyfn8Lc=;
        b=EoEdB15hmkMujmcBgnOfKkt/ZQArP6HelhgXwMfcXU4HG6U2lRr9i1NOYWf9yUqCEU
         UBPjXKFurNXCQ3iBNy2FBtAlItxbBBKFMiPGCYPpuLu0APQQsXQU5MTPTXFjZJwxLTUL
         aqs6uX+Vf4zw2Gurk3oP+NKLMUL9F0dOcVkwWtr8qJPGoRqRVuiIvkssj0lRtsSj/U9T
         PKjOHs5mln0X4nPXW66HL73jjqYRGDurpyBzfJ5EIaah1s8dZs7wnLBrPpUxdVGm+S1P
         gm3iimPZgBneGurXaen+Qe3nKxE/b0v23u3pcVR5Ze7XKQ1e8o3zw61LZP7dVH3MWTKV
         ylsw==
X-Forwarded-Encrypted: i=1; AFNElJ+0KCJbDvy7kcdFkYcaPtCXRqE1wNK+0az7FfX5TDHYPPaYJw/Dt0UDp2eMuXVb0VziYEbN4+x/H4ahsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8aCc91YJ4GBBv6FT3YO3NMhwGpld5afcxBhiwQlJP/LyIYzgT
	oHKP/OQQS+knI068QM1RVWoSH8Ro6CVBKUId1zNy03xDmAWDW8P1/b8UxOLhJfL6PTeWkVV7Pwy
	hr1DWK2/HSNh2QO8Lujj8BP0DgC9WbvQ=
X-Gm-Gg: Acq92OE/5a5QvgmO2xMipZJHSKZIzLGND66HbQiCkpZZF4qzuAOV5rwcjWyV3xUdpT5
	Hyv0SRpixbx7Qi5RSHb2+QxsspRQvOKvYccCEJbyQK6UJ6PF+miRfKzss9ODLOLwjrkROXxp7oU
	2lLs3S0MAd55mp0NeOOD18zu+Qo3SibFA3kwzCH/asRYS8NYfGeKWbrCsuqeQGf+YpF4iFj32U4
	+Kj8O7EPLbpxjkTXc0BnO82o1gixhJsi6c9fb0U4Lbev5CnCIuKBB86CgS/96xt6BPHRfQgeZ2h
	jsEYz/ZV60FjaTdc31M1tf9/2q3iiFCkuRHRGO0YTekb9aICpCw/CUz28CHxlZCfgPDIt0NxcxB
	XaQb3axuYhUqHg7v3nqz4EWs=
X-Received: by 2002:a05:7301:2b06:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-3044921564fmr3206406eec.8.1779731379003; Mon, 25 May 2026
 10:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev> <20260521-miscdev-use-format-v3-7-56240ca70d0c@linux.dev>
In-Reply-To: <20260521-miscdev-use-format-v3-7-56240ca70d0c@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 May 2026 19:49:26 +0200
X-Gm-Features: AVHnY4IGS4NWge_5oO5mtK6gWsE6gPd3PI1zRry3kpNJ_3QwcbAxHC9OP1Zg3x4
Message-ID: <CANiq72k7p23yTLL2Mq5nVr74oWCCCNuxWSdscU3YgO+2sYCEhQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] rust: doctest: use vertical import style
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:57=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> Convert `use` imports to vertical layout for better readability and
> maintainability.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Please check the titles used by previous commits for files, e.g.
"scripts: rust: " would probably be the prefix here. (No need to
resend just for this, maintainers may fix it on the fly).

The patch looks OK otherwise of course, thanks!

Cheers,
Miguel
