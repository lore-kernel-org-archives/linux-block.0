Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D11DFE8;
	Fri, 16 May 2025 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362789; cv=none; b=PUbYaXhtWdjmtWwQHuQ6BEliuJhbpW2cJgTa1gnzdOZ2T/RggnYBec7wPaz6EH/m64qfWuotukdXmoIN3YO2bGPcv0IR91KH+F4FM/1qJ9rFRKiRz2SsHyoOeJAnqcdpLWexxZ8m0nGZsAj88RBn2N/purKzZcNIysGWBxa6yLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362789; c=relaxed/simple;
	bh=T7qM7dRp59Fy5lY4eb20+paUlrx1Lrk82Cxc+XpO064=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvEO4Fka+5sTGh6IvW0n5rT8G28WFo039COmXfOujGaL4DdNY61odKBMe6Wmea6O0m7UxYfJVqlVFr/dRYs48Lf95KvEpy8XphSi+Ph7ovzZhyfwVJhv/Qt2+Jlum9AAPiXNuZuhRFWiopGDd2IU6SrEl6UsUqZb+2VYmRBQ2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1RiMws0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1RiMws0"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86135af1045so173432939f.1;
        Thu, 15 May 2025 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747362787; x=1747967587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVGPAcMbIDDAE+CGMGoNk6Yx5l7mc/llgWDfx/5zSXY=;
        b=i1RiMws0x11N0AqPAPAsj+YFRadWEsTFj78oiWnPFVeJB3GC21Aeg5ZUzValkkpeO5
         hftVA3m30Em3GN6T63ScYvGMgZu5PMiooDPu9wY3noVm56F+YD4Jxz7T1j2dvdDb8Bc0
         zd4AvUl1vRfa9/Q+xYkgR1bVSDsD7dWJceIyS8sskyhXjU3vaHGcARsBBNPYwVDxKGqH
         6kkSioYFPbnGC5Hvz+qGIuVIRk+uKh6FD9X8lkwQeldVQg94O9EEWpQQKQs7Dkg+Xgon
         hJ9a0gYGX3m8DSnmpXTJkLqhVprIQIG1ORjibWOljPaauVQTmomar56YASZL0WRt0sBk
         BhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747362787; x=1747967587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVGPAcMbIDDAE+CGMGoNk6Yx5l7mc/llgWDfx/5zSXY=;
        b=HLNqnIfCRdDhDipmd1/I5sMwZCZOUXr7yPm3JmsnyX2gP0nTVChUTEsdjj/wIfrbCw
         H6VgJUpKZSTIaW9yUVFym/bxqWDNTWYHn828cqoivyZzQawVGsdcOp/X0Mz529hyhC5a
         VGvocTGD464KpA4XOqTzQYwws95N/SK0dV8wpMWQ0l0WeAvO5ZH1w6Hezb5UDC6O2gLf
         DIyAJDhdehjhqFJ2BkuXHpA1nzs8oGvJbbe3JCzjUuKpmt1E/BFQ/h3iKt41pQz8A4hE
         S3Sd4ov+oUfIj7XbIP/x5aVZrq+djmjzuLscPQYcVTOQl2xNDNgqMjIJLRtjYnQ7waD6
         mGXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmnlhlohjoZhsp9BR6jfUH7SQRzrNME0QGO0mRbdUEqJmVMqG0ze6ymvCXj+e4maUU65MHWhRHXq9DOQ==@vger.kernel.org, AJvYcCX5YKiVyHxl79s1INnRl7r65NYK6GukQURxq81vuJFgdefdK7A3VsJN7vqlXt2/ADt6Yr7hbXs086ToHx3U@vger.kernel.org, AJvYcCXPZjQMQ4VaT2rsrBhtxgnngL0UzmeJMcR0br2qpniz0Uh0OWPeXumce7nOiiBgjK4gk0tzhPs6+WftBCPgacho/dV5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrz8OUKXOwoQV2fokabqguHZjdEr0t3UrPNBruEi9gs/lYGS0z
	w7pCmOfTwuBtB48wCNcAPawYsvcJ9OjjPbB3Bi5Bf/uS5cAmJgwYsxPlE+k3QwCfRUX0+71xrND
	54L5wI2EBX7YgnppS1Iij4JW3B+51Q7A=
X-Gm-Gg: ASbGncsDQCIzHuenm4e3sJK/C/6RXjdbyC2t0fg7rbZceL0QtyZkrMDjkGTDqaUB3/d
	67Sw9x5VFeiQvDNYOSk8qSARRs3hz1JJOm8DmBIeY62a7d8FQC9p+kDopvh+X5+pXlP0SeRHW1C
	RVJPqIefxP91JN4NL22DNIB9alcW/FE5H+
