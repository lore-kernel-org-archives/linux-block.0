Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E01DF74F
	for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775947686; cv=pass; b=mfUVA+U0CUnc7XJ0LC/xIAmKufUxRFfF4SxuG4Zd+xUWiQR+sy5wXEZL8zN+Ob8xrz9333Q22NHDpQOZDDd9Mpi79DIXfYk7M1RPJpVyMBfsLshZ8GvXC+JiazeW7s7WmlqZhcIbpBBNPr9lLl9+JVgK7BQ2cjoSgZw8JoefAnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775947686; c=relaxed/simple;
	bh=hfI7WZixWr8hfh5FgBWMpYIgkb3WvfVlVAFZ8mrBIQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igMKEmvy1LDz0NGCX/MlBKMBOucWFcR3d2d19ro+p9J5dxbcEgnnnQ49zP+QAkUrYI/aTuQrNqvbd9hMyKKhQppzMSkH9dR1IgK6jXF26/+EUlrzqCE74GxsAll3nWez033Y5bcsaslR9ahqCqNhgENedg1ZbiAo2LupZDEq1Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzWz7qVE; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzWz7qVE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1277863a912so196959c88.0
        for <linux-block@vger.kernel.org>; Sat, 11 Apr 2026 15:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775947684; cv=none;
        d=google.com; s=arc-20240605;
        b=CTi1ZaRc7qdWf5R7SxGcrYkSedkLgfRmn9jCtYh0byei9RLVcmNR3tBC0qcht76n3R
         JN9HQgUHI7ijy1zK+5tx/OOHMSJtl1b9SbSKR5x6JnrrLoMy64nKo3jHwD0AUx+GSEd3
         nU3cu9Gzp0Fbdt65k1A40GsvyCrpD0aVvJOhsL9tNan0cHa+OmaFEa4n84b1VHPrpZha
         gO3LWD/QHOX78Vjzeg/eMBXaB+b98XhgpAOKxmkA/ZJcuh5eMRyUqapPtlq1zJ76Nc4A
         avRzPu8rYERxYBCRpRxOHN3h3Mn12YA7lk7l4804kYeF5n9AycRJ3dG5HYSUaI0h0Rjc
         iWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfI7WZixWr8hfh5FgBWMpYIgkb3WvfVlVAFZ8mrBIQM=;
        fh=A+tjhrIQT4qA4kUZ255EllFF4CDpjP0Y2fVBGU7SSwE=;
        b=TKN++XoUcZ4oC2rinHj2sUduIvlB3XMi8EoIGug0n91YanG6NmmBCG38j91JevvPMN
         wXskbOrLI2+NGx9q2j0G3CGD9YZ/YKdISR6BYJc5TMDARKsn4ay+yfo/nifddakvAgOQ
         J2KlAHV/lVBWPIJUSPEJeJC/+heDLfBGoOXsyCPs4bETYE7tKifSoaoL2WTYNFmBzIrN
         BWzoEO6j3SjQHCJijuSyubco3Mw24icBRG0aUuAZbiousgAffd6pIkXV801yG04quX3R
         Q18xOeZJolOpzaPQ0+olpLISzdZaEcWZCgQyLbl9l1hpwCX+IzJ3GPRcv+ha1i7kg7/R
         J6GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775947684; x=1776552484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfI7WZixWr8hfh5FgBWMpYIgkb3WvfVlVAFZ8mrBIQM=;
        b=kzWz7qVEaJPLNUIrtdhKrQycNx4cB3e7XrU4Q7c4iT1db1n77iVSVnaB+kKeQTqaW7
         ucIwHumMuRXfyLmDGN2Mpzm4U6BtshlHXtP+7R3wcnIvZ8pCYfDeFJKPFfsDNFbI9baT
         euCs9wtcktEepCYKI0SK5sRmbQAYCfeI2onvMDmIHGa2NVmk38L/aDaAGTNypx2d0l0K
         XGi9zUNPVaoEDgKctltAsVTPL77jM5+10iOxJXEreCOAnNMMAEZ2xwl1ryIMw1kqTDC3
         Fm8FOeQwdXJp3/GJ75zfzNfFQji9eYsrQfvyhuXSXQm9NhQ2d4F1CQC8EyUoa/Zt1I83
         SbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775947684; x=1776552484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfI7WZixWr8hfh5FgBWMpYIgkb3WvfVlVAFZ8mrBIQM=;
        b=gC37yD5Fl6VULmRmsu6hCyq7Wl+Id59GBDalxgQ8juyOrMwWRmLsu9sC5BX2VHHd1g
         xSIUN3TYWrNpaQUldhym8EGhmBaN/smmlst60YWnSKOBt1CaQdo/SbLAcSBX35C3tUPl
         06jNnr1o5P7lIJFoXHNUuKFZxOQn6rL7jgHmvs7HOtYX2QDfFVmDKj/wtJAYU8DPBqVB
         ALa0wE2lUa7IG9wq/vwXjvxUgZfTNaWe96O3XMti1Onm+G3usNPbqwesFl3agJJyPCLg
         eYhE8aZSzugtKG2LW75ykLxFjPutMEnbL0bavrQXf5sPyOta3OGn8JqRD8SxoCLB81A5
         wFrg==
