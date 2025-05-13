Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13B1C07C3;
	Tue, 13 May 2025 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101821; cv=none; b=a1nTrkR78KASKJQfJb64G0v7wGhP7tNX4QFv1h8qwSeyo/H1p3wRr5cIDmb891YRW0McVxli16VP8CU9eWmH/oKy6e7DcFLwPdznLSYqroye+BZGPxNWUfCbQIkK/x8viJc+yW9gUG2Hlsg0ihn/vi/2imTbPrGDI4yPzNHmcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101821; c=relaxed/simple;
	bh=zMKEOI34vT+d1qJw9UiVZWYBl9J1VnodK8VFRFXfbLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlFw+Sh5OJv4fWpmspfJ05ACrprLObR/n07Si5OokW67Z9bHfvyP1tKGW4wtF84KLDl1aqlKjWe32RGyjvx5dwQakK9W5QwADVtSyyHkxpbzFkv7YzibjNaJDzi3A8L3UWOdKZDdHcAnZenJpQVfKvjG/fhsm9x79gc0xl1RqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muLePaYo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muLePaYo"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so30257855ab.1;
        Mon, 12 May 2025 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747101818; x=1747706618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9UYIN7YaysMKZL6W+eJK16Oz4mz6hJREhVhFroIGAE=;
        b=muLePaYoz+3vh3jLHI39N2Hn9YZXRH5PsIyhtu8X7mnyBfihixtB5BaSYom88zoC38
         8ptDHBFRMHjWNsqLyzP1Lb+PDUFd7gIK1VEuYCbm/MvX+Ij+Q1Z/69nVZUp2D+LQkxpl
         7qkIuUTl2pcvfPLwqDOtNaWTDExiCpNAfBA6kuus99i3Tc+j7BSSHbvJgWXkfG8nC8My
         vudrJ6RH1h+OQN1bOxpNVerVcBsJjjFApmDsjVOz7SbzSjSLHg+G9hJ9LlGXMGXVFBnv
         3rNUZcEWux085JtJG545pg5JMrtGL8qrCGS/Mt7a4VXTOiW5CpGxs+czaw5e2BvIEEvw
         8PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747101818; x=1747706618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9UYIN7YaysMKZL6W+eJK16Oz4mz6hJREhVhFroIGAE=;
        b=NmRCXqtFfEfKtqx2mqZ2AWLJV8VG7YN8SXtb99s/z4zrFW7pSNI70r+bckWdlXTUbi
         qFgZXVDTaPt2ri6OHMrgZVbVPpYQinTFX5syQVS2LcFWCJCXqF76+GOs6l1mFfc09KbG
         R2MKfMNNA6wJMvQuftse1atzbWKb77eQmecddpZONumXVuQ5Vm3eZxSVsgJqoMsYWD75
         7hQl6A9viXSWwYC/Fnh8c5+arEALx5qljStlsmmYMqsF5NvG01Axl2NkBLTmcksNXFd0
         jHZ6BzDyt6qjHV/lCqzPqjy+cw5C292QJ9tYmQKthMeuf1nFVdxfACbOx93LR3HN6sjJ
         hwIA==
X-Forwarded-Encrypted: i=1; AJvYcCUq6j05Xd2bwqvi5oU51+yAw3nOZEgYWBg4YDDlCoLLeRLK5F/ALCVDlA5vj86cCp6/FZGepRxKCujKz0Yv@vger.kernel.org, AJvYcCX8fMrzQ4AZOmFLFDDwVEuyKYFn5fpJgNYi4PaWbx+J6mvWDmhjZLD98Agn0TzkOKbAfHU/hdeh2dTX9w==@vger.kernel.org, AJvYcCX8q0pl8nBOCV6uDSjso6D11qXkcvBNok8uNCY8LlITzLoEOvFa1wYAl+VpZaPB5pwU1GtOoghKU12KXiGTePsoQ2Mq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/5q4I6sNax3LDYS5wGqe4CC0SlF5H947u7BkO96ALqrP3ANw
	X3Z69tgrWd9zRzWPKLerAKWI5dG4B9W46Aq/DwcjoGnvtzr177QfLT1t4MgTM+rFhSV7PSek5a2
	FFfha2aGh+de3Q5hW5BDFRi7xAgk=
