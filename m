Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7AEAF9;
	Tue, 13 May 2025 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106749; cv=none; b=fMq1zLcFwpEZ2Ugm2LViNH1ruEHEVecNlNBVVJE+cy5wiVVn+6hVojHx3M8hzCghiUFhxoAospwevfAJ/Z9mOFFhFFIWNb0kZ62lRSN3WpU5c4BeWrWDy2YHt/LosU+bNOZv8FG5Vt6BEExmliZNwIau+jf5hMYrrb2xclG3wi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106749; c=relaxed/simple;
	bh=15qup9w8vOtcNdhSWc2v14danfftapn2rxQ27rsNef4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvc6R4Mtm12TnwynpuvyxNbwZe7gmhIbYSbjUBZXr6rTGiyMu3STNmNss2kZNzpsZUC9lm37RXp4C6iutFnT+b0sssxAzUXJ0P4MPUstg44IJZXQNXyq9SMcGLXwtsfDBR2XUAig8K25A+OdQ/OajRX1xMs4Y62/ATytuRiCNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTEgKESI; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTEgKESI"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso19662745ab.1;
        Mon, 12 May 2025 20:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747106747; x=1747711547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM3SoQ83ToOhRs8JQ5sl3Vy6xItes6D4QfWjlEh6LLs=;
        b=KTEgKESIwXbCgoG8gLt5/7mcaSIhO5GWLb1pRDCeyOJ9fp3N1Vaez5X+3d2to3mBdX
         b7/X4i75pBXSwZDbuymdrc4crVHrb+1LWiqOl1b6QIfn7+Du8RcKO2KEuVKvcSR70NWg
         FBsL+3QtdNKDuFhHikNXjngvsJYk+uptBbT7gn6MrEemWWESeduG1eIU+iVUhv8CTQf+
         j2ZiiGdd7grW5Hx2sLqqUFnh9LcbRJLKy18ItezcBZ/7s6viaBEfmdhtNyUPSxWbroTD
         QMMvH9NwXsacDr7WRdNI/qKhe1o+R96tfMwXfk7uZyWTERqfdGZ/52EGDJywR/NX029n
         dAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747106747; x=1747711547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM3SoQ83ToOhRs8JQ5sl3Vy6xItes6D4QfWjlEh6LLs=;
        b=tOSByQEDeAzhnXrdlI13BZMxYrBv6OnHHDDcILqH26bT2heuqsZKlGuQJgjOnMNkiE
         wAiaGX8kl/l+68RGAogQZ3wcLATiikR0GBwzjGr7SY6/pk6+MQw9ahTgfzYHKIuADZ+U
         K5qCfApxzfxw8irKKXTcXzhPDwvI+66XN0KoxVi0Blley1lcKHJVGJKqGbPQ5n7isGMM
         QClvqwf9fF5XHcXz9/fAp/3zIVcy+mI52OSO1gU0DDK2dB4sONTyVBxfc3iixS4WGwuL
         9ZsBkxupM4FvrMUWIsRcnkIXugIxvm9OmcqV9ZTbBYLkpbgmWw/DZJsOqV3Kcg7wnKpr
         m0vw==
X-Forwarded-Encrypted: i=1; AJvYcCU17yy5wBMBFKX1u4/qHK9E5IOSWEnwIkDWizGYFYr6MnNEzufN5+Q681agT0d8AYG6rwXeOezPAGMtH15h@vger.kernel.org, AJvYcCVgg9qUPq+DRrfCgKatySjGGuipdk71dYlW6Y62j0VKIO9gZL+j7+zs7KRtxkyNFgXTmZ5roXqp0s9JJD1lLe0qW9qs@vger.kernel.org, AJvYcCXOZ1TdlBW5j1hfNFRyXha2kMZO1v8mmspyK3MdXzdQY2kF5K6wFvFzR4eoiciQhpCAu5S2q5cvFC71rA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8mo4YIcvl5gu4QQwyr7HuGTeVbSdOeNdKSVC8rQu17caIe2D
	aIHCnSFRlRjuHE6Uraw577p3mXCA0oeHw/cfx9pAxBeZ9unnpvEcL17pu/SPcobhQGZFIVKF/Cn
	o6TRwvXKMz9P+30GBYiGxeK8AfoafrwW2oJU=
