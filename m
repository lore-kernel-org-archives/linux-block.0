Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418D1FC0EA
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775417496; cv=pass; b=eE+RKT5WbmDuhimDsYS5bi4TWfxU+ghFaIaT0BC4O61bRz/eMV1eIJRx2H1KDMdmVsHIEuWzzVJ+sz9EXfrkvsaz1msKNzVuVOg/pAsPLuHo2KBsPIdqBmWHQARmxHkqNvEhwlHYnaNoZ/2UP+RYPdZPVJveQ4mEL8rLPZGdR9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775417496; c=relaxed/simple;
	bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHa1jc3KXbXCVu5JIKhbKvDuo2/luW33/j8SQSDeG4+ZLetJBJWM3V1gcvp3ZBmwgNvsC+qlLWBaKKtiacRv6IAyiTCY/jSVDND0BvWVUBRhiDiHkABlba0UGpaz600JyjIOdvcZ1gCnI+qQavNp1g55KtiL5+QuUQKZ/1N2RWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVCEwxRe; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVCEwxRe"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bd5658b901so219882eec.3
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 12:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775417495; cv=none;
        d=google.com; s=arc-20240605;
        b=UF3oW0GKXTm6hcAeh1gSc6GGdRgda3GbsQoeZFsY/TT4toX5s0Wa1iGXZkqepIdsI5
         xsr9uHSnnXAC4AXwRC4WT1loEg7PoBjMIKQvlLNMOmOAWlno66Ja6Y1en8podoBakKwE
         8CNj4CiIoBb+g59S1Kbmq063nrV/N4Q2EaUN2Ad1zPDqe0ZX6PObRORHL00Jk1Tup7W0
         RokLO1rkX2+zZb9Q066Og9/IYnpNd3N3QabMuiG8QQHIw9u+GRjBJF0+rHkVS/6f4sdb
         5nIj/VVcTMPszNM6N+2mYoHmcpxmxAkSr9PcQhlzcXip2S9qnyO4OD4Ip9eFH0k4ofHR
         2dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
        fh=1QMWfWqy2gXW3976832ogiiR0TVUMJSoN0A5YWETxkI=;
        b=k08QZ0AerECwwtpeA7IX9UY/yvBybYKASV8XNvCZ1EYvTjO/lC84rPgVzn20hoyrY/
         jm9diViTRFhp72IypUkPxcre/Hxgknm77AOPNsFqYGWxfuXXBXGSi19FkvR4JtxxkAdE
         S0gvmHkrswg+byz1XfMhjhi2O4jCPIIUTLebrmEWaFtRrmVMEQfBvvvfaoerVN/rPKM7
         FLW+3/s1sTU6dOstxNiCprek76Xv0iEYKcRExpJGIt88N7hlwsWMJk4X1BzuxWl79Yi+
         YhVtywkqJttr/h7kR2N5mgP9WAN8C9DEs6KrlhcQiMWafeZsDC1BdnWLsm96H/Ya5zIg
         EzWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775417495; x=1776022295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
        b=lVCEwxReXi9mN7cmASayUr5PgOSdAvJhNeYBKcnYoLBzpIgT0TuwJ/Jk3k0JnGksn9
         LPLA3K3hqKAwZ1+Gu0W8fbUQE7/Wf/eIofzPngWRiYCxfRQ15HFeQRREpXcs19Fk93cS
         AtImrKZrFpPYme34oYo9XVkw75r/UkbvOYlYg1wBNtM3FO5qvq/+NCimsomC8oVNMQhG
         HJ4hnag0EWFRXm2UKFVOIWvh0vo0JDsJ36HGzINS6PP6/p0hnFvfoxrEyp/yKoUdQ2S1
         2aCnEvsZed/qapAswjf3R0CCMMgGqiQy+yh4skj1F+RIiBGvxzcCT1hKH5CAfAiCX/cX
         XvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775417495; x=1776022295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NE2biLOaCGqGSKm11Njp+ZmwyPkoVtMqAuCiMoTPLSM=;
        b=o8X/RFApXiaZRfldjgauBvfCGWfI/LQx4VFBqQwdVc4XhTahjxsnq49iriViWFD+kF
         VsN5QVWkgpEcCiR7kcBEqfCTomVdrs72zSWc+KP+TxwYQ2SC1rOeEYvv6P3lDJxzbD4C
         9mIOFsSU92p3FqT1uPwA2gwPE8Ztm5Q781JUTdqOd/40kC2WDbCjxEqtPVexChfWCd1T
         OJGgFrf3BJ5prV/CIsMAvyiZoekJ89yRhrv502nzsOLgvOD24zA8UCzuoRiNF1A18TOk
         0ZuMxH3YyWOIHxse4fLCY6VjPk3iN3Q5ZN8UIPynkVIz+YWeZ6yVMA+32o9AJ5TmaB82
         w9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUq1Yzhzi+m77NDf3PLiAxAmMjp0YlV9xGzCqA2j3MD4xD7suc35mJyt4TKh4Dnslr9hhxrZfFWoN00eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXnetkzdZtuHCPDs4l9FhZJeGJ/NbAVsJJYuE07+OohYEXTuW
	NiijwE1SfDXiM1I51tgqblkZmSWw/p+q66QisFzUQ2wVU3KhVJZbUwMGuyeSZ6lb6IYfo0lS6EG
	zjDxGT13wLa9BIg5VAAeS0OthAVQz1rE=
