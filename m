Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1892153C1;
	Sun, 10 Aug 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754826186; cv=none; b=nKCLbHubVNrQwgfB2DaRfv6V9HZV2oFJI3O+ZfB1nXZ8qnGndm4Z2G+rMPlUlwu05MDz6IYG/AieGs4J776lzTJTU3OlcvqgRg3UDZkZ78CHHTdM6plgPHOHsTcKbP932nYa33ytvAfmywNcGURcqEcFNUGzM0Tl5ASVzrZX1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754826186; c=relaxed/simple;
	bh=91ET5rF86WWJH2uEOY8goKvqnyw4egDzDk+qkBG4z3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFY1PC1ei8MXbKxnz18oTwkPmhHfgGyUQ2zuhuuvW7jwbfHdPva1DKm77jxo3hoAEb8WuA/+HAwasalZ6NXOz2/A7TnORwub9PGuywqVTphL8NuI2tJUTbLJS9/RTLzyJ2yGbWPqISy29HjvLQQ/WctiClAsFZgGEjdiE1DELj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgy74BJ8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgy74BJ8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f3f978cd1so746074a91.2;
        Sun, 10 Aug 2025 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754826185; x=1755430985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91ET5rF86WWJH2uEOY8goKvqnyw4egDzDk+qkBG4z3c=;
        b=Qgy74BJ8zODdIZT/Oh21nrMfefWPDo4ZkyMqQr7OFTd6FMZbwCUGGSaUqAc39nKTEJ
         2MkBajrsMYi7iXZAAFB9vYfGyrSaV4GWjIROrR01/3XK9pPzlohbC0qvvmh25mYYn2ia
         O2j3gDM4++noGILMM+T9qQWGxqc9rtyQj02GI73yFrjJZiXMXgSDVhX2BRmwRqjLAhgn
         9q5fuywNoZVoRgAFUXx70CcxDuxVk6f8X+Ey0cIYfIhvoVk8+VsKqZBLX6ykhECPbBx2
         0d7HCdaYWqqlh2ja2RNfsarjP+r3z5BF1+jIkhdxAnxp7XLASBkh00HJvBbarVbHLdqe
         YP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754826185; x=1755430985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91ET5rF86WWJH2uEOY8goKvqnyw4egDzDk+qkBG4z3c=;
        b=lWHLHPTuQQk4xFSz0sTfVGLkMl6UL0/52GqppuXS6aA3wtDpbeyzb3laNp/xxxFNsA
         DO0Jt165kZUER/SAEX/sLsmOqVXdcIVqCMF7mVLMV3/zPiaOf9r0b4CrOe0b39/ruyLy
         km019blT7RJJz0C03t9gvg7hI/WcD+5hVTMyytjbCiKapypsofwaZupT3PSWGEyQtHFG
         BKrjChMPgPEM/mEEAfdTyehp8UgQu1uTgrHE6etpdCryaA8XT+hBA/2c7/xcAATQ2tWY
         ZAwN2+TnqlSDkLMI1BVSB/VIALgmtfUtFuQJJX4nYQEhyjikLLijx4L6dhddAvqKjrg6
         wIog==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1VFhsXGnxqISOqmTzLxj+zkei+0IoufkBA8JhCvMKh5vdOOHz2iAoxshwvLsg76zQCUy2h0p8IAbg4nTuT0=@vger.kernel.org, AJvYcCVRi7Ms4CQwMz35p8FbMSXZPydnv6shR8249qyJMztS+tz1Jvbr4DjY2Hw6CYxE2VNIcpcS1ioKFrqZAQ==@vger.kernel.org, AJvYcCX+nJqrKmApAyZElK/SSGaHy1I/53V+KwploS19k6bjLD3sbNaYooi/wdVZYYp3A9ov9K/6NgezmpW5Q5VP@vger.kernel.org
X-Gm-Message-State: AOJu0YzVS4P17+0n0PmL+VN4X91SAbkd/10fGKYyuBFo2CYEIaoCqYHp
	mOjVZARFettXWQKK+frl2ds6LpUPRVfmB86eWyaFsDu7i/5ZUWMSD31eMtROucW+cjwSStDMXfn
	MhpGwjClkeTJpqnqZuaEKdt7q1w13OSc=
X-Gm-Gg: ASbGncsM6PxUqUqr9Fga+bl98f1D/IJTmAZpf25a74QkIhy7IgwfVzvRuIFZATinsYJ
	huDn7o4wJk8iIbHrzwqX08iT6Nwqs7Fn9DoDWl1KuyypI4hxXt9XqchoTaXCh+GgEIOk0fwkEC9
	Q3qL880ovHYEpExh17UePiBT0eRRWP9FP0NH3SJtQIkoq84M0WvQO3EjFppEkz6s5RUpCsClAFi
	hOxbz2hJ05U03gG0vU=
X-Google-Smtp-Source: AGHT+IEqlt+PxFuiuxU8+W6GDdBLu+oKjOa+sDHv3M270eVfk0DsWulSC2im2qIc7BEaNIkCa9aAu0zY6SmB9nZdT+w=
X-Received: by 2002:a17:902:ceca:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-242d6d83ea4mr32253205ad.11.1754826184602; Sun, 10 Aug 2025
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <KnSfzGK6OiA0mL5BZ32IZgEYWCuETu6ggzSHiqnzsYBLsUHWR5GcVRzt-FSa8sCXmYXz_jOKWGZ6B_QyeTZS2w==@protonmail.internalid>
 <20250716090712.809750-1-shankari.ak0208@gmail.com> <87cy965edf.fsf@kernel.org>
In-Reply-To: <87cy965edf.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 10 Aug 2025 13:42:53 +0200
X-Gm-Features: Ac12FXziWX50nYsrNpMzmQ37_zE0gmW2f0vWbEXqgMwK4juLfdxsar3rKHw4jKs
Message-ID: <CANiq72=Yb=APVFiJbdveVD45=fwmAbXR3vUXLTBfqu_n-BpcOA@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:53=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

I think you can pick this one, i.e. the idea was to allow changes to
be picked independently.

Otherwise, I can pick it eventually with the final change, but it
would be best to get these cleanups done.

Thanks!

Cheers,
Miguel
