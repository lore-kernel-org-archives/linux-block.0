Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58003246792;
	Tue, 13 May 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132388; cv=none; b=V1lyR9+c0UliAvPlx2Jw6sKfXY+SFxFoy8shh0nWef92VkG46wHahg+NgCxiL6fcKBsa5isn5AbXSY83WLtamfyZ7jmlrDZbUD2EkndsyP06+W2BOorLtPS8XcB9ySvqBWgcoFW6kwEBdNFM8wsAX56qrmn6deH7PrFShXF+UUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132388; c=relaxed/simple;
	bh=+gmYBF4nyZFcTZBT5IfRkHThGJLlegp6OFKXZbPojes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za1ANYhrGwIJCbjXnJI/DXwm4RNQROrqL9BeQ79YCgvAE0MYxbPsIAxZcOuDOTGVnItuvfAa3dgTDDxD0xsOBBAgSqr0wVwVAXdC3AmHkRtfDr+3SvhJsw3ec4ZjmEA01sxtN18pTdiV39Mambqw+++pjU8eCXh+I6gUD+IY64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V43s9xmE; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V43s9xmE"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so28056175ab.3;
        Tue, 13 May 2025 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747132385; x=1747737185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/9ZiZyUDSdEN8J7A43w1HOrQtII9rQoVgCxq357gF4=;
        b=V43s9xmEvM2s8tH8Nb7Zda6gUbymF/AsC1ij6DYJ3Y5y4p0ekqzsphhG4pMRETL1U+
         v8xcenrUIAXDhWzgtu0+ugbITXdb9b37aM99LPyjojeVQgteoOtm3otQgjgyWbacw0sX
         x/OtStSzF99iqF/GGO/Z8pkDZxyH8CiXlAjid54x4+Y+e1b6Xn1gLjAEYMfXL0bGSlcU
         DXgy3163DE5t5zHjF/h4DN4w9tAcM6zHIUhCuvB+XtjlXnh0r1WSp7fomNZJpk7Io5oj
         wVYixg4g7QcbgXkEcuwbHEk35seXmZbH+5KCCR20F67dZiGKeELFdWx8HCo5si7+pF1S
         zVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132385; x=1747737185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/9ZiZyUDSdEN8J7A43w1HOrQtII9rQoVgCxq357gF4=;
        b=ELQQDyxYh/PLFiNJCrqEZAx2wgw8f3E1KCBT1u4KzdwJ7DB2mxd6i2RF/n4uY0E4HI
         y6W3JrgDazQsSucBWtES1Zdp0HPcNP/2WMSWrX9JmVF4KtFE2q07JswSPXDOzBgZMdME
         G6OGhFm+q+XpnbtxOUGTg4dw1tr/02SKDHfA2i/eKSYRH2cXwNfxdOLu/KFRFvE6F6I0
         4B0VpGag0Rdvmi7wUW7zJ6CAGUVqpzhaA872CyQEhE5NNjdF0XX/KV1uvA6wTn/EFqaV
         qEP5keEPnxNpsuFJPsD02mrfNks49Pr7LE4RQMR16xwPBVJjp6fcAfAo8VQCVvgOtxHe
         LhVg==
X-Forwarded-Encrypted: i=1; AJvYcCV774REHM1698JA4jwYFi8THmvLpi7M97r4PFSatZKpCHcO+sIYBWMGvwQH7rA+yirwKzOF68As9NAebw==@vger.kernel.org, AJvYcCVi9vs7ent45Im7nRpaEOE/lHESSHbRY/xu1UoIXiRJZoWEBUb2sa7nACqg/oWDaG0UvxcJylLtY/Ys5YHO@vger.kernel.org, AJvYcCXfpo/xV0ueQ6JkKanrES5s+V1KIuw786XJpup8UaVmkSN4gprlBlDjL+g2qrHADCb75iRko0P/HhmzW8pl8Tg/RZle@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkHpTVlGG/7/z8p9EKCx3aBvhv7F7FUYHgEwRyNd45bmJ1S4Y
	nrz2f7IjsYZyC8FPd0LpdNUkmu3qHOkRRdTvOg4IbNCqO6N3Kh3D76xCytXJNljXS+FOyQMpP2X
	qt/88v8l9RwWtwWhmyrB/8XSkYFZsSLEoFmW18A==
X-Gm-Gg: ASbGnctjQGgMyznwq7UzfH9m3Jap3mUnuGb8GatMh7gPmbtVRHy/bX5tSMSeJwdJBxi
	EoKXl4gkECRXimUGwMzJpFFTNzTJ4gjDvcF+zRghANa+kNEfUOBE6jryGcpnGw/kXljKNiqqcUJ
	b796WMnlLKYvqXU/BdFE33n1zmMjZxCJY=
