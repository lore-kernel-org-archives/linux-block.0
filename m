Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F034CFA7
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480383; cv=pass; b=MtQ80igCuxuroJ3BKD+hDELXp9/niv5pIomqo9zV0T8WX0GcjYVgZjbGCEMezu32X4KMBiV3ia07F7etp/9/PoCxpUWgntny6iVWnMzq0nNPyvHYcE/vUeGFl6wosMK5SaHTHd793H4lH35N4swj/M3TERVlaVncTQib7NbTTYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480383; c=relaxed/simple;
	bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbERnLClxch1xZQTvW90dSX/wjL1buglF35wn7xuj5XDx8sgwP6O/5IhnE9MxQj6uAFPvK3Ng1pYNz8x2fMqmS59Pn2XWBcten8ZQtovmGtnOLvJaXfD+ye51v1amvvS0LPZD/s5ooXYgVlVzo1W/oy/NV34w1bs4j+XiUrvDTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHnR1d8I; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHnR1d8I"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a6f026675so107235b3a.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 23:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785480380; cv=none;
        d=google.com; s=arc-20260327;
        b=TQqxPBBoPGfFgUZyQoBFBQhyAdTgA06hVobQJwaVXNK8EGSA2xBWoKt8XnhHhodn0x
         2Sf8wu5XA1bzHWKTSyjkTWNydtfY3U4aH6EoPIJw9Eg2QETBMd/fa3xLf1UothI5R19j
         tsqlwNCV5WbiaC+ZCPhItwevTlAZTfQ+xbzHyc61OpXvfCMwwVGPjz6Gw/W7Ui9yqkg4
         tphrErYSg8HChoEhy1bc3NJn+DaVKSFX3Q8/Gpg+nFoPYL7vAKj4Ys89FwnjMRv35YQk
         MElIIn4guAM87kjE6/YtK4fC1vzBiPJmijY5darXA46KfaA8nGx4ia2H3Pdw71iZIBYu
         +HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        fh=G1VV+3YceSLq0ziZkGawxmTiiEx9vjWTVxgx3StWsyo=;
        b=AZTzwx6yJgUYs8fGo1NLEezqSVf1e2HlZcGkZMXvqZaLQZBBrHSivaJ3ZLrrzm0QjT
         biJf9GOsMYoXVlknMSZkg4DTBI039pSmoHZALlq/yFGRRAHPUcLTeRamw+3A0b6uwEXa
         NQNd+ZjCrjESIz1GPvnXPEbCLCyzDkxzx0cR4XBEeCgw0u9V69gXdrpKMQLCckBrEBfq
         uU7PsyDxd/nLtfDBTpAAeaBKFkec9NwUROYsgWQBnif7hpkiArkGd4uRYAm3CVZw40rn
         ig7U/DAY3n2YpQXuDXimUSnujjPyrNONq3y2od1E+tG3MZVqfsoGtm6Rip3I+owc2HQE
         feTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785480380; x=1786085180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=QHnR1d8I/TMMKJbGJJ3aw8izZ7RG5URa+aA4KhAZbDqkJRLAM5u4XN+gTfEheCPRqB
         2KMZipuxAp4b/k4FTiHsqZKYgtPVQyY5mBzOSij4/2JFMQyMisjb8doiJWaGsIkBKgOu
         svJaHDM83vcM4tByZM0OZxbgwcmf1awtATooPE03M8/RPgJGUd4Lj2eT14WW2vHwl8uJ
         54X3B3SOEB9R7nncrk8sPxZC9BeDLB4h2nFts0jSJTlrjZa3D+Deu3V+97jE4J1CfZ/K
         YZFqt1ZbXILwW6MbA2Z2rvJxKWwpkWpyYduUHgls1FbIhiNDInIIo0WBGPyiY8nRozVO
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480380; x=1786085180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=s12cFI5f5Oci/nGBO/6Uo6S6oshbJlkQjE4/50kBgZNkiD5eu4yBb+zFVqsf9v62km
         Gq1qZ+v7WRxs18PxQmTPUeIvKVg18NqKhFe81DhZQ0wzmwcCZlO/hxOmGH70yU4Hail6
         XmP6mjSnBM8CAPLXuGSxS/1NmOkgDCAmfxtO6kJfWIEscixFM2+r4xvcfSynPq23GTtp
         VZQJJdv77v1FWx5XVtM3r6CZZt8iaee6cXSrApNM0JKOSqRKCRSCwXCS1n/0vrIAjjv9
         tP1WO3YwAn1v/CSmn576BBnSuNyZ2LPBFwjoawv8/PjAwzNpWGIzZRkPnlWbPAzWUCDq
         mmEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqS1jMdmL3rx90telNFed5Yb3mDyZp/nV0+TEIe9Ar/Du9Ciqeoa9HboJ6rrYTBogGBM4VmDJo2xi2pcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2x2kxNGtWcE8ZPA/YjsItbDrA5PCnR8oj8O2nmLLTaekWfY/
	eh1yCTp9wrIrdvf3MarF7ULY+JXr5WkXH/eEyvVqValMpSMUYdOhvuy5Il5XPK33M88kFXdta0I
	BsunepLQ8tRdp9Dy/sUgCIEXTFNCO9Bk=
X-Gm-Gg: AR+sD1234NP0dyetoXfYtgGDJaC9Pklh10piy7eHI1VRwqQBLqxXcqmF2Q6S7/XsuE8
	zwS/UZ/W3VeGWzOPNuaeyJPiBdU7eorAzNZcGsrII8dC2FEzjUlYMWrMFyhVk6hr9wWe7vbMlTt
	dshvrsKm7YEqh4tGSxsKvvjk5w8o1kE2OXiiNtKZj1HPFinOBQ6V7W/7fiSsRXShoNMw7NVDiRh
	DhFWbXxKbLC6S7M8ybtOxgs3P2+RKLfsRMzNhBGCJUtcaIspxAADjfd+WdF6lm+OSpT7ttryY58
	aZFxTi9aWuHaqmwjx0cGYyVHALkNCg3Op0QhDM1nxuDl2b9Wo8Li32ezKqPo5cpjF1HjTmbJQYr
	Q7aym/kHbUqKYhBkOkYPhWRxCAcVL3SyOXxIFytoGuc4ZBGEcyAysqwvMO5rh
X-Received: by 2002:a17:902:ce08:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d046b459b3mr15748155ad.0.1785480380480; Thu, 30 Jul 2026
 23:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:46:07 +0200
X-Gm-Features: AUfX_my5gmBTyBxP6uEcBbaVDtTCrtAGlQbEryzjfR6FoeX2UBUc_vHFPgNtGlo
Message-ID: <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed

Was this old tag used for some reason?

> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Are all these actually needed? Some seem unrelated (some were already
applied too). The only one that seems needed has Andreas' Acked-by, so
I guess it is fine.

(By the way, I will use this second message to take this chance to
move the modules maintainers in the To: in case it helps, since I
didn't do it in my previous message)

Thanks!

Cheers,
Miguel
