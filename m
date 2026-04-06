Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6F385535
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486289; cv=pass; b=TI+sSErEWk8twzUEpq2rHpq2En44a5oHvWCcwvAbS402GctI3v7/vpMJ5Ni+N/TL6EFtL8HtaTJuz5gqh9QtyBd2YC8LvJBCoNsOH0iGKpZw5uUGvrFVREjE+nIEjchd61+Ubah84xC+iAlvUutSsTGliCGwwhesyUp/X+5tPoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486289; c=relaxed/simple;
	bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hok8C0cBMrC5Y2sFN4BgVnzCZ8dkkzjuN4S17vW0Oclku6EbWyySre+y39/J3uVzdsFLvehGTTT++fie1fWkW0Q9PWQIwIoEI6jyu9KW6yT5uKn7GozM7r6ig48lvS0rwJ4uFYuLO7+Z7/fQGGqYYjmBeeXP2zZZXgpQe4l6jW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgwhN/LO; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgwhN/LO"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2cad171900dso222614eec.0
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 07:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775486284; cv=none;
        d=google.com; s=arc-20240605;
        b=C+ImBIRePwskx6g/CnuBF5a/K6m3jabgk4oPO/PBbVJQHsPr3lPJrnk7vSBPvEIozc
         Zc5Q+CU20oM9Tjsaq/up0hkmEoArYBankLmh9o7FbMIexcJ+jYhrX8QXsOw8l0LpG5de
         hGt25S40oPOvQd7Oc9qkP5LTmULgHZnRZrOM8AYoM9U4tH/2l36A+dKIPcXyTjvbySHA
         Y44lKt0ieUs5acPtAqFYLvKJDaqwLJ8q4FQbwdaur3ufG1NwnE3Dysk+0+NXf/AyFVT1
         vAnHobqoreXMCcngG4L7hbJNR+a7PNq5MQoe6ydbB6AQEoaj4GEdE1h/GKnMXq+x/MYy
         /+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
        fh=zUFt7BiSkQ/E1YSe/mpC7WBx0sawGxeQy8eBnaZNq6s=;
        b=iLlHXyHInoV5qYUW3FhBu+yiKpMBtG2PbWvKghQURBsQCkBPMsKeTnbenszogU90/k
         Yt5CWPTh+jCturm1t4m7JP69L9soAm1cev26hGj/QjLQhLpmG+HyL/YmelvOQxaZOb/Z
         uG0YiDz9t+fw7Do85rklGQJXWnXbIpD5maVo7SXb7E5AcS4DGxuYdisP/3UCFjT28Tdo
         2N+CMcNl1Ot/pDOozYhoSMQyAXnA80Xy3pR63vDods361Tbt29zFPA9jaXp+koF7SAQv
         NyN25t0pZe/DjchbcnoQkh3gN8l6IQrEw/ngT8g5iVgVFBjp5HUQxovi2qpNIUcKZ4K4
         nSBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775486284; x=1776091084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
        b=jgwhN/LOCRUuz5UtuAxbMF3jgJnFp6nKylfYyZFBTJc1ux/cteBqbZhrHUpd0SVrJ6
         9hhlLqqaYpY1c0QaNN6MWPPAIwh5+uX2vnAa59YCd3Q2Ao03JARshIQClxScR2gU23q6
         1Yi78Tqo3Y4/iAxKQ+p+X62sVoaB+OFZJCt2n+9UhA+AY6ZbTDd1LWJ9E3QbIJgzyByS
         8zBdW1BmZbAb+cnapbsOd4q15lxIceJHUjgfEn/NiAWrxrT0gr1mHOyFTsaOq+RvDLti
         a6G+lGC7X5xWVSu975ZjophQliZNveh4HFzgRC1AO8zyzB4RALb+QOAALbUrIIiMWMGm
         AnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486284; x=1776091084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIhNt0MJcuiCREyJL4elAnSUfXIEbP8C+cm2AS/TYZc=;
        b=LLULvJnG4i22ASaSmkTksZL1j4j7+Ke41fZUM3WbJeiRE0Cu3Rer1EQRy9n0Taptgy
         UL6HbWD+YkBhuSAPVjIuWItj4SOYsM+CRi8C8PzHtbROfAPhgqHF8JLaRhM86tBMATw3
         m6bAFY8yY5Haujn2TxAwKdOgFQDbrjGcK77sSCI2uL6ErO/e9OmLebw2bh0wqGAW9X7a
         yaRY+HT1Hgm791mVVsHI5TD24H/6v/GXUSfAWSnrWdAnKHIueac84OizM9JaygO/kYvO
         XqDtuXMizbAYWE31/LcJjNsK/mRT4Rg+sU3qMOH2wyZ/z6lphkCvdJtd4Wn/0tpMLYba
         41vg==
X-Forwarded-Encrypted: i=1; AJvYcCWytBDIj5bo+R4q0WhRXnrRXjtM+YZHe2mkCOdY9QuHRJvmT/kya/ynyLgmO62c+3be6KcGyXsGjYNIKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JhSRd3FPOMp9nnI062N5Sx+T0CH1+UBMv2KRO5W0GSoMb0Yb
	S26rzj3P6UAZvJvJH1HMTEwRyUIWAjh4o9hrjqWtkeQHiAk7YoaNgXdpU9WFaQJ1invdoedOSL3
	/wfeACZPk5mywK74iczL8KfIUl3WGU8g=
X-Gm-Gg: AeBDiesSCOWmkpY/gkTfuXeRdOmOJRQanjPwzypt9JhFEvkSXfNx14dEiCFk1tRCKOP
	6XlzILvSVgarzrPDryIZclXPWaYobANYAVlFb88+ke7xYbKoVVCI1Od2rZ+GYtuIZ9XYwqcrW52
	7aiNrhvu9Uwwm/5yTfqt8bZDRxyII0432r4LpHBOINqT121bu2HNWWWBBK1QciRBVrVyERnFMn2
	YvsKO7OhhmmYqE/WbVIhxApcfTKmZ7NQpmNyUdCseBlOK57Qip1Ni9WYCNPNQYnKq0recHne+xK
	h1pn4mzod2/b8q4jdxQKltom+Z1xTDQk2GHNf7IL9EYhUWmCSUwsYzefrT71s+RSlPzGz7584c1
	58WfYq5/ZnAdd57efnKsJQd1JUCJD0ipx3A==
X-Received: by 2002:a05:693c:2c06:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2cbfbc7d828mr3020598eec.3.1775486284289; Mon, 06 Apr 2026
 07:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org> <20260405235309.418950-8-ojeda@kernel.org>
 <177548573697.95472.13544191227699996309.b4-review@b4>
In-Reply-To: <177548573697.95472.13544191227699996309.b4-review@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Apr 2026 16:37:52 +0200
X-Gm-Features: AQROBzAshONAZRL6Bf4qdEX94VdiVWUdtgExWPcnxvz_Z_wjuLZH7VazFmpsU7M
Message-ID: <CANiq72ne_JYPodnROckyNto10ZF0PqadRxSrng5-mZyqVovxFg@mail.gmail.com>
Subject: Re: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
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

On Mon, Apr 6, 2026 at 4:29=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Could you add a reference to the upstream bug report [0] here?

Of course, thanks for the tags!

Cheers,
Miguel
