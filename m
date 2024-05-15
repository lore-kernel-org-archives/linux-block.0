Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCD181CEF
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722233; cv=none; b=mVvjwMdhw1WFA7n9B/OJAyqpjz8kAjf0072AWhJZx5VnXZlg9SIg7Nff2J5mMYOpyRNwFOZQ/Hq0fmBEzEW+gW1kTvroJFipGLi6HaMpFI+bW7CZYoRBY+8CLn0iTSUTPm2FX/ddrkLCKDYqPvDvrWWwpKVVc9FHpCbWisgc0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722233; c=relaxed/simple;
	bh=RuAI++SoVIlHd05YaYB8gWn2IVcA/jHLXYOcRf3tQKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2Hi+yEhSIjsGgJZ/GZ4TIZTAv401xXFLiDrgcmjgcUfyR2uLwgRcOMZp/0n4I7/aEX+KEiJVZJtEcV5zyIJi2nKJN+8zsqPfPF9/ruLFMcspcnZOUSkaOlVltia/ZI/+wKPzt0TT5+AviS/8uzYgW8JYorF/d4Rajhq1l93UPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyCmrLzS; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyCmrLzS"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23dd52c6176so4189518fac.1
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715722230; x=1716327030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZurqd/gZ6QFwdhwsizttTDWmPh16bUHHZCUzWs7aTQ=;
        b=ZyCmrLzSd1bQ875B9a0xAnNVEavDuqMG/gJcZuNYlQkpS9ycB9GThDcwnea9r/68KZ
         lvPwj75VW+taQz0NqZk5uL/H4Iyec+M6NxtH81R2+yoNoni7Gx+ZmsOYlJ/Qe1eQIaZC
         W7WOLhp7pJtjdwAwJYOm31By3oN8Vs45AqdrujObmxeIMGcG4ARiLhK9XOnlmNf2xS30
         MZiogpdNGrdYIeUfBXDS9S/gjFoy5SCxziadvSH13Y7OVI0hWpniC55rqCW3TzK1EwOR
         MCdUCv1LUqXPMt0lk05g2QZBy1e0h4pWHQEDlOZos6jI/E4ls1LpDtDUN29ZbfEgJ/as
         jD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722230; x=1716327030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZurqd/gZ6QFwdhwsizttTDWmPh16bUHHZCUzWs7aTQ=;
        b=dvDRQ9vF9biqW+aO9tDUoLvS5dlYaOCRc5qvuqP8Vra8TNHe/oZtH50EsZQlW4e4k/
         V38MwgCZQHubk0a7is+VTpGP5arLDx9+usOvF/qlGlF+kPiVfIxkDVCbV/wYZhz5nqYK
         4+mLAE4s1DGjd3ALk2gum8msxJfJjoueG0hdyHq/a3IUZlie4iBaGgMvJpkMUhq3GnWE
         8mjPnMez4dgaeI3sL4iyDaFo9EWBou6G8J3V2BLP7xW7HSMF10Uq5rkiI9EbjKV6uqGi
         MdAipoaM0UAw+AAiAoCgjue2J5cgpWf4YIGZKYzI+P+UmajiCx8v/7Abkq5t+qRAgOBw
         ENGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/2OHqw148GMbkZ0d8fiMdLgySaK5MJz5/50flvG7XWzEx6I3AS+OvGYxB8sCNqCkMLome1yl3wYr5O5jbZIdbKtq3G1tVZdlQbJk=
X-Gm-Message-State: AOJu0Ywhc9IM2esVtWGTqPiMWHt7tpDM8uOut5yx/PbGgOawDDlysg0e
	/f65Az0r8Su6MtKz4JzVEAq1afpMPeYxJw2o+afM7meRCv7hLOvmRAdFAzvm/kG5cLC3LfW/oKu
	4Kcim6vaf8EweaqRR0+y+GKgFI9CyxmR4
X-Google-Smtp-Source: AGHT+IEycJcbPG5zfCZqWOSZZTQntcgwvQT5RiO9XocQJvPSCsd1FEQKQGkcgRfm9DqQvfwhKyHU5zzYSuTd6dAI5uE=
X-Received: by 2002:a05:6871:e01c:b0:232:f9e0:e4da with SMTP id
 586e51a60fabf-24171730217mr6811949fac.1.1715722230103; Tue, 14 May 2024
 14:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com> <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
In-Reply-To: <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 14 May 2024 21:30:03 -0600
Message-ID: <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable FDP support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, david@fromorbit.com, gost.dev@samsung.com, 
	Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
> > On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> wrote:
> >
> > On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dubey=
ko.com> wrote:
> >>
> >>
> >>
> >>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrot=
e:
> >>>
> >>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the ho=
st
> >>> to control the placement of logical blocks so as to reduce the SSD WA=
F.
> >>>
> >>> Userspace can send the data lifetime information using the write hint=
s.
> >>> The SCSI driver (sd) can already pass this information to the SCSI
> >>> devices. This patch does the same for NVMe.
> >>>
> >>> Fetches the placement-identifiers (plids) if the device supports FDP.
> >>> And map the incoming write-hints to plids.
> >>>
> >>
> >>
> >> Great! Thanks for sharing  the patch.
> >>
> >> Do  we have documentation that explains how, for example, kernel-space
> >> file system can work with block layer to employ FDP?
> >
> > This is primarily for user driven/exposed hints. For file system
> > driven hints, the scheme is really file system specific and therefore,
> > will vary from one to another.
> > F2FS is one (and only at the moment) example. Its 'fs-based' policy
> > can act as a reference for one way to go about it.
>
> Yes, I completely see the point. I would like to employ the FDP in my
> kernel-space file system (SSDFS). And I have a vision how I can do it.
> But I simply would like to see some documentation with the explanation of
> API and limitations of FDP for the case of kernel-space file systems.

Nothing complicated for early experimentation.
Once FS has determined the hint value, it can put that into
bio->bi_write_hint and send bio down.

If SSDFS cares about user-exposed hints too, it can choose different
hint values than what is exposed to user-space.
Or it can do what F2FS does - use the mount option as a toggle to
reuse the same values either for user-hints or fs-defined hints.
