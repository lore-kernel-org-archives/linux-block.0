Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462417C220;
	Wed, 14 May 2025 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188438; cv=none; b=oOCCPPg/at6oRWfKIzC68ZNKZKK4HN6uOpx3v/s89DwINEnFG3+8M9lFVxzAGps9LE7hlJOLIs05sI/xGaQCqz0g0kzANAjuBszcOSYIRVY5hwU/ieLGigR2cqdRyWzMPUnGP1tELeLgfSbMXFWCdqwOOv5cpppdwMWhDEXYtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188438; c=relaxed/simple;
	bh=d+d/UHC/2vh3oGoJlIs98iUvpQrj7IQBkL/Dj8ejIW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRhqHr0rrLeb7hhqYmlQs3FYhE25opOASdZwkKQ8WgibBvQ1oVjM4iQZVH+EzJN7MTo2aPHjUnckL6aW1DvrJsyyHJpSR/RDU//05N5en8Iiu6VclCZ21vFVd6PFbT18UUEICQmCnV6HUhS2cvuFHlt/iNXRHdASvD+sXzwl9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZnGKT6I; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZnGKT6I"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso24011565ab.1;
        Tue, 13 May 2025 19:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747188436; x=1747793236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/bFA6/U6p24AkyJ1ZYs9l1TykpsfywK1D/cyRMHnvA=;
        b=eZnGKT6IjLENJ1GKSOKPowPAJCmzoTAGx8n6pYt6npriiH/tSyE53oGaWj+hYQ1lu5
         qnE/pHNJbtlTWeM8ta9/OkCzOkJ4dqfQDsi5OlmEX62u3kbzYbIvO4eIXlV+d+NonJGg
         g0WTF9c5bCfTuN7oaxZqsxa6t5v/FNdEvSORixK7Ui5lUvqTlIYCLh4q5C+/qRU64nl5
         2lN5xVmnbb+rnGpj6SBw4EVBVtnNxBWKZW0TAf7i0y5qyteON+ob9M+GowzIu9YN36lX
         RA6zGZitzCLvntYMj6ukl390R7xS5F7q1Ih7u/hyx1jNRiEfioRmjTMn81FDaaiMcESh
         jeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747188436; x=1747793236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/bFA6/U6p24AkyJ1ZYs9l1TykpsfywK1D/cyRMHnvA=;
        b=upX3UnQpX2fLoAe8TL94/gYVahiUORotujix6DCs1Lm6TMxoUkAh5p/6Gm6oxgym0W
         Aoj2w9K+ltnwr70W2vfBRZrvww0w+Tn5/4u3b+4i5Rzp26fUKtaz/kIphaiHNz3NB+qG
         PX8/nTJRoaZzYpTzNNJIBm3BiXZqMIZEJ3fw4FHwtLb1DPvHvulaRuT3umhCOLuhCLdl
         h/+jt5rVEDDZDmmCNf/tMEADuMM88lZ5h85YKTTi3TOyGz717X6IzNtfVrWuMh+p7qQC
         ETceBtiCMmnPswr1i9XefVrUeZjGNF0W6IpJwrwHAP8eWctnu+hubP+A2wek4xKi+rks
         gduA==
X-Forwarded-Encrypted: i=1; AJvYcCViurdsqsO3EbiebeFNAu/uJ4YGP+6nqiPGw4yp+qlRwfLVgKLOLl1fsS7pfmzr9bN06yvW4o1IGnaz+4HyAkxXRElh@vger.kernel.org, AJvYcCWyIyMnaG4rrZNUxvRdNdzKpDk9RQRnZSzgxcHySYmOrkeRaVf/H1dmEtggnR/AIQzcbc9RphMeKPF3Bi9s@vger.kernel.org, AJvYcCXKqomUtdKT8U9x3S6hP7Tk3of7Z18DwVn2qQJPTTbcEo7JxOtBUCLdzNwtqyzhhzeiVbDQYtRFaJ2QnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTcSRreSJm3K9t1rWntCdVVxI/aKGWzH1iVzOW8sGbigl2BPu
	TfxbEcW9+phOwcv5e86J5zJGL6lBg0gB0nYyyZGquAnpWaWRQJyim4jzax6cB1+DxzcYGGb+xMT
	o+VbxehS3XYO1yPJ+OCMpMBH+8q+YSHMd
X-Gm-Gg: ASbGncs+QV7FgIr9inhWGQCF+NSIMoQ+D+yuJUfE0U+pmcZIHKEUA2OcatzdNdYOOym
	RZCvSp4g8w5GSh8prqktw3Bg1Nh0QxWu5SEiAR+596f/ibTEjod4BdbCHIR0QrYAvIfdvvwlhjf
	RZQuiqBvPGSO531+PpfDizzNTDZh/F35MDGf8GXC0BQIc=
