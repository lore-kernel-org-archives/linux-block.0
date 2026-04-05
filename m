Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F132FA0C4
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417531; cv=pass; b=DUp8o97qFsX1zlyCoc5rkCS3V/huhH2IksGBKpOkPyo00dKzpzx70lGmp3YK7lzXr+KNfwy9/F/ak/pNftafuYFvA45FGkT77QWKA5vWpgef6LW1NKGxMjqCpN8yVb3jWIE1svbFyLnu3k8wjoXDK1gdY5mS2qtqiA6Mv6U0g8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417531; c=relaxed/simple;
	bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2yEIn2UuAwzQcyVH9GhCTA98KDebhtHDeuK/zUo66BOtg6lMpihcIBr8gZbsTTNv3u1ekAOmHVzhG0L/RlLTkgYz4DybqNq5YxMBfvWb8u3+v4LBJiO0v8XXx/Y4Gq7g5CfROYCawiXqK3sbxVQhAPlJuFzTOPQGA19du/O3SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM4E3kMD; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM4E3kMD"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c7e5f38a69so180147eec.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 12:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417530; cv=none;
        d=google.com; s=arc-20240605;
        b=O95+m+i1uqrIMHZBKopojiNbKhHVzo0otG9wneyme3XIvY0IDQ+sO+32reBhYulvyj
         Dqzkq35TJzlKenANtrwKNNNfkAi9BFDRy1vDd4/HWTb7gS+9DmDw2GzRw/kEKN91yTkd
         neysJgOCemgfwHUdmNUEyvtw4UKZhKZjR4LIresiUqlIjxfW3PokxXOI0xmzge0WFfGb
         WOni8k8gn2XVPVxsNxE8yWemclIMdVhslrRsG2nnoAtX8k+zqAO3IXvrL04zi0bL7+6m
         kitAaonPQNkoacwrhRWmIegsmgft3vv4nNM4IyRC/0L/iLYnqAZpgOMxuIaZkAOrAAJJ
         V0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
        fh=94OnYZc523Vo94sXyK0/cqzgRbsEQCqRZmfwR6R52wc=;
        b=k6bCdDvaGejVQxg3zAINzg425Y+ewgbN9JON9S8CbcsLoXlQ639z51cxxIvWhtn0Rn
         O9PkLsvZPyTiF84S9fbYKk4I8SEjw1lnoRSs9Km9MP9kNyh/opBEI2X1uXWK+mv+Xip0
         jCOvb/mcuLj6gPRc+cwg8IMEJXyCdgiZv4HN2zm28G6flioSRR/xuHjA8IFg1WBMY/Ww
         jZyXMd7bnwoavtn1olsnKFZA5mFsE66Sqydjf+eztYPeXs+ZAA9VsPybG0jWUk14CFUZ
         xWjqP5o0TIzYXmvdNnYgkZpT3li2ANWU/R/aJnAzSpEvULCpVZHZ2V/XvzTWVSu2PhY4
         z0qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417530; x=1776022330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
        b=jM4E3kMDqms8VNJHv8kbVSfyTEZTTKjtGooGApmTiF9/nl06mKbaW4l5qIrYswnwpT
         Kh+4uqPBEQCls44ciwK6q97c6RKkdhRDyH18GzzB3vo2S/H+Keo9XO7noiMkDp0chNkY
         oVvPX4x6uk8b0yagBZvRgeuVx38qA85crjHfPf+OpMXap5ch23Cu2O9SIacAvShK4RSI
         v/5nvGmWcIZ9XLN9XSXX/rtp3Z/xvyPg/yADjrkoUeFg7nDBaSirxtRcasaRJz6mxvND
         Zu5NAABnzR6ScrYjUxhifSEHfR1D8AOj53N9+osYsUGSSV8LyJ8h58n2OY765I7uh+ho
         g+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417530; x=1776022330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uj4oJAcIVuVW575tTJ/+8h74lmRr+UIi6+RvtopYiMw=;
        b=fjhVfvm0GTotLWXMMOiU7T9VWGeSc7HGMFoTQg2jhp+pnYzWRwFOdq/8qNset8Vmo8
         TAHHKaOCSVYNzLGDBfSHBM7eqPnIoqAgbpkfJaz6NbFSReJUy7RmVpZzcxXEdyAWjr0q
         rOxtaLtGTXgUugVWLffLbmBHH967DphwGrgQFXf6OSelyaN62Cb5YetuM+f+vl/aZJTk
         fPhzhI1KREDG9dFDpJxHrIIpsY12y4mgpJf8JMoelLfXhkCDdaNHYOuAxEmSX7v4veZG
         8mJFgSutWXugUoEJkOcUDuHqFyPKR4zjbf23C84I3Fd5fCEfEk4NL3FioWyqiq1/yV1O
         vw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsm3+b5FvEK3ZcT4jztol3MUjPWAx9EGW2w0tq/az18/3Qvmreuf4GE1pFL0sgj5DSG5h5+V8L1WxvKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1HP/0ZNsOBUgf68B1739DQVteuPDHW4k0OMetDu9tGbm9USA
	P9daliNplqVAxayFrQzG80IvSK1CkQRV73SKlsEiQHJqwQjNNwQ5RfwEZE+1SC+yS91RhdJWhe2
	0MtnGi5l7fFtPC9o7jN31zCDrgjOJNGc=
X-Gm-Gg: AeBDieuYZWyTgkLeKKIz4WneQZUYOdAAdEipAeJOXgrXE3SLgJ1OKM+zcCpGSzB4Ahb
	NZnGQ/jvm3dZz4ItirpXrQ/EVOpUGTiL+jybPhA0fB8OAGOdNIY2haqAGCDbGt8qucsenqxqwna
	ti37IEaFzXOMjqfLN0lXnoIOabf3vlr07Avdnz0PTK0vszh9uE0+y/zVwp3V1M3L5f5SFI+Dx/z
	oWszZKt+PU7SjhvTXNCK4Ljqkuy+MaVTIL/q1l0Fq6lyhgf0Nz06gPRCzptpvwZBVps26/gVM0K
	P5l60RjUzf/MyKMpUk4G0cA9RmUqdcQWfyI34aAURx2UOxj+gqai7ES/1+qb/p8fYnllH30rPgw
	tP//33W23YD3S/uO9i1Ps9fo=
X-Received: by 2002:a05:7300:cd86:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2cbfc768bbdmr2210515eec.5.1775417529556; Sun, 05 Apr 2026
 12:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-21-ojeda@kernel.org>
 <177508434460.73816.4231801886718165891.b4-review@b4>
In-Reply-To: <177508434460.73816.4231801886718165891.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:57 +0200
X-Gm-Features: AQROBzDsQvgh2EDKUg3LiGNTUf-8TUQBnEeLR3UEGt8KzpEPnOxtdZC7xsmuU3c
Message-ID: <CANiq72m9bsXZnMJv2w9eszV5DGUG1Cq0NCEUqv60=4Op__Uong@mail.gmail.com>
Subject: Re: [PATCH 20/33] rust: kbuild: remove unneeded old `allow`s for
 generated layout tests
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> How about ordering this, the previous patch, and the next patch ahead of
> the version bump to avoid the need to mention it here?

That is reasonable, yeah.

Cheers,
Miguel
