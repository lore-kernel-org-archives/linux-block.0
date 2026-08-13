Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4D43B6F0
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615460; cv=pass; b=J+yHeJUgMw+93aKho3sFgTH3LGf7Svf043PCr6czANHON6qCj30ykyVlVYn4RVPLVrob1i6QXCjNgvncDhg9aoGB3f9lpFpd7Xb+aLNclT2cUZJnvIpzXw+ivT14sDVTqBqAlekVDL9Lv+WHVxvj7Y+USxMcw4nVkmMiNcvx45Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615460; c=relaxed/simple;
	bh=izncAFina5udvh82qhiR9A/Ymo2QgJMmGzIkcJM+wME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPt/JDmOpuphN+WdZ5bULvCYWwAgrywjveQ/15n4mqr/efTmS6RoSggsZpOZtDkhxVHjOFYzzWQqx5eJD3hqN8zMW0zPicgqE1L6/l3fR6/vrA1ndW02N6wgw5ama0hzQhP7KLGugne6a7seEikluhcUaYPHjdNhKnW6unPJyPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFHTrXRV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHTrXRV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d027b7c8easo4319765ad.3
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 03:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615457; cv=none;
        d=google.com; s=arc-20260327;
        b=oDeQn4jfN3Tz1StRRkaxprR8yE2zuQTPiLu5TQKDCFkUkYTvngfbVN9/S4dWf4kSYi
         eYMlPOvGFxakFcXamyYG4aDvnAViR95akOGJm3qrF8g+xiQb0FAY05HX486kewHoL6Ju
         Z91fGiP9prkYFMSdUXf6MeNSN/uQWzKY/OLdU591vY+zYq7siHjMZtOxFxXT6a3tk74N
         jhRJXq/3qGXAVvZRk+KCpkjzMMMQurBtzVzNZL9u42P+blPe+MvglpFAeHIZAhgIthxJ
         7fUc98GO+qjpM9cj0xZxGLhm8cuySce2+GJ5rLCAKHwo25bFF/ayfyzRKmPpD6t6iC/1
         mmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        fh=FYsD1e68WiNlfRtkgqKzklgu3U/lYzD+tD0wQKXHKGQ=;
        b=qSOtlUvznR0787UFSad+5ua3EGhQ9DMOIjrrZ7SlrRaXdjcW/l81GxoK1CesJHO8s3
         QpQOHGjUapVT7tZgTqvMKbrdPKdeuESL7Umok7YAOa12dA+lV5SKH+0Uh+ZstF9bNOw/
         hBac1WNUOn4TOtSmCnTvxvMwLC+qt2KDxlvWWMURD1vtaLRUoaoWfd9Ih+VGgmY9PSYo
         XtU3SwIavjXwsQaozsfhHP0Q0ITi/LXNfYPbdPQuYtsopc5+cduxodnh0cMVxL55Tdy4
         q0Sz2uqQUF6wbZLEuqs6ok6zn8yoxApD/DEQY7bLzew8QX3nzArUsLBwyRD+srmPq4fd
         0yOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615457; x=1787220257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=NFHTrXRVpZQTifaiiAeRhSGvfW/dP05MC4U1EuRQWVJr10hfFTND65+3+8jb93NkKj
         pyVgNvfrsAHjJCQSlBnv74kIuyAGwTSHOr/dBTUV0FlXohKVfuehKEUbu+Xe3QIPOuZT
         xyYOmMs01ckolTS4zDf1GolYHoz54YaFz1+Jivey5iRPUdra7EMw9Z/AYpSZUXI96EKd
         3/FfoMhZEcw+UBCPoCbiwXXB7S4RQ9x13SiLR20aVLYVohDLsUPCpyg8prA+dVsmLDAw
         h9GzD11ijNfTClaEZMVLRNH9dpACZ2webaPItG2U1BR+OiDQwMwbfXeiDxCLD+bWtAte
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615457; x=1787220257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=oxzeMklC2Wja7DazWHiH4FmtbaTDWdSXWI8xgzQjw/BAiffVKW/FZIQMXCfDwpuPQk
         BdAhcdWryHr934unMDbzeGEXhYzBzwrbRFNb4ejiOT4FQUjTL6D6w3aIAi6Qpcq38bu3
         JeF2RZeho3aDCK//CzEcLcPQUEuhgRzwMsLvsITzxj/tj5pUaaSZRQcdZYj1bjN2x9GR
         gcxPZFB6N4d6T9+myGEMM4zMRu5frd1hzRvmTm4u5JdmUiDx2QuCEADAMsiGEeK2HkGa
         kusjZIYIPkhappklYMuAFFKWotWacH5dNRRipBp5HII5NfbM7u9d/syiywsbhDREM1lq
         S4aA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1QaGI1na2LTMsQArEqfdtC+8JNNiKDo99MNkVt0PNIoRdUXdq1LrpWdJWOdePaFdGjidznWCaeVC4/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOGWWVF2sqGNVWc26LD+hL+QnuHWZyhleXN4U1uHJXLN0/wgx
	8UjLOnqHVMQOeU+MBXVLmsKNsAFA9av+UwgnrsCd4GlmDJ5ShiD3iV0aIjRDEtPgXvCahnwfnjp
	6GpldTbgGRniiBi289ziziMxioU5pIXQ=
X-Gm-Gg: AR+sD126P/SE3TMzza9dZeI0Cb3MMu2nqeXUaA/nKfmBVFmA573wutDi+MCxA8Mga8b
	6QfU799gunIPcXF1GHqwElnuoJ0wDw60mesa/xnAn5x/OtNuX3kH1ME0j4uS65jSBh9G0A5bfzd
	4s3rqthi15+fQXIPIMF4li5TX7/1nq0J4HDyVSdIK+jYhWWyHsGjB8sjwAkv1y+Q6rUMyRjIQrO
	/qRNXwaB3sOqxXP/99o9cX2Zo4Yo8wBSwY7ldwSoSlqdd9ljdA4twdSWlpCZgbJZO2iIjDh9F68
	K0xipO1uKt/uszvUf3oUvFEYmQcBNGOT+CyPPorCQ+SbXEbdF+JLX5pB40Sqhgeuw/ZHTJHL9jt
	YvQs2GmGfke2dUBUygm4NK8RuuJDVE1rXufM2rs5asds2qS2qiSMg71HU5ZVY
X-Received: by 2002:a17:903:19e6:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d389b61bdemr35547795ad.3.1786615457444; Thu, 13 Aug 2026
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 12:04:04 +0200
X-Gm-Features: AUfX_mxe0Lg9da-FioFXEgvJltaWUVJqtXi0b-R5y4sq5pbip1KqobICrYsDddk
Message-ID: <CANiq72=Whd+u0cA88++KyeOQQrsBK+NqK-586jNX7L=_Ocixrw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Thu, Aug 13, 2026 at 11:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:
>
>   ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
> `#[vtable]` `impl`s")

We also need an `allow(dead_code)` until we actually use it
unconditionally: a2595ed13816 instead.

Cheers,
Miguel
