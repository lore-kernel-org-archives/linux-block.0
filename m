Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA42AEFB
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888639; cv=none; b=ilVnLlvAKOTSee+0YGk9VaJrkevUwDR91+jpUUnL16VNTBOYAdhkSj7q3bo5vz5C3ma+VHz6HoavqWjWKV9kJmuwPYf4MYvExoz8ZCxRmaAKSHUjcw/pJ2NN7Iaz+C01ZJiemrobhin3DQWO0ncCox6qsZZiekm1t3ssigQ7FQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888639; c=relaxed/simple;
	bh=sk9YEwqJmiYHAIyIWI3U1QQYNBCAHI0iM+4dHKLU8Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7cb6xEwJMHdMATEWkIxN2em7V52HYMMLjptpVvClydZbZT8dPYCpZOFahOOaK7yBDVfvBcRn7U1XoSsV0UN3XzzbN8t7VSuiO8wC+yU0GgSmc6lT50H4uM6mfJS3yVgRKL142cYjT5TFnqBp+RCIadWN66X9fBvU5G1yA5m0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XpcxwykN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XpcxwykN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736abdac347so530396b3a.2
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745888636; x=1746493436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zswcvteDd8Fr8mPbToDhQkXnNSPHFirZwYjZTXvHRF0=;
        b=XpcxwykNKwEtNVej0y4RTJTlruKmKZpsukNlD8nveMnbLz2d6fa7SyWD/OC3TENR1H
         kF2F2djXuAuXr7W41UYIFrkm3zQvB3Zbs9XQiViTfmBMptyI13H4Rwh24EZyt3oCwEXP
         RBrVmblWphqJ8bsYIUjPSJW43DtnGwRWrDytLLWoNZwwHG+UmlO7jTIOCA2Ck4ByiGSy
         DeZM4VEZCoelsVGBJq4MPqWbo49qK+denwjRuTtSY6EnRFpG8rOTXp2O04u/MolZqe2P
         h22azDFNaSrRPeIl9o0MZ6BWmHIj2f/lfyljHBTMp3b9/LG2J3FRB63ZpHP66PwI0eBQ
         2zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745888636; x=1746493436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zswcvteDd8Fr8mPbToDhQkXnNSPHFirZwYjZTXvHRF0=;
        b=o6Vwie0DqdkK2Su4+jLTZZftp6awQylDc5ii4RMCzPMw0hEi/GBULpslF2sBV1GjDZ
         4XNLDZccWujQ51j9zrNSeVuqOpZr8vH4BtRQWxlj2KybzpXQY0ffovKiZJca2twbydR7
         h008AKFfGgxbZf+qAXmlIl8qQ3WMrXBlvllSdT3/Omd7Tf1Cz3UsXeSd5Cvd0Fyv5HHI
         3vewkU0U5ZmNhnxOG+87Snv0wk2vsyOqwT/GsNWrwOSLZhK0nK+MynS+DSCuRFEiXDok
         5Igojr9RlwqMe8jEZ3CRT2yX3fQNdwGi1GOMWoKLIGQB6J2nxQPjY6+O9O5q9JOd66VM
         mdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2mt8yIFcTSX9gAfnQgHLq9oAqb04kkbhX6o/sIviDLuPUIrUuQqFGK49Tk0p4rrtuiUoqjKprWmx5bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHd09l3MQY9DFjyzYhkidoYKLnYrye7P/p/EraswzSymoLcX7
	tqWoqSKjSqtnxxK5ey9WU4XaD+W9mGh9VPHrT4mVoCB8oH6WupjUrlMH1HWzhn/2MU3jqmpiAg3
	Cas6Kwr20qlWRAGllXknTVmDzn5xWlEsdRbI7XA==
