Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF441C7F;
	Tue, 13 May 2025 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103244; cv=none; b=k+HcYtWkOwN+Ur+ULVBlx9oX3F1ksZ6Cng5hsZ1tZ8vs67TZbWSVVI8wiZ0KEVEy3OVprP8m/J8L9ehKRTrBquJhwUnh2v9Rh3aWHtPIijmkt3zhQnOwxW9tmbe0S1Da6A29TarkBrAjklsezBOf3DR/8xTiXyijhxz8JN7k56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103244; c=relaxed/simple;
	bh=98a6Snc/NXc0TR9PbEOFzsCdszqsYw9UelW69TWeBR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1RuaWUiwtehIxn074Xt1MKMXT4cXvqWaSMSo8XE6xzl5Z+s+GvyqQ05Qf0FRJ3PpUPhauE55lq0naPS3LCYfyKJoW6Xax7cRy8xGaOYTs0nJZy/fd8wRSmu8fMYxUB0iAdQWzsk22htZ9j5Fm84FzxmUEMye7UuF4/Hn6AgjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTOcduti; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTOcduti"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-861b1f04b99so138093039f.0;
        Mon, 12 May 2025 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747103242; x=1747708042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azq0tGUBdBCpe+b8W3cDnCoHuYkgjMlpC0CbksCxYv0=;
        b=KTOcduti2X8HMMMfngP988ohN5FKLlY++FAcXLsErwDc4TEr5p01f289WtWz+SQ4vI
         VqQUiUCmsMig9HRo+Pz1mkeCDaPqAEKAzGphu53YjJR9Y9jdq50Lu8tmKrO00pXvuOPz
         j+NO4Ceb7BUqIpMGw5MN2iW4/gc5SGlUWFvEGHrvIY5A9m5oV9UNnPzeVRom9IxdggsL
         FyGOTWvGrvpAbAAno95FfU236urxARHwENMzyJPkyacqhbGyd1EDmLickYoWfssMBWK6
         iy+huLb1HD54eyyP/weJIUWX5kNvmeMwVW0xyOjX+nIiqWSNGMFgKKohRd91D67yVn8x
         NWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747103242; x=1747708042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azq0tGUBdBCpe+b8W3cDnCoHuYkgjMlpC0CbksCxYv0=;
        b=iFRUniXpEN3oCOkYa2mbduAEbwPvsVPuoK3PjqxXl3suE+GPjq/PNctB/4uJ0OdvyG
         Kqj78cZQmxbHZo2s3oNdc2f3nu122Yj6JuFFnRIHHjBT//Arp5j3fCSH3uEj7kRRXbW6
         qKeaSuO8zHKz8+M3uNJdbWLx6dN6nrpzqlUa5VncPFk4xCj2MkOTTfVO1eCHxO/HIBRE
         s9ZGcA9St1zTsO3q07y7M2UWKxBQPyc0F17HQdaiaXU/ktQ0o0B+Hiw5kPGHG9udQw8h
         yA78nMDsJkLhMKBpaincDq6NOUiWJuSv+fAZ/PHupas5uRdw7ZLH199uBqy2xVSyVu91
         A0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4/mNUuVt0VQ9CQDrKcgrcBzN+Iql4h76Zkc9/Z5Dmytz0yPTpPUzCJ0VC15s61m19UjdTwS3p0mU8Vw==@vger.kernel.org, AJvYcCXNbvWTqYlO+zgocf5B+Pi/IAk3a8V1LT1O9ZaRo4j/dpZtYEuwF68TLzllImrwsQAvpuA44toQLUAOiT2K/Z8M/nmA@vger.kernel.org, AJvYcCXgDcxQeXvwmfJ3hOiddwIcnxp+f0W+qmyd+g9OJpHVGC2YdaXd/pR35wj2n1leJWO9PkFc+39L3xaci9P5@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2Bn5UF0QHumPIS4YmzT7KbI2E44GEgdHzsDmcjr+SRRdnbJA
	MEDNfjecCh2k5Jb++FgYm8C/V7WEmhDvrT2cZZtl5dD/SY2txghEdUmPIZtXQCV87Uhd3Frusiz
	kbaMbUT9ILDIiEvsP5Wwwjo743qhnRq0YYIO1EA==
X-Gm-Gg: ASbGnctkFeRmQBEqWj5vJAPAiGpuMiTmKRPctya4kjVgJmdz6gvWebO/h3+N29h72Ia
	WH8/oxn83ueojdl+CFI8PDM/pmqb9AyPUDpyiArgyf02Met2C3H2l2lcXkJdI0w5UP1JGG36ZJu
	oZpWRmVoJ4PL0lDw0JLvQOBXgn4xgW6gY=
X-Google-Smtp-Source: AGHT+IFfqqqM0qYp1RV8b6+aJrLmSHYVs776COusec5YkuRmhO78WWK5gbTx99FVP7Iy1g3PjpggMOHyAQxltVnIERQ=
X-Received: by 2002:a05:6e02:1a8d:b0:3d8:1d2d:60b0 with SMTP id
 e9e14a558f8ab-3da7e1e26e9mr165032355ab.5.1747103242248; Mon, 12 May 2025
 19:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
 <CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com> <20250512190427.b7fb67f6b78fd8699ea2811d@linux-foundation.org>
In-Reply-To: <20250512190427.b7fb67f6b78fd8699ea2811d@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 10:26:45 +0800
X-Gm-Features: AX0GCFt-It6JU-VSizNKEH2nMqzT2SRUTafCnyqDEsiL8cxKunhyC1lIzE3Gk_U
Message-ID: <CAL+tcoD+VrRfAGMjj=9uAbanMO=W+cW0xgxMzVwrpiTgagmQ2w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:04=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 13 May 2025 09:48:15 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > > > +{
> > > > +     unsigned int i, full_counter =3D 0;
> > > > +     struct rchan_buf *rbuf;
> > > > +     int offset =3D 0;
> > > > +
> > > > +     if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
> > > > +             return;
> > > > +
> > > > +     if (len < RELAY_DUMP_BUF_MAX_LEN)
> > > > +             return;
> > >
> > > So we left the memory at *buf uninitialized but failed to tell the
> > > caller this.  The caller will then proceed to use uninitialized memor=
y.
> > >
> > > It's a programming error, so simply going BUG seems OK.
> >
> > Are you suggesting that I should remove the above check because
> > developers should take care of the length of the buffer to write
> > outside of the relay_dump function? or use this instead:
> > WARN_ON_ONCE(len < RELAY_DUMP_BUF_MAX_LEN);
> > ?
>
> It's a poor interface - it returns uninitialized data while not
> alerting the caller to this.  You'll figure something out ;)
>
> Perhaps
>
>         BUG_ON(len < RELAY_DUMP_BUF_MAX_LEN);

I'm unsure if BUG_ON is appropriate here since technically speaking
it's not a bug. For now, only sizeof(u32) is used in the buffer.

>         *buf =3D '\0';
>         if (!chan || (flags & ~RELAY_DUMP_MASK))
>                 return;
>
> We don't need to check for !buf - the oops message contains the same info=
.

Got it. Thanks.

>
> Maybe we don't need to check !chan either.  Can it be NULL here?

It depends on how users call this. If users call this without
initialization of chan, relay_dump() can avoid the crash. It works
like kfree() which prevents the NULL object from being freed.

BTW, should I merge this commit [1] into the series in V2 so that you
can easily review?

[1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason
