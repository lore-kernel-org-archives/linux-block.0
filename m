Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245421765B;
	Sun, 27 Jul 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637249; cv=none; b=XEUxjrYc8DlWHWq9NZJsliWfHeYBOufrC5LBT+swBx2RMTs+u7MVpEh1sxZDrLJ9S1uziAOBd5RJJAKbxIQA52Sqn3xP3CVIT87R2hhd2mTJXMzw3Yv+dwyB3hJHdPrAXEbRWCIVJqFCnlKE8n3PGq0M6883kqnH2hnhe++VKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637249; c=relaxed/simple;
	bh=xIrMAVwTSCMerkRkKb6Xym4RKxHEt9FrryzVcp5g0dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPCbDs33CLusrzTBI1/a2jR/UVi4ET7ve0YuoUagQYghpk7lBiENYNKGvwKi1qn5PejLB3DLoYmJmzXepCbcB5a93ZREy2IG5yEfmkgJG8KmZeV5dDRBU6q8E9Gb5J277KIjqlJ3aKvzutJtNWx4tmqJ7cQ7VQPj+lKPDPy84P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy0kQNKF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy0kQNKF"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso4127180a12.0;
        Sun, 27 Jul 2025 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753637247; x=1754242047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E85YpZEInHKsW2hee+1m3UbS/1k0y+Q8zbJaiHqizWw=;
        b=Zy0kQNKFn0yDniIMY5HQ0XpEnNXjSdHP5ntpbGyKL9K2U1Vh4LMlJ8PFyvQg7HTO3k
         CBZfJoNrUpr3H/OJXLloovk8LXuxSi57CCqyc0g18RCuu9ieVEYWuY/0xL+ahtRXLz7B
         ljoAWzpx8jbwmiJueO68LZ/4KqzWygBxnxk2KN8y6lO2MtTyIHXAqs2/2hpwcWnAEx5x
         SVgooOJAiN+7MSjfSmuvxFA1p7igvRBTDQJE7Cq8SxSIBXMEqvMjoPUsCH8AVKV8j8PH
         Pcegvj5/OaMUhMZLWyM9h3e5QKMhO5F7sRmdBxPi7y+cGqcigzl2k+wN0Cwc0ylgLId/
         5LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753637247; x=1754242047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E85YpZEInHKsW2hee+1m3UbS/1k0y+Q8zbJaiHqizWw=;
        b=IxbhEC7SHXJ0e5mWSQauYwkjgJpYCvo7+KCxbasZilmsMbavnUr+HpkCIySO2d9d7X
         NvBJjSnNZouZ09yRB3ov6xFpT0jUvkjYKRdifJAQp32E9BJmO84HL8aR4Gq0yGL/Jclt
         mNyrTAJF4e2ftrg+iXdOTlxVVw6NrsbRu3DDF8j0U8dTf6IOM1g6uiyJnVdsln03X5LI
         2rEnshF9GcyShYhzpk5pSVNgnOUdpv6CV81gorOYYvs1TTRzLAFQ8ljt8g4rhYwnaWjR
         CRztTJSdEmUxuHHEUBaDNsQGGiTd2KPCpKDLLohBugQBHvSDA30b/or3FWFzhaGLGv+t
         ISEg==
X-Forwarded-Encrypted: i=1; AJvYcCWkgPPRS5Vp+d/NJIsQZLBHQx/PNvKQ3o2Rn8TeG3FoAgARM+xd0XZgK+PB+TjQTriYbC4Nihr9tMiv4Q==@vger.kernel.org, AJvYcCXR0CdilXWkYCg1+JSZYE88LHs8MEQcis6CnuRAWnmP7wgmzsdl6Sid86zeGb5eZktOZxACDsWyOUATysmJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXSXNYdKcUaXyKfLMQ3zLNEsb+m7HVgmzgB4SbntnihqrB8KU1
	A/yHEd+BbTOyTjIKeFcmbeYVeT1Jxr5zBY8Gt4YIfRiTni6gMLRHwykPMz4Y0E9rax20FK9GLCP
	58D92qgSmlzR4VKCfQov21CQJjPG0wcA=
X-Gm-Gg: ASbGncuAfenjAFk6aJgyrxgIuizLkTnejYQGTMdOUmuS3OC0hRXiLcGgi2U7spO2gy+
	OpwaXTXpP/+KrD9Kvup4gboX9IeGzV2DWEzJAhs3LGNXABvdaVVINrpzvm28qaWFuzbUYmPxUmX
	IIzH5rdQOFSXpcRtlHOYRJaATRVVdEpTsvTjcdPhj9CrXkHUH1YP8hefFQ/vyuvL1g81Yx6fVb3
	Olm6r4=
X-Google-Smtp-Source: AGHT+IHhKkqRBC9lCg12hZX4/slYo8kHO6Mzc10to2c8sIkhkcA9qONRQuNvzjJ5FTZulOqlROw/b4VrvF2PYHGAXgw=
X-Received: by 2002:a17:90b:580f:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-31e777311ecmr14130508a91.2.1753637247383; Sun, 27 Jul 2025
 10:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
 <20250727164709.96477-4-yizhou.tang@shopee.com> <939f45b2-4481-422a-a747-012808953d7f@kernel.org>
In-Reply-To: <939f45b2-4481-422a-a747-012808953d7f@kernel.org>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 28 Jul 2025 01:27:16 +0800
X-Gm-Features: Ac12FXyPDw4QDrYV-LfhqE_8IUgVyjjA2GnvT_TRuSoe3Sih2StcMbw4fSf3GXk
Message-ID: <CAOB9oOaKLvfoKA1jrhx3VzejuZ+6RS9P1qga+HYoLe+h4UFqhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
To: yukuai@kernel.org
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de, jack@suse.cz, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:09=E2=80=AFAM Yu Kuai <yukuai@kernel.org> wrote:
>
> Hi,
>
> =E5=9C=A8 2025/7/28 0:47, Tang Yizhou =E5=86=99=E9=81=93:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > The symbol wb_window_usec cannot be found. Update the doc to reflect th=
e
> > latest implementation, in other words, the cur_win_nsec member of struc=
t
> > rq_wb.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > ---
> >   Documentation/ABI/stable/sysfs-block | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/s=
table/sysfs-block
> > index 4ba771b56b3b..277d89815edd 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > @@ -731,7 +731,7 @@ Contact:  linux-block@vger.kernel.org
> >   Description:
> >               [RW] If the device is registered for writeback throttling=
, then
> >               this file shows the target minimum read latency. If this =
latency
> > -             is exceeded in a given window of time (see wb_window_usec=
), then
> > +             is exceeded in a given window of time (see cur_win_nsec),=
 then
> Is this a typo? Jan suggested curr_win_nsec from v1.
>
> BTW, I don't mind rename rwb->cur_win_nsec to curr_win_nsec as well.

Sorry, that was indeed a typo.

I checked the code, and now both cur_win_nsec and curr_win_nsec are
used. The latter was introduced by Ming in commit d19afebca476
("blk-wbt: export internal state via debugfs"). In the Linux kernel,
both 'cur' and 'curr' are commonly used as abbreviations for
'current'. If we were to unify the naming, I suspect it could spark
some debate. For now, I won=E2=80=99t pursue unified naming =E2=80=94 in th=
e next
version of the patch, I=E2=80=99ll change it to curr_win_nsec.

Thanks,
Yi


>
> Thanks,
> Kuai
>
> >               the writeback throttling will start scaling back writes. =
Writing
> >               a value of '0' to this file disables the feature. Writing=
 a
> >               value of '-1' to this file resets the value to the defaul=
t
>
