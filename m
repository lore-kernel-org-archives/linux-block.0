Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F118027;
	Tue, 13 May 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144025; cv=none; b=mLnJBNK5tIfq6XBdBoU+Mn5ze5rfOBsy/N03Ohd4ixo1bGbwQaJcDaA7g9gJLBQSQ2HK4JREoIAksEqAHavnFeNl1YREPlALGDhJAKxCQ/ycsiFdEp8xHaRsg3s0mBQIJB5CV0KMHSoawLzsoWyIPluOrJ8ltDma/yDVxLeKd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144025; c=relaxed/simple;
	bh=oRgPcbjmLPOmg7THdBFWSJDr5S+uKHQokITJtbnTDEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao9hbPtly+nfIGJjtkFW6TP5RB+YuYhprzfTobt8eiOVMNBNrTj+qr2olXhIFcgfO6uKJhfyjYKLEWj+wkNoCtPP5mVL1cQc9gizdGMyXIAHmjhyL3JUjbOo17IOGPyPD68K5b/3t3xO8GMhm7nnOgUG6tIqB2IKiT8CJvwdRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyuBeuWh; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyuBeuWh"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so29128605ab.1;
        Tue, 13 May 2025 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144022; x=1747748822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB9xFtRAlSHTdzfCT0D2Hx0EwAE0U1u6DE+8MTRRTPo=;
        b=jyuBeuWhin6klifrYM+dlIURWzcwqtxGt/UdCQCnJZjPofz7/BsCnFyZ6UVw/6XUQC
         4DzyhiP+7HCWwOarPoPAfLICiYeL40heQaTQ7ed/f4u4Jf4k2foxHKVbT+sQ+44I0lA0
         AggcaSpDsEQo5hLK498lXnxRtkoNxu29eK09WO2W2XOsXUZDVAI9Z15MkNW09RPp9jL5
         3r9ewyujsfP6D1wDyyLjEnqyAdvHXf4FJcZrVVOtbzXADv6aieQ+N+fVlBLxu3vbZkCC
         0zSUHl890rlYHe/y5nrQtcHqbfF3Q7yGkmTCDmfmOAEyckMS1VzGPkvHtGuH8kmk2hip
         5K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144022; x=1747748822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB9xFtRAlSHTdzfCT0D2Hx0EwAE0U1u6DE+8MTRRTPo=;
        b=dBNz8uDKBE1RrjUrJGL1zb34ngG+TQrt1vZs8TrGpOO4767alE6IHjqp0OX8ErZfHR
         EpERsty0xA72A/OYnTM+PKEYihUbuG79k7FGbBrZr//PlOxDsFHpIZf7P+xlaD6u7K77
         zMYlxPLGNxGW0g5HycLigj6L5Dlz3N6ZzFMY3RHfk1IsNIQL2u2dmLwfDXb/b5RLZ8lh
         tpkfvV/G+ewUIcYkhARPKK9N8sLAAi2yP6MVEpjRSqZJGiTwEl8QqJpitbfGOui30uq7
         sMHTfqaPYYsJdcTi9CzhJHSapIF2MtfRazfKRVXGq2xmPXgRH1mxR7CT9vl+sPHr1s8m
         V/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8EkQWB9tVG2KzofaWMZtOxxLSsD746R763Y6zFwNGnVz8aDnJ+h0DitThnhVMzOxncQWm7u7ldTl0qQ==@vger.kernel.org, AJvYcCWQZK3dFUSm07ROvfD3cYb4bcgioAUV06yd+vLZABqLwhm94ONqj8STRwUlhkJl8gRzXWSeaeyvT5+9e7Isu1kEBFYw@vger.kernel.org, AJvYcCXhF9mUHhZzxncccCk9F70m68fTjUuWfJf+/Hl5EmhMnip4eb8RGmW8qhqJ36zw18d0XCPokzbCFEKjvdUM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GVz6GqE46f79vFR6iZuiZhVQ98RM/AM6hS3a9aZGe4z63N7R
	4+5hPlDkuQ16JFRY5d/MRHYnPd3vHf+9RMmDdVo0skfygBn3T8Ld2XFQyB+84rJ/ctKzNOTKn1y
	AsJ6K9fvCGZzcRLe/YPklCJx8TyU=
