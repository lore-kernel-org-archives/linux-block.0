Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE43376AD
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481862; cv=none; b=XPO0jZHGbu8Th1UTymHdX4HLm/zuiSCLN4cC9wVfUPWNmH3msqUmJESyGk75N9O4HLRLEd59TLDSmTTeOUOLSd3vzsyPMS+RcoKNHzVbgHolW+PYhoQN2rlREY+BTA7RDqe3/zWTPWTbnN0/fVCEQVNg4iqwyeoZkPnhOvOHpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481862; c=relaxed/simple;
	bh=9YHgX8b0adqN/tsPpqnsXZcWRel1ohaegLgAc7vZ1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvsSkbopX0K2C/z+pqSFBf4bhETNGSgYJd1thu+W55DOr9qANhA8/U6EHN8jgS2syVL57WX4ANDiw4eF+42dLK/EUC0FJ1QJNTC43F7CYK/Q0cYa2wp9rpWu7hVaG6oQQNihsr/+AOcO/5gJay7QUZ3nXcePcB5ATu99HZWbfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UToaWQjU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UToaWQjU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2488be81066so5142615ad.1
        for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756481860; x=1757086660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsfm4QAgfacURObVvwz19ewMxcPM5l7DQIdKadFTk3o=;
        b=UToaWQjUswP8tc407jy/fF4XYZ6BOu+CoxWDUOuPr1q3IXxQnWqWhwuxc6AEKvGZ+m
         yOGFFflRC9p6SbjvdjOURIfyV1uyNDzRAa3Y08RyqVjnVR82ca9sxPh9W7pD52sP4QdC
         rfrhTmcg2bzDp3bYWSeiIJjlawc8CuGGLBJI6YoEOPSdCEZURu1N+HhXLhonce/VoV28
         I00ERKLhMzB/vF22Sz26tWdTGVq6vHAFY/6yLwXYfDX0Eq4wQ40t5OphB4Rm5elJFPyV
         sU3mKJj0CgjKR1wiFSOdVqSzZd9ZOSmusa2RWutiPC+4kTSqL8Z0v4b5RakL7G2gnhw5
         e5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481860; x=1757086660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsfm4QAgfacURObVvwz19ewMxcPM5l7DQIdKadFTk3o=;
        b=uBR+WbVtkB4R6W3SnbhA9PliHpyBCdSnlydQS6V9Ub6pgGK61NFeWo0lGch1Vz/UrG
         nFHsTEqySm5V7Dz6QCs6n7G8pZW4OwqsPQpPSusjdrcwLrCGVjfwaSIzI/wYMJaiidWf
         +yfMP+ui42zGdRcbg6qnszjv4nl/QHY8Mai/I0rDJn0aVjI98O2hII+eMC9j4tBqxez4
         YJLKMs11BywL0ZbNGWwwKI/sf4w4DxLZ+mJB5ERtdF5aubybPe/r2XEJg+/APcyQ4XCu
         0NqZkSv2Uy2lHdpkeZ31DUfrmhqQ7vpS+41lK0Nw7dp9yMzjCzuJ6OkkULRC3BfufLSU
         NHfg==
X-Forwarded-Encrypted: i=1; AJvYcCVhl+B6XK6OY9wS/hTI0+hxe+DxIEuhrPkC9KojShrEtG8tqC5daWkZRJ0Xh3yQ4f/giIkYSEyOc5nVqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6/hfnyFJ+uL0sp3o2IkxKkXZZmwQeNXHkp26qvOaoZVmaX8L
	/PaPPjTSp32Ia36J015dQNz6nDMofd938BsmTmtI6b0D/cAbMWvBPz0g6hs6xIZ+g5EyhFi+LfQ
	VyaMSPgGfiapHPAs5Ug12wn5rBRbC9k//GtyWXX0U4g==
X-Gm-Gg: ASbGncsllbxRDS5z81zRGmpmwOBp039wtioWGxTXFc7iDsdHKIYsdZCK9IKD4KlXgzv
	Wi1CKNIYP+GQgPrN5KXH/qU/k0J1PxvVjqD4DRs8qzKx9b2huE5Rn8LFpAIfhhEHkH3gi8kRIaD
	wI25hLg17rrDWYsC6v0cqK7TQX8siDYdD0OW8FHngkhJMrr8YEUsu6fbM2rNzTU6oMAM00n+0AG
	TE9aragGO+X
X-Google-Smtp-Source: AGHT+IGuAgV9atTfKT8eROLh18L+0SsWhfdNl6ob7zOmaIOBk/BKcr7zEWfh8iASpRyWT3f6OlryciwAuY/3pjBVB6k=
X-Received: by 2002:a17:902:ea0e:b0:246:a152:2afc with SMTP id
 d9443c01a7336-2490f6e2a41mr23899435ad.3.1756481859611; Fri, 29 Aug 2025
 08:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825124827.2391820-1-ming.lei@redhat.com> <20250825124827.2391820-2-ming.lei@redhat.com>
 <CADUfDZp1-Tg+Gp+9kaudFNYyz3mLjNn+v=H3wKLEoKDftcX1wg@mail.gmail.com> <aK1xLM9TLUBxEmmC@fedora>
