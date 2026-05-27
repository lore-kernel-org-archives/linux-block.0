Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00388357CFE
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879576; cv=pass; b=B+DdqP95SSN9f52p5faBcb1HAgYfj4KwZpA8PMRsEHUF1+qfyx42mnbXLxqZ+AatUyJXcPy+NkXiWgtKfwDACsM8p70MFEbO8RCDitTrc8d4/5hDjJ0qR6lj5IEenOcOLJAHV+R0d5ZEV3JHqWPB5OYLs0keC9D55eaEe7w0t/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879576; c=relaxed/simple;
	bh=vi4XAxfj3zAim+9+fbwET64Xq0emqr1tUp9jN1CKwkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtUv44ZmMymY83Qn8Wy3VYFoUBbYOZtUd0zIX6/FadXnSwHtI3RGFGXIwkiphTJOoAEPtQHq3j+NWdZY8wRtB831mASc42+D8DSqQnNGFveUVYPfowJueE0rod/htiOk6l6TBcZvS9yziCoFxLUT7D/Mm7ZHOp9v9M7R9ava/a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dp/FJl7t; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dp/FJl7t"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490426d72f7so49090895e9.3
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 03:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779879570; cv=none;
        d=google.com; s=arc-20240605;
        b=P9aS6NPUQCzh6jjddfHPQWDmupVyCutBb7IRXTa5d/j3hW2J3oWlP6PviC5tkBNw+n
         LKG0TfQDKHusnMuUMv1MqJJ7QYJwDCIPEdpGo8vTVHe0NMljuAD4bKkm0bT/9/VEsHS5
         HSaWrEUAEp8z8vp8lbrPQQTCspGJHt8uWCGsuum2aloSRTkRh4GjRSpUAaqtCA+1PfPv
         sea/v+SAT4fCvzt4EUNPdWrUtyzVVqyXjrovZyWGAiQKgxvdsYoyMb/0IeZDlYMfh1Wx
         IgmScMKWA7Dlh2rWBncQY6d8b+2489K5ps2fILppDXZtCkQuerASVr2Z1Sunml5tatq5
         Bl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uqc+6PLq4wunNvFDYhJWtFDhhNpIle7G8pDeD45PDWA=;
        fh=vrsc7ZFko72lG/xUqE3Z29cOSewm9oS8TwVobFvFLsA=;
        b=bIoW+CutT8m3WFTu+kMpQodF3g0nQuYeeC63slRJqnpfkmaDZClqPCAC/VV8Y4TcmM
         R057zW3yJPxMjTDxqJtL3IuLnaTRN1TzwoWwAbbaWGeMK+Q+EdKhxsWwtZoT00fjhIZT
         b+lUKi1iYt7sA1g179HoxCH2uGYbz0qhBC4bRu3Tissa4D03KPg/ZKSGZ/UnoVwVv9Hw
         5DvtD7MxHKj73KMLOelP6eg5RdwUPzRwX7An0yUICsaFX5N8lzggNUW4AqeK+3vTSgQ5
         UgZUfDH1A6Hvh4mQfsxD591yt0+Jk/07P/9fYQ6fkTzBKTFNHPsMSMzKhYKf6uNFFIjk
         UjAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779879570; x=1780484370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqc+6PLq4wunNvFDYhJWtFDhhNpIle7G8pDeD45PDWA=;
        b=dp/FJl7tAAwjw2GiBtm/ejHTOItMuN+2nEh2MBxh02whfcXTbgvaw2HVsI3nIyy0D5
         1lL7c4HDPTCvoesPIBBvrosARmm77wZjZZ+Wdtyuswfn6nsVZypc3ZJok0aM8Vmr+wX1
         bB0Ca9v7AvmiEd2vVSKRb/oQJGZCZKIVSxc7/UMZkP1YZ4X66vcP3rLJDeWQJ46xI/UC
         MKB8GoEtOIbaXEvENDwywabgldlJpqn2WAoHw1pOqcxkyqR0feftxXMzynG5Lb4Tzrds
         UpdqyYf/s67jR7NIhjaTWb3thuIv8aD0gnETfwK/8cTUlIxLfXZ9MtN/g/aX8MwLWk70
         zFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779879570; x=1780484370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqc+6PLq4wunNvFDYhJWtFDhhNpIle7G8pDeD45PDWA=;
        b=g9GGdHarAKGzXwNsDTWr3BjfMaIGdgjbdjBMmQM+PzbVQ+yH+yLJcOZe2GUPHNhqXZ
         X2noAeeQE7DN81C9GqxfkQNSpWq8DQmD0uHZWAB9tYV9ewjoSBJwGsEZI4dhv8ViULYm
         3hqBrFdKscD/h+dwGzLvZixG0Iv8N/7DxzFLMzYa4oBXDZ72k0/1ttst+zp3vEuRT2Mz
         vPnebxrZeF2jj72GYsfRjMSKw2IMz4gLeTqoTTXdUaO4sVSYwvsMYrjNx/QhmO8up8OF
         AT0WmpoL4c2yEtPWenJ40edIH0dZv22LsIHWQZVIiZeJixw6IPD4WFX40c4f0S8hYVc9
         UScw==
