Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58B3EC807
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613785; cv=pass; b=kwXFtAZj6TopO+/o7UkLV9JtU1RNx4RsMYJcKpAwDYvkVWqAbR6m/rai9tZC4Te6MzYAJsA2MLV7DIh4NHJw6PJw2ZqiPXY4TEJ+zHA4Jom2V4wbsQFDk3sQWWfM6Tq7x+7TY0u7CbgnUH8mR3Tf6/r0sb6KEwsDhSpP2Y78R6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613785; c=relaxed/simple;
	bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFDkdcO0FI+TFruvzGgt4gQ4XrCDRRJoHU2m/pL8uX9MGQJltImoW57VyObCXQVZAQNZcBaPWIjxvdrd/3ZO4KSNjp1WgLpyWy2Olo1FEutaZWKxSVHAgQRzFj25ySyFUTLDj2Qn96ay//rgVxA1/cP4+yHdxBcNlurk9SMjBkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLY20tq3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLY20tq3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdce28edeso3400915ad.0
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613775; cv=none;
        d=google.com; s=arc-20260327;
        b=Mm2ymXFbLg2PA+X+5kSSVQFLwm5qCU8OCEk+mu2Igg+MqiJW6nqa9EEXQr1TmNP/OR
         XPY8tmJ9BN/bC502O+Rnz69N975qggJPwkNZseC8nKTldmszPHcczKUYVTJPGbj+P/rT
         ZeMbGYuz3altheul+Awyb9CgdK73CpQbI/ayqsEL6u2vS/qXskCIofZf1rJDem/oKcrz
         /hA3Ku0lajjdgnQnRleK0N4TIT82owwx1ghUTqf/eDVCjoUxj+DmDbiIPvRIFH5BjFxE
         kQ1xYxDv8hVxSuQnKNDb977X3Gu2s05Cr1pTmELz/h/qyQkOa7AC9F0I/RExvL5Nkmu8
         iS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        fh=QN7MdO+ep4+lcX5K8Xhk0biNA268q/oWtsrZyzzbpKQ=;
        b=GFLX0wMhY5t5VcYhM/5n+57FSNCOnndwzOWVAO/GgZGLTpvn9RYyBF+g8ZlbL678q1
         pzbhQcwYYUPmOTAx1Y2MIncrWX64qoS0ZJYDlZ5vIeYFzs6A/ytdRh/L8cJC1aPVFd4d
         tm9rEJCs3i4fJQz0rEkDFPBCug2HOykz8pYffK1V63/3LnIGEROZ4GH439LaL0D7zAK7
         It1Hn3F7UfLjIY+/uOXt6ZUaitldghhbvBlp9XbiE1hJNROfolsRbDlIrMFqm3KIQ0H0
         kAAKpim5Pg20ursSBZebLucGlfa0B+71uBUGJh3oKVoJ2v+hf+9y0iHq69cWy9NTUUm3
         RVgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613775; x=1787218575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=hLY20tq3DTzgOPpU2TWFvqupEvw6BZf9j3keoSE+Gba2EpwLBOoPs3SQcPLdhbHOQd
         av4LzjQ9lYk8iOzG7fbP90+/67JTKwJKjagYjTnyBsp7LINLmDMXAMkvWpmAAwVUvpVB
         WOEJ5hPHiPAW5JflzYC087QtbgUj9OaqQKBUyQviZTqRro+AWpjLp6W2TORQUC3zlftH
         x00J3FqT8MvEhq5XipmwYmYthJ2Z4yrlDkTn3YRtrL9UiuQjU016jZXv5tQqSGMfeB1W
         CUN6JmXZU6P23klRsBB+8cEq/q+V2fmSeWpK4LPNLpfnOwggw5yl0cHmhsqlOKZT9DAk
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613775; x=1787218575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
        b=kgbyQl6f9TeYS3jq0ao65oHdHs6VzppfK3RbIyCxdjtAJKH3VZs3OHHWZPq+rcQgXy
         gEX/w/lnBQaVl8oTsasnxNPmuEx6Kj9nsK9vKVcrdwSXets6kfeDnOD1UzuWGAc/65SJ
         29vxE9FU63Qz2wHmTvkE39wnKDOx9KTORlcOunQy9YzwmAU/WzP6wejLbCRKLPL4Mxc+
         F1gYpVP07uBlIIC9TE8tAgR8U0kAn+25lLRkROQi7BLMAuaWkebeXM3ORnAIbMntqjAy
         DYghCu5mzA3/j9reCUIRlOuWgpg25wbmJEXmYaDQSZkJ5L+1tJqbYAM19Ehotbmv7bBO
         yjqw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9qMBKVW5Tr4k5RUbZjLOZkGhVZ8KJHrcqcemPART6RsIemK/uF435r7xxw3ATwCcHAP/9uyi0oqeLsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDf+1DgclG85CUf31BJvfjFniuKdCi2vY7QZTNHBjA5f8bQG14
	sVrHOBq3+bUvyJYrnolYiuji8OhPavnKPzsLCMkPdfNB2b0fZ5CZPrmozYT0rL+bZG/qgaYqr8i
	Ay/ChDou1DUhN/Yb/hrAjFU7rWlUTgdg=
X-Gm-Gg: AR+sD11HBmdtaxMo4Rf6CVqVcN9x3BWoTqgu4RXo3wVaAJcKJskAPO8PcftjqD44rZ9
	4rEtouXi0fcHMDFou8f9M46NE1yrAwibEGs5bPcHAfkJgodUi2/VWROn7TiGvf1HC//4hfkaS+Z
	h1jxGEtiuHWgDIJq6Dthfe8C2/ldiT5noE8SXSl1XD1s37rw5HQfvzHacEUcW0Ezy22zROgskTk
	w4OpKR8mWJWtGifCqFPaKbIsmqdjAsZBH6LV9RRkXKbUvJ1cGu1/VM6sIXmKw8BLhgkFsZZt2bm
	VsKgh7TYLLXsUZ1dIwxSQCwWCG9GdG4Kf8R8hsNshCcEELGLzwQHLNXOJjfLTwrd1JOMBAORM2t
	USVDD8wtIWOjFUNaovLu++desj2pmB4CW2J1Xbnc0v+penSjM3Eq29ebhaGxq3PZcOEs98eo=
X-Received: by 2002:a17:902:ea0b:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d389b9107fmr28401875ad.3.1786613775343; Thu, 13 Aug 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:36:01 +0200
X-Gm-Features: AUfX_mydrO4nx0TADc_1KF-ELy8K1d4zi4yvOYINpS4bHvyjdnsvoZ1CepMueE4
Message-ID: <CANiq72nR3K9d0Y--FyUm1yAkww2LaAuYQZ3yHXjYxxfztgMMYw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Wed, Aug 12, 2026 at 11:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.

Mark: in case it helps to make it clearer and so you don't have to
read much, that [1] diff still needs to be included (i.e. the rest of
the discussion and the commit I added is independent).

Thanks!

Cheers,
Miguel