X-Gm-Gg: ASbGnctVc+iv5gQWwblGlx7sYuI/vLXcdLoOMHYkzyMZyin1P1/B3X70fyJvlsj0HRo
	dT/CU3GuSu+uK2f9bsxBfZ1KwlcIR+cyZGHcxa/r7PHzwTE47vo9xxpsLMMSU1Eff6fH8c0t9XQ
	rjcbg59OGmVAzK3kUKLtRCd2Ctvwg/lP8=
X-Google-Smtp-Source: AGHT+IGUE9Y/p8lqePnxoQO9PUUKixOfQfuhHYyZxUHCCkq5AXg8IW1bgAuR+CrJ1ClCQcvW/NsmHcic1e3BJxIHC+0=
X-Received: by 2002:a17:90b:1c8d:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-30a220ea247mr733205a91.6.1745888636451; Mon, 28 Apr 2025
 18:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427134932.1480893-1-ming.lei@redhat.com> <20250427134932.1480893-4-ming.lei@redhat.com>
 <CADUfDZrVOUE+Wweaz0pg9qfSB5Ye8FHuf-FmDjO2VOz0GU-cNg@mail.gmail.com> <aBAlEzqzx2Vmn661@fedora>
In-Reply-To: <aBAlEzqzx2Vmn661@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 18:03:45 -0700
X-Gm-Features: ATxdqUFcZE29UYD5_HMe8nMBUeLhP_dzU0l-xUgmRIIG-MWxrbSoeX8ygqdBaMk
Message-ID: <CADUfDZqmoin_dxVo5OxPzRact2RaeYjrXAhc7JC6RdLmyU9C6A@mail.gmail.com>
Subject: Re: [PATCH v6.15 3/3] ublk: enhance check for register/unregister io
 buffer command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 6:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Apr 28, 2025 at 09:28:07AM -0700, Caleb Sander Mateos wrote:
> > On Sun, Apr 27, 2025 at 6:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> > > register/unregister io buffer easily, so check it before calling
> > > starting to register/un-register io buffer.
> > >
> > > Also only allow io buffer register/unregister uring_cmd in case of
> > > UBLK_F_SUPPORT_ZERO_COPY.
> > >
> > > Also mark argument 'ublk_queue *' of ublk_register_io_buf as const.
> > >
> > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 24 ++++++++++++++++++++----
> > >  1 file changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 0a3a3c64316d..c624d8f653ae 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -201,7 +201,7 @@ struct ublk_params_header {
> > >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_que=
ue *ubq);
> > >  static inline struct request *__ublk_check_and_get_req(struct ublk_d=
evice *ub,
> > > -               struct ublk_queue *ubq, int tag, size_t offset);
> > > +               const struct ublk_queue *ubq, int tag, size_t offset)=
;
> > >  static inline unsigned int ublk_req_build_flags(struct request *req)=
;
> > >  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue=
 *ubq,
> > >                                                    int tag);
> > > @@ -1949,13 +1949,20 @@ static void ublk_io_release(void *priv)
> > >  }
> > >
> > >  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > > -                               struct ublk_queue *ubq, unsigned int =
tag,
> > > +                               const struct ublk_queue *ubq, unsigne=
d int tag,
> > >                                 unsigned int index, unsigned int issu=
e_flags)
> > >  {
> > >         struct ublk_device *ub =3D cmd->file->private_data;
> > > +       const struct ublk_io *io =3D &ubq->ios[tag];
> > >         struct request *req;
> > >         int ret;
> > >
> > > +       if (!ublk_support_zero_copy(ubq))
> > > +               return -EINVAL;
> > > +
> > > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > > +               return -EINVAL;
> >
> > I would still prefer to see this common UBLK_IO_FLAG_OWNED_BY_SRV
> > check moved to __ublk_ch_uring_cmd() along with the existing flag
> > checks. Something like this:
>
> This way mixes bug fix with cleanup.
>
> We are close to v6.15-rc5, and bug fix should keep simple for minimizing
> regression.
>
> But it is fine to make it one cleanup aiming at v6.16.

Okay, I can send out this cleanup for 6.16. In that case,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