X-Gm-Gg: ASbGncvCZP0IiS/foko/9eDTCgZmSvWfriJp5D61w7vo491MisDQtPoue2EawkAMVoN
	ldnjUXlXj5Hzy569QvoYb995uRyho/YaIPttZ8RMzZU6e7NWQIUvqKeR6xT9du0PKWEHy00AEfH
	uKW2svZpV3aY+BXE0ksjimR0PXGf++XD8=
X-Google-Smtp-Source: AGHT+IEPsElyxadkcmy4GcnqJYIDf6cRbOSZ+3suGJeA+LXgZR70jHCzaj5QqNkOk9wjQew8mKbeFB8eaZXHPLxD6c0=
X-Received: by 2002:a05:6e02:1a8d:b0:3d8:1d2d:60b0 with SMTP id
 e9e14a558f8ab-3da7e1e26e9mr166054385ab.5.1747106746831; Mon, 12 May 2025
 20:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-6-kerneljasonxing@gmail.com> <20250512175204.8faa5fd646da7247137db14b@linux-foundation.org>
 <CAL+tcoDou6ewCSD3LDSBTTtJwB0Bxp13v6PzRSbyaemg8KWDOw@mail.gmail.com> <20250512202130.39dfeee8606354cd3fc1b9ce@linux-foundation.org>
In-Reply-To: <20250512202130.39dfeee8606354cd3fc1b9ce@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 11:25:10 +0800
X-Gm-Features: AX0GCFuaVzAEKV6EVF1Zfs5wEl0cGUq4EkYfhq2iSrUNeWrmTIsiHZeD9cV4ip0
Message-ID: <CAL+tcoApBVuyra+K4UkL5euzpKbUZkvBToeQNvmaspRu1ywOSA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] relayfs: uniformally use possible cpu iteration
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:21=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 13 May 2025 10:03:01 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > On Tue, May 13, 2025 at 8:52=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Mon, 12 May 2025 10:49:35 +0800 Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Use for_each_possible_cpu to create per-cpu relayfs file to avoid l=
ater
> > > > hotplug cpu which doesn't have its own file.
> > >
> > > I don't understand this.  Exactly what problem are we trying to solve=
?
> >
> > The reason behind this change is can we directly allocate per possible
> > cpu at the initialization phase. After this, even if some cpu goes
> > online, we don't need to care about it.
> >
> > The idea is directly borrowed from the networking area where people
> > use possible cpu iteration for most cases.
>
> I'd rephrase that as "I know this is wrong but I'm lazy so I'll do it
> this way for now and I'll fix it up later but I never actually do so".
>
> Yes, handling hotplug is a hassle and for_each_possible_cpu() saves a
> couple of hours at development time, but its cost is forever.
>
> > >
> > > > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  kernel/relay.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/relay.c b/kernel/relay.c
> > > > index 27f7e701724f..dcb099859e83 100644
> > > > --- a/kernel/relay.c
> > > > +++ b/kernel/relay.c
> > > > @@ -519,7 +519,7 @@ struct rchan *relay_open(const char *base_filen=
ame,
> > > >       kref_init(&chan->kref);
> > > >
> > > >       mutex_lock(&relay_channels_mutex);
> > > > -     for_each_online_cpu(i) {
> > > > +     for_each_possible_cpu(i) {
> > >
> > > num_possible_cpus() can sometimes greatly exceed num_online_cpus(), s=
o
> > > this is an unfortunate change.
> >
> > Are you worried about too much extra memory to waste in this case?
>
> That, and the cost of iterating over 1024 CPUs instead of 4 CPUs!
>
> > A relevant thing I would like to share here:
> > To keep the high performance of transferring data between kernel space
> > and user space, the per-cpu mechanism is needed like how relay works
> > at the moment. It allocates many unnecessary/big memory chunks
> > especially when the cpu number is very large, say, 256. I'm still
> > working on this to see if we can figure out a good approach to balance
> > the performance and memory.
> >
> > > It would be better to implement the
> > > hotplug notifier?
> >
> > Right, but sorry, I hesitate to do so because it involves much more
> > work and corresponding tests.
>
> I did this conversion a few times, a million years ago.  It's
> surprisingly easy.

I see. Let me try this :)

Thanks,
Jason