X-Gm-Gg: ASbGncv7J6CnXY7jQofSNaQJTKD0A7HxVcn4tMDrmb48yOVPVWjw11hvZr3BxERsmmA
	4/6uYVleYnA9KTgKoztq6iT+C1RMrekDReWv1+EXejw0+ylewErbSoDUDzv9n8lMiRsu2o/CGyn
	ZCXIwAJXv0p8FVyHpaTV4G78I3qBaU+YrS
X-Google-Smtp-Source: AGHT+IFoWWambxOVFW3EY4PKaIMYTyZ3gTLHHAYsjloYE2Sy0FuB0epExbiEnFt48zaiBUtZwLSPy/cpoamStCoAMUs=
X-Received: by 2002:a05:6e02:3812:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3da7e203ed4mr190372055ab.18.1747101818174; Mon, 12 May 2025
 19:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-6-kerneljasonxing@gmail.com> <20250512175204.8faa5fd646da7247137db14b@linux-foundation.org>
In-Reply-To: <20250512175204.8faa5fd646da7247137db14b@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 10:03:01 +0800
X-Gm-Features: AX0GCFsJqhnBbhJJkA_z6zAQ9a5IFVz_32J2f7krMSuzQny8XMIizQpd6kJE_VI
Message-ID: <CAL+tcoDou6ewCSD3LDSBTTtJwB0Bxp13v6PzRSbyaemg8KWDOw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] relayfs: uniformally use possible cpu iteration
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:52=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 12 May 2025 10:49:35 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Use for_each_possible_cpu to create per-cpu relayfs file to avoid later
> > hotplug cpu which doesn't have its own file.
>
> I don't understand this.  Exactly what problem are we trying to solve?

The reason behind this change is can we directly allocate per possible
cpu at the initialization phase. After this, even if some cpu goes
online, we don't need to care about it.

The idea is directly borrowed from the networking area where people
use possible cpu iteration for most cases.

>
> > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  kernel/relay.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/relay.c b/kernel/relay.c
> > index 27f7e701724f..dcb099859e83 100644
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -519,7 +519,7 @@ struct rchan *relay_open(const char *base_filename,
> >       kref_init(&chan->kref);
> >
> >       mutex_lock(&relay_channels_mutex);
> > -     for_each_online_cpu(i) {
> > +     for_each_possible_cpu(i) {
>
> num_possible_cpus() can sometimes greatly exceed num_online_cpus(), so
> this is an unfortunate change.

Are you worried about too much extra memory to waste in this case?

A relevant thing I would like to share here:
To keep the high performance of transferring data between kernel space
and user space, the per-cpu mechanism is needed like how relay works
at the moment. It allocates many unnecessary/big memory chunks
especially when the cpu number is very large, say, 256. I'm still
working on this to see if we can figure out a good approach to balance
the performance and memory.

> It would be better to implement the
> hotplug notifier?

Right, but sorry, I hesitate to do so because it involves much more
work and corresponding tests.

Thanks,
Jason

>
> >               buf =3D relay_open_buf(chan, i);
> >               if (!buf)
> >                       goto free_bufs;
> > @@ -615,7 +615,7 @@ int relay_late_setup_files(struct rchan *chan,
> >        * no files associated. So it's safe to call relay_setup_buf_file=
()
> >        * on all currently online CPUs.
> >        */
> > -     for_each_online_cpu(i) {
> > +     for_each_possible_cpu(i) {
> >               buf =3D *per_cpu_ptr(chan->buf, i);
> >               if (unlikely(!buf)) {
> >                       WARN_ONCE(1, KERN_ERR "CPU has no buffer!\n");
> > --
> > 2.43.5
