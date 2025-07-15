Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A51DF99C
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594505; cv=none; b=P/YABpSPb8cbGIlz83w5s8Cky26wcXumm12oPD/fSPR9ZdcERxqejkWy3oxE2uxK4VsLnFFUQ75X9DDb/3FBwYwvSHHHrnE5Yq2Kb3ugkZc3AXM1OcafzWssMmxvSqVT21moE89FGDP70UfqeujvAPV9Tosys0/rBhufDSraACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594505; c=relaxed/simple;
	bh=RH96XpcDJBxXiI+o48Ks9OrHhfsc3OL/5IzUI6g3mPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dso2s6ZlTq6cUjlwBKuUDzA0Sz9/uIkwFTs2hm2OfsSu6dnKePtoq3wNIEuoG48ezVmj/UtLBHG+LNrhK/GC2gf6uw6A5ArT6MX3Ip+o3EhwgglC59OwLRYkmzUEi9VoXVWBxrfEiRc5Fea8OV/GAjANmoPRVsrbY2f8uBQdvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AcqOEiX3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AcqOEiX3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312a806f002so944124a91.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752594503; x=1753199303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j627q4ORHb51CZCllyqxMTaNNKt8GFVJaQkKXQE2d38=;
        b=AcqOEiX3Huduf7rLpdG0SHE9VUIg50fqFb5ZAAfzKHLx7676pkCh+rSJtRLh/c+LZm
         C8F2bf6M/DQGMrLtfwIu89hjFwwJSS59sHg71rx1GhdkjEZsn3YpB6j/Zl2uXBUCbAIp
         snRtsQOqdJ6P6Z6feRKhZKhVZEEaiN0WSMouvibe/cjMRSFlbNcgXVjyh0CNWR7jhJBe
         1leum2ewxLVSsq9bXEXEtVeQ5GkFG4eH55XbA4yWdPLO9CbH4rYetKLTp/RVCFZIonWN
         wDcbHnFUW4nYoLtAwJsHbVfasz9SU67g1c+td1lEGWRfFE3TyEDeOjqilHLpe8xyE/qQ
         WDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594503; x=1753199303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j627q4ORHb51CZCllyqxMTaNNKt8GFVJaQkKXQE2d38=;
        b=WqZhvhu9+nCTvzQddlfqOOt9mpVuEvvex2P3zHxhNcztbZQMyVy1/k7Yi9vRAIuGW/
         4JuJPoX6P3DzJIev5KJQO28ng5vLwDM8GIlPRf+F23eELqm5cu5RFHTh691TmzZOKwmY
         q3WeLNy+7lOqJzelKrZsF5ger+bhqc+IiicLJmNf0HuAsFbBv7dF2hb0NVtjIe7gawDR
         oOikRycSUqDY3Kqaa1gnEU8rUYRmB++u4uEt5xEAoS5uAtqwhzMMOt7na4kRicUuXAx+
         MFbNhl8cTuJRM0HVRgjlf8e8fZnyqC3W5D2qbLxfhp6yQrv5D+emJ69+tsciYrF8VZ93
         /zwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd4Z952zd1nlIw6V/5wqts3+3G+4RU5NH0P/x6nIHY0QsEIuoVfBUWPonP3BAjT6dU3OH6FdMW1R4T2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+h5mVk3JOsvJfgTGAV7K635Dk3WwlfqSklOtd/ZxXZQwbtUC
	LhO/SORFk5M24MV/atzFS3L+tLZkoM8D6B/WhK1P1vV14qBHaI8XJ4eCU/Kk2dxOD8zpgY60Q4d
	CVI+51ftXRIjxyLlw7v04BCDlEPgawH4Yo5n6D4zrqA==
X-Gm-Gg: ASbGnctpF6GCEV//7OKG8WEdQpJlc2xowaNKPA8l06WfsxcEOlrWB/m49/HDuSkiq5B
	awoci8YDBWl1yDNhrF9lltGgJlbp4CWHvyzWTMDCkI8e68BBmcJ2Nky8BoFpfFgb8KLtVw+nKY0
	jO96XVlcpwnzLp+FdqP5CKA6Ybjnd181ZGsDE1v8Fs4sfu+x5xLl0rAqMuFI4vg2MfHab0JBu2x
	rFb1g==
