Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF73242BD
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113958; cv=pass; b=XzuOAOhi21TN+cm+VRfw1T6fjpASoup8eCpKM/MnH3KwO9I09PVsYPP7K8OunFkc2R8j6f3yTG290HEuubcuqVuncwkx0QhFGvX6qs0Ucjw1nXhSifixNePFRQv0yJ38VjboldYSRmPTPmAvpo3zB8ORrY4ASx5X9o5Jkqn8ySM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113958; c=relaxed/simple;
	bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMRfSnOdn2OKRxI5OtGVxAN+PXnL3Jj8PzjKvPrbRmn3F87/6MTY5rcMKN91RWCrg429xNwugLqRnnr3i/Gcdxc+qqyf93d1D9QxSfltLaVTYplNuyn0QaoiQTvUAgqz3Iym0K4PW6uTjX6UnXV4/VpSNSSdFCfJ2sMDKLdMd8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rctgc0sm; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rctgc0sm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c5cf871adcso21694eec.1
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 00:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113957; cv=none;
        d=google.com; s=arc-20240605;
        b=WN3fKLjOFIsZI6gXaiXPHCwJfG3rqaMPELl+Uis8sinvE1m9bJFwOAb/2SwP+UFm2c
         RN2P6cgWG/DppATUaYXKnqPrJ8Tz0loaRc4Z7O85I94ltYeeQAYIGVYyHicltahT9Mi1
         DJX/uOLeb9pV0nNtpvD4SmzZv/4x9X6gBQ/VSnAE5xEzO9TUvftgzjpNgnG2xTlu0NGw
         SXwHAxgbEbIYevX2Rrp9uJqOSmblm2YF7mmWapCxfAn60Hkdpi17+T2NCSrGynBo+dqO
         WWT04Y5Dfr0NdPvCiaWXPh+tQAqK/URF5LHsrUslVkp6EoYa5pJ7nDiVOEayxHJSRkcH
         N/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
        fh=m72O/YSbK4IQmcEZm8GTmO5PX3yiB7LsfWQBX5rKNTU=;
        b=VkmlusZZMDcDqzPqVv9A9apDdjfc/uDCafTlN0wAuClmn/5xVIGjmlWLf10tgYV5Jf
         FHlUo5yuaYWFQKlWKGWZf9Xdriy01qQvR+P35xWBBM5Jp0LPoIrLK1eUTqyukoPwlQBs
         Wgp1Spep1dZowzDhvyMjBKYJj380S9mhsRc7F2XsF3dR7Tpl2bCBwJRNBF33xcodJSGc
         Gr7ClwFDVa23e5GLtF7vbhgcsUWKgPSYLgjK4bqRNLN+vswJSOp8nKsqnavav/N+U1k+
         4N1m0UtKXOFdJv5evWpevGbbQ3wyFD+4P4eGER05S7RsWELish/iaU9da1kLX/rQkkhB
         kMYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113957; x=1775718757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
        b=Rctgc0smJaz1L/DzT0w31Pkz2ioXDTbLbdLHju8I+MYH+TZcUE3kHlF1I3EWm1SyCh
         eQiNL6PiFdoKan04df3xcrWzktvgLtMghA82LhAy1WM8mvZxgLz1GSwI8XqGOCnMQ7YT
         2D1lyJ0uq3ZCMkSjEpGiGkD4H86zNRjQKPGPw6RpZfq6HwjQJWO20WsfP29oaR3kWllo
         UTeti7cU9wsmV9EetTySmlcHgqjE7xKikJY34Of/cFLLlkcsUWK4X7Vkycacqi4xDHHa
         3JLgo68Gh6qywE0saN37PiY4ogF+/E6JrqwZSKSReopxi6fjf65hPIDqvZnM7SCkNmQJ
         AROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113957; x=1775718757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KsNlup00ToveqB7aTUYVDBzpUNHd54qGWP+GbDHjCc=;
        b=rcKRoWeoywPzwLoBviEzWY1HAspY/6/KH1O6/yksv1MmrHGkbiJg0bkX1Y/nhNfUc7
         yTcf1AqShoI9rgBL+MjEHPHTRgqhA+bwJqMXIHUE6bjLk714OlgI6jD51CacZ19D4V/G
         Wh02GXAwJ+XeJKkEH7tKyqtsivmnFke1Zb3W0rIf55YNArTS0rsWgn7+QohUBJ8BRjqL
         9I1moPm1cuV/7/boZFL4AMLTA/GwUB/Xrx35dQ1HLO10UCrJpl3wm2oEO+rZB+JZNi63
         uADDWZGAOGKcmA9vw28i67deiJA2dI0LnomORH1EimPI/27kbHYLj+TyhQsopfsQeUnG
         10Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWPXEoG3BYzNgz4OxRJCH9B9SrnzAy7TzN8IhDETPyGFim7APMd3JUkrWL9a6t17y2e0fljwgp4ptplaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3gcKBPzciijQvhVbIMcS/r5DUe5hGCs0WIA+XQ2o4+vfWDr1
	OOPiwhzWQc4IegynG7iZOjwF7V41mPb4guhS0Qq2uR6sJdU+S5+O+g5liI6/PoOIz1Uf/EkWzq9
	yoEaQLuRQm6TgaveIMWx06fUrC05BEKI=
