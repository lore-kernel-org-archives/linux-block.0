Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0001F09BF;
	Fri, 29 Aug 2025 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448375; cv=none; b=fGZqeWGbTHXJM14QHyb0UbujI9WjHFmgWlI7SOnY8rRn2/B1pHvUz8QudjOB1kyFRD/cS2c7r/zp6cwourQzkhPskX0uY78Q73wEEgyco1QC+P6YMAY0UQ41CB13/Y1tZ98K2w3WAU7dfVtUWbEvqrAsVUhtlaDA7gR3tHgJ1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448375; c=relaxed/simple;
	bh=g9JPHOm4Qzq7NOwWVks/w0CGNhTZ0lSavt8D+9snWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBaccb9ZhCo9ynTar0sjvKz9FLSJHt0E5vf7qfNM/cRsyJDWXvhnZge4Xi1W+cZs+Kncwn5fkeK/i0Zhn5eB2PNeD5sLYbIB01O8N/VMLeZ8sYK7b1WrRMN7pmO4YVdVU4zSRn3ohcfE21Tr/nm62Vf5M57+aN9dhd8NYs7yNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1F4rJLD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1F4rJLD"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-327ae052173so954780a91.0;
        Thu, 28 Aug 2025 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756448373; x=1757053173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLXzUPmsk5RxcWHSnTFCy0G8ysakJ2dAKE94Fnosk38=;
        b=P1F4rJLDzkRe7TqRRy2aadcXpCeetfg8IE7pKihFDFpE6Qca25NxSP9TMnAmzRZwJj
         RWYaH6R++x8lpFj/bjy371E/rug3uK9X3awLaxeMK846iqst3g+xzjrid8svIjvelXRm
         C0omdTDrhkQKYaGJbG2ZiKUprp2lQ7yvziKBkc/8uJrDg1npI4jopuWk+ypTr2R05lJY
         yv2DRs3DvRO1XOjuuWcV2zf/vvX3sElwwXptb35XW38JoFeLp/bbAxAqgDdN2e86hKDG
         xUNlH8Pgi4BAuOf+ItIRj50eWf44N9KBjZzzTBWWs3ID/ZwX4iqwHKsq0Ge3/qqj4B//
         ki5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756448373; x=1757053173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLXzUPmsk5RxcWHSnTFCy0G8ysakJ2dAKE94Fnosk38=;
        b=fjYbp2BcANPTlysPfh8XIBm2HCu0GUTRzxWOkpuU7VKvDwISOnHA2YyilVsoUtPIK8
         0FV9gH1ljFBWrfafcHRdfk+9V+DAOoBNXh9EiA/T022aARRvfGb+e935ybHwMVV9AKCb
         zm0EdfPxZ3wf6FbDccGzz0LcwILmtZ/YExUfAGNpNYKlUPk+2aRqY4Ed4191q4S/Fof9
         kYSukJO01zphMdW8u/pIx8VFQFfdkCKja7+R3zDKyOdZcZRUehUXZ5157MfL5Z9woYTM
         d561OfA6g1Vr/oUyeGc8N6LYzi+SC/gvFjmUZ/wlXlCh6+6OwjFtrs5CfPBBbX67xX4h
         fuNw==
X-Forwarded-Encrypted: i=1; AJvYcCWC8PJdhauN5s/hI6lJ745btvAoXcQeYDqONH1cx3TO3GYjwEOQGW6nHKJYcDGye3ilQ0A+whHpxWhdOg==@vger.kernel.org, AJvYcCXxI4WfYiTlVzoEl8hMfhGC0lJlOFAkR955qul8in7eLxzQtJ9lRKLo2qJ7A4bhyzc2sMmpnDAudlsFVMCO@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTDHIhNW09Lh2BXJ0zVsf756nbqKcxUfekxtA8doztf2FnVOX
	H+EFgTqpCfNXLMIeAYuQk1ryrt6EMyAe4jpRXI7nkl4kLV+nm/5RvuzJOQi1zektPzBo79m8UN4
	WFOXs+Co+Zwe54/piwbfrK/U4hDMbcsQ=