X-Google-Smtp-Source: AGHT+IEArUWw7fv+2aLvDYNuJ2lUNmN9w0DfhWr7EyePZ0E/QR1dcxoznx1PWONJdRZnCm99AXsqb1zC2xVwpUD4tyU=
X-Received: by 2002:a05:6602:3e94:b0:864:4a82:15ec with SMTP id
 ca18e2360f4ac-86a231b703amr347766039f.6.1747362786828; Thu, 15 May 2025
 19:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com> <20250516110837.355d963224cf74ea2b020d9d@kernel.org>
In-Reply-To: <20250516110837.355d963224cf74ea2b020d9d@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 May 2025 10:32:30 +0800
X-Gm-Features: AX0GCFvwEQ1j5Z-FoSMzorQ-dGuNPeoemf9Wczbrn1TtjwBZRE-D6iQkLDrHgM8
Message-ID: <CAL+tcoB=HYB-EnyYTK=HzpgsosbOwo2VxMw-_mzbkSYnEWAVqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics function
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 10:08=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Thu, 15 May 2025 14:16:41 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In this version, only support dumping the counter for buffer full and
> > implement the framework of how it works.
> >
> > Users can pass certain flag to fetch what field/statistics they expect
> > to know. Each time it only returns one result. So do not pass multiple
> > flags.
> >
> > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > v2
> > 1. refactor relay_dump() and make it only return a pure size_t result
> > of the value that users specifies.
> > 2. revise the commit log.
> > ---
> >  include/linux/relay.h |  7 +++++++
> >  kernel/relay.c        | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/relay.h b/include/linux/relay.h
> > index ce7a1b396872..3fb285716e34 100644
> > --- a/include/linux/relay.h
> > +++ b/include/linux/relay.h
> > @@ -31,6 +31,12 @@
> >  /*
> >   * Relay buffer statistics dump
> >   */
> > +enum {
> > +     RELAY_DUMP_BUF_FULL =3D (1 << 0),
> > +
> > +     RELAY_DUMP_LAST =3D RELAY_DUMP_BUF_FULL,
> > +};
> > +
> >  struct rchan_buf_stats
> >  {
> >       unsigned int full_count;        /* counter for buffer full */
> > @@ -167,6 +173,7 @@ struct rchan *relay_open(const char *base_filename,
> >                        void *private_data);
> >  extern void relay_close(struct rchan *chan);
> >  extern void relay_flush(struct rchan *chan);
> > +extern size_t relay_dump(struct rchan *chan, int flags);
> >  extern void relay_subbufs_consumed(struct rchan *chan,
> >                                  unsigned int cpu,
> >                                  size_t consumed);
> > diff --git a/kernel/relay.c b/kernel/relay.c
> > index eb3f630f3896..f47fc750e559 100644
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -701,6 +701,37 @@ void relay_flush(struct rchan *chan)
> >  }
> >  EXPORT_SYMBOL_GPL(relay_flush);
> >
> > +/**
> > + *   relay_dump - dump channel buffer statistics
>
> nit: relay_dump() can mislead to dump relay channel contents.
> Can you rename it to relay_stats() or relay_get_stats()?

Sure, both are good names. I would choose relay_stats().

Thanks,
Jason

>
> Thanks,
>
> > + *   @chan: the channel
> > + *   @flags: select particular information to dump
> > + *
> > + *   Returns the count of certain field that caller specifies.
> > + */
> > +size_t relay_dump(struct rchan *chan, int flags)
> > +{
> > +     unsigned int i, count =3D 0;
> > +     struct rchan_buf *rbuf;
> > +
> > +     if (!chan || flags > RELAY_DUMP_LAST)
> > +             return 0;
> > +
> > +     if (chan->is_global) {
> > +             rbuf =3D *per_cpu_ptr(chan->buf, 0);
> > +             if (flags & RELAY_DUMP_BUF_FULL)
> > +                     count =3D rbuf->stats.full_count;
> > +     } else {
> > +             for_each_online_cpu(i) {
> > +                     if ((rbuf =3D *per_cpu_ptr(chan->buf, i)))
> > +                             if (flags & RELAY_DUMP_BUF_FULL)
> > +                                     count +=3D rbuf->stats.full_count=
;
> > +             }
> > +     }
> > +
> > +     return count;
> > +}
> > +EXPORT_SYMBOL_GPL(relay_dump);
> > +
> >  /**
> >   *   relay_file_open - open file op for relay files
> >   *   @inode: the inode
> > --
> > 2.43.5
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
