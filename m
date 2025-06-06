Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B36487BE
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219943; cv=none; b=gbihscw+vA8icGU67NvIlAS6cHOCs56h5zDgDTsYRnI67nMBeSw4x2qjpGRcsuzAB9y0ebdmGvHCaAYDq4QBJMO4MuXTCUzoAl36pE1d7js/ykVw19QmR7Uwq9Ef4iKV1iYz6Q9pb3ryAaWBSdWJVUwVFcWYquyuM394l02JOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219943; c=relaxed/simple;
	bh=3qDXXSo9V97Ln9bq/SaJnvqAfowOQYvP+bIcxRBosxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOhuzlwbBfoaF6UhSUDuqNrvmz91Febg1ut2xmooehX2oYKF13j8V3cpE6dHOnctS2w8p0svQRvW4lla0JRmBoEeTliZXaLw58GzZpzJDdPSxe6e44ExmR+UIXqE4M4vhlgN25Lagty4ps1TxO+Adq5817AcH1luMYw6hytVAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EroYOhtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EroYOhtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749219941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
	b=EroYOhtLQ581wz0nBQY+GBav5DYHmif7L88xoTL99V1qs7fJPZgedNUQrseMWZOkXslVaM
	mDp3/kiRG+zZKrTO4A3xZQo0riVfHxan0k3RTVuPDzJ+9yDUEFVFA2Poh4Z35aV1Wuplob
	eV78Jzdf7Kw7q2nOaL0qGinGTjvdxL0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-qQLwxJQAOIK5SseUZQrXFw-1; Fri, 06 Jun 2025 10:25:39 -0400
X-MC-Unique: qQLwxJQAOIK5SseUZQrXFw-1
X-Mimecast-MFC-AGG-ID: qQLwxJQAOIK5SseUZQrXFw_1749219938
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a6e117b55so14480231fa.1
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 07:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219938; x=1749824738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
        b=oI5oa8ceUc3CQ4V4d/RjwvdAHm7A7DfudHL6lIyw9aHgnTPXTrek1rikUeCARlbqWU
         BSHUSffl4ANud/5cqEzfulgVHKR1LeATegfTSEHefW8L9nx69FYoGmyEq858CI7yVgUk
         wbuVDXsdkwg+5o6b6vk0szJoMtAynV46JiX4fP/1IBHB7Uy+10JMs/T7/dfo/rau8cQ4
         VrOFf3xwrwTdwsHy56rrdbeptn8ZTpYnCpAVUygNHS9rFM/6rwtHQCG/W5atLEZX3drR
         rR2S48hTAOWhalZn5FSqAmMUxzHJJE0bjjJHI0uYpsrt3yEYo55kbHwU2vULfJhKEitD
         KoqA==
X-Gm-Message-State: AOJu0YxeEWZxgxtEPYEBK/VapqVXltIeaWTW2bx5gK8UEWZs+xPa4kz/
	+XF5ynPUTPVG0NTTIIZWEXzWaN28CxIqMiNSn1x5nAL0MD7WJWnG5yRbcs7UOmWwWWHY6/4fpto
	io6+3KUrRUXAr+g6DLYm7A2jSV83lScIGFG0MUmnN02fPWFO/gthdb5HnOZpAiyVlLvShvQLf9z
	aFmnOHbAloepBF3GDoxL5rWGjEd2Zekl0XnesGqzE=
X-Gm-Gg: ASbGncsQRnjeXt/riYWsY5ymJrPtwG7g7dUGsI4kJkshoxRr4ULcZ/bh+QFKmI7jMoU
	DxFLwsL8fykY1XbyZRlVYT10gOPPFXDB0At4us6PrwgscqE7h4RyX0FAw29TPwU0DNJQKHKKCli
	dCTdC5
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id 38308e7fff4ca-32aec98e7b9mr2665401fa.15.1749219938106;
        Fri, 06 Jun 2025 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXglcxl80BE482xq4dx91qTebsclNfPlMg1sw20ymT3/ZEh0z8jxknKBzXzbqnEY78ZQMjNrsOPiXqzhYfTLw=
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id
 38308e7fff4ca-32aec98e7b9mr2665271fa.15.1749219937714; Fri, 06 Jun 2025
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local> <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
In-Reply-To: <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 6 Jun 2025 22:25:25 +0800
X-Gm-Features: AX0GCFuL4XNUJVJ0lfr1A30P6N_O92q6LMT8TriVlRQc68jUCEDZAsCtx8zBrpc
Message-ID: <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
Subject: Re: blktests failures with v6.15 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Tomas Bzatek <tbzatek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:55=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> To+: Yi,
>
> On Jun 05, 2025 / 15:02, Daniel Wagner wrote:
> > Hi,
>
> Hi Daniel, thank you for the fix actions!
>
> >
> > On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> > > #1: nvme/023
> > >
> > >     When libnvme has version 1.13 or later and built with liburing, n=
vme-cli
> > >     command "nvme smart-log" command fails for namespace block device=
s. This
> > >     makes the test case nvme/032 fail [2]. Fix in libnvme is expected=
.
> > >
> > >     [2]
> > >     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323=
f5d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee
> >
> > Should be fixed now. If you want, I can do another release soon, so the
> > fix get packaged up by the distros.
>
> As of today, CKI project keeps on reporting the failure:
>
>   https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aar=
ch64-kernel_upt_7
>
> Yi, do you think the new libnvme release will help to silence the failure

I've created one CKI issue to track the nvme/023 failure, so the
failure will be waived in the future test.

> reports? I'm guessing the release will help RedHat to pick up and apply t=
o CKI

Yes, if we have the new release for libnvme, our Fedora libnvme
maintainer can build the new one for Fedora. I also created the Fedora
issue to track it on libnvme side.

https://bugzilla.redhat.com/show_bug.cgi?id=3D2370805

> blktests runs.
>


--
Best Regards,
  Yi Zhang

