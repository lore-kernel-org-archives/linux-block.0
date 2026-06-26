Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FA3FC5CB
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495705; cv=pass; b=RncBXI6zP2rkzq/6oYrYKRR8s2XX5FPXiW/lmbl6ZG3YRVHEFcpK80m6jYRZ8flYagpYndTRRnAgypjF95Nrek3p7jp9pqE2tUMHRf75IEbwhRL46zysx3ps6acRAp7hhUi+FsilcbEIPis5mBscoLTupr0dQgZgtuitAEw7wSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495705; c=relaxed/simple;
	bh=+DzHSnD7L/2m4CSZY2dtwDB/ltwkTOioXrGGOZwG6BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C72WwQVusRsm8rvTpFD+WGoX8bpZgoCuJCRL2hpMaEjcvlv6mZ8MXpif1o7BCnxF1c7yCXY+ed87gQDNCt76BDgofFV7bQQ6mFE8bsyKyr3SuP1MYYoioP2qd7l8w1OmATruuFSpDRhCmuOvPWXG03l5+v/w3HaVTg4s5cZMY8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i57gKkNT; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i57gKkNT"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6da33a561so813517a34.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 10:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782495703; cv=none;
        d=google.com; s=arc-20260327;
        b=Trm9vXO+2fHk1zjjoPeRjrSXv7kFtBXkOweYevhw5NqEsG33/4gE12ATUMtTyq9rFl
         Gy4F1ewRWyWy4lEtXa2wTKoGlNhJ5QAvhkxiEz45DlzSWA5uj6sc8QDK1PDXkWrQAzvD
         V8Hn+LaJpV4JVORtF+m70fb/qr3kxOWbKAj/lHUZixUziZ6cciodvDdbFbziT4UgW3w9
         xOV8fDqTXUvV7LugwtMfwA5B33ofr/7QAg/atQ3zMHVJ7DCJXcw+3ZmNar/RyFuLIqnM
         noefA7fryonFw1xR7bm7Sy3i35X6H5PVqG8rhGPXQxg5JuWiUz5VChqkz0aEv1EFO10C
         hD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLP12Tvnhxz7EW5GQyhj6jTfDrZDZZGaLiZTc/gpe80=;
        fh=Sz+70bOhiLV0I9r6kwGqC50OdsqBA2snWVQcQso81i0=;
        b=pgRS8U/4YuO3re/XEC4OnQjNeORvfrToaCSBqa332Rqv3Ds2gaeGiuIsbOkZeTJaPJ
         7dgqNAqvlOQQqydqAE+ony37OWRdFjeCDEg0xBog3UDsBl9KhO3zTlyyPBezPRAkr2Iw
         qJ4y69LF0beLeGH71I1tfRKRCWLispwTOVGgJu9SnY6yG0S4fezSQzKzuGjy3+Wm+lLz
         gqefsQX1FtWife7f4oYEFzArKFiF7Ec3R8OQoVg5hv5b0gj0c0YxlMHwod9o6cutE40S
         eF/wZEYMSYYVh3oDVg46tWGlgHbkl68bkWIIUfUJkcBej9kMP/zx1pQOUfRosR4zckSd
         kfCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782495703; x=1783100503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLP12Tvnhxz7EW5GQyhj6jTfDrZDZZGaLiZTc/gpe80=;
        b=i57gKkNT89d/h+0LuC1KM2iKcNwqve++3cOqCTY2hxWkTsF/l+7lObCn+8xtmFANKu
         8n+HwL0kU9/AoEL/2ii/ho6eQQlL16cIhmdSUt6IcBfA3bC1EeQ42ujOyG6L1C5I7z/k
         sg9TX03rRjfiHCU6Q83kOOIuo4uVTA7QSErAIG+R3B7LtnhXlRqdNlLXMiwNmMpPzX7k
         hNJPP9xFdzGU4ZUxVamFuioZMfCr7CmrbqLNGhuYvgB/g+wGs7tgcdiVLR/6c9ZqxWBO
         GLO6BCxqIz2/IfKl7MtrfFmdsD3lSK/XlXsSRZ8apuBmifHPeUSerZatt2jcrgnDL9mS
         nV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495703; x=1783100503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLP12Tvnhxz7EW5GQyhj6jTfDrZDZZGaLiZTc/gpe80=;
        b=i/11TzsN6459taIaPROH/u2oVLvIx2UOXQX03sSB2Cyjy9zkPa+UHWmAxGXn6FzlH4
         Y5FvtodftBXso3s36k66YVWdjvnYIlH5C/hiCjTfChzxaf9g+GpEDxV5krV1EjTbEn08
         RHsAY6xY6z0gQRLFoTaO11gGYmAdHeADZEg+dv85iQ3lVWYOOjFDxQ8uk+kWgQUoQgzq
         jX7x6tiHAIw2TNbGBTOHffXw0VuU8uB+yAItuiGgE9hALTegVpVGK2hqlc7sc/ro0uW6
         Qw9QKx2AXdI541V3azcCgGrGLPa3P+DvamraV02yjCzRQJWizdYkBjMkG+KzU6u3M17l
         4Eag==
