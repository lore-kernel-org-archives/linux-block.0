Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814986342
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187404; cv=none; b=VIpbdKkDA5Ppk6x0uQMPfZUiAeTrKPpp42VHTRAT5HLclv1qohdpvWugZJPiJhMbIoCD+SF/i7lMaxK842sFCX+mK/p2F77B2mFP94TO2l6kOeSsa929u9lE+nCZ/JemNv5D6Y1H/2p0tHf4LAfFZ5nAMf4PaDugsJNvX9X12Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187404; c=relaxed/simple;
	bh=kEA0r8A6aVn6IJrSsmPRBEHj9T+/+xN9SdoOLY/gTqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPOTiHpu09QMLy9/plHAfEXgblvgd0QVYXc24osOjGR4Whdfqj86AU7X4JVJy+fOfdxYVrCQsmR1v2K/IhYVN/UbDtzy/rlVnBu7LTgc+db09Q8fNjOzxpCMRpbttzhFKyCyNUjEFxhFtXP65ZypDQEcm4mEP6NEImGcmgEImtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RyMuhmZu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RyMuhmZu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24616371160so6329745ad.1
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 22:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756187401; x=1756792201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUd+JvK+dYWrh1PXGLaNj6KVOpzUlm+VqqwldQgY1AE=;
        b=RyMuhmZuyV9Ovja0f7QKMHHcL749M47khoZF2r4qyjWxHj/pkE/Bh9dSOrqHMmdxzM
         UBXc4fvz6+beY8PnieCH++QV98nx1nCSvm4o8+g9461bK2e1mFV0fUOWLvuqYSxuYtAb
         aGNVLbn6VSGBrMsZvPMGgWjk3NfUlYvGCMXSgyw5iIK84xmjgAqjGku0R9/2PoBVQs9j
         bOl7iZyMgIQs5xXc6KcSrP/M/9jZfJUcBOB7PJd9CsVH4vkKl3ZQVrt1gwoHFoOW7X9U
         cXGt7XWBpEsdYm8UxilQ5d6gdAWj3eEJOFWdhUM+TvQbDJnt5vAcGfHJ89+O6nb6H1aE
         L0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187401; x=1756792201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUd+JvK+dYWrh1PXGLaNj6KVOpzUlm+VqqwldQgY1AE=;
        b=igOaT7eni3kwCsN0mXCUP4zw/YcFPHaqHhWoWx2oLkLuyg5yjjYtV8I9E/9qzLK2Wb
         ems5llEKUjaNHCv6mjLWtSn59Nc3nkvHK93dj61J6P/vq3ESODM5c0fxdC3mFVSTTmhz
         JYIuB3taGaVimjf9XYj7X9E2dkZtuh7RCE+3z7yAPpjC3LjX7WkzP9khjkLdsCucfFxP
         TgeViyAjt6Ct3eBMQC5dGnSONp0jBg5+K2v2s0Qu+iEB3sTRn6XRYko3HJ6wDxRU7yLu
         3RV+Q8NGl3NHJYK5NTjZgCpwmoMFM+Aonj6ogrVFQCf9cnXAWeciF/Bb+WIhxVEnQs2h
         Mghg==
X-Forwarded-Encrypted: i=1; AJvYcCWosm9+IpMRc8cCuWC6PsS8Oc8iEvbFpqmu9nKJjRmirZHSM4kIk2SqbR6eq7i7KmVklTdyCQ9GV2U7mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyt+lkpvZtiWMLU6zlLgGpLgUJPMnpx3gnAqyRzJ75IDsX6RG
	Q5GwA+VWXpqjA3x7Kz8fNIbSv6wasoio7vom3JaSdeUGCUJdv80NY3PLsI6N0+hD9tYdAYv2N3Y
	sPsxGCx2q1bcLuITyAM6V+v2MG9lEbVuZLETydlz5Jw==
X-Gm-Gg: ASbGnctGynAhkUfkDcVhAbdKUh4wb4T3td8CIRVerp35fU6IuqHne1Qlr7BI5dJZ43Q
	WL90Qjeo2wqfhOTuPoYcaOHn0RNBPAyVk8s+9ENZOsl/XehW6ik8P/WeJtfKF4un49lX0KZIkbH
	Ef6vdeVGAmz0iV5ytS2nwXmxoEyEzDfq8GOGr28LVvea3m2VoCn5OBu1Q3CugBJJJ124Y5iT8mH
	LY2MXVHKYGsuh9VXoc5jHhi2KY9nQ==
