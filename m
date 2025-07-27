Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644F217654;
	Sun, 27 Jul 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634157; cv=none; b=qMT3FHWPPHGmHHK37avDRB29TZtT76k+IRyvyzjHVxdsWNvCd3yOL+SLOVWEav6Wv1VFDjNjkNVqoVdclECbGgTibPeQBUMz37nnwIquKCWTTrl3ZF0QkO+esrd4FbdNmmaxaJDsBX0HkbZSGHVmBUHdYwPB+p9/UsNdjaUsrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634157; c=relaxed/simple;
	bh=uKAxF14EawlDKwMCpckq4oqxadnrWfUDGGgAvT5ojvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1JGVZP1O0RldQzJZjl5/VmIiIiFJgdwsAtc758WPwoCzLzK+LdwUqeV1/50G3WwLM8rLwtq34nclXQAsH2RrMkMOt1OGO4A62XAaaE0WE2x8OYvQvt/myR0qBEpzEr1IMctTKRW3w0nfzQbw7VBq6SjPMaxlvAQVULP9/9fPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuieWyOs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuieWyOs"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23ffdea3575so3517695ad.2;
        Sun, 27 Jul 2025 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753634155; x=1754238955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBerHzAFY1KVLbcOiy0TseZy7OHCBoqOvgqvhp3eINE=;
        b=XuieWyOsoFFPu2Gkd4HciVDFE5rjpSJiz0cz1ZZm4xOJwFvlYUaXIsaJSjOJi3Kt7+
         v7BIsyaU6yCcuWzDJFrklwB6HLUZnedewkv1nTSYuh2dFpq+dfVkSjL93bJSKT1+VYN9
         ZYuYd53q7kqSqxoUYgTTDP3C6xcEY2DAh82o42MCH3llYjjvCb3zujafKQe0EZ/34zxN
         TKFLsC5p42qYnoeUUnzlud8Nlnm7gJRoDzbXSmiCW2C3pDmqCDeqy/WBy8xdeu9DNJDr
         pA0Q/1xj36bnPAOa8pTXqpyFo9tFANU5sMeB52BKhWiSWkZu283/LS5g8Nt/4i7tyf2D
         wkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634155; x=1754238955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBerHzAFY1KVLbcOiy0TseZy7OHCBoqOvgqvhp3eINE=;
        b=kmCPI0ZwQP6oDtlq0sX/1fx3aTWM0fRF82waM0Bce6JFjv9AucuYApUxSeyt2Ks7/E
         N7fxRco3CYegrJ3oTBQM+O7c2q+lb0sNvaXgWtHgEKxTLGpa44Jx0UvWCXSrsvBfF1wh
         +CyH7L6YYJ3J5cH25N7ZNZhjU8Y5y7Sb+Wa28M2eA8RA1+WgImrNEZv/mhlc2drW2dWp
         hThp+iqvWgVKkRvuBbnuFPhN0cF8DNPvHNrNDex0TUMFzAqY95zAx5qBJhMA4VPwCkIv
         hDdgdXdAntMKvZpa6bQEC0oatkh4/cHsZcd2/hgk+cUGxU8iKwM1R+9HCpJna+f25PaG
         GjNg==
X-Forwarded-Encrypted: i=1; AJvYcCV1iUsexe4G/tu0nAxzb1v1uNyf4+7yWOA/vP6M9zQkgJEzoO6Q94eKu24LQw36qKd5Sa+zzHen4b7SWHn9@vger.kernel.org, AJvYcCXIKTEAmWq+TV9BFOJJKXjQwnMpNuIQRiPpifzkIwmqrp0NzZmzM8o6YiWabgq17OZHUuN/Dst81rZXCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIUDGrO9n4PrrlG9SJ0BHwc55vWDoHTqySleEI5fIXfxBiKL0
	bUZV4p0py+55//C9gSAHC2oy/xUs7mqAfs7byVwpvL3IhCeXqEr5ViWDziIfH9P6NyxcSgnSe0+
	BUE3FQt085f+Z+XdusLopENTK3KSzoeTY16Z6xpk=