X-Forwarded-Encrypted: i=1; AFNElJ+lNbdihHNUk+lNynD3hZZMZFaB5rxcGUCrfXRlaeXMpu7VMeHLUEpWqV6M2aQPHNQ0tOEaJWL7xIBx0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7k9Jefpv8oWoF44OWNIL5elcUWiAi8Jgt3vm3Jx80l0NfG9UG
	47P4EDY2K9UDOixDn09QcMBCtO/ksIkksdZDREhbajfavgEMeR+a0N3EgqnAcjOtAXaP41pevvt
	3hfN9TSDEaiS+71Osn5twrU45i+2fisQ=
X-Gm-Gg: AfdE7ckSO5get9HdEFkR3qOa+9ImquCNA3NbBLnpgKDFIZ/QgewLt6FGFmDn2vehfpS
	8Y5z0Hu5OPmBDERc52QhiBf/dsKleyRvUQEsCSuhk9PWXWzPx4HTZiYHPGTCbPgAgDHyz5w/+19
	vQXVDxLBnBwvlQhnJDBpAEe/RQFEW41HJhs4IM7otGle/qjUUPBIC0nFp/g8aDaZp4cnoPPbNnm
	SBdV8ohEkGvRYQiRDB1qLWFpmkA93bX+m8ZaJGuvYr8xeGNB/LuOe0Rjlf4hMo1bLnOiRQHRQWO
	IeI1bdLHq652uubredNeavZu2qAJU2msus3SR4M9y8an6OjEyTIJ/f72oTsBf5/0esGBfjtDnIo
	5n4/niVrrt826WRFOKVAjri3J
X-Received: by 2002:a05:6820:a0a:b0:6a1:50eb:d520 with SMTP id
 006d021491bc7-6a150ebe0e1mr877474eaf.65.1782495703089; Fri, 26 Jun 2026
 10:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org> <20260609-rnull-v6-19-rc5-send-v2-10-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-10-82c7404542e2@kernel.org>
From: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Date: Sat, 27 Jun 2026 02:41:32 +0900
X-Gm-Features: AVVi8CdvARASe7Bopjeo_gHK1uUJA3mCPHieQrToP-jIjvw3vAaNLMrYIkVgFqI
Message-ID: <CAGAB667mVuECQDwYDij5PcZ-fvqr-6womuRCHibrwiR_wP=YDg@mail.gmail.com>
Subject: Re: [PATCH v2 10/83] block: rust: allow `hrtimer::Timer` in `RequestData`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:23, A=
ndreas Hindborg <a.hindborg@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

> +    fn cancel(&mut self) -> bool {
> +        let request_data_ptr =3D &self.inner.wrapper_ref().data as *cons=
t T::RequestData;

I think this trips clippy::ref_as_ptr, which is enabled in the top-level
Makefile (-Wclippy::ref_as_ptr), so `make CLIPPY=3D1` fails here under
CONFIG_RUST_WERROR. IMO core::ptr::from_ref() would read better.

> +        let pdu_ptr =3D self.data_ref() as *const T::RequestData;

Same here, I'd go with:

    let pdu_ptr =3D core::ptr::from_ref(self.data_ref());

I applied both changes on top of rnull-v7.1-rc2 and `make CLIPPY=3D1` passe=
s
cleanly here (the two ref_as_ptr errors go away, no new warnings).

Best regards,
SeungJong Ha

---
I'm not a regular reviewer for this subsystem =E2=80=94 I just ran into thi=
s while
building your rnull tree with clippy. Let me know if drive-by notes like th=
is
aren't the right fit here.
