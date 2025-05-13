Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573944C63;
	Tue, 13 May 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106492; cv=none; b=g6KOXkRanqt6MiLJQ85vX1ZXjryiqebrzpC4ImfzOeq1I3Ab0IdyawnG79ULIuFY5usHJRTesA9LFXLzimb9Ve82rmT/hYyma8DgfdF2WP4gr/kFUcEDLcaNRuJHOjJUVYp+6XMlZUpDEM6iw9Cf+m2uDiciF/nJz0rkKbZgkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106492; c=relaxed/simple;
	bh=qcfKQ5D5y8OOPK2xGw5M4b8dJ7pf+xBaVlo24qWVweg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TnHgQH9CiBo5mbKVGnV8olpEdBJwd17U6w2/rplkEYmiVXw4HuG2KoKVQu8grLgQFMjyy9yrVAHBHFyBewtpm0shMvOZH88pT5+Is+UWBle9LakH7uFGH8H+K19QHkvb4TD3nR8RVnZ2nUjAVFvivhXyZA0GjvH4dFRfTH4AVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xI5KcCgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xI5KcCgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332B8C4CEE7;
	Tue, 13 May 2025 03:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747106491;
	bh=qcfKQ5D5y8OOPK2xGw5M4b8dJ7pf+xBaVlo24qWVweg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xI5KcCggP8nXIDI8AsksCGmaorrWHWM/usaXFFJ8oTg7rMEjCvnvYm6u6K73u4vP7
	 9NLOv3WLlJxrpK9UIadAuqaPam8PcAlb7JOr1Ux6VUDS4Nqz6Bf/mY1t13WGpyoNLh
	 PkLPyi+X47WqeafYJxkgGweQfXTLS0+7its1IG7I=
Date: Mon, 12 May 2025 20:21:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 5/5] relayfs: uniformally use possible cpu iteration
Message-Id: <20250512202130.39dfeee8606354cd3fc1b9ce@linux-foundation.org>
In-Reply-To: <CAL+tcoDou6ewCSD3LDSBTTtJwB0Bxp13v6PzRSbyaemg8KWDOw@mail.gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-6-kerneljasonxing@gmail.com>
	<20250512175204.8faa5fd646da7247137db14b@linux-foundation.org>
	<CAL+tcoDou6ewCSD3LDSBTTtJwB0Bxp13v6PzRSbyaemg8KWDOw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 10:03:01 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> On Tue, May 13, 2025 at 8:52 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 12 May 2025 10:49:35 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Use for_each_possible_cpu to create per-cpu relayfs file to avoid later
> > > hotplug cpu which doesn't have its own file.
> >
> > I don't understand this.  Exactly what problem are we trying to solve?
> 
> The reason behind this change is can we directly allocate per possible
> cpu at the initialization phase. After this, even if some cpu goes
> online, we don't need to care about it.
> 
> The idea is directly borrowed from the networking area where people
> use possible cpu iteration for most cases.

I'd rephrase that as "I know this is wrong but I'm lazy so I'll do it
this way for now and I'll fix it up later but I never actually do so".

Yes, handling hotplug is a hassle and for_each_possible_cpu() saves a
couple of hours at development time, but its cost is forever.

> >
> > > Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  kernel/relay.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/relay.c b/kernel/relay.c
> > > index 27f7e701724f..dcb099859e83 100644
> > > --- a/kernel/relay.c
> > > +++ b/kernel/relay.c
> > > @@ -519,7 +519,7 @@ struct rchan *relay_open(const char *base_filename,
> > >       kref_init(&chan->kref);
> > >
> > >       mutex_lock(&relay_channels_mutex);
> > > -     for_each_online_cpu(i) {
> > > +     for_each_possible_cpu(i) {
> >
> > num_possible_cpus() can sometimes greatly exceed num_online_cpus(), so
> > this is an unfortunate change.
> 
> Are you worried about too much extra memory to waste in this case?

That, and the cost of iterating over 1024 CPUs instead of 4 CPUs!

> A relevant thing I would like to share here:
> To keep the high performance of transferring data between kernel space
> and user space, the per-cpu mechanism is needed like how relay works
> at the moment. It allocates many unnecessary/big memory chunks
> especially when the cpu number is very large, say, 256. I'm still
> working on this to see if we can figure out a good approach to balance
> the performance and memory.
> 
> > It would be better to implement the
> > hotplug notifier?
> 
> Right, but sorry, I hesitate to do so because it involves much more
> work and corresponding tests.

I did this conversion a few times, a million years ago.  It's
surprisingly easy.

