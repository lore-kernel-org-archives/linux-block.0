Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3245020
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366592; cv=none; b=SCCumCmUmaBijJYGSThIKRmqjSvIrU2DYAJKjvw1PhWINIgDfeXrsi5CmVVEtQchxTEIcRk2TNxyRbvgYaGB5jf5PHZNPDg6pVXtL+cTKSQtk/pvdba6Pr79hDzQqvJWBofPu8wVV41YSwvgi5PbOPHNkMn2IqVtbSuFkiwNVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366592; c=relaxed/simple;
	bh=96q9XvURU9UK4eSdXpumcy5wqHtBHo4uAzurCv5lqnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTauRxt/VPrit9Jx3Wol4TbarcU3CkRkgxCqhRRdhmBgoUpLx1rlbYr5jZmlhc51jged2OPmGMIF49t3P+QtJP01f3xSfmrsRKlY55lsTofIvFIKFvgQjoNN4lcPVehj9mf2+qlmbvNp8DzxCchv9+KxO3P2dEM8uJYgL/m26E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0mqOXJI; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0mqOXJI"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7f161a3eeb6so715957241.1
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715366590; x=1715971390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2PXq+bIzUymL2/4umrGV5LlclRd9rNx+xV5yojQvxw=;
        b=k0mqOXJIVR5hFwhNhY9VxefYXVobhhqzoT3yIAsvgsEnrQ2+uBXB1a8cVszHAfA64Q
         KcGDHwttrLpnw/I9ZuWd2tKJephlwIJ2t3aGkIXY1tEw9HhFjJHL8ql1e1UZIKm+yewk
         9vM1QIkVv4ygU8dRh5+6ntg2BgK6fLXRonEZK2sLsynoSAiiVAqHkpg+JkYCav210+CP
         OmrMSpEQl1UmsFIqji1LWbQeQat+nys5VkHtALxQEfi7T0KoP1g+IwYFhysBVkttOtNL
         obv88EMbBvf6L5iyVv+U3HSnST1p7bD2D+mXH84rs4ZIEGG1k7Js24UFPhNQ8QDLRd35
         3v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366590; x=1715971390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2PXq+bIzUymL2/4umrGV5LlclRd9rNx+xV5yojQvxw=;
        b=cfdOu4KoosjBH0FY5/WG0QNdFn3/8qoFpZZwePvMMAzFu+wrxuqpH7yZxKVX/Ee5BJ
         CTNgr7mt4OxyIAm7KAFqUN8skdrS2Rwv2zaiMQKzjIzaRykoJ2+dfmDKPuOATDgz58OP
         KsZaBCnM+MyAFg4I/HPPpUw+OHPzFFv+LlOa+qVih/rlW1lOk7NhcfM8BRDV8yIk6J5N
         una+hr+nLPGNlz0RbZFrxnm0Z0f+Ysx0gcj9BBm6lwpx/xR1/E5nwCk4DcCEFP3aZwRw
         o+938R0GvZx46OMJMejx4FOQkf3eHWX9m6C7vzQ2TZukxYjZ61h/DKFlfQ88fSoELFdr
         Kjqw==
X-Forwarded-Encrypted: i=1; AJvYcCXFtCKX3iHPN6mB/Ja+JqNY+tLNuQEWl6g3qh4vrN6zDQcBZIBvJVyK+cIjDbHRo0gOgJu1xbJ3BcVKnEGZMhMHaPUo+Y+cg4ttwk8=
X-Gm-Message-State: AOJu0YyL6TMuh0bhnKA/jOg7FV2fqZ34PkVcR9JWoT3AzHYnyI7xIuM9
	ygThX0Q2MxZYh3rPXjIAitJEG7yAzvnvxL7K1ru3j9dRvcen0LPReS+mPzbdL80AI5nm4LMkPnh
	kG5duLOI9BMUCTi2aer2oP9WQnw==
X-Google-Smtp-Source: AGHT+IEwweXm3f+VrqqIlTVGCBZKVeLCLG0TLyc0fxrDlFxQj/tbsLoTuQ89oNhN2w4m0P2hOANktDi8/YyWUJaxLRc=
X-Received: by 2002:a05:6122:3c47:b0:4c0:24e6:f49d with SMTP id
 71dfb90a1353d-4df8829dbacmr4045538e0c.1.1715366588674; Fri, 10 May 2024
 11:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com> <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
In-Reply-To: <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sat, 11 May 2024 00:12:31 +0530
Message-ID: <CACzX3AvhZHsT7qAcWNU5pHDraHpfoAyspH3NP0oAdqbrhZ1d-A@mail.gmail.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:15=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/10/24 3:44 AM, Anuj Gupta wrote:
> > +/**
> > + * bio_integrity_unmap_free_user - Unmap and free bio user integrity p=
ayload
> > + * @bio:     bio containing bip to be unmapped and freed
> > + *
> > + * Description: Used to unmap and free the user mapped integrity porti=
on of a
> > + * bio. Submitter attaching the user integrity buffer is responsible f=
or
> > + * unmapping and freeing it during completion.
> > + */
> > +void bio_integrity_unmap_free_user(struct bio *bio)
> > +{
> > +     struct bio_integrity_payload *bip =3D bio_integrity(bio);
> > +     struct bio_set *bs =3D bio->bi_pool;
> > +
> > +     WARN_ON(!(bip->bip_flags & BIP_INTEGRITY_USER));
> > +     bio_integrity_unmap_user(bip);
> > +     __bio_integrity_free(bs, bip);
> > +     bio->bi_integrity =3D NULL;
> > +     bio->bi_opf &=3D ~REQ_INTEGRITY;
> > +}
> > +EXPORT_SYMBOL(bio_integrity_unmap_free_user);
>
> Should this be a
>
>         if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
>                 return;
>
> ?

Right, I will fix this in the next version.

>
> --
> Jens Axboe
>
--
Anuj Gupta
