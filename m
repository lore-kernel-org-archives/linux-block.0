Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8589139CFA;
	Tue, 13 May 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100294; cv=none; b=ObMPi2SklLy9KK28VzTsTP7VXeIphFTCtqhZqzWUOxXEaZY+RMPzrB0unVTPAaOPTO6JFOc0TRV/tVDKOnyRLwD546Rzn8DK8d4vY2mz0tFgM1QFzJcu/z/ID9+/Y4vjmNdzS525N2HoFqypnnenBj+yGOi1ujF5gWoj1+MmEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100294; c=relaxed/simple;
	bh=rMY8QKuKuEmCv9b2YVyG5lCTg1KwhM3ScRnRf/VnU2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9Cpg3xKb16CPE2u86HDfEo2b0DfhEFjxA9OYkqYqsAY0cXiQ0knT+AfWLRChhHJ+W8Ewk5REV1/CqIVhkH1qqRzag0RfeVGw95h/FGMYaUaBbuTr8I8bIqIU1inJxTvyEZNqlhiXFIJsN7QWvAJF1dLrvwTp0+B4jrUDdeTFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHfjGUE1; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHfjGUE1"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d93f4fe5baso19004815ab.2;
        Mon, 12 May 2025 18:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747100292; x=1747705092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItloyKp2wT3VEtFun2Jj5Eo9ey2aM5C1PK5HssRwl3k=;
        b=LHfjGUE1dQzXhdP0mzKlgMH1AAUeSboa3ibgyUodJme/XWG27YnHNqvyH9G2Ca/ytT
         JePFEhQT1WgtXlsVBI5n7wkItr8MP1wV2xeZ5HfMVma0yTsmLxrqysjY4L+zd7koPPtq
         h8UJdH+lWmQhnPB7Na6pY5HP0RjIbeNNJgtv3h1+Ahc3a+U/8qsiHgsPLghAT7kAl0Cj
         sCjzAXpSHDWc9lh6Owmv3Oeh09wLSV7VGmIRPDzUZHP4s0abgwL15AXoJ9NGMCKZeaZN
         dLr8FuFtn9cdqLoy1D705UzUl42nqUetun/zFXiEZRV3b+yT1eVqcvjQwj6HVjee+tV5
         a+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747100292; x=1747705092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItloyKp2wT3VEtFun2Jj5Eo9ey2aM5C1PK5HssRwl3k=;
        b=r04NtqRzkiiQXhtlXucfXZ5rUzvO18QLvaUF0xCjjHvEgI3G1Z3b/0nhJ1mXEuVX1x
         cwSiKmim/3R9Xi9J4SNest9NgaOSVTCtjCACQbSjwcyRzLsl7LiQaZLA/S4WZSICHzKx
         33uouqM+ahf6a49Oe9OoLAzGCyxhJliAKSxNkJRpeImmTn3qoypgD89SLMS5lJVC4Bvd
         Xf9OK1Gf9+b2kNP2B0kAYdHFTOkO72M0cHbP2ySrzMpqUaruXDp+7I+aP5rX9U+MudUm
         NDqphDoh7SbKq6xWW/NC9ufLSiU9UBw64Is3jnjjEJuI5H3FFERvsY5Yk9bQaj5U82fP
         VYWA==
X-Forwarded-Encrypted: i=1; AJvYcCUvepPsCOj6dX0m7cdIa0VdV4U5jz0ZbnTRwEKxloeTeJdRLsxE8YDwMz7BaA64/TaosHAajgMw6e0Cp1vg@vger.kernel.org, AJvYcCVgg3kC777UtPfYkmqPyda2ORjsbZ6EXJ6tQ0HUuxN2O4/Hm+ZYy8hFtyzy++gX2BABgPfMvjDOCb9noc3wtBDkZQUk@vger.kernel.org, AJvYcCWgvLmmVJrqH9VUeAXDFaVm4mJfqPcWsPSoUl1Fu/j+FY9nHcz2GEa2vmlZP+QO5Zvoqouz4B3HYv/Lxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC49V2Ox/1cs7VR8wOlGnwtRCASmFWhU4lvO2Bd/1D3PruVCTi
	bJn271qu08+XijvG4DKNgOcg2fPI7xuJAYVg0mK62xDdmrwL4/6Aow0AYdh/qWcA0u0PL0M/LLw
	v76v8s2Wkiylq74/Ki9IucMWdQBA=
X-Gm-Gg: ASbGncvtf3zN4fkMqPQnZKlY/KDA6NgbmAcl1+BCdiFCgp/PtO/969Eubqt6Zos2YpI
	rVP0r+Fxq/pA4te1MOA3r/DU0R+2H9rjAeV3F3qRzNncBH1MKGJ990709UK/HRSWR0AUqA0+viV
	jcQflWZzXnvjoN5GSy/QNGuXU+I7+8YWUT
X-Google-Smtp-Source: AGHT+IEv1YpUbXgDXULtYLVZnHNMU1Kaq+ATDb0MvJOs/GobAiWUqfb65TrkKLVCYjrMgY32QRRzPIYG0ZzVoTTQTcU=
X-Received: by 2002:a92:c26d:0:b0:3d8:18d4:7bce with SMTP id
 e9e14a558f8ab-3da7e1e23eamr172143355ab.2.1747100291724; Mon, 12 May 2025
 18:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-2-kerneljasonxing@gmail.com> <20250512175147.925bcdcd5f6cfa71def08bb0@linux-foundation.org>
