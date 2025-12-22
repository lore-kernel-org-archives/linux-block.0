Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49E2E8B67
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417851; cv=none; b=lmnlcuMZGhaxyDlEJzSB1YNbHWdF8Fx6klCBvUy57YUZtONDh9Nwh9eHyRIs+Xfm50gOcGisukmgr3nvbG2L5AI70gtaVACeyLU5Pwz0oqyNpEz8dL+hu+/Fz1acAmtou7RbTaTaYhpjQ3u9Kxa3V/9eBc5ZpkaBxj5HyecdeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417851; c=relaxed/simple;
	bh=RcUzhWg/Um7DuspxpIDIAp0IJtjt6YbaI9Q9VwJGvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRFUI+r6nLYTzonm7bhsmnTM/dM1IJApFxQL6QCS7qGMykJsJCwugfIffSqnfSEQBfPeN7IspV+ejWPVyB5GmIT3BqK8oPjLu2oPoKy1dLpYCv4qAwFtjoAlZguAIAv6eVlyRF5YWNyeegajr1v0O2rHvI1l/0OLo36SBuvM/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fAOhR5jH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fAOhR5jH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a110548f10so13300705ad.1
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766417849; x=1767022649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT3Diy9pIeV/PN2q7dXNIN/gteU85UXLAruGSjxuY7k=;
        b=fAOhR5jHEOjYoEhcIrvhhf6mnJZp7JZACt0C1LbMwjLiP0zQ1HCWtgsZYwP8JudWQO
         xEoFM0tAG/1r0GUWLXVkI/eEAVTCTFXr6eUXBHMXdo9wGQ0OA4Di2/j9G3eIy1nq4GJa
         NXnjy3vBzL6vBCkxuJqcpsOg7BRo3OGr0kNAdekyZhAMqsRaEFwurxlGWAWXSWpuUp1r
         M0+rvA+taHJm/nzNgbr+NHdj0KkmaTDFK+wwnT6/vkeRlfpDBZQTDaQMnaRyShMLr8sc
         er3h1BQPMNzKr/W6q5cdXZTETElIXHO1FFFAo442KVCIT0Vfapmsqeuhq4pwQDFs/hjh
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417849; x=1767022649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT3Diy9pIeV/PN2q7dXNIN/gteU85UXLAruGSjxuY7k=;
        b=IadZ6EnssS8KjaI1Z34v5wg2Fa7XAiXQnibIjrH6AiZ5p4yXFeEqFN38I8KoPwqrDN
         IOdK7m2mNLldtNHLaic0ntp49DHdEFR7aGXapznQZUoMo2jDrtCLNQsc7ysHtn5MqS20
         FNLN5z0ZNvc1M27VQL9H98PZ13QvQcp6W/TkZPkakDjecWq9QcqEeDraQFbzyPVGrosH
         apmivbQlS4TU8GMlIX2vnhR2DQ8FOaU5VP5NADod9jYbeMBXdg08fFgShLRT0RIS2ZTD
         1O7SUPeltmV7ukzMAkOLwEu2UHBCIBfne/tlugw+5jpR9RaVkIxjBj5vp70N1MGPpzsx
         lC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZmCaNOp+8hTEMs+BAbScGf1Kw3YWU4Qovodo3dDDZTguEF0DqKZ5yUzJTf5ajBS/4+IT3uqwuAX2mew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6R7dut5VuRPW5DGLTrktqwWq6V7RZ2ZcMPOFz/HA4wKAQ1WN
	m1PhixN+lxrZJT4k+AW/F4ZVitu1bsxAgx4m17oQBReuGGyy3+FNGUZa0/Ylxc3iXa3Ikmzl2OO
	x71euwzun6iPDrE3DtPKCXl8Kppof3mi41CwAqjIqlQ==
X-Gm-Gg: AY/fxX6VrMgV0OtieML4741h/4Z5bSrXZS6fx4lAeP1d1OQuWYgLEGzz+25gwc/pN4B
	q0dguyDvfNhjAJ2eoJPviGQWu7aKb/ZOCwoUY9xmkKva668zP27hRMtuf0pCfvoCVJCUWSFXANf
	IgTOWIf1f5Bb7BHicg3Ptc/IKrDyZSclSoG8bYzg0RExhSzasqmrbmkcxiu0Y917ZcrDJk6dA6G
	LTcksXbBeFkVDT7is+cggUgYh4wCK7wysXi4mu+ZtvrHi2NzF0rrRLZpeR9OWkDi8u61e4=
X-Google-Smtp-Source: AGHT+IG48uyE1b0nQuixVJe4XhHbbPE00lDgvxvW34A3y719k7ccU/Y7YctxFgCLxQBrdafH3y5D7Zxd3tmvFXs4w2o=
X-Received: by 2002:a05:7022:6199:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-121721ad61fmr7865966c88.1.1766417848941; Mon, 22 Dec 2025
 07:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-9-csander@purestorage.com> <aUlbPcjuk_XlE_zq@fedora>
In-Reply-To: <aUlbPcjuk_XlE_zq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 10:37:17 -0500
X-Gm-Features: AQt7F2oQd6LyEEMBKp5IZ-BamQwRQ8iC19BlCQuds5IXxVlYv-HC1nOaOAZV2eo
Message-ID: <CADUfDZpW-8e+tkPJZX29w9Rs1vWc5T3t7qZQXWpyygKh42WKbA@mail.gmail.com>
Subject: Re: [PATCH 08/20] ublk: add ublk_copy_user_bvec() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Dec 16, 2025 at 10:34:42PM -0700, Caleb Sander Mateos wrote:
> > Factor a helper function ublk_copy_user_bvec() out of
> > ublk_copy_user_pages(). It will be used for copying integrity data too.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
> >  1 file changed, 30 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index d3652ceba96d..0499add560b5 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -987,10 +987,39 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > +static bool ublk_copy_user_bvec(struct bio_vec bv, unsigned *offset,
>
> bv could be better to define as `const struct bio_vec *` for avoiding cop=
y,
> otherwise this patch looks fine.

I was thinking it probably didn't matter much as the compiler was
likely to inline the function call. But sure, I can pass it by
pointer.

Thanks,
Caleb
