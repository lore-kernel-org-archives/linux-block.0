Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6131E991B
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765101872; cv=none; b=BOr9RX/fnfPyAqwDtSuucqJJOi6GQyNaxw4D8VtriUWHILPvkidiIRtFWTxkcr6NxtZAtkbW4beC0o3bpD8krAEKJkU4evlbtMKQZQss9fYRjzPhTz5Rd4OgTRQUQdTvBcHDX4pHP3hP6ioFmftuigXc1KPtJTRPr5PT72bhlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765101872; c=relaxed/simple;
	bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5/X/ar3ZsiFvUt/L9PxqeW6j6PVEPDVcsuqG+cNmkxuMAoFwoVR93iEWkCTrWqZg5ts4IOSTnR+BXkEq4uNisDmfQVTVs2G9rIcaCupxEfU/sTPEFZV5ys3th45aTeUZFun2XCPp10IKpvvzNmm4nWBHIx4jDiEbEGCoJ8hRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSQIzmnW; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSQIzmnW"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2627269d5so293010985a.2
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765101870; x=1765706670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=RSQIzmnWj4khIOTf0dWLfD3/Kb647t/nCWk2E4sHXhw+mItmDj9ehTOnAUPSQE0U04
         h7ubqgDAHGu4fblNFF8M4DsRTwJ/fMtrS+aMJkIbmkFcIYudx9JHLrhvhRQ5T7mBBcaD
         3ATRVYkW9o5UxUypUahcEjFc0IzsUWPOU8ziilHmECruvt6zvSdNnzQLW82BWsRyWrEX
         82vUbCk4zTJTIzu3XdvKgpQLcNUFKIl5CnjJHW/0mjyhxGlH4YjgAv3xJ9dy4gKJ0Vbv
         qzywEokoZv9Vem/8ztVxKyS3FuyLzJlkwP9FX0WoYD0tlWfzdXppkLD5rLIfek7uMvbn
         7MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765101870; x=1765706670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oU+vvCeHMKSGHwu1ci54jpS3s8eATvZ3aiVnEThBVIc=;
        b=bLio4c8Ag3mF6Oh6Wbrn4YokWB/Y4PB4hz9KMXCbA+2t/hCPzFd21swzlekewkKt8I
         cODu1FmBt4LO0PsZ4cWNhkk1Z6hy3Q4BhzNvST9wXz7x4p0Gdw25yUlMy+fyNhuDvi+P
         aSzDgU9SFpmgupaNbCBcvc7goFUIEBUlznhJWfEjFdel0Xf7w6VnlsDJJsTouzNjUR2o
         jtxkn5YirNmg6dTa/2fEv6bJJ4DKwVrEOU3X4b4IHSuMBJrnBTxMiA5OL3txtEY277lv
         Q/cTH3+iITI7gpeGmxLdwsKo4Yfjnz9WjYSE82GwJWS1YpUEq0Wx33a68OVAoEDK+riL
         kevg==
X-Forwarded-Encrypted: i=1; AJvYcCU6FYItVm0lYr2ImVs0eF8QcBr0QR/pF1D+qDdGEz6PH6M8wwNzukPW8/jwUBlXsmK56Sc7JZx+o8j4NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfnwWdBeLboU40kBFE3ArLFXhw8jbruGiC6tNZMfsSt2wthGM2
	OU82FJI7srNcmPc15mZoRAkm9yKKmV9/VQh2b9VSuFDQxkzeyzDDdjuo2YXQTijgl7iOB2Kzrm8
	/uJ3eGZZW6+4u9qzMIa4o4A6EF0UbwOc=
X-Gm-Gg: ASbGncsqdvbO0sUU25iC8oPIi1zYuyeNryGW9SM1TI8N/DRhS0sKQhW2UCISy8CBbJz
	/QQt8BoyWeUsMrshf8TGMfwVfNvVuoAqQXdONs2XjyUkv3H7kukkI97eL8Du/pw7sZgegv0bvF9
	RDbrUWUWZeblTpEDfy7om6rMERwn1sy6MXAh+oFIVTJK9k8SO6oW5lFnSX6thZb4zL3Ay2T12Cx
	JXggev9IMRZ+HG5aM1jITKRt6fAputp7O3LitTbnmCiUR0uWRwtgHDL8RCcv9U1YpNzMq4=
X-Google-Smtp-Source: AGHT+IFyS19gciaAgZhRx4HvH1R1sNPMXGO05IWdCy0tyufd5AG5DROw9tSZhuIt2ZeFQYvOMOepLj8Zf3YwFI1IGTs=
X-Received: by 2002:a05:622a:1249:b0:4ed:aeaa:ec4d with SMTP id
 d75a77b69052e-4f03ff48c23mr65405971cf.77.1765101869874; Sun, 07 Dec 2025
 02:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
 <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
 <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com> <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
In-Reply-To: <CAHc6FU4G+5QnSgXoMN726DOTF9R-d88-CrfYMof0kME6P_o-7w@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sun, 7 Dec 2025 18:03:53 +0800
X-Gm-Features: AQt7F2r1YNFWGA2Q9VwdNr_tG5KYi4lqES_2HjNJQ6tE7fdz6CI5_Dt06IQV2e4
Message-ID: <CANubcdVAitTW_aBqwxC=TV77rg_iie0uX54_qEtMCjgdN+zeig@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>, sashal@kernel.org
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=94 16:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 5, 2025 at 8:46=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.=
com> wrote:
> > Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=
=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd=
@gmail.com> wrote:
> > > > > This one should also be dropped because the 'prev' and 'new' are =
in
> > > > > the wrong order.
> > > >
> > > > Ouch. Thanks for pointing this out.
> > >
> > > Linus has merged the fix for this bug now, so this patch can be
> > > updated / re-added.
> > >
> >
> > Thank you for the update. I'm not clear on what specifically has been
> > merged or how to verify it.
> > Could you please clarify which fix was merged,
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8a157e0a0aa5
> "gfs2: Fix use of bio_chain"
>
>

Thank you for the detailed clarification. Here is a polite and
professional rephrasing of your message:

---

[WARNING]
Hello,

I may not have expressed myself clearly, and you might have
misunderstood my point.

In the original code, the real end I/O handler (`gfs2_end_log_read`)
was placed at the end of the chained bio list, while the newer
`bio_chain_endio` was placed earlier. With `bio_chain(new, prev)`,
the chain looked like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`bio_chain_endio =E2=86=92 bio_chain_endio =E2=86=92 gfs2_end_log_read`

This ensured the actual handler (`gfs2_end_log_read`) was triggered
at the end of the chain.

However, after the fix changed the order to `bio_chain(prev, new)`,
the chain now looks like:

`bio1 =E2=86=92 bio2 =E2=86=92 bio3`
`gfs2_end_log_read =E2=86=92 bio_chain_endio =E2=86=92 bio_chain_endio`

This seems to place `gfs2_end_log_read` at the beginning rather
than the end, potentially preventing it from being executed as intended.

I hope I misunderstand the gfs2 code logic, and your fix may still be
correct. However, given how quickly the change was made and ported
back, I wanted to highlight this concern in case the original behavior
was intentional.

Thank you for your attention to this matter.

Best regards,
Shida




> > and if I should now resubmit the cleanup patches?
> >
> > Thanks,
> > Shida
> >
> > > Thanks,
> > > Andreas
> > >
> >
>