In-Reply-To: <aK1xLM9TLUBxEmmC@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 29 Aug 2025 08:37:28 -0700
X-Gm-Features: Ac12FXykFvnj8HXOhHOxs4sVXY5eNMDF6CtibzpBIq4hVpgMoehFzfKlM1XFWFE
Message-ID: <CADUfDZqJ8PN8FT50gg0grJ+Kj+gOaosRctS_dimWAaRC-myfRw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] ublk: avoid ublk_io_release() called after ublk
 char dev is closed
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:33=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Aug 25, 2025 at 10:49:49PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Aug 25, 2025 at 5:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > When running test_stress_04.sh, the following warning is triggered:
> > >
> > > WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_rel=
ease+0x423/0x4b0 [ublk_drv]
> > >
> > > This happens when the daemon is abruptly killed:
> > >
> > > - some references may still be held, because registering IO buffer
> > > doesn't grab ublk char device reference
> >
> > Ah, good observation. That's definitely a problem.
> >
> > >
> > > OR
> > >
> > > - io->task_registered_buffers won't be cleared because io buffer is
> > > released from non-daemon context
> >
> > I don't think the task_registered_buffers optimization is really
> > involved here; that's just a different way of tracking the reference
> > count. Regardless of what task the buffer is registered or
> > unregistered on, the buffer still counts as 1 reference on the
> > ublk_io. Summing up the reference counts and making sure they are both
> > reset to 0 seems like a good approach to me.
>
> The warning in ublk_queue_reinit() is triggered because
>
> - the reference is not dropped
>
> OR
>
> - the io buf unregister is done from another task context(kernel wq), so
> both io->ref and io->task_registered_buffers are not zero, which is start=
ed
> from task_registered_buffers optimization

Right, but I would consider that to be an outstanding reference. I
think we're on the same page.

>
> >
> > >
> > > For zero-copy and auto buffer register modes, I/O reference crosses
> > > syscalls, so IO reference may not be dropped naturally when ublk serv=
er is
> > > killed abruptly. However, when releasing io_uring context, it is guar=
anteed
> > > that the reference is dropped finally, see io_sqe_buffers_unregister(=
) from
> > > io_ring_ctx_free().
> > >
> > > Fix this by adding ublk_drain_io_references() that:
> > > - Waits for active I/O references dropped in async way by scheduling
> > >   work function, for avoiding ublk dev and io_uring file's release
> > >   dependency
> > > - Reinitializes io->ref and io->task_registered_buffers to clean stat=
e
> > >
> > > This ensures the reference count state is clean when ublk_queue_reini=
t()
> > > is called, preventing the warning and potential use-after-free.
> >
> > One scenario I worry about is if the ublk server has already issued
> > UBLK_IO_COMMIT_AND_FETCH_REQ for an I/O but is killed while it still
> > has registered buffer(s). It's possible the ublk server hasn't
> > finished performing I/O to/from the registered buffers and so the I/O
> > isn't really complete yet. But when io_uring automatically releases
> > the registered buffers, the reference count will hit 0 and the ublk
> > I/O will be completed successfully. There seems to be some data
> > corruption risk in this scenario.
>
> The final io buffer unregister is from freeing io_uring conext in
> io_uring_release(), any user of this uring context has been done,
> so it isn't possible that ublk server is performing io with the
> un-registered buffer.

Well, the ublk server could have been killed before it could submit an
I/O using the registered buffer. But it's an existing concern,
certainly not introduced by your patch. I think you can make a
reasonable argument that a ublk server shouldn't submit a
UBLK_IO_COMMIT_AND_FETCH_REQ until it knows the I/O completed
successfully or with an error, otherwise it won't be able to change
the result code if the I/O using the registered buffer unexpectedly
fails.