X-Gm-Gg: ASbGncs+CroRePSpVtP9gBmj+RnYc2LSbAvtBto0uZrmtqz8LKgk8O+z4S3kXmYolNR
	l9N9GnffGr8wIuvn4efXYqlT6H86dGyE/x2vXi69PvR6+ZFIhwFvONPj4vpQHpovOELpKtnCqLV
	Kj2oStK07rNFryhY8n+1PnduygWdie9WjrMsutFScmkIM=
X-Google-Smtp-Source: AGHT+IFSLa4fAeq6pH734InSEbk0eVR8v31fESXFH/VffnmF7L5QzpnYONk/lWFMZ2OXB4R3ZV7oftua7Mtn62mSN1Y=
X-Received: by 2002:a05:6e02:1a08:b0:3d9:644c:e3b0 with SMTP id
 e9e14a558f8ab-3da7e20dd8dmr168857135ab.14.1747144022275; Tue, 13 May 2025
 06:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
 <CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com> <20250513222235.33fd1817970cd601b18e92cf@kernel.org>
In-Reply-To: <20250513222235.33fd1817970cd601b18e92cf@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 21:46:25 +0800
X-Gm-Features: AX0GCFsLm6lgi60mPFd-ga5m23xncAznbgP6FDzFqsb39ZVBARwDMD7XjfP1D-I
Message-ID: <CAL+tcoAGCdowY14QL7HEqbW3ewAJi0OXpWNVkbqq9cM6xRmLkg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 9:22=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 13 May 2025 18:32:29 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > Hi Masami,
> >
> > On Tue, May 13, 2025 at 5:58=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > Hi Jason,
> > >
> > > On Mon, 12 May 2025 10:49:32 +0800
> > > Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In this version, only support dumping the counter for buffer full a=
nd
> > > > implement the framework of how it works. Users MUST pass a valid @b=
uf
> > > > with a valid @len that is required to be larger than RELAY_DUMP_BUF=
_MAX_LEN
> > > > to acquire which information indicated by @flags to dump.
> > > >
> > > > RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
> > > > choose to dump all the values.
> > > >
> > > > Users can use this buffer to do whatever they expect in their own k=
ernel
> > > > module, say, print to console/dmesg or write them into the relay bu=
ffer.
> > > >
> > > > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/linux/relay.h | 10 ++++++++++
> > > >  kernel/relay.c        | 35 +++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 45 insertions(+)
> > > >
> > > > diff --git a/include/linux/relay.h b/include/linux/relay.h
> > > > index 022cf11e5a92..7a442c4cbead 100644
> > > > --- a/include/linux/relay.h
> > > > +++ b/include/linux/relay.h
> > > > @@ -31,6 +31,15 @@
> > > >  /*
> > > >   * Relay buffer error statistics dump
> > > >   */
> > > > +enum {
> > > > +     RELAY_DUMP_BUF_FULL =3D (1 << 0),
> > > > +
> > > > +     RELAY_DUMP_LAST =3D RELAY_DUMP_BUF_FULL,
> > > > +     RELAY_DUMP_MASK =3D (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
> > > > +};
> > > > +
> > > > +#define RELAY_DUMP_BUF_MAX_LEN 32
> > > > +
> > > >  struct rchan_buf_error_stats
> > > >  {
> > > >       unsigned int full;              /* counter for buffer full */
> > > > @@ -170,6 +179,7 @@ extern int relay_late_setup_files(struct rchan =
*chan,
> > > >                                 struct dentry *parent);
> > > >  extern void relay_close(struct rchan *chan);
> > > >  extern void relay_flush(struct rchan *chan);
> > > > +extern void relay_dump(struct rchan *chan, char *buf, int len, int=
 flags);
> > > >  extern void relay_subbufs_consumed(struct rchan *chan,
> > > >                                  unsigned int cpu,
> > > >                                  size_t consumed);
> > > > diff --git a/kernel/relay.c b/kernel/relay.c
> > > > index b5db4aa60da1..0e675a77285c 100644
> > > > --- a/kernel/relay.c
> > > > +++ b/kernel/relay.c
> > > > @@ -810,6 +810,41 @@ void relay_flush(struct rchan *chan)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(relay_flush);
> > > >
> > > > +/**
> > > > + *   relay_dump - dump statistics of the specified channel buffer
> > > > + *   @chan: the channel
> > > > + *   @buf: buf to store statistics
> > > > + *   @len: len of buf to check
> > > > + *   @flags: select particular information to dump
> > > > + */
> > > > +void relay_dump(struct rchan *chan, char *buf, int len, int flags)
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
> > > > +
> > > > +     if (chan->is_global) {
> > > > +             rbuf =3D *per_cpu_ptr(chan->buf, 0);
> > > > +             full_counter =3D rbuf->stats.full;
> > > > +     } else {
> > > > +             for_each_possible_cpu(i) {
> > > > +                     if ((rbuf =3D *per_cpu_ptr(chan->buf, i)))
> > > > +                             full_counter +=3D rbuf->stats.full;
> > > > +     }
> > > > +
> > > > +     if (flags & RELAY_DUMP_BUF_FULL)
> > > > +             offset +=3D snprintf(buf, sizeof(unsigned int), "%u",=
 full_counter);
> > > > +
> > > > +     snprintf(buf + offset, 1, "\n");
> > >
> > > Is there any reason to return the value as string?
> > > If it returns a digit value and the caller makes it a string,
> > > it could be more flexible for other use cases.
> >
> > Thanks for the feedback.
> >
> > I will remove the above one as you pointed out in the next revision.
> > And it seems unnecessary to add '\0' at the end of the buffer like
> > "*buf =3D '\0';"?
>
> Sorry, I think you missed my point. I meant it should be
>
> /* Return the number of fullfilled buffer in the channel */
> size_t relay_full(struct rchan *chan);
>
> And keep the snprintf() in the blk_dropped_read() because that function
> is responsible for formatting the output.

Oh, sorry, it's not what I want because (please see patch [4/5] [1])
relay_dump() works to print various statistics of the buffer. In this
patch, 'full' counter is the first one.

[1]: https://lore.kernel.org/all/20250512024935.64704-5-kerneljasonxing@gma=
il.com/

>
> static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
>                                 size_t count, loff_t *ppos)
> {
>         struct blk_trace *bt =3D filp->private_data;
>         char buf[16];
>
>         snprintf(buf, sizeof(buf), "%zu\n", relay_full(bt->rchan));
>
>         return simple_read_from_buffer(buffer, count, ppos, buf, strlen(b=
uf));
> }
>
> But the question is that what blk_subbuf_start_callback() counts
> is really equal to what the relay_full() counts, because it seems
> relay_full() just returns the current status of the channel, but
> bt->dropped is the accumlated number of dropping events.
>
> This means that if the client (reader) reads the subbufs the
> number of full subbufs will be decreased, but the number of
> dropped event does not change.

At least in this series, I didn't give the 'full' counter any chance
to decrement, which means it's compatible with blktrace, unless
__relay_reset() is triggered :)

While discussing with you on this point, I suddenly recalled that in
some network drivers, they implemented 'wake' and 'stop' as a pair to
know what the current status of a certain queue is. I think I can add
a similar thing to the buffer about 1) how many times are the buffer
full, 2) how many times does the buffer get rid of being full.

Thanks,
Jason

>
> Can you recheck it?
>
> Thank you,
>
> >
> > While at it, I'm thinking if I can change the return value of
> > relay_dump() to "how many bytes do we actually write into the buffer"?
> > Does it sound better?
> >
> > Thanks,
> > Jason
> >
> > >
> > > Thank you,
> > >
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(relay_dump);
> > > > +
> > > >  /**
> > > >   *   relay_file_open - open file op for relay files
> > > >   *   @inode: the inode
> > > > --
> > > > 2.43.5
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