X-Google-Smtp-Source: AGHT+IEFR/W6Yikvrt2qC5isSx6evDsvmERokoCwte20SIUgeglaJE8pzj4uii2AXPPMmwXkgUgUX/Vhwgut8yKZ4Pk=
X-Received: by 2002:a17:902:ce01:b0:245:f904:8922 with SMTP id
 d9443c01a7336-2462ef09262mr108738235ad.7.1756187401247; Mon, 25 Aug 2025
 22:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825124827.2391820-1-ming.lei@redhat.com> <20250825124827.2391820-2-ming.lei@redhat.com>
In-Reply-To: <20250825124827.2391820-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 25 Aug 2025 22:49:49 -0700
X-Gm-Features: Ac12FXw4TopmEJgtMhljsOukapmlzsJDQMT2vqVqXf_e7MA0FHwkOKt_6l0PxQI
Message-ID: <CADUfDZp1-Tg+Gp+9kaudFNYyz3mLjNn+v=H3wKLEoKDftcX1wg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] ublk: avoid ublk_io_release() called after ublk
 char dev is closed
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> When running test_stress_04.sh, the following warning is triggered:
>
> WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_release=
+0x423/0x4b0 [ublk_drv]
>
> This happens when the daemon is abruptly killed:
>
> - some references may still be held, because registering IO buffer
> doesn't grab ublk char device reference

Ah, good observation. That's definitely a problem.

>
> OR
>
> - io->task_registered_buffers won't be cleared because io buffer is
> released from non-daemon context

I don't think the task_registered_buffers optimization is really
involved here; that's just a different way of tracking the reference
count. Regardless of what task the buffer is registered or
unregistered on, the buffer still counts as 1 reference on the
ublk_io. Summing up the reference counts and making sure they are both
reset to 0 seems like a good approach to me.

>
> For zero-copy and auto buffer register modes, I/O reference crosses
> syscalls, so IO reference may not be dropped naturally when ublk server i=
s
> killed abruptly. However, when releasing io_uring context, it is guarante=
ed
> that the reference is dropped finally, see io_sqe_buffers_unregister() fr=
om
> io_ring_ctx_free().
>
> Fix this by adding ublk_drain_io_references() that:
> - Waits for active I/O references dropped in async way by scheduling
>   work function, for avoiding ublk dev and io_uring file's release
>   dependency
> - Reinitializes io->ref and io->task_registered_buffers to clean state
>
> This ensures the reference count state is clean when ublk_queue_reinit()
> is called, preventing the warning and potential use-after-free.

One scenario I worry about is if the ublk server has already issued
UBLK_IO_COMMIT_AND_FETCH_REQ for an I/O but is killed while it still
has registered buffer(s). It's possible the ublk server hasn't
finished performing I/O to/from the registered buffers and so the I/O
isn't really complete yet. But when io_uring automatically releases
the registered buffers, the reference count will hit 0 and the ublk
I/O will be completed successfully. There seems to be some data
corruption risk in this scenario. But maybe it doesn't make sense for
a ublk server to issue UBLK_IO_COMMIT_AND_FETCH_REQ with a result code
before knowing whether the zero-copy I/Os succeeded?

>
> Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon =
task")
> Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon ta=
sk")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 94 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 99abd67b708b..f608c7efdc05 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -239,6 +239,7 @@ struct ublk_device {
>         struct mutex cancel_mutex;
>         bool canceling;
>         pid_t   ublksrv_tgid;
> +       struct delayed_work     exit_work;
>  };
>
>  /* header of ublk_params */
> @@ -1595,12 +1596,84 @@ static void ublk_set_canceling(struct ublk_device=
 *ub, bool canceling)