X-Google-Smtp-Source: AGHT+IGxhA2z/ceqVmur8CVCCM3LTy7ac49dRpS23lmDPvC4mw3ucS9bt7hfciTy5WAtGfoCrgoPTa4ahuwQkQrsdpk=
X-Received: by 2002:a05:6e02:1a85:b0:3d6:cb9b:cbd6 with SMTP id
 e9e14a558f8ab-3da7e1efc43mr167980865ab.13.1747132385188; Tue, 13 May 2025
 03:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
In-Reply-To: <20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 18:32:29 +0800
X-Gm-Features: AX0GCFvlJWHVcSdTegWk-0RLXAr7U4Ngm8UitndTSC2NMuE5bpGuS9Aba1gK-c8
Message-ID: <CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Tue, May 13, 2025 at 5:58=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Jason,
>
> On Mon, 12 May 2025 10:49:32 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In this version, only support dumping the counter for buffer full and
> > implement the framework of how it works. Users MUST pass a valid @buf
> > with a valid @len that is required to be larger than RELAY_DUMP_BUF_MAX=
_LEN
> > to acquire which information indicated by @flags to dump.
> >
> > RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
> > choose to dump all the values.
> >
> > Users can use this buffer to do whatever they expect in their own kerne=
l
> > module, say, print to console/dmesg or write them into the relay buffer=
.
> >
> > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/linux/relay.h | 10 ++++++++++
> >  kernel/relay.c        | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/include/linux/relay.h b/include/linux/relay.h
> > index 022cf11e5a92..7a442c4cbead 100644
> > --- a/include/linux/relay.h
> > +++ b/include/linux/relay.h
> > @@ -31,6 +31,15 @@
> >  /*
> >   * Relay buffer error statistics dump
> >   */
> > +enum {
> > +     RELAY_DUMP_BUF_FULL =3D (1 << 0),
> > +
> > +     RELAY_DUMP_LAST =3D RELAY_DUMP_BUF_FULL,
> > +     RELAY_DUMP_MASK =3D (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
> > +};
> > +
> > +#define RELAY_DUMP_BUF_MAX_LEN 32
> > +
> >  struct rchan_buf_error_stats
> >  {
> >       unsigned int full;              /* counter for buffer full */
> > @@ -170,6 +179,7 @@ extern int relay_late_setup_files(struct rchan *cha=
n,
> >                                 struct dentry *parent);
> >  extern void relay_close(struct rchan *chan);
> >  extern void relay_flush(struct rchan *chan);
> > +extern void relay_dump(struct rchan *chan, char *buf, int len, int fla=
gs);
> >  extern void relay_subbufs_consumed(struct rchan *chan,
> >                                  unsigned int cpu,
> >                                  size_t consumed);
> > diff --git a/kernel/relay.c b/kernel/relay.c
> > index b5db4aa60da1..0e675a77285c 100644
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -810,6 +810,41 @@ void relay_flush(struct rchan *chan)
> >  }
> >  EXPORT_SYMBOL_GPL(relay_flush);
> >
> > +/**
> > + *   relay_dump - dump statistics of the specified channel buffer
> > + *   @chan: the channel
> > + *   @buf: buf to store statistics
> > + *   @len: len of buf to check
> > + *   @flags: select particular information to dump
> > + */
> > +void relay_dump(struct rchan *chan, char *buf, int len, int flags)
> > +{
> > +     unsigned int i, full_counter =3D 0;
> > +     struct rchan_buf *rbuf;
> > +     int offset =3D 0;
> > +
> > +     if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
> > +             return;
> > +
> > +     if (len < RELAY_DUMP_BUF_MAX_LEN)
> > +             return;
> > +
> > +     if (chan->is_global) {
> > +             rbuf =3D *per_cpu_ptr(chan->buf, 0);
> > +             full_counter =3D rbuf->stats.full;
> > +     } else {
> > +             for_each_possible_cpu(i) {
> > +                     if ((rbuf =3D *per_cpu_ptr(chan->buf, i)))
> > +                             full_counter +=3D rbuf->stats.full;
> > +     }
> > +
> > +     if (flags & RELAY_DUMP_BUF_FULL)
> > +             offset +=3D snprintf(buf, sizeof(unsigned int), "%u", ful=
l_counter);
> > +
> > +     snprintf(buf + offset, 1, "\n");
>
> Is there any reason to return the value as string?
> If it returns a digit value and the caller makes it a string,
> it could be more flexible for other use cases.

Thanks for the feedback.

I will remove the above one as you pointed out in the next revision.
And it seems unnecessary to add '\0' at the end of the buffer like
"*buf =3D '\0';"?

While at it, I'm thinking if I can change the return value of
relay_dump() to "how many bytes do we actually write into the buffer"?
Does it sound better?

Thanks,
Jason

>
> Thank you,
>
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
