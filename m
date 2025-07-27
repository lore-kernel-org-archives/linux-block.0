Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367321B9CE;
	Sun, 27 Jul 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634119; cv=none; b=dKm/mtocKvMPkuuOp73iFVUxWyX/l2qAJHzH5y/135E5NjdzclouQSrtB3tfc8iEyUmvU5Q+wFjowdHX2fW3+b8cvprL2X75E4T9uyYNggPlx1uySp4TbGD0Ky4/M7oO5Qt8ANLiVl8O5suZLAoiAdjofC8rgp7KQBPn9Ll89lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634119; c=relaxed/simple;
	bh=VBLmlWDOyMYFgPc94fMQRoz1ikpH8y2if/N2Yj1yvMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWFErnn9WWVXZiL0nNOFUWaw7JjYNnpvcRH1pPrSms/Rq+rcPLMyvS+1tDukAFUtaNhjkCC8JU0uJF7T9YsxKBkzwy5W23UNUGRHOFl0HSltTEJi50uddl2SrXqXvgQHtf/gBQryQCiSj69kT5ZWA+9FIBaSewlWoIijbS9bBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmpgdVt3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmpgdVt3"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31c84b8052so4206362a12.1;
        Sun, 27 Jul 2025 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753634117; x=1754238917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi/pacCOnG+zF7RB9PA3nOBBI8Rbz28pr1Put8fWaN0=;
        b=RmpgdVt3AuKVYtkewT7Q1Z6bfkTyF3Rvsf0COnaZyLpP8aATxAhuaU+gYCatnvXYYi
         +pt/SvAnuQpRactbhFQS31hzACebx+/I5cov6pMZSqehngH42mldHDT5KJcyK8W7TkmC
         C6C261mwbzU+p/1Al89zZd7Chg6CKxY86lJuZiFKmJx3S4q7qdQLPBeqi/baKNhqrHQY
         r7orxaYTPA7n7TFBr6qf0IoarrjjPyWotY10auokQtwL7RsKdoWXNLCwGAt6yZMFVrBm
         6f9QWdgRkuX5ytgWxzZnOdmcA/AKxBGaJrExVYajJHcBs3xKp5WfF+8nqoHAQuz4I0Ld
         HXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634117; x=1754238917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi/pacCOnG+zF7RB9PA3nOBBI8Rbz28pr1Put8fWaN0=;
        b=U5IrvExu0uo98JpoSiDvv6wXv59Frem9V5F29FTzRCz9h+7G0nqOPx32lS2TWNU7W+
         GDHZrUFoqHBc6yqBZ745qEzXYM4wFIHWU5K5bwk8zJINIGw6cCh2Z4I6GTxHRl0n9b7F
         ILjaJ80hl3bZK566Mr8efo9X6OfP0SfXbWykB84oYCCS5zpQI0wwlXtLmzXVmS1HWNXz
         AtPyVMq9KY9VFobnVGimAghNKdaATmWFZcqGvY1EVDNHmfOgoAnV/aAWDWV8m59IxCU9
         Q9bZ2xSLUhyw1t9mDknQlRVhF58wkbvSJ/+pvEV/Vz5Ci/JHv4db+wdZ07XBPfif5PgY
         4+5g==
X-Forwarded-Encrypted: i=1; AJvYcCU4YOPbEbq6X726s9t012aGby0AsHDk8jjlAGxDFP1zCRMQ4hlyj5vx+lONS3gSGItpyffEd8BtDt4r+A==@vger.kernel.org, AJvYcCUG03h3B/4wF0qQjg2WMyTmTnax3HU7sNK/HebRyyHNRJ6RqCTt7f6NfwNvZdu7vkLpoQiHP9XoAIzXKqSz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ch/saUtk/fUpED4YxId4zqj2bOzzu9hk8cAR39TdDnEms1xO
	4UR1SX9GekhK9W7tUTum+yYZlIZP/l6gKojsKJsEIKljBJRN4cSgaeeWRXBny8OoAbnWkAa0Tjc
	b874H+cKSVHp0B1BV6GWUEGqA2FArnXk=
X-Gm-Gg: ASbGncvsJjZPLimygAFzCGUOp3RIRff3okONVDAuzP+D/fHNbu5jg7AMNyulrXJXIzW
	+I01Q3wFqiTItY+HEN6gb2qFpOsJTO4CA52Khyl04Zw6WzPQjRpkSpDRHz7pPfzcRsMoC18MOjr
	lOYbeD895iEkC8VO7J+XjEP7aRxckEPJ23zeOQp8kzLwE/x7mP7za4vgy6Bl+XGgqWdMxbQG5eT
	4qkINU=
X-Google-Smtp-Source: AGHT+IEnBZIjNpzsu2OtGSerulQExSPADHVmoRas1xbF5oNLsN4hlZqbEhZsg0APSZxFCRdj2L5xmSeNWdeq4VeR8Ds=
X-Received: by 2002:a17:90b:3e8b:b0:31e:ec02:229b with SMTP id
 98e67ed59e1d1-31eec022a8bmr1272504a91.20.1753634116772; Sun, 27 Jul 2025
 09:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-4-yizhou.tang@shopee.com> <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
In-Reply-To: <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 28 Jul 2025 00:35:05 +0800
X-Gm-Features: Ac12FXzYe6t-D5QYvYLUTqZOzDNiM4OUKs8O3VbIQFvPki00ivhsu3tqpqRUIJs
Message-ID: <CAOB9oObOcbTU8s-rnqSeVKjCjM4Z6ySZzkkLamQ5nvVTrTH_6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
To: Jan Kara <jack@suse.cz>
Cc: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 24-07-25 16:30:01, Tang Yizhou wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > The symbol wb_window_usec cannot be found. Update the doc to reflect th=
e
> > latest implementation, in other words, the cur_win_nsec member of struc=
t
> > rq_wb.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
>
> I think the name should be actually 'curr_win_nsec' because that's the na=
me
> of this value shown in debugfs.
>
>                                                                 Honza

Agreed, I will make the change in the next patch.

Thanks,
Yi

>
> > ---
> >  Documentation/ABI/stable/sysfs-block | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/s=
table/sysfs-block
> > index 4ba771b56b3b..7bb4dce73eca 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > @@ -731,11 +731,11 @@ Contact:        linux-block@vger.kernel.org
> >  Description:
> >               [RW] If the device is registered for writeback throttling=
, then
> >               this file shows the target minimum read latency. If this =
latency
> > -             is exceeded in a given window of time (see wb_window_usec=
), then
> > -             the writeback throttling will start scaling back writes. =
Writing
> > -             a value of '0' to this file disables the feature. Writing=
 a
> > -             value of '-1' to this file resets the value to the defaul=
t
> > -             setting.
> > +             is exceeded in a given window of time (see the cur_win_ns=
ec
> > +             member of struct rq_wb), then the writeback throttling wi=
ll
> > +             start scaling back writes. Writing a value of '0' to this=
 file
> > +             disables the feature. Writing a value of '-1' to this fil=
e
> > +             resets the value to the default setting.
> >
> >
> >  What:                /sys/block/<disk>/queue/write_cache
> > --
> > 2.25.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
