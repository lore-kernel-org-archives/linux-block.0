Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383D43F0B4
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609162; cv=pass; b=JmeHSvzRgA3ZUhrFhRnmCKFhfau8jd3A6cScqW26fCI/0+unl87Lmhgk7nZihrAiwBFbJNN/uehPg1I0Nc3R/OVF0s5ThumKVIorYKgrFM+3dRmkl/rGsYPIfUAYDSaIxRx8o/uzza/bpfm46uykeQpSZ9wyM4mjjyVGBCsQnLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609162; c=relaxed/simple;
	bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z943N3QTyd0axtMj/2oFKKXVqPpKHeM/ByBwoLMx1WlhiHhvbN4jadzV5NLI4J9znahE+Gc1xDcnQzWuGowMm4HsCDhF13hq89EawOOu6VAXR3Neg90GLGE+E175hykYhg7a7feBjGuiyZOHc1ad6Py9vZw4NQ8DaY6jNnQWYTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiKXJg03; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiKXJg03"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso271707a91.1
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786609160; cv=none;
        d=google.com; s=arc-20260327;
        b=j3AibPUHfBba9AnFBMt+s/PY/wEy7ddpc8nuU+pHNQfUC+9hHDsnCV3lK9GZUv707O
         lW2S5KjvnOe7th2+29wasWzlgVQ6478C4Cd9N2qgUN9vxbc+9nSiSRYndV5HauUBcfYO
         p26Bcbz9jobcMfSMhR/BhF+G2njCIh2UsN9PawlOKl5bzOlJVX769x9RaPg1X1VyBzy7
         c/wdA/o2P2bN56mUz4m3xkRAMIlra2KL7TPtJDRQiYMgBkHJNCt/3a6by8QFb/lT/HYF
         +fD971cXQ97Z2nfULcz73x6dPt7Q7Kc34w5Fiau8R8+hqnXqF3vTe5erKA+KqJ5oe6Bj
         3HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        fh=MGJ5861OhqJtnuUAI4/FUX5zEsCEBwrqbWcPtIFDupk=;
        b=J6k/NOSpQg/J5h5YKHCJ0Hqwm6iTbGerOp+qkejp8pbkdt4HudgfWZcjEIHQhua8lv
         hsOFLEDXfk20+EW82fhDabaTDRqPcNMF3TrGh/48O0kN5G1mn46t/9ml2W5rv4VKTfpK
         r5fa7FldrIp9RvXXjYd6T6kSYFlaC9c8cGnbRm5DqE/3DK+rZbziQrkBYx+zXPxcyiOx
         OvAxXuYPQGRlIwNb3fxXKm1gWHpvWRG9luWTQo/4/yUg6P8MSNzRs9ZbfKJ766FFJCxf
         vNzmX1ObXkbJtx/11+KEWkk9YzIkCT/jzbeoYp5h2YDRqd55sY6BziBAA/z2/h0iYmSb
         3PhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786609160; x=1787213960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=jiKXJg03ISCWp4I5Y7ccPMu321Ea6AemOZfQWlLgVESV0Vh7f3GfggkE0tt+xWkPpi
         3ACJjmUZFwOHd4xdX45veGxbDPNmBHmWplhxbEmy/YKTVnkRGV5Zm9dXtlcLWuYbBACn
         M3WXqdZUW47hmbmp3YHhFoRMGh3/FL8SbUiZfcchHI4i43vXfNupNOt0MQTPWpD74ajA
         JptqLcLrvVjxvvALg1i53eNw8PTMq7AS0IgAzYWk1XBV0I7Hygmf7Me67r8NWsjqbyY8
         7GNl2JTiQ+PfCLX7//mzkJspyqK6oK7NOLXJfN5pSltReyQsGmRqKK9Er43gYXiqaEdn
         Bp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609160; x=1787213960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=CulXsVrWe105y11/YfBasAvB+f4ZdvGVHsKmXqoqTiBiqXrfIk7KBPr2yDFCbROeB8
         ALnzevbiRG7fIHX07OzQO3nZHJ26sJCQ8cDef2B0pXFEv5c1Mr/K358RCVBv0joe6tLm
         4/se//WonxP+UNarmtYGhLNK85hF9uP208InIY23sNEQRSew6YVqbNJURAe4QngruDma
         jFGKkN0qOMaEfq8NBFIs0lnG5kF+/tsIH2wB5+DJEU1/IBxor5fnYebFNjiVe2RE5GzR
         3WlWP9JnVf4ym0XrvyQquTwdVWSntsrJ/3SIEximQIEtneOHPi3lHXIl4/AITnRZSsri
         4u/w==
X-Forwarded-Encrypted: i=1; AHgh+RozNdzRMbTYdkKsndH0DFTS9wMjG9lgx1ZzHZvGVL3QcQHbt37BmlGQdxfivnF0hrwsRnF+lBGSeUwbLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdFTR1AFA8k3sIczChl3+2NA6bSZE1b4RZJ3pHdV/M6nuKQfWd
	lEH5ioHY+oVSLYMQDxqD46z4ql5gbHqhyDFAaS2+f3pD8QjQEiXAkbMR+CnuJEr4hUplXHDDXHI
	sIBEEqu0bf/8bVT9Y2jhp9mNborav+30=
X-Gm-Gg: AR+sD13rKKEYz2hEusano9ozpvXUkyPT4laGxcjKgguv4A+PSb5In1osRpd3HWj8t0U
	OITAZMNe3+iHkfeIcJfHLdoCNxejbvGgTcwDgG9vTyC0HkMRu8hxiTpbiPSJSFNTqf6MUmA5o2T
	EyukVh4rXQECbiBuQ6uh0OE1x0uLQDpzUSo/jRwOV80qE3/8fyCroqvz8xIjjvQXdu9O1unqFT7
	w+iDaQcaj+9DG7Ai3UqV2DUmnudUai8OUdc3svr4GtPsW3K7+ss6bU4+gpd1nr5PW+JY0EBepv9
	JOMl2g948r+M4vLALXOG6Xaa71rVpXwBylT2uW+XAUtTiabl9afODCXufG8Vj3eKO+JNvXkRHCb
	gQcLQzS2dNP59ClHPN0y/1ZPLoA33KkQlyjB8/D6ugLM0+EQ5riW5rrRE1Vi0xBcHpNcYqos=
X-Received: by 2002:a17:90b:5807:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3931e2aa828mr3336244a91.3.1786609159836; Thu, 13 Aug 2026
 01:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
In-Reply-To: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 10:19:07 +0200
X-Gm-Features: AUfX_mwh5p3w0RKVhg92eH8jsf5k7VluJKRFIvAAaH6tiIul7a7G8q8L9_4Mlig
Message-ID: <CANiq72mcFp-MODPkNGPcufxb0YhPDO_eN8J-ZFVzkd2-W6VK6A@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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

On Thu, Aug 13, 2026 at 10:15=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Thanks for applying the series and catching the stray Acked-by.
> It was a v5 series-tag, from before the MAINTAINERS patch existed,
> so no need to re-add it. I'll be more careful with tags in future
> submissions.

Thanks for confirming! :)

Cheers,
Miguel
