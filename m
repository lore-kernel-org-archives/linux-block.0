Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856A221D9E;
	Fri, 16 May 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374312; cv=none; b=hlcgmNSSG2pa0nEyfgAMqCVMJz0udG2bHaWCPYUtT2MCyzFr+gCFbnutssTtgf/1C45jmWl+gAaWFUG7J44i23kiNycxcQ5fKGydRx2FclBs5EFKg6FSi5wCvtWfZd9w0YjgLg7/AkPVlbTRp+mO2RXQGLL2uPYTb1s41/9wDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374312; c=relaxed/simple;
	bh=KQ8DEGIjFGtjkOm1Z6wmVOGMqwGH2m8oFkwVyWUXYnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhLLPLLsnRzepw5asxvUxi2d11CXIg4uGqX4liUuZwH9X42ydQXmAPN6NbePkcZ/taqfUdX7qKkwE8/HZInV4TxV+YifrmZupKpi0ndURybkZbpe8AlKQ3+f3pu1h8pACqv+lh+YAvZ0jNCVyQIRGzaraMdZvzruA4re3ecrT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0KpI7Bt; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0KpI7Bt"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85df99da233so155274339f.3;
        Thu, 15 May 2025 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747374310; x=1747979110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aVGf3ko8McvoV5H/mqGMDqVnghfA90z2DNdFa2PxtE=;
        b=C0KpI7BtR+pjQ7Wp+2CNzlv1G8b6l5W44CImTXib6ROBXJXPVlL5LQs9X3oAKCEgPW
         xkxZS/KmzEyUSZz3RSG64FGFjpn5vNs1ledcZdDD0yOOvq+S88GsFcqVt7E5a+pkPDfA
         un1qggiTBL2xkk062osjiJ+hDhUVqNIAXQC5qWAHA/mz/4a7c3nZ+3/TZbqzSduEjvUt
         SchG59dhBwd+4NdkSivgLOaNBjpF7fwoBqP5/GWfg/xdjm7gzuMysoFM9azAJeAeMqjW
         7aTLCQzlRg4i7kH5t3Z2S8GyOfCoiuFk5mtWwaAkKJcW7Zrpn8/9UL/PhC7uo/3xtEMd
         4Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747374310; x=1747979110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aVGf3ko8McvoV5H/mqGMDqVnghfA90z2DNdFa2PxtE=;
        b=hbPDDIBPilFRr/x5TmhgcBQDuwuM/TNSbJ1RGlTXqrBCT3vlV/cuMwk78K43PZIDVi
         VNYTXiYioZSBWUN1PToCoOokkH3fzDPDuwZ73cWeHYLmWC9gD4h5n+d7MP5JGQ6r8Z/H
         DDIf02NC4/Wic6H+28f7ENKpXVXg5+7eYr9CnTV4ZxdC9cXzdCrgVFyJVdT3Xa0OwZcF
         9BwPOw+ng0I9cLCZ5Vlb449KnWY8NzUmL/LbvrtmfYOLA0UTtwevy53oe0RNPupMC3m4
         s7BhZ8MTqei9YY0Ct0lTkruPPDXkaFKyNA248h1P1SbqN/4kIBAedzSXW59j5d58KgoO
         RXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV23pVO9mFgtnoNYBt2oqzjWRmI6K5UvNZNuMqlXJ3E7UQVzRFLW4w8oV4Y3rNroHETIsLy2SVakw4ImusA@vger.kernel.org, AJvYcCVmEoySAagEUV6SzvrjQ1zEJu4YKi8RTqtMw4zak+BNR2SgmHqcW4pGNsfWEvSSlYqGU6BwqkSFzN8Pqw==@vger.kernel.org, AJvYcCXeLQgKyWTN5MnKMMijIWTkeLbZUMQz8bRZ0IKDwQMuuxFbuUtC1Pe/YFb1tZ17UhL9x2lnw5WhljjVF8ZtPpqUNliL@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfAPGkbKyf0hkc+k02UMGNx81Xl+D8bfemigTfGdAHPURcNMa
	s33gZv0dIsfVmen4Ey+ffnJvVGCd3HSy9koAppV98mzq9Cvdn5f+2HEqTB6IkuF45K/qru3/BFr
	96JS2CvgqsHvoGeBqiZfPpl7O4w6h0vQ=
X-Gm-Gg: ASbGncs/aUq40t/U5QlqDcg3r0hV0n/8C+3jFGbS0jnlOsf5dnqgyA4QJ58tbpSN7ey
	ozarfLtklezvVSxe8x4qMp6xZ3kUYsJ8yEXRwPyDXRYM6btseQcK35tH8zxs8upP9ZccSUEX+bo
	Aij05e1K/7vgaAiiPkMbtKdRvv1gNtDkPqZ2S0pgdctoA=
X-Google-Smtp-Source: AGHT+IH/fIQmQ0PPXOQCAyw2SYiLWKIfvjBJ0LkJ4GEuPRDhvdmhjetKdN0Q2HnIImX3K50vxPRCK4V6pqYMo8VW4Zs=
X-Received: by 2002:a05:6e02:339f:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3db857282d6mr12509285ab.5.1747374310306; Thu, 15 May 2025
 22:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com> <aCbBEg-DFYvx0Dpa@infradead.org>
 <CAL+tcoBtLu6_E1qKL9VHOiCe_RVpEGzMiMqA3GpPi1Z88aMiWw@mail.gmail.com> <aCbH1eA8Iicg_Fq_@infradead.org>
In-Reply-To: <aCbH1eA8Iicg_Fq_@infradead.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 May 2025 13:44:32 +0800
X-Gm-Features: AX0GCFvHJDgX8tyRmZmTFC32DZWnKpLQIi2lM-nsQoTd2O3TIIJvfRPQ-MRMkBk
Message-ID: <CAL+tcoBmLvPh-OhmUP2O5BoR3_FPWPXyLFhipNh5b-xHTGCb7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics function
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:06=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, May 16, 2025 at 01:02:59PM +0800, Jason Xing wrote:
> > Do you mean make it inline in include/linux/relay.h like how
> > relay_write() works?
> >
> > Will do that.
>
> Just drop the extern, which is not needed:
>
> size_t relay_dump(struct rchan *chan, int flags);

Got it.

>
> > >
> > > This export seems unused even with the entire series applied.
> >
> > My initial thought was to provide a symbol for some kernel modules to u=
se.
>
> The only user is blktrace, which can't be modular.  Or you plan to
> submit a modular user soon, like in the next merge window/  If so
> note that and add a pointer to it in the cover letter.

I'm still thinking about how to upstream my internal module... So in
this series, I will remove it.

Thanks,
Jason