X-Gm-Gg: ASbGncvNnDq5Xmfg2mbTCufwJJuYe0cNlgHAVVIDDHXypq5Hm2PGpytld6wyXlXDjC0
	4OwLeNfs4D8O0ZJfRRLZXTzqTwpfr8BO+x+C3Ex2J+rFsIcTaLT3QoIY9Wm/VlmW3iAvbLM9QeZ
	EtzGRRdGu0dLVAhEmL4r3ihYl+ZEobEouDKwjC7ky48LAFe6LxX9LJWd3zGf58RH4M0CtSwLXqs
	U7fjqdwzR6JWfMf
X-Google-Smtp-Source: AGHT+IGf1tNPq40f3BUgdXUWiW+vto3YnZyLXBveOF9fPfkTS+h1IGzYK6jHMT9UWDgzxXpCeUF5HhsydpAWTbE3D1A=
X-Received: by 2002:a17:90b:5484:b0:327:a625:f43c with SMTP id
 98e67ed59e1d1-327a625f4f5mr7617442a91.22.1756448372605; Thu, 28 Aug 2025
 23:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829015444.91369-1-pilgrimtao@gmail.com> <62c9b68f-6adc-41d8-b504-4bce4d721e64@acm.org>
In-Reply-To: <62c9b68f-6adc-41d8-b504-4bce4d721e64@acm.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Fri, 29 Aug 2025 14:19:21 +0800
X-Gm-Features: Ac12FXzY3J8vnVEbGE-x6nEfOpsr6cNmiGLmwyrMmhGUbC5B6N7eWbLQJT48ucY
Message-ID: <CAAWJmAbumBHVo-8neC+b8WqJzzLbWqARpc3vkBsgs9j08wh3kA@mail.gmail.com>
Subject: Re: [PATCH] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:38=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 8/28/25 6:54 PM, chengkaitao wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index b9b7cdf1d3c9..1a031922c447 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -41,19 +41,16 @@ static const int fifo_batch =3D 16;       /* # of s=
equential requests treated as o
> >   enum dd_data_dir {
> >       DD_READ         =3D READ,
> >       DD_WRITE        =3D WRITE,
> > +     DD_DIR_COUNT    =3D 2
> >   };
> >
> > -enum { DD_DIR_COUNT =3D 2 };
> > -
>
> This change is not an improvement in my opinion because it makes it
> less clear what the role of DD_DIR_COUNT is.

DD_DIR_COUNT is used to count the number of members in the
enum dd_data_dir{}, and should be placed inside the enum dd_data_dir.
There are many such examples in the kernel, such as:
KFENCE_COUNTER_COUNT,__MTHP_STAT_COUNT,CHANNELMSG_COUNT,
ETH_RSS_HASH_FUNCS_COUNT,DEPOT_COUNTER_COUNT....
>
> >   enum dd_prio {
> > -     DD_RT_PRIO      =3D 0,
> > -     DD_BE_PRIO      =3D 1,
> > -     DD_IDLE_PRIO    =3D 2,
> > -     DD_PRIO_MAX     =3D 2,
> > +     DD_RT_PRIO,
> > +     DD_BE_PRIO,
> > +     DD_IDLE_PRIO,
>
> There is code that depends on DD_RT_PRIO < DD_BE_PRIO < DD_IDLE_PRIO so
> I'd like to keep the explicit enum values.

Wouldn't it be better to simply add a comment for this purpose?
>
> > +     DD_PRIO_COUNT
> >   };
> >
> > -enum { DD_PRIO_COUNT =3D 3 };
>
> I see the above change as a step backwards because it makes the role of
> DD_PRIO_COUNT less clear.

Defining DD_PRIO_COUNT within the enum dd_prio{} clearly indicates
that DD_PRIO_COUNT serves solely for the enum dd_prio{}. If a new
member is added to enum dd_prio{} in the future, DD_PRIO_COUNT
would not need to be modified separately.
>
> > -     for (prio =3D DD_BE_PRIO; prio <=3D DD_PRIO_MAX; prio++) {
> > +     for (prio =3D DD_BE_PRIO; prio < DD_PRIO_COUNT; prio++) {
>
> The current code is easier to read IMHO than the new code.

I believe programmers are intelligent enough to understand the meanings
of *_COUNT and *_MAX without needing to define them independently,
especially in cases like *_COUNT =3D *_MAX + 1, where _MAX seems rather
redundant.
>
The above are my personal thoughts. The purpose of this patch is to make
the code more concise, and not merging it into the mainline won't have any
significant impact.

Looking forward to your reply.
--=20
Yours,
Kaitao Cheng
