Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881915A842
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312985; cv=none; b=VR5fDEnX4nsmie+4m0AIIjhV6juuYjNaE6XKoDwuKeF+E1Dev4emlCvGGM4AkQiZx25ezDkVDGlxzuGeHR/mnPR+TobmNYUqDi810PQfac2LHTzNqxnKo6Jijb0B3PqzUtax1HmrFp+I+EucaUgsN2qf5TGgH37FrwFsD317DuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312985; c=relaxed/simple;
	bh=/DgzjMSagDpsiKkAI13Vi3hCzyv2nW9w5Hb5qz4D+Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYJyhf2nwy7CLRE3aGeuYi8OT6TgBbyJr+1QIYA8+P0jzUJmhI9X9i+0eI6xV4Xh3T7wgfjPsWMJZWmZnuyaLTucP2b6/+DKL1PzH9HXzZSiFWUslQXH2mK4Y+VsgkzbluQFk4WK3AzzKOFUPbx/qCLRzfYKmkzdB3YFsDIx9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fy6bv3G2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy6bv3G2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731312982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sswn/yWFXh/I4+VJKZQA7OtGWIn3XUvK0AhEuoM2v3s=;
	b=fy6bv3G24MtSd62EhRGah4m+SsTlWH43jGcMWXRDLdYDrpCNIw0dOmAphADWaJqZHiICip
	WCPwQMVa8EUvidR7tmuiiL8Vfj9im1OlfN9shVswN/LqYCP6J6btJec8y2AG9rBcqhrfFd
	joqp9+aq4S3SQ0QfIBSpi1miwuoOJj0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-SZDEedxSPlOBxrpO-we_YQ-1; Mon, 11 Nov 2024 03:16:19 -0500
X-MC-Unique: SZDEedxSPlOBxrpO-we_YQ-1
X-Mimecast-MFC-AGG-ID: SZDEedxSPlOBxrpO-we_YQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a04210851so280155166b.2
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 00:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731312978; x=1731917778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sswn/yWFXh/I4+VJKZQA7OtGWIn3XUvK0AhEuoM2v3s=;
        b=oHiVtfMZvP2lW5AsOT/hJjiADZswydZl2jxP9wkBKDiO6GLSu+x7OIhDSPomi6G9bq
         UX17bnF3j/6SS6ZoQ/Jztp0FMn1tqPU5yZ7Svhq9pILESwNKnrJaUGpvwndfJhIJKFKF
         UDmwCKH/y9ov+t6oOKWxLnmQ4y5tYL1TT6nJbHa7kdPPibdJkRiZ9+q2ZkG48s/QEGeL
         PTaRMva5YcR5A4pvYM9gWkN1JL0FcVvjW0s3iwk1MggeF9AhiAMNKWigCOg5rs5UpTEx
         Qzd1N2EvIamsYzW1j4YaFFfOpTsQDO9nJ6QkA8+tlCSBCAmGN2e49lK1ctYHOtsKtWxG
         Owmw==
X-Gm-Message-State: AOJu0YySPRojYAuT6N1P/CpfIJ/4r4AME55rnHL175hdYp7o70GEDlfi
	W5Qg9xQB4BzJW5LcCLeoy2N0P1tsT9XlfCfdgrvXWdJlVPBzFjJkCkGtkZJHr9niaZ8zFqHbXcB
	DrroB/6s0nQqSjSyNvQXK1iaTuI1oYhXM1K53CN+vJATOl0z/EilSLPWq447f60Ms1m1Ya4Bry/
	asc2hGQkQBzfrEgqQSvJGBqnQFFpRtaRjtF9g=
X-Received: by 2002:a17:907:842:b0:a9a:1792:f24 with SMTP id a640c23a62f3a-a9eeff0eaaamr1146295366b.24.1731312978015;
        Mon, 11 Nov 2024 00:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVUiOT1WItFcquK84t0eVWA13hCGajjuhTweC1hSCd69LhRZj/ezlUq86TAsfwHnJEPo77diKMKZHFU7UiK9w=
X-Received: by 2002:a17:907:842:b0:a9a:1792:f24 with SMTP id
 a640c23a62f3a-a9eeff0eaaamr1146293366b.24.1731312977673; Mon, 11 Nov 2024
 00:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGS2=YqYbvNi6zu8e9e=R+gZMKwY_LegK2vi2MSgdsL1pMyDLA@mail.gmail.com>
 <ZzG3Qk0wvKR67CoU@fedora>
In-Reply-To: <ZzG3Qk0wvKR67CoU@fedora>
From: Guangwu Zhang <guazhang@redhat.com>
Date: Mon, 11 Nov 2024 16:16:06 +0800
Message-ID: <CAGS2=YqS=euMO5-mBU10p7pKMbRdfSGO4q-9cpg12uOm0PU7mA@mail.gmail.com>
Subject: Re: [bug report] fio failed with --fixedbufs
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, will test the patch and feedback result.

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2024=E5=B9=B411=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=80 15:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Guangwu,
>
> On Mon, Nov 11, 2024 at 03:20:22PM +0800, Guangwu Zhang wrote:
> > Hi,
> >
> > Get the fio error like below, please have a look if something wrong  he=
re,
> > can not reproduce it if remove "--fixedbufs".
> >
> > Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linu=
x-block.git
> > Commit: 51b3526f50cf5526b73d06bd44a0f5e3f936fb01
> >
>
> The issue should be fixed by the following patch:
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index e7723759cb23..401c861ebc8e 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -221,6 +221,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe)
>                 struct io_ring_ctx *ctx =3D req->ctx;
>                 struct io_rsrc_node *node;
>
> +               req->buf_index =3D READ_ONCE(sqe->buf_index);
>                 node =3D io_rsrc_node_lookup(&ctx->buf_table, req->buf_in=
dex);
>                 if (unlikely(!node))
>                         return -EFAULT;
>
>
>
> Thanks,
> Ming
>


--=20
Guangwu Zhang
Thanks

