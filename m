Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432311B2507
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872382; cv=none; b=m6X4FLHr7AjYeXE2Qzxa2UaKZ5Y7ekAkZXsHDIEzmw2uKbFSZfA41mEktw+B5hYRnMiJVmmBKFmvrgczUF9q0cvfTAx4u6UBQPlHTONkyLbhX3fgodWO8Nk7BLRQGpjrNhTT9MoKfX8GJckZmfAwDvWHpnhVKlXCMj703Lr7qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872382; c=relaxed/simple;
	bh=kYwMWMOUYoJZKPWDz0p/NGGwuUGLl3O/po+hhV/ySR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zva8EafcsL9nBB2M5e+iZEEl3ctAR06dO3i/FR2Rufx5yJclz339n7hcdJGKlZVy480qWDOZI3VyqAdvlou1ZLri6YagLaXrnhkGZ8RlKElyCa3fXKegxkGld3M+CsJeEojHunwW48sC3QEPDH1ebdvK2VhazV0e9eOpMTvNhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OX0nj0dG; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OX0nj0dG"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365a9574b6so3864982e87.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725872377; x=1726477177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S2UE6lFQFIaK4OtJMbVxXJXe1O9tXNFiR7Twawdri0=;
        b=OX0nj0dGgRdvSkuZQ5TjOckTvUotgw3dbzW5U2/jndT7AirIr++Fdd96ED4OfWDrNy
         WUoeckGeo9efcgyrsx/UlCw63zi4fHQG/xR0piYRKX7BfCiEAmyE2RAM8FVwTmyihDBo
         eSyDR/NVNj9epuYiqN6JC6W88VP/BJlw0YPA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872377; x=1726477177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S2UE6lFQFIaK4OtJMbVxXJXe1O9tXNFiR7Twawdri0=;
        b=PwTCPL1d8A97WiV61HWRVs4gbgtlChtqCTHAKmKHLFuxoVHFedSjlssbfeJLRrwyAR
         KZnViEgVwBoT9D1ShJ622qNyBXvrrq34glUMEwAG2nGgvNKGskJ3dGz+RoeGK++w6tMg
         o5zZw7IHHypvIKLCRc/CeIaN4rWoQk4G2D9zAOk5E+UJl88lLkwFSU8grG7ZhN5T8fxu
         5v8tDrQQaygHxlU/nb2/8iM2k/fP2U5/2Oxoogmk2z7Aw8NEiR8es8Ftkev5zwTKjYcp
         M0Xq3e/ZsLt15yQigqZrYTWQyKiKUW0biysz7aW3tea90ud+pKQijdfjbZIGpDlT8/Np
         gFIA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Wcs/oIfOJdv4w3PP6Cd2UUcVH+coaQURQqgucR3imxXiwO7EXTbyGVn+k6LdpDk61OR5tNss634wVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEE0LtaGFHA5RVQ6fMFho1Xbx90EpwyQ6loHpuwyjqpkB0Kuuz
	j/lBWZCpphCICcgqetUru0OgxJsM6ayCIpHoVeUwkI/7tHMpqQW6+5ronGJD6zBQ2ZpBAzqr8rO
	1xuiOQiNdQoMjOOkpjKdjbJSoNkjZZVHqmu+e
X-Google-Smtp-Source: AGHT+IEV5KHTyM42uPsdDXbjleRs4adAC8RAMwKOrUjz4iDm20YabVneezv8rJGiE6wMjCx8MJoPuYEUF0lSIgN32s0=
X-Received: by 2002:a05:6512:3d89:b0:52e:933f:f1fa with SMTP id
 2adb3069b0e04-53658818d02mr6743959e87.61.1725872377196; Mon, 09 Sep 2024
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com> <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
In-Reply-To: <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 9 Sep 2024 14:29:25 +0530
Message-ID: <CAD2QZ9Z_rpDAyeJGBDxx8vqq7nSAuiktTTCxYHUu1QtA42afew@mail.gmail.com>
Subject: Re: [PATCH] block: Fix validation of ioprio level
To: Damien Le Moal <dlemoal@kernel.org>
Cc: axboe@kernel.dk, niklas.cassel@wdc.com, hare@suse.de, 
	martin.petersen@oracle.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:15=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 8/28/24 17:28, Ajay Kaher wrote:
> > The commit eca2040972b4 introduced a backward compatibility issue in
> > the function ioprio_check_cap.
> >
> > Before the change, if ioprio contains a level greater than 0x7, it was
> > treated as -EINVAL:
> >
> >     data =3D ioprio & 0x1FFF
> >     if data >=3D 0x7, return -EINVAL
> >
> > Since the change, if ioprio contains a level greater than 0x7 say 0x8
> > it is calculated as 0x0:
> >
> >     level =3D ioprio & 0x7
> >
> > To maintain backward compatibility the kernel should return -EINVAL in
> > the above case as well.
> >
> > Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definitio=
n")
> > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > ---
> >  block/ioprio.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index 73301a2..f08e76b 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -30,6 +30,15 @@
> >  #include <linux/security.h>
> >  #include <linux/pid_namespace.h>
> >
> > +static inline int ioprio_check_level(int ioprio, int max_level)
> > +{
> > +     int data =3D IOPRIO_PRIO_DATA(ioprio);
> > +
> > +     if (IOPRIO_BAD_VALUE(data, max_level))
> > +             return -EINVAL;
>
> No, this cannot possibly work correctly because the prio level part of th=
e prio
> data is only 3 bits, so 0 to 7. The remaining 10 bits of the prio data ar=
e used
> for priority hints (IOPRIO_HINT_XXX).
>
> Your change will thus return an error for cases where the prio data has a=
 level
> AND also a hint (e.g. for command duration limits). This change would bre=
ak
> command duration limits. So NACK.
>
> The userspace header file has the ioprio_value() that a user should use t=
o
> construct an ioprio. Bad values are checked in that function and errors w=
ill be
> returned if an invalid level is passed.
>

OK. Thanks for the detailed explanation.

I agree, to use unused bits, functionality (return value in this case)
will be changed. If applications are built using Kernel headers of
v6.1 (doesn't include eca2040972b4) and later only upgrading Kernel to
v6.6, because of the changes in return values applications may have
some sort of regression.

To make the software backward compatible I believe, unused bits should
always be ignored. So that if in future someone uses it, it should not
change the behaviour (return values) of existing software.

- Ajay

> > +     return 0;
> > +}
> > +
> >  int ioprio_check_cap(int ioprio)
> >  {
> >       int class =3D IOPRIO_PRIO_CLASS(ioprio);
> > @@ -49,7 +58,7 @@ int ioprio_check_cap(int ioprio)
> >                       fallthrough;
> >                       /* rt has prio field too */
> >               case IOPRIO_CLASS_BE:
> > -                     if (level >=3D IOPRIO_NR_LEVELS)
> > +                     if (ioprio_check_level(ioprio, IOPRIO_NR_LEVELS))
> >                               return -EINVAL;
> >                       break;
> >               case IOPRIO_CLASS_IDLE:
>
> --
> Damien Le Moal
> Western Digital Research
>
