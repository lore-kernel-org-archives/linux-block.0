Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708653F9F5D
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358847; cv=pass; b=uflG93drM09uVmaOKFyPsD9AsMZdGm1pKUAWNZsxHjGI8w0SEIhs7TZ6Qyzy6SHxf2onIa3Fc9tIaFK4bzqAkOMpWDlvHIcuJWC+27cONoFYWhecsE/MeZ0iOUgaWoDaz7BoFqik3QQm5T1u7cCePhhm1AeZGGBUdUf1FPg7Y8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358847; c=relaxed/simple;
	bh=BINvtLCBAGvMj9bi2l2TPbrC05xIHlcYiDwfuMX07iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IR4yhUDTAS0axiOxsKKCSJ5wf+/zwbtiWBQIXc0D/yLN7OGaYsANgDprmxTcMFl4JtDhIoKFPjNMz53hXBXaXjPZZve/XYxoM7wOE2lyqXU2N/TfVKVo3kcyzpvvYGBBm39B7X/yKF1ZC/aCEnVT6QmDUuD3Dg/vzg5Go0Mu/wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9fBPQsZ; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9fBPQsZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b9b190easo1054945f8f.2
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 06:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358844; cv=none;
        d=google.com; s=arc-20240605;
        b=X2tHXwtGBzr2yl3EXNH6LPtKJtqwyYW4MH369+bspDSFS4XQy/pnvSUuL1I1z7TH+R
         yXRaBEfZsQWeJeept7Fu0WgOjzJRVaTnFL3cHgRHieNAztxSQR99lttAbWAFDe0AmOsT
         nK0/ExfXlKtQxurPqYy2qxgaftAA3RNTZog2stBNcP704L5hR22iMcaAG1kafVxTUHIg
         2Gz1/EFxdYeWwlN+L8VeZTs3IQTfn1ttqHn35TABmxehbrKqfC7i+VG/2Cl9875Kb5LQ
         y1NpyamJAvVZYSYhgM4A2rO/3NAui1z470jiPP5lq6JzItTTi077ihF4BFGxHBK9isf4
         PtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAVyjs7BfIwZAVkKntYRgyhMAqaKjTB8tChCQpQIM34=;
        fh=2HR9Cc/+1by+NvNRCVCWISuATEPTeqa787LQNuOpEw0=;
        b=iSeh7Vp2Fcpu7bqk/IobRPVmwvm9QoHmCzyShM0FXOcdoSQ6LkjE9+8l8M7t+gATTw
         7JUcDOaHqosIy9t5KsC47dCQ60HilEPdnw6ZzNP2M+NnWGnGzXezy/hv6ys2wTgHKJgs
         xV4mbVe3dOa3DQj3AbH7ngeYeAEpurCw9AGbGP1eZR+gM2CribsTv5wK1RixQ52EnHz2
         rUUYXCoIzEWvkEi4ax9rfLn12JPT+BaKrftJ03mTiUBnvCN6WNx8zslxczYEPF9JwvzZ
         9bYGHS2xEbYhxPlaFBzv7IGhiRfsXKsv/zDkUNWnwqK+P3R6L91R7UnnYBnS6SOv/Sns
         8esQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774358844; x=1774963644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAVyjs7BfIwZAVkKntYRgyhMAqaKjTB8tChCQpQIM34=;
        b=M9fBPQsZveGYCeu10Ws6GLTLa4NAnHq+4iJ07uU1vh9wqScY82fk5yvHMMEZu3aOtH
         2aNITIVWbnXgvkVARTlH3+kxJcxqohG6+JHP42LkHPjOurBik1WF/P33E9im8ltLlRGD
         1uC7eg8mDxL5nFnQjUdcBkurUWT9T3bgkTPI2l5Dg49OahMmze2rWHWLxguevDDhKoez
         nDkCGxblurLhlcaYByA5p6wQWKEvVKN6sEimcuBE7NfdtnQjaRjcU0XfXnKKlaFbeRsF
         6hDjgrXJOdVWfK/A1Kp96nQC5oyhiJYr8hZa5QwkqEk6Fh1ZtoOd8OcR0nDIcZWa/rOz
         O5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358844; x=1774963644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAVyjs7BfIwZAVkKntYRgyhMAqaKjTB8tChCQpQIM34=;
        b=CkPo+Oca79Md3XEuIM1M2qxCoMVzZ6uNMx+O8knWeSw31bqni8QpUEQSakbDZQIYGP
         oq+X+vrJERwRGCBZZf5Tzy5s93zmhsiBWPcWOiwWdzNzpWRlN++Bn2WtBgH1hBPMt0qS
         mAVebaF7hX+5o+53g6i7w9D1l+8ew9FvEZBLlz9UMIy/W5NnlcVYYkaZK7gtwek77edl
         82XDqFBeBg1A3SYR7dvpUPxHkLeoQPsI8icvmO1YXPVLcYJO6JbnF8f9o/ox0f0WHh0o
         BU24AFOA8zbsD/O6no42/YysgMPxHi1nMtYeEH3Y8pCWNStlYz9jEYWpt9tEANqGonox
         iCBw==