>
> > But maybe it doesn't make sense for
> > a ublk server to issue UBLK_IO_COMMIT_AND_FETCH_REQ with a result code
> > before knowing whether the zero-copy I/Os succeeded?
> >
> > >
> > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on dae=
mon task")
> > > Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemo=
n task")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 94 ++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 92 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 99abd67b708b..f608c7efdc05 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -239,6 +239,7 @@ struct ublk_device {
> > >         struct mutex cancel_mutex;
> > >         bool canceling;
> > >         pid_t   ublksrv_tgid;
> > > +       struct delayed_work     exit_work;
> > >  };
> > >
> > >  /* header of ublk_params */
> > > @@ -1595,12 +1596,84 @@ static void ublk_set_canceling(struct ublk_de=
vice *ub, bool canceling)
> > >                 ublk_get_queue(ub, i)->canceling =3D canceling;
> > >  }
> > >
> > > -static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > +static void ublk_reset_io_ref(struct ublk_device *ub)
> > >  {
> > > -       struct ublk_device *ub =3D filp->private_data;
> > > +       int i, j;
> > > +
> > > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > > +                                       UBLK_F_AUTO_BUF_REG)))
> > > +               return;
> > > +
> > > +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> > > +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> > > +
> > > +               for (j =3D 0; j < ubq->q_depth; j++) {
> > > +                       struct ublk_io *io =3D &ubq->ios[j];
> > > +                       /*
> > > +                        * Reinitialize reference counting fields aft=
er
> > > +                        * draining. This ensures clean state for que=
ue
> > > +                        * reinitialization.
> > > +                        */
> > > +                       refcount_set(&io->ref, 0);
> > > +                       io->task_registered_buffers =3D 0;
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +static bool ublk_has_io_with_active_ref(struct ublk_device *ub)
> > > +{
> > > +       int i, j;
> > > +
> > > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > > +                                       UBLK_F_AUTO_BUF_REG)))
> > > +               return false;
> > > +
> > > +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> > > +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> > > +
> > > +               for (j =3D 0; j < ubq->q_depth; j++) {
> > > +                       struct ublk_io *io =3D &ubq->ios[j];
> > > +                       unsigned int refs =3D refcount_read(&io->ref)=
 +
> > > +                               io->task_registered_buffers;
> > > +
> > > +                       /*
> > > +                        * UBLK_REFCOUNT_INIT or zero means no active
> > > +                        * reference
> > > +                        */
> > > +                       if (refs !=3D UBLK_REFCOUNT_INIT && refs !=3D=
 0)
> > > +                               return true;
> >
> > It's technically possible to hit refs =3D=3D UBLK_REFCOUNT_INIT by havi=
ng
> > UBLK_REFCOUNT_INIT active references. It would be safer to check
> > UBLK_IO_FLAG_OWNED_BY_SRV: if the flag is set, the reference count
> > needs to reach UBLK_REFCOUNT_INIT; if the flag is unset, the reference
> > count needs to reach 0.
>
> It is actually one invariant that the two's sum is zero or UBLK_REFCOUNT_=
INIT
> any time if the io buffer isn't registered, so it is enough and
> simpler.

I think it's theoretically possible to make the reference count
arbitrarily high with ublk registered buffers, which can cause it to
actually have UBLK_REFCOUNT_INIT references (not because all
references are released) or the reference count to overflow back to 0.
One way to do this would be to register the same I/O's buffer in many
slots of many io_urings at the same time. Another possibility would be
to repeatedly register the buffer, use it in an I/O that never
completes (e.g. recv from an empty socket), and then unregister the
buffer. But this reference count overflow issue is an existing issue,
not introduced by the patch.

Best,
Caleb

>
> >
> > > +               }
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > > +static void ublk_ch_release_work_fn(struct work_struct *work)
> > > +{
> > > +       struct ublk_device *ub =3D
> > > +               container_of(work, struct ublk_device, exit_work.work=
);
> > >         struct gendisk *disk;
> > >         int i;
> > >
> > > +       /*
> > > +        * For zero-copy and auto buffer register modes, I/O referenc=
es
> > > +        * might not be dropped naturally when the daemon is killed, =
but
> > > +        * io_uring guarantees that registered bvec kernel buffers ar=
e
> > > +        * unregistered finally when freeing io_uring context, then t=
he
> > > +        * active references are dropped.
> > > +        *
> > > +        * Wait until active references are dropped for avoiding use-=
after-free
> > > +        *
> > > +        * registered buffer may be unregistered in io_ring's release=
 hander,
> > > +        * so have to wait by scheduling work function for avoiding t=
he two
> > > +        * file release dependency.
> > > +        */
> > > +       if (ublk_has_io_with_active_ref(ub)) {
> > > +               schedule_delayed_work(&ub->exit_work, 1);
> > > +               return;
> > > +       }
> > > +
> > > +       ublk_reset_io_ref(ub);
> >
> > Why the 2 separate loops over nr_hw_queues and q_depth? Could they be
> > combined into a single nested loop that waits for each ublk_io's
> > references to be released and then resets its reference counts to 0?
> > Looks like the ub->dev_info.flags checks could also be consolidated.
>
> This way looks more readable, otherwise ublk_has_io_with_active_ref()
> has to check and reset. Not a problem, I can move it to one single helper=
.
>
> >
> > > +
> > >         /*
> > >          * disk isn't attached yet, either device isn't live, or it h=
as
> > >          * been removed already, so we needn't to do anything
> > > @@ -1673,6 +1746,23 @@ static int ublk_ch_release(struct inode *inode=
, struct file *filp)
> > >         ublk_reset_ch_dev(ub);
> > >  out:
> > >         clear_bit(UB_STATE_OPEN, &ub->state);
> > > +
> > > +       /* put the reference grabbed in ublk_ch_release() */
> > > +       ublk_put_device(ub);
> > > +}
> > > +
> > > +static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > +{
> > > +       struct ublk_device *ub =3D filp->private_data;
> > > +
> > > +       /*
> > > +        * Grab ublk device reference, so it won't be gone until we a=
re
> > > +        * really released from work function.
> > > +        */
> > > +       ub =3D ublk_get_device(ub);
> >
> > Can taking a reference fail here? If so, the NULL return value would
> > need to be handled. If not, the "ub =3D" could be dropped.
>
> Of course it has to get a reference, otherwise it isn't safe to use `ub`
> is the release handler, I will drop "ub =3D".
>
>
> Thanks,
> Ming
>