X-Gm-Gg: ASbGncu+WnSL70RlGXT/zEywJgA+4c41cM0Jq2LMe/Us2S9O2YgSRxV2N58fNiZ2t4a
	LM/0wxr/wsJj0V3Cy4n2fI6XNCsD58U+M5HXXFpZLZQAkpLJnsVh/W7PJrxa6rxIG9oM1B8y31b
	68jJxZooRjrW7byhCRQmcva2aR7tM9b+GTTVFJ9mKBliDwMmM9ALhz+kLYrt+22HE3wWIxqJWEI
	vQhlzo=
X-Google-Smtp-Source: AGHT+IFb2CamYAmHpTQF5PJ4hW5lG7L+82CD/1+hue7sGYCvbB37FShudBsvAm4DlXTU1r/59NYfLCgY2F7jY/5J3Uo=
X-Received: by 2002:a17:902:d4d2:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-24011cd8924mr22131995ad.13.1753634155043; Sun, 27 Jul 2025
 09:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-4-yizhou.tang@shopee.com> <nk2qqgxickxelo6a7ywxwan2fshjkfygzdb6sooe3v4cl5f3ob@kvejyp5t2cmf>
 <b4e52ec1-a385-429e-8768-5e0eae1dc170@kernel.org>
In-Reply-To: <b4e52ec1-a385-429e-8768-5e0eae1dc170@kernel.org>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Mon, 28 Jul 2025 00:35:43 +0800
X-Gm-Features: Ac12FXwBcddSSHpVIcCGbmpI6Yft_rffNEpgjx6YMLfY6-btEA0VGvLSqzsgxx4
Message-ID: <CAOB9oOaX50BSuftdBWe9LMNCTDdF4RtQCs1kQrX+3mMt95z7cQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
To: yukuai@kernel.org
Cc: Jan Kara <jack@suse.cz>, Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 2:16=E2=80=AFAM Yu Kuai <yukuai@kernel.org> wrote:
>
> Hi,
>
> =E5=9C=A8 2025/7/25 23:49, Jan Kara =E5=86=99=E9=81=93:
> > On Thu 24-07-25 16:30:01, Tang Yizhou wrote:
> >> From: Tang Yizhou <yizhou.tang@shopee.com>
> >>
> >> The symbol wb_window_usec cannot be found. Update the doc to reflect t=
he
> >> latest implementation, in other words, the cur_win_nsec member of stru=
ct
> >> rq_wb.
> >>
> >> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > I think the name should be actually 'curr_win_nsec' because that's the =
name
> > of this value shown in debugfs.
> Agreed, or you can mention both the field in rq_wb and debugfs name.
>

I will change it to cur_win_nsec in the next patch.

Thanks,
Yi

> Thanks,
> Kuai
> >
> >                                                               Honza
> >
> >> ---
> >>   Documentation/ABI/stable/sysfs-block | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/=
stable/sysfs-block
> >> index 4ba771b56b3b..7bb4dce73eca 100644
> >> --- a/Documentation/ABI/stable/sysfs-block
> >> +++ b/Documentation/ABI/stable/sysfs-block
> >> @@ -731,11 +731,11 @@ Contact:       linux-block@vger.kernel.org
> >>   Description:
> >>              [RW] If the device is registered for writeback throttling=
, then
> >>              this file shows the target minimum read latency. If this =
latency
> >> -            is exceeded in a given window of time (see wb_window_usec=
), then
> >> -            the writeback throttling will start scaling back writes. =
Writing
> >> -            a value of '0' to this file disables the feature. Writing=
 a
> >> -            value of '-1' to this file resets the value to the defaul=
t
> >> -            setting.
> >> +            is exceeded in a given window of time (see the cur_win_ns=
ec
> >> +            member of struct rq_wb), then the writeback throttling wi=
ll
> >> +            start scaling back writes. Writing a value of '0' to this=
 file
> >> +            disables the feature. Writing a value of '-1' to this fil=
e
> >> +            resets the value to the default setting.
> >>
> >>
> >>   What:              /sys/block/<disk>/queue/write_cache
> >> --
> >> 2.25.1
> >>
>