X-Google-Smtp-Source: AGHT+IEr08TMAyUm/9QQeyOr8KtPuKG/2U/rWccNP+stG8wlpLFB4BxjyikCZYcP3mPRpTPOOjPaBYqBpGjiTDqKrjE=
X-Received: by 2002:a05:6e02:1a24:b0:3d8:1ea5:26d1 with SMTP id
 e9e14a558f8ab-3db6f7f1928mr21706145ab.18.1747188436093; Tue, 13 May 2025
 19:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
 <CAL+tcoCThLOL1AKPamh2fpeDjYEqvEber0Eddc2ZVxi6VAYJkQ@mail.gmail.com>
 <20250513222235.33fd1817970cd601b18e92cf@kernel.org> <CAL+tcoAGCdowY14QL7HEqbW3ewAJi0OXpWNVkbqq9cM6xRmLkg@mail.gmail.com>
 <20250514102908.6a431966ef5b0f5f197bdb48@kernel.org>
In-Reply-To: <20250514102908.6a431966ef5b0f5f197bdb48@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 May 2025 10:06:39 +0800
X-Gm-Features: AX0GCFuaJe8Eh3FWohwPcHBpERUmy5aA78jEO82YxPZonoGVPXH3QI8BQVKxTbQ
Message-ID: <CAL+tcoD63WBnmMeRhs77YBLEzsb4wQUYqO_U1wXcCUY4XNXptw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:29=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 13 May 2025 21:46:25 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > > > > > +
> > > > > > +     if (flags & RELAY_DUMP_BUF_FULL)
> > > > > > +             offset +=3D snprintf(buf, sizeof(unsigned int), "=
%u", full_counter);
> > > > > > +
> > > > > > +     snprintf(buf + offset, 1, "\n");
> > > > >
> > > > > Is there any reason to return the value as string?
> > > > > If it returns a digit value and the caller makes it a string,
> > > > > it could be more flexible for other use cases.
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > I will remove the above one as you pointed out in the next revision=
.
> > > > And it seems unnecessary to add '\0' at the end of the buffer like
> > > > "*buf =3D '\0';"?
> > >
> > > Sorry, I think you missed my point. I meant it should be
> > >
> > > /* Return the number of fullfilled buffer in the channel */
> > > size_t relay_full(struct rchan *chan);
> > >
> > > And keep the snprintf() in the blk_dropped_read() because that functi=
on
> > > is responsible for formatting the output.
> >
> > Oh, sorry, it's not what I want because (please see patch [4/5] [1])
> > relay_dump() works to print various statistics of the buffer. In this
> > patch, 'full' counter is the first one.
> >
> > [1]: https://lore.kernel.org/all/20250512024935.64704-5-kerneljasonxing=
@gmail.com/
>
> Yes, that's why I asked you to make it just returning raw value.
> The string formatting of those values is blk_dropped_read()s business
> (because it is a 'read' callback), not for relayfs.
>
> For example, other relayfs user wants to summarize the values or
> calculate the percentage form that value. Also, we don't need to
> bother to check the buffer size etc, because blk_dropped_read()
> knows that.

Oh, it makes sense. Thanks.

I will make relay_dump() return raw value which depends on what kind
of flag caller passes, like RELAY_DUMP_BUF_FULL or RELAY_DUMP_WRT_BIG
or even more other info. On top of that, I can then get rid of the
annoying buffer-related code snippets :)

Thanks,
Jason

>
> >
> > >
> > > static ssize_t blk_dropped_read(struct file *filp, char __user *buffe=
r,
> > >                                 size_t count, loff_t *ppos)
> > > {
> > >         struct blk_trace *bt =3D filp->private_data;
> > >         char buf[16];
> > >
> > >         snprintf(buf, sizeof(buf), "%zu\n", relay_full(bt->rchan));
> > >
> > >         return simple_read_from_buffer(buffer, count, ppos, buf, strl=
en(buf));
> > > }
> > >
> > > But the question is that what blk_subbuf_start_callback() counts
> > > is really equal to what the relay_full() counts, because it seems
> > > relay_full() just returns the current status of the channel, but
> > > bt->dropped is the accumlated number of dropping events.
> > >
> > > This means that if the client (reader) reads the subbufs the
> > > number of full subbufs will be decreased, but the number of
> > > dropped event does not change.
> >
> > At least in this series, I didn't give the 'full' counter any chance
> > to decrement, which means it's compatible with blktrace, unless
> > __relay_reset() is triggered :)
>
> Ah, OK. I missed what [1/5] does. I agree that this does the
> same thing.
>
> >
> > While discussing with you on this point, I suddenly recalled that in
> > some network drivers, they implemented 'wake' and 'stop' as a pair to
> > know what the current status of a certain queue is. I think I can add
> > a similar thing to the buffer about 1) how many times are the buffer
> > full, 2) how many times does the buffer get rid of being full.
>
> Sounds nice.
>
> Thank you,
>
> >
> > Thanks,
> > Jason
> >
> > >
> > > Can you recheck it?
> > >
> > > Thank you,
> > >
> > > >
> > > > While at it, I'm thinking if I can change the return value of
> > > > relay_dump() to "how many bytes do we actually write into the buffe=
r"?
> > > > Does it sound better?
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > Thank you,
> > > > >
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(relay_dump);
> > > > > > +
> > > > > >  /**
> > > > > >   *   relay_file_open - open file op for relay files
> > > > > >   *   @inode: the inode
> > > > > > --
> > > > > > 2.43.5
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