In-Reply-To: <20250512175147.925bcdcd5f6cfa71def08bb0@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 09:37:35 +0800
X-Gm-Features: AX0GCFsRxo9BHC4YFMiDvpsa15eOQmRsONH6wMsXlKcF5AYgO_baKFV1J_NjUPA
Message-ID: <CAL+tcoAgur5MNODLbGP2zRje8T22KgekwSOvxfLnKvGFupO9ag@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] relayfs: support a counter tracking if per-cpu
 buffers is full
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:51=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 12 May 2025 10:49:31 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add 'full' field in per-cpu buffer structure to detect if the buffer is
> > full, which means: 1) relayfs doesn't intend to accept new data in
> > non-overwrite mode that is also by default, or 2) relayfs is going to
> > start over again and overwrite old unread data when kernel module has
> > its own subbuf_start callback to support overwrite mode. This counter
> > works for both overwrite and non-overwrite modes.
> >
> > This counter doesn't have any explicit lock to protect from being
> > modified by different threads at the same time for the better
> > performance consideration. In terms of the atomic operation, it's not
> > introduced for incrementing the counter like blktrace because side
> > effect may arise when multiple threads access the counter simultaneousl=
y
> > on the machine equipped with many cpus, say, more than 200. As we can
> > see in relay_write() and __relay_write(), the writer at the beginning
> > should consider how to use the lock for the whole write process, thus
> > it's not necessary to add another lock to make sure the counter is
> > accurate.
> >
> > Using 'pahole --hex -C rchan_buf vmlinux' so you can see this field jus=
t
> > fits into one 4-byte hole in the cacheline 2.
>
> Does this alter blktrace output?  If so is that backward-compatible
> (and do we care).  Is there any blktrace documentation which should be
> updated?

Thanks for the review.

Surely no, I tested blktrace by running 'blktrace -d /dev/vda1' to
verify the dropped field after the entire series applied. So it's
compatible.

>
> Also, please check Documentation/filesystems/relay.rst and see if any
> updates should be made to reflect the changes in this patchset.

Right, will do it accordingly.

>
> I'm not really clear on the use cases of this counter - perhaps you can
> be more verbose about this in the changelog.

Will add more.

The existing code 'blk_dropped_read' in blktrace might give you a
hint. In real production, we sometimes encounter the case where the
reader cannot consume the data as fast as possible, which leads to
data loss.

>
> > diff --git a/include/linux/relay.h b/include/linux/relay.h
> > index f80b0eb1e905..022cf11e5a92 100644
> > --- a/include/linux/relay.h
> > +++ b/include/linux/relay.h
> > @@ -28,6 +28,14 @@
> >   */
> >  #define RELAYFS_CHANNEL_VERSION              7
> >
> > +/*
> > + * Relay buffer error statistics dump
> > + */
> > +struct rchan_buf_error_stats
> > +{
> > +     unsigned int full;              /* counter for buffer full */
> > +};
>
> Why a struct?

It is because I'm going to add more counters related to the error
information, like patch [4/5]. Does it make any sense?

>
> >  /*
> >   * Per-cpu relay channel buffer
> >   */
> > @@ -43,6 +51,7 @@ struct rchan_buf
> >       struct irq_work wakeup_work;    /* reader wakeup */
> >       struct dentry *dentry;          /* channel file dentry */
> >       struct kref kref;               /* channel buffer refcount */
> > +     struct rchan_buf_error_stats stats; /* error stats */
>
> Could simply use
>
>         unsigned int full;
>
> here?
>
> Also, the name "full" implies to me "it is full".  Perhaps "full_count"
> would be better.

Got it. Makes sense to me.

>
> >       struct page **page_array;       /* array of current buffer pages =
*/
> >       unsigned int page_count;        /* number of current buffer pages=
 */
> >       unsigned int finalized;         /* buffer has been finalized */
> > diff --git a/kernel/relay.c b/kernel/relay.c
> > index 5aeb9226e238..b5db4aa60da1 100644
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -252,8 +252,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
> >  static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
> >                             void *prev_subbuf)
> >  {
> > +     int buf_full =3D relay_buf_full(buf);
> > +
> > +     if (buf_full)
> > +             buf->stats.full++;
>
> I don't understand the changelog's description of this, sorry.
>
> Is it saying "this operation is protected by a lock"?  If so, please
> specifically state which lock this is.
>
> Or is it saying "we don't care if this races because the counter will
> be close enough".  If so then maybe so, but things like KCSAN will
> probably detect and warn and then people will want to address this.
>

Sorry for the confusion. I meant the whole write process should
perform with the lock protection which users are supposed to pay more
attention to. User calls __relay_write which means he already
considers the racy case, adding additional lock before writing. On the
assumption that the whole write process is protected, there is no need
to add any form of lock internally (even like atomic operations) to
ensure the consistency of full_count.

I will revise it in the next re-spin.

Thanks,
Jason
