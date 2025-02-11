Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E181D63D2
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292666; cv=none; b=jA7/OQq/Rn785gi5AVd5I7bn5jQJpn6HNRx9swLcQbkLQVVFk/i8OxRCMEUgm5DWKsq16vMad4uo8PFn7sPztxGg+OxjRs/m2JhYalHwsW2uoPweT1g/kLHfnGDt6CJmUtLZnoB4L9GRWXuGpVfMBpWDTXYrNuLlRJZrhjvWseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292666; c=relaxed/simple;
	bh=nlc9058a3V6MJpYn+sPPU8t1IG50HtICtCAlsTCuFeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHsjq763HxjYpnfKiCbSGMumIDeDAo6FMEHRp3xYSXJ5fVf3Y5W+GQup1c5r4Zy9va4Cd0VeJORWPsWDqXjoQ1Bmp8ESAYBnYqIfFqoTKd4KGOB/kbVAaHhp5RYRdXCSE9vz3ARr39iFi/O4zR1JiulqEX238dFGL/D/HL9lotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlYNawNm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlYNawNm"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f9bb24d033so35896367b3.0
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292664; x=1739897464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlc9058a3V6MJpYn+sPPU8t1IG50HtICtCAlsTCuFeM=;
        b=nlYNawNmmrxGypwW6BOyZ4QsNKo2Ud4HhprvcyvibboKuk6RUguR/wsxNdfiDL3Y8/
         hpfFE17nOVU6c/NZlnJmJOHsR1npFB9zNGHEQRUI5BGKUMA7iMRMP8dy36VtxeR/4iCW
         ld9UhQhOiva+mOu5YIV4CgKzWVuMLS16bUQBbymzYamNx5WtuJf6dsECa4yvV3lA9bsf
         fj6016Qq97epEAsFKu0jymqNbTP1sKlPplJd4sE/ZA5T5oGdFQh/I9hStZsV1V2S8QdC
         xx5elUSr1sTnkhh9OH62qXznUe8cpM/f98on27eLDPXwCbw1n92KaYYL/y5sKaTWJfxX
         enqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292664; x=1739897464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlc9058a3V6MJpYn+sPPU8t1IG50HtICtCAlsTCuFeM=;
        b=qiAo2awYpABSrZKxJfCqRyeUXnZgtZEcvi037/0MqMAIFpxRPugz2+RsnnrlQYiIeh
         fQZqyYlydaN0x9zf7/z714fjB8nhniq80o9/kNlrSNfruwYCMn/i+GIyAeaYLxwAj4gC
         1d6v8EQ9lUeSF4mGRpGB/4lHMKQMNdBjxC5Ykih5ljWV79OsynSTdJN14cLdNi/Fw3ze
         bPw16bdOU2cxq5VDXZ2qZOrN1YVEjq+kyQMTanecjBYOk/ns3SwWihw/SPKWK9fXY2LQ
         2JObekHsl8cuez+OXbHrbWpmw8OJY5nHTMHfLUhFboXs6jYsCIJXaXQeihuSPqRAvCQI
         fikg==
X-Forwarded-Encrypted: i=1; AJvYcCUaeNtzgw2EJM7iBLiRCB27pwvOJkOY8j0V2iqsT34gEEJVi3wtJumBmKgEXiylyPlg9xL1ZiUBMxiJtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpKER0bR/jkT+Wx736vZXP42KqSX4aTRr9OApPfJMVQNnsmxa
	gIbRoUAjnL7pTTuZ4AsJJV8vB0pEtwndkG6bqixr9/KomkjCHFA5jU8qNwJ7J492m4Dmdpm1EW+
	aibvhOnmvgwfEDjCTCPnqlXdozFU=
X-Gm-Gg: ASbGnctIr6Ki3s9cTfTv9PMida27F6hhMD6TqrPe7xRgfgc7Yiof3fqGeYrF5KNY7Mg
	KPcE4vGOZ8OyQoO/tY9JTcQV+kUpi+aOopXBc1B4bQnbkB1V7hjg+0nv9644ef1w84F1bPIsx
X-Google-Smtp-Source: AGHT+IEAjw7jUnSqPPKd9TnLVBbr/Ls5YvDW40MEFWbRPF5gbCmhPvDT5/CcrwQbaQ0UeXVRgCfPhC5JkS7vREmJoGY=
X-Received: by 2002:a05:690c:9688:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6fb1f19ba50mr3060477b3.9.1739292663896; Tue, 11 Feb 2025
 08:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250206131945epcas5p23d932422bf2f172e132678b756516c0d@epcas5p2.samsung.com>
 <20250206131134.cqlq5fhem34eme2u@ubuntu> <1aad2e80-427e-4f53-9343-baf5bee8e88c@kernel.dk>
In-Reply-To: <1aad2e80-427e-4f53-9343-baf5bee8e88c@kernel.dk>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Tue, 11 Feb 2025 22:20:51 +0530
X-Gm-Features: AWEUYZmq2CVQMdeSIJ-8Itq-w2EhxIUVnpMm9OEPCV22JHzbIIepfGaBCLgQTMg
Message-ID: <CAOSviJ3pkqroRutiyqs1DXkrwh3FV=Cm1t8qmzVY4GNaBWFY3A@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Block IO performance per core?
To: Jens Axboe <axboe@kernel.dk>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 1:39=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> While I'm always interested in making per-core IOPS better as it relates
> to better efficiency in the IO stack, and have done a LOT of work in
> this area in the past, for this particular case it's also worth
> highlighting that I bet you could get a lot better performance by doing
> something smarter with polling multiple devices than what t/io_uring is
> currently doing - completing 32 requests on each device before moving on
> to the other one is probably not the best approach. t/io_uring is simply
> not designed very well for that.
>
> IOW, I do like this topic, but I think it'd be worthwhile to generate
> some better numbers with a more targeted approach to polling multiple
> devices from a single thread first rather than take t/io_uring in its
> current form as gospel on that front.
>
Agreed. t/io_uring can be the starting point.
At present, I see for a single thread, half of the queue depth is
occupied by one device followed by second device.
I tried to change the order to interleave devices,
but overall I see a no gain in performance, there was little drop in
performance depending on type of interleaving, from 5M IOPS to
3.8~4.6 M IOPS. With respect to polling multiple devices,
do you have some other scheme in mind?

Thank you,
Nitesh Shetty