X-Forwarded-Encrypted: i=1; AFNElJ9flpo9wc1dL+jThdeDYwYG+x11wKCeoyOr8SljtJhJ/t06/8yN4hQ/2ZF7JWXHrQpaapa8dR9NgBFLfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycbx8fVD6dqEqhYQYWgGiJd+OBxewMKG4HuZwYk/lbVlfoYkPb
	BRDiWmgdMww9FO1+EgCtfZvM9XaA8X9gBiRsBYPSwsSPULzupvMymbNtekv963Id3tVCMGZYxjd
	TkYYp77ecqzKJbPZkuVkhNsMZRxPccas=
X-Gm-Gg: AeBDievfRnMWGT85hVOKRXrrhQFSYkur4FiRl5qZipewyhyAVEzDbOPHEFgCw8Jaxh0
	tm36tEt/2hgt4GkUOnazTQFw9vlhbz3xpRKxF7ceb/AZeWqyn1fwJdT09CuTotMmpps9SMq3GBU
	JSgEeFds8UoNnAVoFuZRbgR4mj1VojozPfbnOGec+JJ3CJE9MVDxL3PAXsq2zvxj9yQCOCgb8Qi
	G6F8HrGyVXPkIQs3geDRvkAo0HSJuz1+2X7dbftlsVjERkRu8m3ntAOzCQ4jg4KPTmrul7wmmfM
	sX0wEZ6VEmlC8wreCLOXfTYF5dURs6ow/KkRdAaeN9FMw6QS8giq7OlItbm8tgapFocz+5EBnZi
	+4tvh0ynYzhlmgKLGSPmUq+5DAuIlww7ddA==
X-Received: by 2002:a05:7300:6da6:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-2d589ca7743mr1992099eec.5.1775947684276; Sat, 11 Apr 2026
 15:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YpOxb7raN9ztoDEyfT5M8S4KZA74Ua0I9VLcImKPi_lJ6K5xWugbgbzKmQcl0rz2XdRw0cXOYrDpOYjz9q62Dw==@protonmail.internalid>
 <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn> <87ldetx01d.fsf@kernel.org> <ABUAdgD1KKnjiCpcrxWXD4pE.3.1775914622691.Hmail.2023000929@ruc.edu.cn>
In-Reply-To: <ABUAdgD1KKnjiCpcrxWXD4pE.3.1775914622691.Hmail.2023000929@ruc.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 12 Apr 2026 00:47:51 +0200
X-Gm-Features: AQROBzBJf75ZdfXiiC9J0iti4_SQ4JgL8eo_clRRhwnKg6Y8oacC5LbCeYbWwUU
Message-ID: <CANiq72nuy-KoA1oQewOX9EgrUOo7H-9UhWB0TkzhfAZWpnUUDQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 0/2] rust: block: add a borrowed blk-mq timeout callback
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 3:37=E2=80=AFPM wenzhaoliao <wenzhaoliao@ruc.edu.cn=
> wrote:
>
> Learning from you that module options are considered 1990's technology an=
d do not fit the modern kernel model is a great lesson for us. If we misund=
erstood the maintainer's intention, or if pursuing this outdated mechanism =
goes against modern kernel design principles, we sincerely apologize for th=
e noise and for any burden this has caused.
>
> We are perfectly happy to drop this patch if this functionality is no lon=
ger desired in the modern kernel. We really just want to help improve the k=
ernel, and we will try our best to sync with the maintainers to pick up tas=
ks that are more aligned with current kernel standards (like sysfs/configfs=
) next time.

It appears you are replying to Andreas' message, not Greg's :)

It is true that kernel module parameters are not something that one
should generally be used when there are better alternatives, but rnull
is a bit of a special case, i.e. null block is used for benchmarking,
and Andreas may want to have parity with the C one for comparison
purposes.

But since your commit message didn't really say for what this was
meant for, then Greg rightly pointed it out :)

In any case, I wanted to thank you for reading and following the AI
and tooling kernel policies I mentioned to you in Zulip! It may also
be good to disclose the research side, at least just a link to that
Zulip thread could be good.

Thanks!

Cheers,
Miguel
