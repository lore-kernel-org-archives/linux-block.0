Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822A28A1CC;
	Mon,  7 Jul 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897907; cv=none; b=EF2EIe6dfJfSkeblaAzIjV7UwEo/vi0egjsOLcOSSVfdw9uoL5zRzHetwxc4jqSFe4dCOBS8Y52IhNz46pJENHuOrmNm5x5kcd3eANHWDIXPh16Obbn83fXKTjypvtkD4i8XRsVLLnCWZHn60eLkg17sfYKA99M9GI9MtZ56pLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897907; c=relaxed/simple;
	bh=ZzPU7nKD83hJqr6oUnbAcbugCf3QBocAmZl8G0iXqFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQlwtETdBFIptAtPiO/z78eYMC0UZQpdynd08fvhog2Y81/syXy3Z0uLkfEkspOmO5IB+zA9gj0hiYfEvvslf2nEsXl32mLLzmoIIUBhTsFgM4azGL9GUZu+osMwkJ3LJVhqxp51jeR4KICBJ92g2LXwmqR3J3n/F/H5Gvj5gQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCwVPyLb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCwVPyLb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313862d48e7so382045a91.1;
        Mon, 07 Jul 2025 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751897906; x=1752502706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDhq5tJp38pifNdFdLn+IZDqsYz/V7C3KPTvDZYsKVM=;
        b=FCwVPyLb/fsViBy0e9RnoqhFWxMTPYiRjtkRM+wdl/4yhJKl2xMJSTX+IWonGUNYcd
         qf3qHUuGhcH9scFp5q1EdVK/ukx3uJ99Dn8wQtdCKQaJ4xYjYRz/gUhWsF6wP4TEaCgy
         ot7hz+bodd5ofjRnaCtg4uiC3dNsxB+vq1Dl+LirA/St2U+vmOJjtAvMYPJ5WUBUmkoc
         6fL4mJp70mPcvGCCxK/PfTYiTaAlKKcXrnuEEXW7Oa1BNyRsvN2U2BtU8ITZIpzOwhTs
         KKoqnx+ChfXZjA2CQme/pwUyskLCeXjeDcuYsuu4RjEKoOeVWp6Q6K1YXuoZzN2uRzEm
         Qx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751897906; x=1752502706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDhq5tJp38pifNdFdLn+IZDqsYz/V7C3KPTvDZYsKVM=;
        b=SjePVTJmVDAfj3Iu4m3fsDe1JG2zwfoQ4nNV3kJytireps5PNIM/nPFbCpdvZJ5EUi
         /sPU4zI2FOkZcdoMHsHEbSWhfUqoDw/KFQWbTCZmh2mVujFewCV+BPYU8wH4Upm9fVh0
         zTGn8VXBIshvUXy1LxDzsyMtzIvmhDmwS6pNkbzgMz4ylFvEnbTjA8Rdl9rcgXG9S0db
         eL28gYOxoxpNjXgI8yMqA91NuITmBFIIp/1I9qiieiysTgu2LwhYhPU7EGiCejCTghSR
         4lmY0MCkzxZ/rU67GP7e22sJ2U803puYq9neUQ8xsmHvTKzkT6tGRa/4BJxC6nKbDn52
         4oeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4LECDaijAOgiRZu9kCARsUKHHrAQJuqez8VAtzBGFnRSshGW4igv9B5l3gHM6k5s+X85nrYfG2TXEscIa@vger.kernel.org, AJvYcCVNo4Cft6BLC8mpf7ctAW78z4llTbHpOybCmKZLElQC9tFhTxvxkX/XAYyJCiNtAWGJqSUDkiXsNoCwQVXPcko=@vger.kernel.org, AJvYcCXGMPsEgX0dPcIUCMy8kArdo0VYQzppXVcOptCdZDC4MDbQAoYnNd2Qw/7oB8xQQuw9jltqQNtFglB6NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaaDWhVOEqxPdlZGCwplBNF3Fmp7wzuaoig3gyVOu9mt0FsfQW
	VCS+aHTWt74nU+7bXw574fqdaSrdC81ileWlPEEEaMU/Ra6/wjKPdcCZNmW1PlAqlDxp4UNNi6O
	XsnAmapCfkdYxkXt3XrGhCdFAf/t49eY=
X-Gm-Gg: ASbGncuxbyr46h1wv8+KyYhJfxmoDXZp04tJX290cKtGr7Hmm4kUonN2I1rl7qZLg9D
	jSHuDnVqgG+NLovOvufTXN2xOj3/h+hvbOn25L3/Agxw6YicQIPh0ldiW4Oy5eQDlgb+JHmS4dX
	IFdHDphkDHOfShwO/13Y5SbRBO/+UFssK1CVY/VBB7dZbD
X-Google-Smtp-Source: AGHT+IHAxcdHSvyUsVlFBpHwsf17uHOZg0CQLk/OV/XY6LSq29SMgei/X3IhAe70aY2jm1LaXV/ED94sv1WYzGJybkk=
X-Received: by 2002:a17:90b:258c:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-31aaca78f48mr7550410a91.0.1751897905613; Mon, 07 Jul 2025
 07:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org> <20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-3-a4168b8e76b2@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Jul 2025 16:18:13 +0200
X-Gm-Features: Ac12FXyViA2EM_gr9Jy94geyDutwc-rsdqO6_vtaKhCNfIo6OT6mYXIAxbpVpzE
Message-ID: <CANiq72nfeGwm17kp8OsmpgO-U6xMsuL9KBNwX34Rt1xz-Nxa1Q@mail.gmail.com>
Subject: Re: [PATCH 3/9] rust: block,core: rename `RawWriter` to `BufferWriter`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:26=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Rename the `RawWriter` to `BufferWriter`, wihich is a more suitable name.
> Also move the module from `block` to `str`.

The prefix should probably be "rust: block,str", or just "rust:".

(This patch would be ideally first in the series rather than in the
middle, by the way)

> -pub(crate) struct RawWriter<'a> {
> +pub struct BufferWriter<'a> {

Since you are re-exporting, can this be kept for the crate?

> +    /// Create a new [`Self`] instance.

It is not a big deal here, but when you have a "move" commit, please
try to keep changes to the minimum, e.g. type renaming could be done
before or after.

> +    /// Return the position of the write pointer in the underlying buffe=
r.
> +    pub fn pos(&self) -> usize {
> +        self.pos
> +    }

This is not mentioned in the commit message (and should have been a
different patch too).

By the way, cannot you use `{Raw,}Formatter`? You could add a
formatter that null-terminates automatically and/or that tracks the
lifetime, but we add the null manually elsewhere.

Speaking of which, aren't you null-terminating manually anyway in `gen_disk=
.rs`?

Ah, no, you are adding two nulls -- one at the end of the buffer, and
one in the middle. So the current code will fail if it needs one final
byte (i.e. when the last null would have been enough).

Given all that, I would say just drop this one, and use the one we
have. Then we can add a fancier formatter later on independently if
needed.

Cheers,
Miguel
