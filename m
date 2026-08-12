Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF638DC59
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552425; cv=pass; b=ljaK40QTX4UQy8xoRsv2Bb1pBT4n6UsA7u6t4vTcLXiXga0fos+k19BrVQGx4HdTtouP8OakUmT+ljrLYk7+FHMXJ1VZ6dcuNCpzxeDtGfDD+Bh3l5LmuJk2Pgsg93+LSLvCyePb22VoWyrIp1JRyJo8lP01VJUbv5SrER2vQ6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552425; c=relaxed/simple;
	bh=gOIsyGGYeGZsd7+1t35VENt6hUZ6tCz5k0UwrPgrJB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVvvWg/retkM3IxYkuAO9E2shsz8keQn9rD8V2x1H6Dm8ztmWcqqcSxT30JfLJ07K3h86abyTBmWogCdPFqkFU5qupqPH/Bo1fW6+qSVU6NTjytC9ah+6ukIMwQ4zXCxHGQK0XUjp0Rsu6INwZADMtbMUwJcRbpFKx2eMzKRamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al5TqyfU; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al5TqyfU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf420670bbso2637305ad.1
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552423; cv=none;
        d=google.com; s=arc-20260327;
        b=rTtX/6q+C+AXoVtsqUd4KFSU9GQOxs/xL0hYIusCW2GW/JEN0vR26kathVW7CPUKVl
         wAZ6NhoeW7o8RcecZ4PUisIezN5v0mwwjQfL2hagZIzS1//Mn8Z/T/6jdThPnC/Bx5ou
         IZsid9NVMlVh0+12sXduy9tLFxtmCQ3oBADYox9QpAEA2BEGyJ8JygxJcqCkQGTiM983
         lhqmkbZYzIVWfR7asrPAjx+hq2e3+GLBHSIbPmexm5Kcko0meLCspndLzFixEhL20hm3
         tJ6N9JLvElbmu+sRevEH9TDuS2MdeIrMxljyHgt7Q4dnOa3LHDeRHGOy4BCK8GcZyYFS
         E69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        fh=c32lBnqRkbuC7FfvXOJVGDOllwOj038G70uW/P/REW8=;
        b=S0PiFKn4b2URzUtDRzRQAQPLAV43knuArrS1dg5XJPVLIYTYpFak54sUW0eVEddMvM
         rLF9AI2vhTCTzQmlOvHcG22a4haV8uup5sO/AcbN07/Eki8ndYMP5wureGrQmryQQHMh
         A2nD6F1Ua8qVf36ldl1YCTtRvKJWxkTB4YaTlyd0lETn9S8WjYW5D5rwQv+Sw1UDQexd
         TeZ02XJvlHeBkVoJuRYb/UAXSEH9aAHgOaYottNey/7i8xhYSwYGNMd/cOFQ3xw8vIrM
         6/Fu7OHqUm1DBlmBAAu9bQ4Ppwy3CeqnFQhcfV+ScwlFEyhQBjV4gR2FzBdRr+rt2fpS
         yhsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786552423; x=1787157223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=Al5TqyfUu+23OQeZiYehEwCKw9h7n1GWuwvFfs5W/FN6ixV7O12veg3o/+6+ecIG5q
         gi77Jv50TJJVfBr5tK78wp8gBVgj+5Y7A46NSJQiMg9vf/b+171Ld/CV/ytLNCLuYUX5
         JGnwl6csWpus6UXO9bC2cOxNn79Q6o54bdsEtVRm7+6yYsLP6x21sneKJH7rILfD6V6Q
         tMWciyTleAT2pJLtlHf4Ke1yqhLx3FZDQ5GOYVRZdJPiPy5U/KlYo5NBcXMa/AeygtYc
         /sE48ZwkvJJt8DLXaboqm3a/tld2DEUcqAqzzQ8WWBf/PsfhZ7ZNON80nFOWRsL+Ksc3
         WL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552423; x=1787157223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=QdVN0rb/uDw8O95CSWBoR8CpVOhl1ZQ4mrtEwrTDQ8ubzKjx8nZUhHIB79VR+MtWjr
         +57ShfZUqeYAH5sR9gF6U8ddOqfPSVVBIrWHdAlJSmrayQObOqlfWn/BL4VfE/iHMlGM
         phh1X4qUPp2WrPwdtEkAyzRdlzGavclOKPOef9/D1CHVXQ5Epp3KWh2NiCOQ0FisKwl2
         9tiCQ4wnNkwrh7e9iXoOfblXzElfVLWsIs82nmLgTjCdzmrDyBdv0V5eVzWfSkQHkKiB
         vXylx61CsPYN5UzFQXEaRbBHka+AdUDxwRwr512z52D5eOJp0tuYXKnoTsF2RbiwxcFJ
         bK6g==
X-Forwarded-Encrypted: i=1; AHgh+RpfDP54cyK3PLxzlyKwV08MmNAh6Wb1zDk4ILmjpf/58uiu1z7PvD9aiexZoYn97r/+iXG1U+13GpKVBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEq6x18S9i9rCkwQ9Z/NTyowQFvy4Dup6XmcimstF5AJhrFSVi
	5PBspdlOMMc1gDJDRxIgRTTrfl/GZxhl3K4wbsfGTQU5Q9raWaZQGihMPaCx/zIQemnLbUM2Edz
	mHOF3lzByGyBzwlxE96oqNZw/SzrPkt8=
X-Gm-Gg: AR+sD132IztHmZVfqEB1nTH453invkE4bow/yD2N215k71OqzkucTb/kmrgw5kPLAmq
	YXfU97JACK+lbOMJ/G4G3MgZTdgOjMiCEw+bpenW5Znrs1d1bCs7MMe3CJS7t+2wov9oPaU3REY
	aVJAUP/nCwcgKvlnqsMk2DU22cT/nLYYfrL8oUJiCWKaW6qA6Uuoe9T4mxGybRTVZTm8Iih+MMO
	wQP1XJgjicAP3AVZllAgs5jWfCtpkpwZr093WGhAHEF8g3kvE/mF2UQcsZbfRzV9HM5PinBDq/K
	SO192F8jKDNS1I5EnPPN/Ebe0EYzF8uEaaqTFO3jLcaD3EvqDqy1lKinBgZ/fuoSnEPtWKaJYrS
	D57fRVoatjphSfSlKktyez7yPLiVUCfG5939kFKUPywimkGNmgXlpgd+aOG8d
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr58880125ad.4.1786552423044; Wed, 12 Aug 2026
 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 18:33:27 +0200
X-Gm-Features: AUfX_mzHM3XF1m8TGRbbbrVs79_o_CCgi7jI9gpogE6umN7ICq8ixcdhm-skrqA
Message-ID: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Applied to `rust-next` -- thanks everyone!

    [ Fixed `clippy::undocumented_unsafe_blocks` lint by wrapping with
      a block. Added interim `#[allow(dead_code)]`. - Miguel ]

    [ Fixed `rusttest` by adding a dummy `LocalModule`. Removed interim
      `#[allow(dead_code)]`. - Miguel ]

    [ Rebased to avoid the imports cleanup patch. - Miguel ]

    [ Removed Acked-by and Cc. - Miguel ]

By the way, I removed the Acked-by in that last patch since I think it
came from an older version as a series-tag that didn't have the patch.
Please let me know if I should re-add it.

And since I was editing that commit for that reason, I took the chance
to remove the Cc because Petr already gave the Acked-by which you
collected, so normally you don't need to keep both in that case.

I hope that clarifies! :)

Cheers,
Miguel