X-Forwarded-Encrypted: i=1; AFNElJ8xKwR3rPlq6nZVvbZEyEYBM13gGud+Yjd8obv7E6JxPVBnXyCe4vdC5QZcsMk618WXzSVljv2DIbz41g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjg+7Zo9uIrJCmZgMDHeg9ulsIiRhTXicnD+DGygbB+RfotrN
	nTi5Lbw+c5XNqOnEnHQHjEFWBJwRniju1YuQJLl0OwcmWKYR92JHiSt3wckQ5CkaRfs2DQyowCu
	qyPcMuIRycTs6sZV0F+1LdFCoydVjHbprIo1O6dAX
X-Gm-Gg: Acq92OG16yHLZchd2sCypXuKJ4q52SnfHHAU0ahXKd8C6jMVtoRHLIvD1p+bD/tEYbb
	1NPEkeUP8b7LZvWZnIGZMMLsqy4qkr8j7mUCen1SZ+6OxDbcxCpSP6b4vWC0YzcE9soeupSQZ4W
	OwyRe9DB53m8oroJ9DPazUbgt1hLlz6ZDwFSjkf7pjbRRk+PpJYbEqQYdUPrng4NDFB4Msq1G+y
	ry7vajwcFDRpv6IyIM/S8CBda2oKpCb5LWXwqixjn9Kuf8L62TomwnCPBxUmM4tmGiNTr2jwoja
	tQimqdgDRmRxqaTYS6CeRtYKcAW199Givw0LSNT2V8zA8MEghiIF/B2Uc0lnB7xw3PRVhsy5OIM
	XFZnCNUV/C2PpGAo=
X-Received: by 2002:a05:600d:840c:20b0:490:41b6:4d87 with SMTP id
 5b1f17b1804b1-4904248b0b8mr280616185e9.4.1779879569496; Wed, 27 May 2026
 03:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
 <DITELF5LNOB6.2IHJU3443SMVH@garyguo.net>
In-Reply-To: <DITELF5LNOB6.2IHJU3443SMVH@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 May 2026 12:59:17 +0200
X-Gm-Features: AVHnY4KcI_Ads2Jzvtoj9mPcbzPEYiAu7NR0eB4MyvIiSRdOnnt3X9Kz3yZ8qis
Message-ID: <CAH5fLgiobJ2yCbDM56H8rzMeAWv0eaqt8-vPchU1EV3VEYb=jA@mail.gmail.com>
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with C signature
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Mateusz Nowicki <mateusz.nowicki@posteo.net>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:57=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Wed May 27, 2026 at 10:18 AM BST, Andreas Hindborg wrote:
> > Commit b040a1a4523d ("block: switch numa_node to int in
> > blk_mq_hw_ctx and init_request") changed the type of the
> > `numa_node` argument of `blk_mq_ops::init_request` from
> > `unsigned int` to `int`. Update the Rust callback signature to
> > match, so that the function item can be coerced to the C fn
> > pointer type stored in `blk_mq_ops`.
> >
> > Without this change the Rust block layer fails to build:
> >
> >   error[E0308]: mismatched types
> >      --> rust/kernel/block/mq/operations.rs:274:28
> >       |
> >   274 |         init_request: Some(Self::init_request_callback),
> >       |                       ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >       |                       expected fn pointer, found fn item
> >       |
> >       =3D note: expected fn pointer
> >                 `unsafe extern "C" fn(_, _, _, i32) -> _`
> >                     found fn item
> >                 `unsafe extern "C" fn(_, _, _, u32) -> _ {...}`
> >
> > The argument is unused on the Rust side, so this is a pure
> > type-signature change with no functional impact.
> >
> > Fixes: b040a1a4523d ("block: switch numa_node to int in blk_mq_hw_ctx a=
nd init_request")
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> You could also just use `i32` instead of `ffi::c_int`. But it doesn't rea=
lly
> matter for this patch.

By the way, all these constants are in the prelude.

Alice
