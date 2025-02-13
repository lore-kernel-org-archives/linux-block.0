Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4F14B95A
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456920; cv=none; b=CQzPgWGvUF9lRgIbCVHE36WC1XwPY7BiXaS5ktZVETDZkg3kCbS2DZwDQl8QEECXHhZSz2leWvHVzSa6OVWZlsKqg/OlhpUS0G/vx8UA05Dskd2jHR/2Wiz1Ul3ylUZTJhoZJeCgJhInKnsQREM8GyzE3kxFKx4R0OSPKbhBAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456920; c=relaxed/simple;
	bh=P6kYdtdWTG4amcDgsbJjP4qCmz0j3Cwce7Vlx7RP2o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHNzWonID8fZzSws9VCgEZq1IJEshEZoRamdJzZdbFEpKhBYN+z4HOoI65+zHZtQ+Inc6Hk4dQegTrMWC9gbyDKV0HKLgRZL0sFurdtynDrb44J+eMirVT+zeSlO+jH8HagTGedg5SX4HgV9Du60gI85fw/sdT9Vg65WOU4g+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ViUVlain; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ViUVlain"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so445122a12.1
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739456915; x=1740061715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipm0yflvw3SL7RKduSGbgwE/CsgQaitRRpnD1zan1lA=;
        b=ViUVlainFkC7l9r2tdLZHuML8SLP5kdfMveYJxFxpcwjLkKEHkMYFhZt8wz1N2qaE9
         VYIgcbeE9ZiPjmrBI011pAmFsBcAxi6Ur9G/AxRoZR9UPwJ6fmQ5GsID7lOR7Nb5OL/v
         2eFuVs0mWQprr56sj0iCBNpU/tvW2gnmder4LzPoSzPFwToCVjFc8N1Ac4taJeGcXYxv
         eyD224oY4CBGJ3bsQ/NV24DWHl0uHjQ5WYXQBaBIPvH5n7kulfG7Cilsc65sSpCZnYPq
         l+j6yZnOj2bDpg4UWM1qTBM+JF3/4fFbUwHUP7rHocTf3yPRQAvSXLdBddIaV5EP/Vl9
         E9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456915; x=1740061715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipm0yflvw3SL7RKduSGbgwE/CsgQaitRRpnD1zan1lA=;
        b=OV93xKKBCTeZRtEq3ZJZn7G6zitNnrZue95h1dVtUgHzOCpk4uRuivWfyiMGNMHF8v
         Al+UKqaSvxFBQXvcG2xOmmJBKCypGr1KGuwvJFjHUBngOEsL8RuHqBzpwssh9nu7MkWO
         jP+WYxa5bxJVOMeUcITaX5genOBlh3opKdc/7+y6hKJFoEIwh95FVHGlu7hkYVrSxEZp
         uCQXbzKxgvYnJAz8evo8W13L4d7FOXAgW4rDcOL4QTngcoNdo2bFPVxYdGclHhDam9AL
         siCz0Co9jHfBAB4/HD8Hn7RpMN3BQAoUGrSB8FNjHwzlDsQJDXx0IzTfTHo1sWOEOkr7
         HLOw==
X-Forwarded-Encrypted: i=1; AJvYcCUTGC3e9oZH1pzjycMjmNWbtfVzT9UJ1IoKdxR3M2135I3r+EoH8mTQge/8io7na1kMwXB8wWM/s4gw6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKIBNEfj6Kn/sWdgM32tYS06O9o5EGjexegBkUlz1csL31uZ+
	87T1q9lE1yB13vd4lo9Hb3aKhrQ0CgBWBdGoqAxIadXpLqRBxreFY5sQDIp892hzhCDYhNLyDNC
	+VwnJdFFtKAhVwgAm30JThn/aGmAG9FNOlDGkU/D/CfQM5uwXWCk=
X-Gm-Gg: ASbGncvyUIhNPLXd0NjNkNYQ2RURMSpHdWy7bZCL7sCzvH3GOw09SOGNoknEWfCCX3U
	HrSHH81uysyCPLUqWG0iAXyyhEwcaUzuWbjPdKonQhyCraEsX11vozlAXsdxW/c1HexrL0ACPUw
	==
X-Google-Smtp-Source: AGHT+IF0DlphfyDXBQJQrpRoFPWkcp8QLEmA2DcCwLgYvMw8iY4hgRGFJHr0LQyadxz4JM2Ej3JEBOuCTyZ95kwaLOU=
X-Received: by 2002:a05:6402:458e:b0:5de:5190:cfc7 with SMTP id
 4fb4d7f45d1cf-5dec9d4b115mr7932622a12.19.1739456913433; Thu, 13 Feb 2025
 06:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
 <20250213100611.209997-3-yizhou.tang@shopee.com> <70741bf4-1d1f-e017-7c76-8b7e3b1d9203@huaweicloud.com>
In-Reply-To: <70741bf4-1d1f-e017-7c76-8b7e3b1d9203@huaweicloud.com>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Thu, 13 Feb 2025 22:28:21 +0800
X-Gm-Features: AWEUYZmJF8bIUynT0twrwjquWOmrPkO9Jce7FeZZ_PxCuwIoPGlbwFmDjK1fBTM
Message-ID: <CACuPKx=th7OBma_fxSRYUWZtKyVR_11JOyguE5MdDR1YJQpVbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blk-wbt: Cleanup a comment in wb_timer_fn
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:17=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/02/13 18:06, Tang Yizhou =E5=86=99=E9=81=93:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > The original comment contains a grammatical error. Rewrite it into a mo=
re
> > easily understandable sentence.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > ---
> >   block/blk-wbt.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Personally, I don't think this patch is necessary, people can still
> understand with this error. I'm not expecting a seperate patch :(
>
> Thanks,
> Kuai
>

Got it. Let's see if others have any suggestions.

Thanks,
Yi

> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index 8b73c0c11aec..f1754d07f7e0 100644
> > --- a/block/blk-wbt.c
> > +++ b/block/blk-wbt.c
> > @@ -447,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *c=
b)
> >               break;
> >       case LAT_UNKNOWN_WRITES:
> >               /*
> > -              * We started a the center step, but don't have a valid
> > -              * read/write sample, but we do have writes going on.
> > -              * Allow step to go negative, to increase write perf.
> > +              * We don't have a valid read/write sample, but we do hav=
e
> > +              * writes going on. Allow step to go negative, to increas=
e
> > +              * write performance.
> >                */
> >               scale_up(rwb);
> >               break;
> >
>