X-Gm-Gg: AeBDiet895bM44IA0pbs0EkZFRij6lYHE9jYvq4bkeqOAryzq5wZL1PpZK0BP4aXFju
	s4j7lZZsnZ7ThdkwGBUCH8HAHdMcBf1h3Ay+navt+EIbOtdVuLXzCaZ2HG0xwEBFeQqeKGsMrxi
	4UD9cDM9uXIsdkIloJOZb7egiw7zSfZTmJ760FUiI9HKJnAjL+k5b6Eo+Pu5bwxnwSAFL1aMYgu
	XZbwIDqV8rVbxyO41wxCm0patjlsb4931xttsFo9HmyLl/PqkZuiSxA/3e0utwpCBM09hnPWZog
	VESHrHouRIZOpBRE/3JWBBkeIK19kifEmsJwUuK4QHq3xFz0ie7IrNoOAL777KFSkEu/tZTzTN+
	pGXvGb7qMyxmTWV+7lo/1vBA=
X-Received: by 2002:a05:7300:aa8d:b0:2cb:cc20:1771 with SMTP id
 5a478bee46e88-2cbfdb8142amr2476120eec.7.1775417494698; Sun, 05 Apr 2026
 12:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-12-ojeda@kernel.org>
 <177508434445.73816.7873322235592463050.b4-review@b4>
In-Reply-To: <177508434445.73816.7873322235592463050.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Apr 2026 21:31:22 +0200
X-Gm-Features: AQROBzAFcfOg6EKctMXZNeC0mwP27xs6Xk4PYTGLQOlXdHdfwi1d9GtE-fAbfxA
Message-ID: <CANiq72k1U0JacHf9rEVhOMmeZ4szCPBhbfLxC1K_0a0cQPw6HA@mail.gmail.com>
Subject: Re: [PATCH 11/33] rust: alloc: simplify with `NonNull::add()` now
 that it is stable
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
> This description is inconsistent with the previous one which had
> citations for both the feature (function in this case) and the feature
> in which it became stable (available in this case). I don't prefer
> either style in particular, just that things are consistent.

Sure, I added a couple references. I think it is good to be consistent
(well, at least within a patch series, but I wouldn't say no to more
information even if it is inconsistent sometimes, especially across
different patch series, since everyone writes messages a bit
differently...).

Cheers,
Miguel
