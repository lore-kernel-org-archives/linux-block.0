Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533861A4E7C;
	Tue,  3 Sep 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359941; cv=none; b=faudUuy5hEPEbKBmYM6gmf7NpA44W+R4PcjMtazGy0rL5X02W+89ufXIrKvfnO+IBk2BxbxJOmedrNhpus7AsIe4dQXRljJxXDMfopuoWQInbxXNy1XIEiUr2mPmzVXh4wANWklGCX0GQ1sKTwuDZH/mSsLmyohYh9xF1a5ry2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359941; c=relaxed/simple;
	bh=QsB9ytTgaYVg/jbAlllbbzbJruHNK7+AM8/jWK6QZqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgne7EcmmpjNkwYvX9ThzVl1Y6fBYRcheJnPAk+Lt08SsugFaRG+3CucqBzLFz3W0Ws9OaAkmCAfJm2J9K3lOgCpPEgZ2+RvwlRbIk6HJVpRJm6BXL9ACDTGp7Gh6B9kiJwKQ/rRFGV06xT1yF/4WlJt+Up+xjassvkjc2iGfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFRLK9oV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFRLK9oV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71446767885so662220b3a.1;
        Tue, 03 Sep 2024 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359938; x=1725964738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBup1UfPYH+jBIe3t6bYSH/YuGGit6nmS2KxsQ9yvQE=;
        b=gFRLK9oV56iUKX1M46fGOJ6aTHj/CdusgmsDfYbD7Ggj2AIqh5Pwk/f0N79P4YsGOQ
         H+OnwAdhszgZgtn+lvkp1pmR09dh3cDSoTLV5WBwwQddofvEvSSz7c/eIuG0ocMyDQVt
         QI0bVIMzNBIiJb5AEm81RWVl/7RtPdXr4qumo2USVP8Pe31GuK3zVZNxApsBxVLxujBT
         vOW7ymW+PC4KOXjIYQfh5ImuJ5UoEJyP1LPyvpq5hAd1P29Fl9UnFecvKEc9Qw0ZSryp
         PjN5crbyd6DMgchEJK9jODA5ajVP4ixYK9vakWjUJMfOC2DDQRWf6szzBDDSB7plXBFW
         y1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359938; x=1725964738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBup1UfPYH+jBIe3t6bYSH/YuGGit6nmS2KxsQ9yvQE=;
        b=jcxqnuAyCvAfrM8TPEtkYpG1SjGIcmUxfgHta2NNVnRubv/NwFVKhe9/+kfCOxyLnk
         C0J608XK4sePjLM+ocmK0yLXU0nq/uth3YZEhdB7LhTCXrblc7EUIyfBX30T9jugQy8s
         /2w82BPhwUaHsTz08TbtoCJSPpyIRp506bcs0U2EvDerwQ6MzEh4KL+lvTHRYbF8eF1E
         3AGVfYewsOIfZUMWv5Un+h2mrmLoF0iK0LF32H7KUJhu5H0rwB9vRQ7+KF00KKLbkWn/
         mFjOq/EmfmErcOEjZq5BjFk61yYSF93dtqGfPesYS/6MTDXtEDjkCjnJDvigXK7g+ozE
         8Y+A==
X-Forwarded-Encrypted: i=1; AJvYcCVwaCBGwJ9CnR4eJM8fC2gxCIqePw+Zjrxh11q3M5GFPgnZDMKp3nmTfhDyfVvkpUY38m3TnBH5IgXk7nc96C8=@vger.kernel.org, AJvYcCWjVgYb+0RAIONQxdIFMyxDV4SEPPxeSRi9wyb6Xph+2IePSujAKaBYMRSxlMJSgM1+yrNZq1SDT67uhw==@vger.kernel.org, AJvYcCXg2Aa26fKmpjmrrr7Ffii4to4I5QE8iQv6WUF8dpXhR7KWAb5bnfB5QSxbGxkQRyEK9fwuZzS+YHPTeWJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxyruVfvRHxTg2sZEHiENF9TezV3lCw88eOEdZL2Zz6B78ODk0t
	8eSkLN+gdRa249tyJ+QuzUfOlqyFe06xnIYoFcirfOu7OMQ0IkYJRhEt31wQlShrcx86s9ctSjx
	Pidk03KE6TbtvSehKp/319XFJdJU=
X-Google-Smtp-Source: AGHT+IGJh9PB9LY+D4XML3Q1TRSkEKR3shqWi/yNYLbCnuZNYDMh4hnKUJGX/kIVREqL/OIQ2aA3uUgtgScUrvRnQds=
X-Received: by 2002:a05:6a20:7f86:b0:1c4:c4cc:fa49 with SMTP id
 adf61e73a8af0-1ccee5179b7mr8048831637.7.1725359938563; Tue, 03 Sep 2024
 03:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902211553.103807-1-frazar00@gmail.com>
In-Reply-To: <20240902211553.103807-1-frazar00@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 12:38:46 +0200
Message-ID: <CANiq72naAHm81thntNdaEoq8rMVH0gVNAKB_Fd5dy2Eu1pk5mA@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: fix formatting for kernel::block::mq::Request
To: Francesco Zardi <frazar00@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jens Axboe <axboe@kernel.dk>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:16=E2=80=AFPM Francesco Zardi <frazar00@gmail.com=
> wrote:
>
> Fix several issues with rustdoc formatting for the
> `kernel::block::mq::Request` module, in particular:

Thanks for the patch, Francesco! These look good (I didn't render it though=
).

> Closes: https://github.com/Rust-for-Linux/linux/issues/1108
>
> Signed-off-by: Francesco Zardi <frazar00@gmail.com>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>

If we considered these a fix (I think at least for the first bullet
point it makes sense to do so), these should probably be (in this
order, and without blank newlines):

    Reported-by:
    Closes:
    Signed-off-by:

But depending on the maintainer they may do this without a v2 when
picking it up -- it depends on what Andreas wants to do (it could go
through Block or Rust).

Thanks!

Cheers,
Miguel
