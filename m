Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574B1E520F;
	Tue, 13 May 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747115582; cv=none; b=ArnFg9Pw+2RUlCvqKf7dOJSw8BfnMaVAZYMEdG+OHMdVYBchN6d3JakV2qVgTNcLhkhycFaCHJHyko6QFPjCBBQIXwLBgasrDuJJYsXCgZG3+XMjTBJxhunCHOEPwOOB8/5Ap+Ewqt1k9mFPCR06/jC+JSrcalvVSYfHrkYyExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747115582; c=relaxed/simple;
	bh=qzoEG/KSWyPHrzMMAY6A0/isDGnZiB/gJkrsON+qzwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlB3awfJJOL1Mmj4WxfklLFOAGk8OwtnqEYC6ZCFwJYvofkRHOk0HGr297mIhWKBFJmlZzFpD1NkkcNrDYGkcwtGN/NUg8eWXRW2VemEEHUGR56MDTPJ0Xnoe9f8K+6H8UVu9u2GHIyY5GeDScSLijnxA1OW14eyjFXwBwvpOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9LHC095; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9LHC095"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d8020ba858so58123185ab.0;
        Mon, 12 May 2025 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747115578; x=1747720378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UNv9BVa0wuw40fppKUR+rAamisYbCt010QW3EVI8dY=;
        b=X9LHC0956XgfSG5eabE4yV1+gQFTSZRT8keckQ6HY54YHy89un7bY5SqXM9ozhoRxa
         ReeNCOeCHzTbO+uwgWhhRAylKMZkfmEJnwmZd+Lt8N45QeGcV4JnKRTfWmISEz9fVzwW
         Majuj9/qSKv6SA757SC0Ny+DnxS/Txu2WjiKQkMbzyPkYdxsQz4mg6NhFbQBE1yC+QvT
         /q7JHnTx8MHyxHJO5XuvO6Z+4VS7FVoGrtbv1Gtdxm0v2VKlUYxbtnbScBZufvG1XzmW
         kO93W97HWMax+0ybLhbgTBGXe6KbarMpB0S8ojAZ+hZshPOZgxxMAH0YjPeXyXSs4oN0
         lDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747115578; x=1747720378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UNv9BVa0wuw40fppKUR+rAamisYbCt010QW3EVI8dY=;
        b=ITfo9wELtpCqh+4n1W4w7p9jaM4WO7nmFYSyUwpkmk4eE7HDD4moYr6kCVgEby7If4
         tMQ1Yx2pfRKMVaqgpj3gQZWYI6GKtRroU91iDW/Te0JWsXYuvIpiGYK/h+WbC/T/HSg2
         rh4WYYCyd0ys2WdVvv5g+RhlLVrf8ghCSCbxil/Q09U9k5JREJECLBXXX5wPTUXFHsZN
         aNaaW3cyi25I5slYOxYqIVK3ozIOTvKo/fpIXueEU+Lhwp8c8fhPSL49hB2ImBSqHBr3
         aRSnSJ0fDD4DmdCsMQOTY1caNzaZBfDtAGGl4b+YpCJzsDwvBSPjSG41RrhX0PumQJCh
         PhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUquVPe/SCjoi6BBekG+/uAYRfZphMUVBC2WUz3RwmVAVtt7QjQsaqrFN7a1TUHQC2lwpuILII2Qamrwg==@vger.kernel.org, AJvYcCVUuVhJcA5HMso+Cbz4KLSv3QlYm0UoYrZUTlmDLPGMD146PYnz/6v0K8Q0qT573vaDaO31MB/3S1fJhpST@vger.kernel.org, AJvYcCXki/xFv065AJsaOckq6LwVObLyNWEkZ9rX1Ug/+7k4USUOprdcFj4R3OBCJYLP26CpJjKU016Ko3FGInHCJsuRcPO0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uMdqErRP3TF/CSdMxI3+ahrk9zuSTc4xqmJnmiCmbQ7kuJuT
	fV4lLbTM3ZysM7TwEWf+As4oUAI1rAtwHBm5lFTBghSwWDT7hbp9uuKnygpqgqWd6CNv+ZQPmDO
	oCltMSf0IRP6l9o0ZyGXEjrD+wqM=
X-Gm-Gg: ASbGncuotTbFDEXDmNRyJDASKkxgmzCPxURMUePS0nG6U3AJRV+EL17CF8uHFIQvSju
	uOPNXGmqH5pA71yZnI2eriAdMg/Nj1sbw7p6MvfwPaUYmDu05Y1pA2ZC5DHEvxS8fQzcZ2Rj1tr
	/TDPvCB6gKAvPg0eSTC5wV7eKVvuaWncjv
X-Google-Smtp-Source: AGHT+IG3hAXI4zZ0Ldsnxik78Vl6FoTPwK50ThHikc2cnUovntlaGx/YFJIOwEVPB3vcPgJY63ae+LGHOAWlwtG8Jhc=
X-Received: by 2002:a05:6e02:2292:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3da7e1dd00amr175999105ab.2.1747115578565; Mon, 12 May 2025
 22:52:58 -0700 (PDT)
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
Date: Tue, 13 May 2025 13:52:22 +0800
X-Gm-Features: AX0GCFsxQg_UtKWDCvOgy-HP5BnemXBkwL31IwrPtx5Xmq4NlyGSASE3erfnXAE
Message-ID: <CAL+tcoCN56fmQadhikyeg-PziM8OF7PitXufPR-rfGb1ko5Gcg@mail.gmail.com>
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
> this is an unfortunate change.  It would be better to implement the
> hotplug notifier?

For the record, the hotplug notifier has been retired by the commit
530e9b76ae8f("cpu/hotplug: Remove obsolete cpu hotplug
register/unregister functions"). And now in relay, a similar feature
called hotplug state machine has already been implemented by the
commit e6d4989a9ad1 ("relayfs: Convert to hotplug state machine"). So
the relay has hotplug support.

Sorry for missing this point. I would drop this patch.

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
