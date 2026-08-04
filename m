Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7C418A46
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827612; cv=pass; b=Gfp9WnKYsHi0Kk8dkTvFnamCGVdmYtpHRHbKlYQDv7O66PfoXw95bH7N5L+yZlP0vD/cm5X3FtnhK5EDAqrl6/S0Cu+sBBI5RqRxdJS53JVRGOK4pURdFw9FjBgBXqOXxUbMzjleldS/rc35coN6E0+/wa0VUBcMYlcSPLh+nhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827612; c=relaxed/simple;
	bh=WbgZck4SuSnijz9rBu1hnMIsUUvZ7iAJtAuqyMpRGiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAA4ftzCSee708UqauKsVdgi5kKaaMS3ieJc1Mx6UX5gYWG8jmulvgkmkBjAm5FVSrgk+sc08Go31HC5HtPJqNOtFof4+LgDx12w6iqbJ+TcBw38lNoykfwforCKek8P6qthtSdb1/ovav9B5Ms8keFfohyM2pKSkdefA2Q3+cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmdVkcR7; arc=pass smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmdVkcR7"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-69c42e7735eso2612860a12.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 00:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827610; cv=none;
        d=google.com; s=arc-20260327;
        b=HjgPqTmQl6EpXgMOjzl+wcwxUrgAUE8+PBiTkT1RSriOwzb0YKeYnCezSYADZK2jrY
         cfE6q00ReKGMzwhWwhYhIEwvvxQIcL4XJrYnP2OyEHGHp/ubxVdcaZjRMNMP2NekYx9n
         N8O3MI3EdmFvsO4ij+Ez+6F77OdjsMuUBq//qKSpQwXCifcDQ640Ry6z/BL6oQo1P0q0
         182q1Q9L0k43UYkBYSymF/3DaVp8omqXMI0r/iJQWnBuDOR2W75HFInR4nvY+QGrBoKQ
         MQzRaUrL3oXvn+sHeR/f2B/SHbu9vrwqIzVkVZ4WIgeY3Rsbwo6UKiFQBzabhytx9HBa
         6/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BANfYVtXlrmYQxzoWmQ7sKCmlWxQONbO5Xpc0r4oaso=;
        fh=k7ruE4S1iWRx54rJxWoh/CMlse3MXKQdeMcW/p3IcpA=;
        b=XY8rwslMf0B/GnX7GoYzQRzOABSQWStoFiYpm8B4+z8kAT4eFrrLMuXQin8aWwiptj
         AY8A64IOytBW6IHM+8vxVIYUkueBNGUjG2bxmPbo7ecBdMyQgsp1XANJ/o4ngVqU1Bo3
         GY7EQs4QE3nwAstcu/Ysb8Q3IPmrXN7gJkzqR4s80tzY0o6pgTDLrzsDOwSBVT25n/kz
         6SIyFxijPNUUXCvQ4+6y1IAX2j35GtCGNQ2SlwO37ZODwZ2OktzyVb5bLmj1z6l09l5c
         eGPxZze++6Q9Jc3LyHzy3KWrxeXrJaBSdMaEwpaF+dpheZC6O4jb5kK3YxHgzR9kSh68
         URhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827610; x=1786432410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BANfYVtXlrmYQxzoWmQ7sKCmlWxQONbO5Xpc0r4oaso=;
        b=RmdVkcR7gGl+qyR+FLLrI9iiOdmWtD3jNeCHP61z8FFAaqxH8p/vHr3CxFZoIgWGJY
         DTjlUO1BeyO69xEsCR+rvuD3B3xmcgsFnH+0GVv44jYQNNB/n5cTgRJ+0yg0bdQjfox0
         Lc5MLChuQoHdg5ROS91mCVtPUHv9ORQWdzvkI+0++TV1+cb0bWmPfnjjP+frVsxGZ210
         WODmfoo4XbiRMZKhELL4IPXERQCoshOfNc3/X0fEnJZDPZAK+oGUzpLvPMsAwKl1f6zK
         8j4o5HuK2SqvShylUHiYCtECynMRZ6Mg+/64ZI8BdXVnh7ecoy7ucEl8b9SfYjanSKhy
         jnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827610; x=1786432410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BANfYVtXlrmYQxzoWmQ7sKCmlWxQONbO5Xpc0r4oaso=;
        b=gz5qr+POSc98frWhZnscw325v+BQ7Aj0zT+oy9oQXDB9M18guhRg589R5XnkQohcQ1
         MWgcePdPkHIqRTvpzo70/12rKY1quNqKyQSD33i3lERJ6rgufYSWa5S+qP4Z5TmTh21m
         dJ5SLoqIfnDXtkKxh+taWZv2GdgKR5izTKHZW4ATPlrk6GKYJGy5Ta3FVG9QO0lVg61p
         tx10MXwqU048eaiufu7li+nwIfrbCjLPBxZduJnTFXthsbYmDLVteA26XQv+ZGqkR/ml
         TYFvHYok8QP2YacAWisHr2kCvs3A9S+MHH9FgfcALUuSOZs9d02wiAbQbECP2QD0aK5G
         vjdw==
