Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AF279DAD
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793280; cv=none; b=ZW2rbOwnBiFwsEiwvbznFA4jsTgZ9OCbF+ql/wZAh0bdR6SS/YH5msg0fkiE8NjNkjk+pCLZI+u9xWYH+wD2xsUhq1i6sSCoH9C5dkSkvHakH+30PAV0ZGduOHDq9bKjuDSRqV1LekcHn5nVLVI/yaDkE0mtNQBWNxFXVwzUA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793280; c=relaxed/simple;
	bh=nOIq144xGgFO4bva4FYwPZPvaRNZDvPcNywFLSl7Wtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaMDDcHyfM5ZTcrF2/FNFDuGsLXCH13iCt4Kt5tRc8PRP+/xBPO8EF2L53TXMAHmTL8YTwfN8uo1oBFXx2s4530qJgXmm55X14d3WnetEexjlRy8mBefEzfruDv8A8XFdv5e04WnAsYB71jBUJtTiCEwvN4Q2sbEq6J4uNgLqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EIE1mYY8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EIE1mYY8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297f5278e5cso4041555ad.3
        for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762793278; x=1763398078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZqfsqvlctuD50vkPLsM39GcbviXIyVkPfjtYlBZ/X4=;
        b=EIE1mYY8cMtV/BEwVJHw4yegOmjxsyMLsaj1JcTJtE3KNNf5J4AlxFYgWXDNKCQFG3
         YyGGCgkPXkFkMtNiiTBajQi9FLptD8LkGzM/URxVGNADKkLyrVuEezxwi1yGpAHaBCSf
         I3qnhxPsGI/dDiS3lzlXKN5tyJZx/0lShIZcBInnJ/3Z+6IRns5ark6f2YLRVJBsFUki
         cXLWsHAr6PQQZYuoeKs3M9EJNFCSM3B3SRqB1oNhItXOh8o/2cCPpQ+NRMsUAFSlV8Mp
         NbTdNoDmCBO6j0ZSplp0pFXvcVwZjmqKUm1FeJTx/+wETuzNOoK9XaQpvEf3xv0DqXk8
         YGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793278; x=1763398078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZqfsqvlctuD50vkPLsM39GcbviXIyVkPfjtYlBZ/X4=;
        b=K2+lGqdXjGDYknyUynkvy/WM7eWUFyjo9kEQ2KW82dHgG8hdg3Ah8mlaNt6jK4eJZl
         KT9iB2orzZRSLoeVpctwOSv6/7ewGhLAC5cR6yck9xMxLdFT2aVUdtVrdU42bAWzUUHK
         8Lzj7tGog4ByvdIVmWTt8/I3xIG1JXf872DzMMXt829OFA3gMuGu8eSoLaccMDVNqvpR
         fphXVbcx9nLAarU1sYAgkCsGcAlW3S7hTE3ATWMy9zrn7TWqHJlNRo5/ZnieP+GhyUhp
         ukDyyIoe5ijRNRO/zk44/hVvL7jTFne+Kcb1dZbuZl0+UjFnRNcR88R+ihUWNnig2Z9k
         Fuiw==
X-Forwarded-Encrypted: i=1; AJvYcCUAPxxnCkF28D3cNtrl15PETsoygtAdJI2FUhHDKNu3cXdSgqoGf257N0lHhGv33m7a/m+oTg5h/OTnig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+eEa846Y3zSJryKA4a7+Nvi8uxbsELBwI92Y0ItR3y9cfc/X
	IhDhETQb6L0q2idKoATiiX4V537zrdML4fF6u1UPZnMGbyyDg9x0ot5XpfkpewFV7+GYG+rzqt/
	1C3N2zOLCZS5V0Pe+KmUBW5VTPO7vxoO2lvXwxVLGbQ==
X-Gm-Gg: ASbGncttORPU20W2ROe0ICEK9Q3WbfSPF55Eha/JGtfEBHL0D1T8L4CNA2PP5mP+wUj
	ttjB4Z5D8vwmgWid18fS4RgspqWj1JZ8v+Fb9zOqZ/1UAlZxbpO1ifBzhuJPiteVyfUuwmuGbjE
	OBrAm6pKI8OiFUYF6DYqE9ES7Qu7qucY0FZ2ibmIkwFqqAGr6mPK3eubxY5hBI506x4sPx2faT3
	WMcXvJptUHXof8ImohFClZ+h3xvam8gB8mfL5QNehTWWzZ5tu9LI5QYxW5p5WnZs6muIOmvkjjC
	au8xTwHWH9I2m9LeAi8mG3+7iI7E
X-Google-Smtp-Source: AGHT+IFIOdjBHi3w1pnM/HGJ88+v2H+dG9zQ6DmQ1N7yZm773WThOr3yfaWrN+hUKMkOOzsS5iJ835zONe6DvUk5kkI=
X-Received: by 2002:a17:902:eccc:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-297e5657e71mr63866195ad.4.1762793278132; Mon, 10 Nov 2025
 08:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108230101.4187106-1-csander@purestorage.com>
 <20251108230101.4187106-2-csander@purestorage.com> <aRCG3OUThPCys92r@fedora>
In-Reply-To: <aRCG3OUThPCys92r@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 10 Nov 2025 08:47:46 -0800
X-Gm-Features: AWmQ_blYPrkmtS7MiqmLPPXzGp4JyIMEirgGSbanrjWPFtKq4gAWKN2U4mpi-Qg
Message-ID: <CADUfDZocSmRC2uSiY=1gayxQ5TGAcCnKQRSg+4SeficpQ3Bfhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of
 iterating bvecs
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 4:20=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sat, Nov 08, 2025 at 04:01:00PM -0700, Caleb Sander Mateos wrote:
> > The number of bvecs can be obtained directly from struct request's
> > nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
> > instead of iterating over the bvecs an extra time.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/loop.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 13ce229d450c..8096478fad45 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, stru=
ct loop_cmd *cmd,
> >       struct request *rq =3D blk_mq_rq_from_pdu(cmd);
> >       struct bio *bio =3D rq->bio;
> >       struct file *file =3D lo->lo_backing_file;
> >       struct bio_vec tmp;
> >       unsigned int offset;
> > -     int nr_bvec =3D 0;
> > +     unsigned short nr_bvec =3D blk_rq_nr_phys_segments(rq);
> >       int ret;
> >
> > -     rq_for_each_bvec(tmp, rq, rq_iter)
> > -             nr_bvec++;
> > -
>
> The two may not be same, since one bvec can be splitted into multiple seg=
ments.

Hmm, io_buffer_register_bvec() already assumes
blk_rq_nr_phys_segments() returns the number of bvecs iterated by
rq_for_each_bvec(). I asked about this on the patch adding it, but
Keith assures me they match:
https://lore.kernel.org/io-uring/Z7TmrB4_aBnZdFbo@kbusch-mbp/.

Best,
Caleb
