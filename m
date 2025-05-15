Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41B19FA93;
	Thu, 15 May 2025 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351526; cv=none; b=vFcRqLhlZ1BmY3B6IvfOieyZYBRlhXutqfOVejd72lWDsgP3KHQN8p2iPPRGVIR6ji15UYw6UVm2N/GiCK1zsP9kCkU2lkaHsvO9Shi1b2AFHN+2x1eS1HFNvfOJhnP2mvHWZBoxHqPfgcCqGRq3k5P7UClSoxvOSvB9s2xnS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351526; c=relaxed/simple;
	bh=13OywW5tBz989Be8chJbDrLamFlsWj9fCikfU9SnJf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3A1XaL0YsJmDGpx9PoLy0J/v6FiR+KPxkFKPVeJhdC240U+ZRrrxz2v8T1u5JqRyTGd82WC95RcGZmonv3TzItj3uXLuaI5vt8lavM5pVbhlZwCs0hqBmQMD04SFIhxGbN0KJU3jcoLYm9tEW3D6vuw6EwqmNfi/Te9h29aK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiBVV6WX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiBVV6WX"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so7140205ab.3;
        Thu, 15 May 2025 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747351524; x=1747956324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iSRSWHA0wZxEBcTIAV8gBudfItIUV9PGZbzhKEKHfc=;
        b=IiBVV6WXx5Ky3bEEkSGt32oTxbz8sZTYWEjJx6KDRiZI/dV8k7biijLUAjsiBc8I6t
         KbPNuh/wpOcnik7shBx7+GvdStJteGAtlSWnlkf7copxQk8oiQBo0Eis9Wl7OKKi2ekX
         7eW+KpDCZz7v63XiXbZCaukc7mvPsfWAuMhey3z2UBjte8sU/g/qYqf118K9D/Uj1BiF
         IPhi3/hDdewVUiljRUW7R/C28aT4YgFkfEp3Ku8ydtwszaTrgvpFAA6ecxQEAZC9q4jY
         VdIkwOlx4AJK3lAQ1iSxjiOpjooSzeCkPtLgxdkDzLNuOg3yIb6G0aJE8I4mL7iTF5Tn
         E+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747351524; x=1747956324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iSRSWHA0wZxEBcTIAV8gBudfItIUV9PGZbzhKEKHfc=;
        b=GURN3GP7MqNUJg0smKGkUMs0Cry8EDB59TOC92xdCrS8hQ3UcGlXFcTHEWjXKFV7Xq
         YgRHvyh3Mz2VQd4KvoTmGwjhJFjumNk4i5TX/oBUk1b/XODUcNJnd5yC5IJ1JHZmMNcC
         v6RNt97B80CO/s6t0QUEXMyhu5ADy6CPIBn0txOTU4i8dfq2FPfQdYQI8vIqgwOtppxX
         sAu/BiQSFCfopeZ8gROyOxTFDvy3FGrKrYR3Wgm0kEq0A65PMPKAyvwlDiqKkzcOJnd+
         6G+JJyumr6Jy38JLP4mreTXfOvMjmCIZrnsdRIWAwv0LWd7oJgHVj5Gx5E8tdxWKuvcr
         mHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg4WlU/JVdwhJbHrf1yk9c6NQzjy+9egTy4qFnAsErpdrGvXXMUkEJOrgt1rf8ItZpFr4lafAu9JUDoQ==@vger.kernel.org, AJvYcCV72MsOHt/JNzC7/ux/DZLBRR1qOa36CC7d1cMbcToMMOzOr40og/rsQdMeOSAalv6CBwP/Ahf1+eQE/Uyw@vger.kernel.org, AJvYcCWQRCzOZe6D6AaTm7xxWEC7DRYY5jGUjuH7gITYEO7Yw4WwKmj+TwpqLKruiGBUQjSBbjhuewwMGdzmv23Zq+gk8XEq@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyFT/C2avCKiGkIwNJq2sIxCyG4YIC1f77jRBF0DwrUrUZGRx
	LqKSWlSDpeX7PZXfv/xX8TLHse0tFjqErafkGPOUuRQk8K2PcAy0Nq2wq4hpa3Eq2v57ij0irRV
	fYfEilMBXzucltdFd7/I+TXXZlKmQpCqpnQ==
X-Gm-Gg: ASbGncsH7/DXwO08han45ckczYBo00HslNI0fJw1QOoFWUldqJPien5DcNHEYlcAXN3
	9Naj4rw8vuy3lCFGLCQeEkxnBm3lNXCx5+vjAiqFDFkaKpl00EV1HLCSCajglJUVu95BjDuBJfT
	Q6k/9eCLINxKyR87JmBF6zdEqEKKw3Jfwkgln0F7Jiyg==
X-Google-Smtp-Source: AGHT+IFcHv71Iztr4DFKwenfbjo2fh4qPjqGj+8jiRWhWN/UQ2/eu8xmCcRzmSdIacT5CrKxNXlj4pROnUOzrQ+V0Kk=
X-Received: by 2002:a05:6e02:330c:b0:3d9:24d8:8d41 with SMTP id
 e9e14a558f8ab-3db85792a88mr6073275ab.16.1747351523837; Thu, 15 May 2025
 16:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com> <d5032331-7fbc-4c7b-9d1e-845121664872@kernel.dk>
In-Reply-To: <d5032331-7fbc-4c7b-9d1e-845121664872@kernel.dk>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 May 2025 07:24:47 +0800
X-Gm-Features: AX0GCFthg23UHmVlvFzvJ2zFURtaq3l3-87z22y-7dR8DEl3EN9kUEkiv5vYfPc
Message-ID: <CAL+tcoB7NBWLQgQqYX8QjJcvpJmDB39iZMrZWZA07PF6ELYfZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics function
To: Jens Axboe <axboe@kernel.dk>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 2:19=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/25 12:16 AM, Jason Xing wrote:
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
>
> Kernel tends to avoid the rolled-into-one assignment and check, it's
> easy to misread. This:
>
>         rbuf =3D *per_cpu_ptr(chan->buf, i);
>         if (rbuf && flags & RELAY_DUMP_BUF_FULL)
>                 count +=3D rbuf->stats.full_count;
>
> reads much easier. IMHO.

Agreed. Thanks. I will rewrite this part in V3 :)

Thanks,
Jason

>
> --
> Jens Axboe
