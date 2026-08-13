Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497D36A03F
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606527; cv=pass; b=B0lGfgbS78+spetVpi/KHBJOfFf3qEMpxqrk72gnrGmQ325S+mEiCx6io/hEx75nmfFwcOdrwJD091GB8JALZCX7wFiFqzaH8j9zwROIQPvcgwBeZa2WkQHCOowyafatDGCUMgCOftDN/zn7JQv5kk6vvHhkb77s+A8YMKy9mpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606527; c=relaxed/simple;
	bh=y7qJ7hwfM2XRLr6JodOHK6g7YYZSMVnnUqSagm20tAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Neyna0KhW6QDvsCANQAVSAZ/sSL8GOfM+ny4yUcVULvxEUpxu7kHZQx/8FtndU2QgcF2VzANbw4ct4AvVne6tSdSd2rdNiq2nFt95fYIHkwBAjmTQZ5brNI0gz4RWkVeuuLNVId8RLkz0ZvKTnjUYxlFEEKjthf536ZidgrlhfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMqV4zLb; arc=pass smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMqV4zLb"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso19680695ad.1
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 00:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786606525; cv=none;
        d=google.com; s=arc-20260327;
        b=YXompxpcW9McAoICDQwYCnKH+gKsv4qgf/vM4/WlaOcoLoWVUJkkx+0CfkvJZZkEaF
         j4lQOqfFnvNliKGQLzFcveqVdaf2nG/cjsWON3UQtrY6U8NXB3oGZU7biRh1n5LomwnR
         9GqNznzQT+ck9JryZZ12gWSlrIXYPhGGTQXzT7HDfS0brKZVyAilX46LtK9P/1TeYVqu
         9Ajj630taigPAho1xVE6ZqDovxxm7jrUzeNe+3ndjqoul9V/ICEfppHyilPLU4iqwEZ+
         zk6kLsUKJytfDhgJ1PTHbxs48IQV9ToZSSNPkPIjF72yBmPHzLs4haDC+d/v1M35tM5L
         nloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9Otx6ZqxAiVjNNzOLpF0kwD6Aer9gVo/rRXt1r2Kpk=;
        fh=2K9xecXyb/phhm5de45Fag1Z6EOZT58YVmO47daZDlc=;
        b=o2EGW4vwTWDZP0v/P0rDNZUJNYnofzxFJffqczjhmj85GkPPaycdfyrRUA8rJYUhD5
         l0OpgYfrmzPlno+P4qfq96/+w4ZScv9070aFp271t/jLC2/Mm4FS/fh3yFFWEAJUKUSq
         yR+bw75bqUvGPDZ5FuiHtmcWv3oGWC+gcZsTBP4EBTWS94dvAFTjT9uh55kejD1hlg7e
         VaER++H0SayzHBqAjQRm36JShjqjY+dRMucLzfrV+Wrggf7w5Amo8lWDYfAhFCUUQnDx
         iaBurwUY+3QMg/WsVtziQ/OlJ6hrkaIOPVDuPp4Fi64T6/9GZLz73Y4x6FpaqERrvr7D
         QXtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786606525; x=1787211325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P9Otx6ZqxAiVjNNzOLpF0kwD6Aer9gVo/rRXt1r2Kpk=;
        b=dMqV4zLb++wNJ+fs9J68zljo5NVaMp7IiF/O6GCxqeQ/PoLNlsPIfhquBJofn1bTFC
         T/RyJtyUmjftJOyiM+eJJhvMnBTgDN0WOIHh/4QT8Rm9ZtXMdWPQiG/9wccTM3oR7U84
         8hdjt26GmuUIFvvOB19yDWCMUj5DSHmTsVEl26H836rZ+m1q1ajyN08KTgqGTY6rPvkw
         uRNUW22O2vIfJF7gd8Fjcc2jyeGMsaLCZmPurVSVSI/ptoeqyddLxOI0eXi9+JpstiEL
         9P9DhPB/PCPsMid9d7vGsq7FQ7TSalJLeVrHPsoWUG7kYv20tJIL4h6Iq07yg5YarfVU
         K2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786606525; x=1787211325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9Otx6ZqxAiVjNNzOLpF0kwD6Aer9gVo/rRXt1r2Kpk=;
        b=Uo8CCpFNdLOrL3VbulL3QjFNig3DCIH+8XGZzJ89AzmGosxurjeYn0AjMy0hNxG1En
         bDnaQCwlCI9zzCIx3Z6/3pw69nexb1bUeT3x9LLbMKdz7F8D3h9hGV/z7oiS8REe/tCe
         zQgh4D66I8TghonXiS9gFCJrg14Mtvk2pEvVvbaKxiUCPbDbvLNEnTALMJ23EtcaPNdn
         Wzg+giR+eVR8gZl2AM5EhaUKfyvAjmFn9SoSF8sCffU0jZEU4XM/GEoFDtV08bWrkA8u
         id6yKykBq4D3cjkhvVcHLxNu29MWenj14s2YyUpPKDus1/d1vzzSJ7vw6bkOSkcODhf7
         JgAg==
