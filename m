Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D1194AD6;
	Fri,  9 Aug 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208325; cv=none; b=fyzeB4TWh/2dFAs+/0Vp7INBoMJGhE4YhrUBIXBXn3tQIhW8XJS3sLfk1UpjObmTSV+aj1DkUGll8imEe/86RWwjvxIr3AaSLVrbSxrchnpxvmDUhMBAzN/xEyzo8UXPo7BFv1D7AZQyGGQRJm9Ic3il/xBCQXZWPgxPnRqHXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208325; c=relaxed/simple;
	bh=FGRFfoKrCyjpQ1L1xKhEW2Z5ELvYBvnzVXI9tJ5zXpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmk7T7AXWpbMJtRWqagxntA/ssl9hRb7ifZcwzIquJjIqunvRQRsqymDypHNJdN+B72Zc200qdbS8eRURQR+2yb42MC0sYFMRztBuKt3YHR6sJWgNTiVkzqpDDqPBHM1sX2MBHEuUBiwrvs3+hsXwZq1JaVZzsK/YF8b2efFO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJQyaNBK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJQyaNBK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso1651827a91.0;
        Fri, 09 Aug 2024 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723208323; x=1723813123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v9350Nj3vlAUY0CEodJkrVSeYBUy8/gULVsctF3FR4=;
        b=dJQyaNBKCki5A060PHBAhEahD5oSk4rvyIwlAECfDxauo9Ii6RM2Vd/P+fSzoYzcLn
         4dyez+XMHqEYe4+XWjpVGzKhOZKJGm64/iIK6A/pjrmv/8TBG3pEtxmB0t7PpPM8Th7P
         fdQTefaDpit6fovn8bUB+Jn1Z/1fey8E4srr3FGQm/V1KBsOrzTF3yCsvego7JqLySud
         XW206Z78tC7klUjeiPr7dxVLjy28c2cfcn0uMON2+PxYNTzCUUq4zhFlGzVRuN7Q59t/
         Ba9ABUKzS3NlkoZjl4n5ceZeXN+WGZhg9sz96XeO7LovsqAFIGnJCpQ9FHUgI3oaMs0s
         iofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723208323; x=1723813123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v9350Nj3vlAUY0CEodJkrVSeYBUy8/gULVsctF3FR4=;
        b=BaBT38WWNQuBZWQOO91y3LOqUp0gD1UVRkSBsQK3sRVT9iOJDbFfsvUGz7Kp1n6Qf0
         rtlv5+bf4buDcNTIkUfmY7ddkKYH4J07au3niZKxyFtR08GlKpUlcMqwPQJ9KsXmKVf+
         7vTDKmeSxMLIOs2kqVZDaGN+1tNfuwp6p6WPgnKiEm6QS4DEqtDUgUQ7DkcVhZ7LztKq
         rl96ie2V/XNdlc3obbrdCLJnRFZ7/7aTnOE/i+thY+pRvN494kvpu9m5YhHUVVyL0Kz7
         iH+VjnbRr/CQ5EfNkzLEaMA9Wi0t1tm1ldejJ9FPPq4inzEx502R7Ty29yQEaFMyCY86
         db0A==
X-Forwarded-Encrypted: i=1; AJvYcCWos16VxmMUIpQ8CRU3eB9B9QwzMHPa8awje+Lu+1JSpqo59eomm7fIPVAXfD9+AYFdUnHuntzvz9WifujxIR3akJow5rvut6/I08zWWEpfSZfSLdUCOrqTpzD4PP9V+/inzAWse/mR3ziji1LBSLN297WArtqkOhajw34eXK9cpIXhP4eZB+yEdA==
X-Gm-Message-State: AOJu0Yxsm+IDfpKc0z0LIm76r2+Mc9przcBsJGulrR9tJiDqQuKErtW3
	Jwpr17OG8/ExCRC207QQmDtauf5fd1oCdv0jKN6c19mGBGB9uJOa9kUx53ketGjfd8LoFak2ZBu
	VIzzEYbShuz6rT6mgY31247rWEr0=
X-Google-Smtp-Source: AGHT+IEQc5kyXmolW0Sis7l41/WL9/1/vMoeqxdlcXNfi8hS5iNTv0gWd+JH9Ib8sWecYe9p6gOg94R1Pplbq30RUXo=
X-Received: by 2002:a17:90b:124f:b0:2c9:cbdd:acd with SMTP id
 98e67ed59e1d1-2d1e807165amr1599804a91.35.1723208323234; Fri, 09 Aug 2024
 05:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com>
In-Reply-To: <20240809064222.3527881-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 9 Aug 2024 14:58:30 +0200
Message-ID: <CANiq72nP+pL7fEvaB7HA-mHJFs1j9SKMoSMSCif61YCy4QDFoA@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Dash has ascii value 45 and underscore has ascii value 95, so to
> correctly sort the includes, the underscore should be last.
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

Looks good to me (`LC_ALL=3DC`), thanks!

I can take it; otherwise:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

I am not sure if this should count as a bug/fix (there is an
recent/ongoing debate about the Fixes tag).

(This kind of issues can be also opened as "good first issues", by the
way, i.e. as a way to get contributors to set their email workflow.)

Cheers,
Miguel