X-Forwarded-Encrypted: i=1; AJvYcCVi17YGbJvugsk5metEsrd/Ul/QajcOMMnydZPSBkkIzOWEum0QodxpR12eAh6LQWpXsv5axabeJQmg8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOT+6Oet9izKnQT5lS8IRihDVXGFKDJBilBJoO9sxbewfp/KPV
	7Xo41uXDc9k4kCI8epwtV0l/316c2mDMRSywInwQSvqlHIbDcSHM2YxDC85lDxWEEyxpkpVtk4o
	OZUCjHKeioKJCsykqofl/01rItRXI4XZojiLeaFiN
X-Gm-Gg: ATEYQzxwzUiKP77jsUBx93ITPFdWJbUFkGOYTu1y1pq8iJgJOSuJ4dQjS6MdpBGxSIs
	4eETtaAYywP76a0NSqw4XTeY7GXR3YMAMKmtH6ZRTP5g92tFgzwMKY/Bz0aIP1SUBeH1fB8u0wz
	iv7NiK8s2aSmQCSzjKeMyB1PyXnr1GDavKPIQ2zyu5ELBX9I4fpXAqjEs9BDxsXE/KW72eLL2cm
	gyuZCUccMsJUj9Qas13swqHBsG702Uwa3g8fmgNccPJYhL7/oKhu3mdNpqNue4CLKDFZhJDLgdb
	uc/pL/ShahMoJOJRoLefDrb5aRMSTTnAR/oGZNF7GOOdGGRA
X-Received: by 2002:a5d:5d82:0:b0:439:b3ff:9ab9 with SMTP id
 ffacd0b85a97d-43b642919b2mr25933211f8f.48.1774358843215; Tue, 24 Mar 2026
 06:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
 <20260216-rnull-v6-19-rc5-send-v1-5-de9a7af4b469@kernel.org>
 <abfU_itQLa4jDy5L@google.com> <87ikamrbo7.fsf@kernel.org>
In-Reply-To: <87ikamrbo7.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 24 Mar 2026 14:27:10 +0100
X-Gm-Features: AQROBzDq-YxIP2yXojVICe3lT7Gw23jBxgQOd3OOjRsR5pVnUNgTkbDxmHX_7ss
Message-ID: <CAH5fLggq-1pReNsRtgRfm0Y_PiQvUsXbMMkPkyO9kuhqzB3wrA@mail.gmail.com>
Subject: Re: [PATCH 05/79] block: rust: change `queue_rq` request type to `Owned`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:08=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Mon, Feb 16, 2026 at 12:34:52AM +0100, Andreas Hindborg wrote:
> >> Simplify the reference counting scheme for `Request` from 4 states to =
3
> >> states. This is achieved by coalescing the zero state between block la=
yer
> >> owned and uniquely owned by driver.
> >>
> >> Implement `Ownable` for `Request` and deliver `Request` to drivers as
> >> `Owned<Request>`. In this process:
> >>
> >>  - Move uniqueness assertions out of `rnull` as these are now guarante=
ed by
> >>    the `Owned` type.
> >>  - Move `start_unchecked`, `try_set_end` and `end_ok` from `Request` t=
o
> >>    `Owned<Request>`, relying on type invariant for uniqueness.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > It would be a lot cleaner if we could implement HrTimerPointer for
> > Owned<Request> and entirely get rid of the refcount in request so we
> > don't need ARef<Request> at all.
> >
> > Is there a reason we *need* ARef here?
>
> There is. Real drivers will need to dma map the data buffers in
>  `Request` to a device. This requires taking a reference on the pages to
>  be mapped, which in turn requires taking a reference on the `Request`.
>
> We could split up the reference counts into multiple fields, but that
> would be less efficient.

So how exactly is the refcount used here? Can you elaborate?

With regards to the Owned series, I still think we should split it up
so that the patches making ARef+Owned work like Arc/UniqueArc is
separate follow-up series.

Alice