X-Google-Smtp-Source: AGHT+IGo4lIg587pr9i9d+xs903/W8E7OjkK4k1p8m6cIepBcuRl9sCr29txrqtPxr940gQ8nUqs/xl8kJW3yuPNlho=
X-Received: by 2002:a17:90b:270b:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-31c94dbc0a8mr1329634a91.4.1752594503457; Tue, 15 Jul 2025
 08:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713143415.2857561-1-ming.lei@redhat.com> <20250713143415.2857561-2-ming.lei@redhat.com>
 <CADUfDZrZ+SDQFC_-upFJNx2cj=xGuggvHMMubfWCaVGy_D4BjA@mail.gmail.com> <aHZ22o0znAVFFDJf@fedora>
In-Reply-To: <aHZ22o0znAVFFDJf@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Jul 2025 11:48:12 -0400
X-Gm-Features: Ac12FXxAF711k_Mlg6sLiotEaY7xQAOuDJKQN8IqvTmuY3oCjnEVLOJkQ3KxhcI
Message-ID: <CADUfDZq86kMtc=OLCK6jUNwgRf6+VTmVqzHXqyD+5zK0FEqfSw@mail.gmail.com>
Subject: Re: [PATCH V3 01/17] ublk: validate ublk server pid
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:42=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Tue, Jul 15, 2025 at 10:50:39AM -0400, Caleb Sander Mateos wrote:
> > On Sun, Jul 13, 2025 at 10:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com>=
 wrote:
> > >
> > > ublk server pid(the `tgid` of the process opening the ublk device) is=
 stored
> > > in `ublk_device->ublksrv_tgid`. This `tgid` is then checked against t=
he
> > > `ublksrv_pid` in `ublk_ctrl_start_dev` and `ublk_ctrl_end_recovery`.
> > >
> > > This ensures that correct ublk server pid is stored in device info.
> > >
> > > Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block dr=
iver")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index a1a700c7e67a..2b894de29823 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -237,6 +237,7 @@ struct ublk_device {
> > >         unsigned int            nr_privileged_daemon;
> > >         struct mutex cancel_mutex;
> > >         bool canceling;
> > > +       pid_t   ublksrv_tgid;
> > >  };
> > >
> > >  /* header of ublk_params */
> > > @@ -1528,6 +1529,7 @@ static int ublk_ch_open(struct inode *inode, st=
ruct file *filp)
> > >         if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
> > >                 return -EBUSY;
> > >         filp->private_data =3D ub;
> > > +       ub->ublksrv_tgid =3D current->tgid;
> > >         return 0;
> > >  }
> > >
> > > @@ -1542,6 +1544,7 @@ static void ublk_reset_ch_dev(struct ublk_devic=
e *ub)
> > >         ub->mm =3D NULL;
> > >         ub->nr_queues_ready =3D 0;
> > >         ub->nr_privileged_daemon =3D 0;
> > > +       ub->ublksrv_tgid =3D -1;
> >
> > Should this be reset to 0? The next patch checks whether ublksrv_tgid
> > is 0 in ublk_timeout().
>
> No, swapper pid is 0.
>
> The check in next patch just tries to double check if ublk char device
> is opened.
>
> > Also, the accesses to it should probably be
> > using {READ,WRITE}_ONCE() since ublk server open/close can happen
> > concurrently with ublk I/O timeout handling.
>
> ublk_abort_queue() is called in ublk_ch_release(), and any inflight reque=
st
> is either requeued or failed, so ublk I/O timeout handling won't happen
> concurrently with ublk char open()/close().

Thanks for explaining. If the ublk server closing the char device
ensures there are no in-flight requests, does that make the
ublksrv_tgid check in ublk_timeout() unnecessary?

Best,
Caleb