X-Gm-Gg: ATEYQzwAfov1kLYX7Ent9i4t7IO7dR+5Tx9PZOMEoSoTkOO5cQujs9NnEt1lgpXqzx6
	80xH3kR+9YNx4EUUvfHl1KGKXrSjCQZxL5iXdEuLk3cpS4uFhDYX4PIiSYegOApJvslKYTiZMnc
	ryesugVItiyoLX+oZpqqm35UOkaq6xxDcHZRBhxeOVy3mVyNiQb4hdFhGnHQX22vnAExOtHX6H9
	BZZcJlmlxyJuxRMJPRbHLF9Oz7/JO+I3/eM7TVV3TcMl8pwWCnjh8kgw5ZHYybmsKvGJH0dpnR0
	ccMqAIDVL47USpbRyzG+FUmByGdUhqLka07QKyA9n980FKq5DRlM0FBTnA96xGSYPVZldRuh3pZ
	DCGNOzBzdaQDnwbr51SaKoZI=
X-Received: by 2002:a05:7301:6790:b0:2c1:6416:2a07 with SMTP id
 5a478bee46e88-2c9321b7bf4mr1634311eec.4.1775113956496; Thu, 02 Apr 2026
 00:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org> <20260401114540.30108-16-ojeda@kernel.org>
 <DHHWO582XLXH.1DU3CO41F1PV7@garyguo.net>
In-Reply-To: <DHHWO582XLXH.1DU3CO41F1PV7@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Apr 2026 09:12:22 +0200
X-Gm-Features: AQROBzDaEWueCbjTzytnJo43NDIAkvyWYngeEqQLnAsLh-4PZJOJIJpad43tD2c
Message-ID: <CANiq72n4sCU=2m4Uee8Wpsv3mjkw_BuT8Sg54Gu0U68j7qAM5A@mail.gmail.com>
Subject: Re: [PATCH 15/33] rust: rust_is_available: remove warning for
 0.66.[01] buggy versions
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:58=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> The scripts/rust_is_available.sh change looks correct to me, although I c=
ouldn't
> get scripts/rust_is_available_test.py to run on NixOS.
>
> Looks like it filtered out PATH but uses /usr/bin/env to find python bina=
ry? For
> obvious reasons that will only work if python is located /usr/bin/python.

Yeah, the script has some assumptions on it (e.g. it also assumes
`dash` behavior vs. `bash` in a couple tests which I should relax
too). Happy to change that.

Thanks for testing it :)

Cheers,
Miguel