X-Forwarded-Encrypted: i=1; AHgh+RpixskAZ3z/fOk/6Av7IpDkhiIrhMTpo5L5PTqACQV+HXoMKjDFFzl+Cl2Zz7m6ohE8w28BIgFVEq6FOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHNn7hNKGquyZUvOu7ev+biY5NxvHzsq0UZ9EgeK+/glaVTcG
	RoayxX9fa+ISJ8vRvxmD2Vse9S0oM0L2wjjfMLPvZU8jIK7yRlLt0dvaUQA2iKs1EgJ81gMfVHI
	dom9d1yJL4B//Df/4BkOktB8bO9iH90w=
X-Gm-Gg: AR+sD12obw22MTrCbNZL6a+UfDF8KDIrc1wz/Azu88BrrnuZXyXSCPOJFHsS7kTBdGS
	go8VgtK9g6FZXK3gK5eiaVRMap4TOWE7LrCwo8DByz0wE7heWSOP64vxxDxygKuxlHTHA5iwJXj
	jsQkTKDYqaQvonYjSexCtAOr6bUZS8e5sO1fomJTq8+T0qyLtI40wPVpept/ompM5wnvvGbdpeu
	Ai4erB1qpVC/uINYFbO8jach8YLvwlYfj0aAPzQ2lQ/Ca8ONxFfAfznRyINh9Sovut1QG8U5pEk
	DtDDsetHtOGXGz9sw9SQNTrKUF2eF9BPmjnyeufhGBz9Vg==
X-Received: by 2002:a17:907:3cc2:b0:c16:3074:6593 with SMTP id
 a640c23a62f3a-c1fe7ec89f6mr1202494666b.12.1785827609554; Tue, 04 Aug 2026
 00:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com> <20260803141256.60599-4-haoqinhuang7@gmail.com>
 <anF8tcbifysw7v9_@google.com>
In-Reply-To: <anF8tcbifysw7v9_@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 4 Aug 2026 15:13:17 +0800
X-Gm-Features: AUfX_mz2k5Ovd5JoOD1N8hAC0xq3-Kgvv860h7Y-y1pHiSE5Y77pq1HW8tiqpb8
Message-ID: <CAEjiKSn3q55VrsB3mufdA5q+MUUdrJQuSevqo3f_-3gEK=NLCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's setup_params
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/08/03 22:12), Haoqin Huang wrote:
> [..]
> >  static int setup_params_842(struct zcomp_params *params)
> >  {
> > +     if (params->dict_sz) {
> > +             pr_err("842: dictionary is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +     if (params->level !=3D ZCOMP_PARAM_NOT_SET) {
> > +             pr_err("842: compression level is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> >       return 0;
> >  }
> [..]
> >  static int deflate_setup_params(struct zcomp_params *params)
> >  {
> > +     if (params->dict_sz) {
> > +             pr_err("deflate: dictionary is not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       if (params->level =3D=3D ZCOMP_PARAM_NOT_SET)
> >               params->level =3D Z_DEFAULT_COMPRESSION;
> > +     else if (params->level < Z_DEFAULT_COMPRESSION ||
> > +              params->level > Z_BEST_COMPRESSION) {
> > +             pr_err("deflate: invalid compression level %d\n", params-=
>level);
> > +             return -EINVAL;
> > +     }
>
> This is purely optional, if you add per-backend pr_fmt() with backend
> name e.g. "zstd:","lz4:" and so on (in a separate patch) then you don't
> need to explicitly prefix every pr_err().

I considered adding pr_fmt, but the existing winbits message already
has "deflate" inline:

    pr_err("invalid deflate winbits: %d\n", wb);

which would become "deflate: invalid deflate winbits:" and look redundant.
I can add pr_fmt in a separate patch and clean that up to just
"invalid winbits %d" at the same time though, if you prefer.