X-Forwarded-Encrypted: i=1; AHgh+RoTISGpNr95OCn6w33WvIGwrPX2FEdvwiRLNQmSBHrYC1afUhO/iaUi4ugVa1QLUvptZafUZtlwo5Lfrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYR6ghb4+4d7ozxv6iycOPgPhp8oYnwEAapMvz13hMjoTWiUE
	tudJAJUkD4HXNGPUv8PzMJy6UP4W7NdvNlffw0WSyKl2z108E3TvMJvXoWL8K0K1I9j2vbELbPA
	8EN1mi1koG3al447AD0wl9FDxXrr5O/Y=
X-Gm-Gg: AR+sD12r/x6tZd502RX9Xgc8Bxp0Q/uikbNUIfu2Yqex1pZIxrcA9VPQflnK6ZtEGwy
	nY2uomh37UXtq4mWlqdpM6dGxZzXpfT/B3qGU7tALn20D3QBGPEpjp/wdJnd0UYBNcWUm64qHad
	TiL0jjJrykYkUs6tyG3yuU62ZqkWl6+/9zP0XOMQkzb9Lf9axwXtOUYMODKJ7YTErUcSGXdURi9
	n94Wh4EhTlRNvywI/9U3ZJweoV22qfU7NtsevBcmp+cVeYwZAklDCdDmzIYgk53SE2a5V1eJb+c
	ipginKAwOsuyYY1xO/u37fk8pjXhQ62dc3dTfdxHSJE=
X-Received: by 2002:a05:6a21:6a0d:b0:3c3:bb13:438 with SMTP id
 adf61e73a8af0-3cc553e0a42mr5885845637.32.1786606524794; Thu, 13 Aug 2026
 00:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812130335.60354-1-mzx199711@gmail.com> <anyicCnbACxAiTTD@infradead.org>
In-Reply-To: <anyicCnbACxAiTTD@infradead.org>
From: =?UTF-8?B?6ams5oyv5YWI?= <mzx199711@gmail.com>
Date: Thu, 13 Aug 2026 15:35:13 +0800
X-Gm-Features: AUfX_mzcrYN5r9tMwJ-6xPHLnaflX0j1EFC0fZLU-0EJpZumje8IJdjuzY9HFWw
Message-ID: <CAAth02BEXd7uy4LpXS7t42bH2kvkFDEcsLdHHAUizaV++zWzEQ@mail.gmail.com>
Subject: Re: [PATCH] block: skip redundant flush for O_DSYNC direct writes
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:42=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> > +     bool dio_fua_done =3D false;
> >       ssize_t ret;
> >
> >       if (bdev_read_only(bdev))
> > @@ -763,9 +764,13 @@ static ssize_t blkdev_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
> >
> >       if (iocb->ki_flags & IOCB_DIRECT) {
> >               ret =3D blkdev_direct_write(iocb, from);
> > -             if (ret >=3D 0 && iov_iter_count(from))
> > +             if (ret >=3D 0 && iov_iter_count(from)) {
> >                       ret =3D direct_write_fallback(iocb, from, ret,
> >                                       blkdev_buffered_write(iocb, from)=
);
> > +             } else if (ret > 0 && iocb_is_dsync(iocb)) {
> > +                     /* FUA from dio_bio_write_op() already made it du=
rable */
> > +                     dio_fua_done =3D true;
>
> This is kinda the wrong way aroud, it should just have a need_sync
> variable that is only set for the fallback.

Agreed, that reads much cleaner, I'll modify the flag in v2.

> But looking at this, the original logic here actually is very fishy.
> If we have a driver that does not actually support FUA, emulating it
> for every write command is a bad idea.  So this should be fixed to
> only do FUA when actually useful, and then return from the non-fallback
> implementations if that actually happened.

Let me make sure:
     blkdev_write_iter() then only skips generic_write_sync() when
     the direct-IO path actually issued REQ_FUA (i.e. iocb_is_dsync(iocb)
     && bdev_fua(bdev) && the write completed without falling back to
     buffered).  Is that the direction you had in mind?  If yes, I'll send =
patch
     v2 later.

Thanks for the review,
Zhenxian
