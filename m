Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288532F9D82
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417526; cv=pass; b=lJ5j5Bwci+S2H0NKSIb8c3HR15WjaK3yDe2TlPzVeqEKgfEx6w9R9nkgrp84Xv2kJcyw1CjLbCka2JgG7Xr7NkKVB5wka3lqr6WTRSk58M5Xk9kyDy2QMDsI9gPgEDhOVTwdFsE9TBt5WkXQ5kiNcJO793xt2TNnk7hoMmOPV8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417526; c=relaxed/simple;
	bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWawZMaMguTpfl4sGQIscVypR1d2E4d32I7w1qxjzGENvFLUsvog1CtsJLr8FhEQ+Z4GjYlyiH4tyRUqlA+ILbyRNZhw4EtyOd+vGEppO0Jfd7erDXNxQvlPBn2WY5WeDThn2lhGuYAkf5189Y/EAHtswngwZHuIJ1t1lcIiJcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTQnoJHW; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTQnoJHW"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-127148c2112so185057c88.3
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 12:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417522; cv=none;
        d=google.com; s=arc-20240605;
        b=ebnOmCdAKlkWwY4ETKacUO1TUhbMEktnWuJpf2pIF17BkYFXx/VTKKmw8MGLdlnDBv
         UXHN5yC8z4UZY4QNMzmoECOuxHi3krRJNfdRO+Nnmz3NdE312vkzF76clsSss8sq+jiO
         LbloLPkjjUUeeyDUCGEAF8755sPIHkW3jBCEPR2Lbr1C/wz/KCA6Im4FQ9v6x34XPV8P
         HgpBw5zhb3mPY3FN010Vm67+sLfIXcArpu66KFnr+F6vvaixVANXfsoIM1M5WjL/RnEe
         W2RljVmoFd2pMFPbWJ+yH/wlhZJlC78p+VeZfO9uysbKgzIdnG+MPD/PCSrbq0Cijzz+
         cjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
        fh=uJnPtTusAud8r7+gPgZS7h8qy/SLkqKJpeCh6FRo/Xw=;
        b=UBUk8mAlLgVIwEUmb17NyOw/6E351IFCdGSnwBQ4saXii1DFM+1kWeGIWLjyFFmgAX
         7xEL8gC9lcm0iFQP2S/hIXzLWPLVVY2ae+rcq3H0/M80bkriB7XNjFtoe6ucKAS+Ryvy
         Mmp7QbqIyMUl5SFlZD5qt+nWYUmYoeH4y57zi6L3juv2u+byb0d4SgHP4y5/T6AgMHJJ
         i3c5EChOE0WG53OPKip4PkZSLs8q8jfQe3ddOBJHjnksmwyzBjJBI7o4D8wujnUnQi5K
         HG2GIqaE7cEycHKhm1SkpYWosW0Q18Xo4bTUrtUVlgFFvVScNCUQchKECEnEBDG7Z2xh
         FhhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417522; x=1776022322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
        b=sTQnoJHW55XIOLQxTa/0ehf0g7O/5fqfreTXKUXc2JHcCniV1llpf87rmHdA4lOpTC
         MwB2O2JOTBUGOcMHQdnTwRc+9zDCTBVqj6jol9Gj88fkUJzP7xdqlqvAczMbkihun9pk
         tOyyu5TtBT6dGhanj3/xCmW4QDFclZUZHVQpnHDkn851pqs9Svq58p4q40XfzrXhsMp2
         dGofuYw2zhZuLPavKH4QgFYvPnQ3LgvcdtlzMuFvWkOfnu+AHqQVFjusoSm/+1uMnJ2h
         DZMwoGLm2iYuPXj5zMAZwDu7uZcKqLlyCVgtI22iva9fGR0cKL14VDNzzyKNZUscIkM+
         PmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417522; x=1776022322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZ97OnLKNSw2H58dmZtpb4byqUPHuyWTZL1aRVE8w44=;
        b=saJ4K3D+v0OGBj0FEMjVSNFPPE4sCFmbezhv/hLXH6G8bXr8aFsY4HkpHWc/Pcei3e
         /pvvBlyLhGGD7OjQtnIfnK8iqFNVdj16os+HrmbbAXUwf9YlGTRlHqRZHXug0SeN8AO0
         zd9neowoUW160p8tkv/2qEWSKJHrGZ4aJ4ZShp87f7N9Y1LX/JRwC6hKVaLYVaEw3LwF
         zWDN601DX3yzh2bjdu9fo+IOIHrDeVMMymB8TRCg9pp7OSjnK7PYOA8BixJXFb/SG8Jc
         y3IL/eupqV7TQfWmWQkIBy9WYx1EjhTcCwZJmQ2tXPJke3dBBJBYg+qURRZBkmSENGCu
         O7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQsW/Qz8mLl0mj+WV8I0+boFFyvduIUyWy1UO02934RurJEGr27CKEZaJK/O5zSPpN1UkKX9XZTj4Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0O+e9XnT3UWozsOxTFwHkl4Av1GY0N5KDbRbAy87LhYlVyxxG
	GHtuxNqyeWRSRZJ94eC3aPyNPhn6n/hehSIK4EGjI6RPGqJu/1LKZz+36D+VtGzzR/0UGQ4pQ8F
	P2pt7iicBI1i2cWGcV5WoEtUv753N0lM=
X-Gm-Gg: AeBDietkTMECpPXL+0uIEcE2dnTrC9B5O3ja+XKzeDEXVjtYvk1byTgIei384E5hY/9
	+BnPg77yU/QF4jGGLe46b6qH3lqVsfW8h6AY+cKaf4LgFt2mewvJ8Nfy0NofF6WDzOOQwRlNeQq
	NvkcDmaRcLGXlRtXga/1ib5vH2A93aV7MdZqZMkQoHcnkT9KLW0y/HW47m7xvdqdXLRRdYq8uSk
	7GqlPEmK22NxbbjTKqr/zZEP6h9VNCP5wMRvMEGcN1RoUpQd0I2uCdSn0UKYCDC4jeI9qIeNDJV
	p+bpJluGr56zh2LXD18jMvoPZSKmzGBvTRhEwepsc+fNolxKvnyTG13rq/RIBuCMQRkFWSUeyKB
	/c3k+IirB0tDkAIaZqE5zDuZ5Kr+8EY/ryA==
X-Received: by 2002:a05:7022:418f:b0:12a:7181:2f12 with SMTP id
 a92af1059eb24-12bfb745195mr2138075c88.3.1775417521967; Sun, 05 Apr 2026
 12:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-18-ojeda@kernel.org>
 <177508434455.73816.15756486388132647025.b4-review@b4>
In-Reply-To: <177508434455.73816.15756486388132647025.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:48 +0200
X-Gm-Features: AQROBzC24JtVqMf2jJjrf2a1W5TmgldNN6NvGBvsNhQ1qBgBmbTFc7OPu1-U-ac
Message-ID: <CANiq72kh47Nss9+OdHf=wRhO2=79dxPaL_vcPv8U8qG64bYfmw@mail.gmail.com>
Subject: Re: [PATCH 17/33] rust: kbuild: update `bindgen --rust-target`
 version and replace comment
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

On Thu, Apr 2, 2026 at 1:00=E2=80=AFAM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Some citations pointing to the upstream changes would be good.

I added a couple links as usual, plus a reference to commit
7a5f93ea5862 ("rust: kbuild: set `bindgen`'s Rust target version")
that has most of the details.

[ The comment already mentioned the version, and the commit that added
that message has the details, but I agree it is a good idea to add
some references. ]

Cheers,
Miguel