>                 ublk_get_queue(ub, i)->canceling =3D canceling;
>  }
>
> -static int ublk_ch_release(struct inode *inode, struct file *filp)
> +static void ublk_reset_io_ref(struct ublk_device *ub)
>  {
> -       struct ublk_device *ub =3D filp->private_data;
> +       int i, j;
> +
> +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> +                                       UBLK_F_AUTO_BUF_REG)))
> +               return;
> +
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> +
> +               for (j =3D 0; j < ubq->q_depth; j++) {
> +                       struct ublk_io *io =3D &ubq->ios[j];
> +                       /*
> +                        * Reinitialize reference counting fields after
> +                        * draining. This ensures clean state for queue
> +                        * reinitialization.
> +                        */
> +                       refcount_set(&io->ref, 0);
> +                       io->task_registered_buffers =3D 0;
> +               }
> +       }
> +}
> +
> +static bool ublk_has_io_with_active_ref(struct ublk_device *ub)
> +{
> +       int i, j;
> +
> +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> +                                       UBLK_F_AUTO_BUF_REG)))
> +               return false;
> +
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> +
> +               for (j =3D 0; j < ubq->q_depth; j++) {
> +                       struct ublk_io *io =3D &ubq->ios[j];
> +                       unsigned int refs =3D refcount_read(&io->ref) +
> +                               io->task_registered_buffers;
> +
> +                       /*
> +                        * UBLK_REFCOUNT_INIT or zero means no active
> +                        * reference
> +                        */
> +                       if (refs !=3D UBLK_REFCOUNT_INIT && refs !=3D 0)
> +                               return true;

It's technically possible to hit refs =3D=3D UBLK_REFCOUNT_INIT by having
UBLK_REFCOUNT_INIT active references. It would be safer to check
UBLK_IO_FLAG_OWNED_BY_SRV: if the flag is set, the reference count
needs to reach UBLK_REFCOUNT_INIT; if the flag is unset, the reference
count needs to reach 0.

> +               }
> +       }
> +       return false;
> +}
> +
> +static void ublk_ch_release_work_fn(struct work_struct *work)
> +{
> +       struct ublk_device *ub =3D
> +               container_of(work, struct ublk_device, exit_work.work);
>         struct gendisk *disk;
>         int i;
>
> +       /*
> +        * For zero-copy and auto buffer register modes, I/O references
> +        * might not be dropped naturally when the daemon is killed, but
> +        * io_uring guarantees that registered bvec kernel buffers are
> +        * unregistered finally when freeing io_uring context, then the
> +        * active references are dropped.
> +        *
> +        * Wait until active references are dropped for avoiding use-afte=
r-free
> +        *
> +        * registered buffer may be unregistered in io_ring's release han=
der,
> +        * so have to wait by scheduling work function for avoiding the t=
wo
> +        * file release dependency.
> +        */
> +       if (ublk_has_io_with_active_ref(ub)) {
> +               schedule_delayed_work(&ub->exit_work, 1);
> +               return;
> +       }
> +
> +       ublk_reset_io_ref(ub);

Why the 2 separate loops over nr_hw_queues and q_depth? Could they be
combined into a single nested loop that waits for each ublk_io's
references to be released and then resets its reference counts to 0?
Looks like the ub->dev_info.flags checks could also be consolidated.

> +
>         /*
>          * disk isn't attached yet, either device isn't live, or it has
>          * been removed already, so we needn't to do anything
> @@ -1673,6 +1746,23 @@ static int ublk_ch_release(struct inode *inode, st=
ruct file *filp)
>         ublk_reset_ch_dev(ub);
>  out:
>         clear_bit(UB_STATE_OPEN, &ub->state);
> +
> +       /* put the reference grabbed in ublk_ch_release() */
> +       ublk_put_device(ub);
> +}
> +
> +static int ublk_ch_release(struct inode *inode, struct file *filp)
> +{
> +       struct ublk_device *ub =3D filp->private_data;
> +
> +       /*
> +        * Grab ublk device reference, so it won't be gone until we are
> +        * really released from work function.
> +        */
> +       ub =3D ublk_get_device(ub);

Can taking a reference fail here? If so, the NULL return value would
need to be handled. If not, the "ub =3D" could be dropped.

Best,
Caleb

> +
> +       INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
> +       schedule_delayed_work(&ub->exit_work, 0);
>         return 0;
>  }
>
> --
> 2.47.0
>
