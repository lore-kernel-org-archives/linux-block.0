Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE1D63D2
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885780; cv=none; b=CnpggHPvGx681HisTwGsnjH6YmGj4mCNqSti1uHQq+q9+9IY0n1v20stYgdyXV8k5pkFp+CRH5Z1Zs/1QHtL5iWNBDnbTbZ7Yf1xyWau7n6z2qXZRSUZmks1MMmNU58pCJX5k5hdWYZOTPmSlff+jeZdeUv3S0KNc11N2sz6Izc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885780; c=relaxed/simple;
	bh=pAWsZFGR7vRBs+tUqRgY1CcKLBgrZYN59VI9W1bGOFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYKqs9vsmlseFNfeSTjgig9CeA3htCtFfneQL2KW4kA01fITr8S5qcSaozRsADj3z9OqULQOFGjKrBNp6V6fB4wiiG+MPfvlXupWH0FGxR94BJFQERYaBW+X3M0bdaNYk51/7LKkm2C5hCdNbSj31VGrv/OwbmLnqo73pAyg4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7eVPUk8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7eVPUk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RJubEVF3mvzPrwjIuVHDasSpsNtDJhejFOGO49WUPA=;
	b=e7eVPUk86oVkNh+R16LWe+wiLKYe+zR0RRObgIcQHYjgt7aahW5A/AMkccMr05JUdnorKS
	Bxt5OyfzmtIJhP4dYALKeecodwouWufyJK6v4tCRTlZeYlOnjwXasZt+ULFMpjouhpJdRh
	QH/hX9M9TdwBueaIeFpQ0VVsKq/Fdbs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-pNZ2A1kMOfSKax7u3wDuLg-1; Wed, 06 Nov 2024 04:36:16 -0500
X-MC-Unique: pNZ2A1kMOfSKax7u3wDuLg-1
X-Mimecast-MFC-AGG-ID: pNZ2A1kMOfSKax7u3wDuLg
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fc969f6e27so31319551fa.3
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 01:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885775; x=1731490575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RJubEVF3mvzPrwjIuVHDasSpsNtDJhejFOGO49WUPA=;
        b=adpzE+1MoG0WeZfiY2U0rnNWqqU2GSsZl+P9zAFOZDqB+F0umWvTwWs3B8i2rPuYGZ
         9tZXxS1V48mjeVscfSf5T3M2uLvh7QKuFup32CCnH6JRfe2MIiLfW/cOJuazcD7Pbj+s
         gfjgapNnfkMHZM53RsBEd3Lp5Mp8I949I2zHIsh9at52jRboq0exeduQW67YCvheo85z
         EI1Epa1QD8BJqcOsyvJGAd/IIxV7qjx253m6v5ex0v1/YHpbSJ25noEv409lTDPkVwwx
         a0jBpdQcno54lxbtSJMmEVA3eNFKM0NiOLas4E8tX6msNro4hgBgoNwU9n/gDTqHNQGC
         liRA==
X-Gm-Message-State: AOJu0YyAxWCkab2A0GW5DPwGgCzHQG7twTshkNT1dpuvPlsI9dosS/nc
	rWmlacyFQmS23IZMl952q91FyJMjEWYxOiVtxSgUMALUxhoQsgDOPpt74B68YxbsazwW3J5VG/O
	k2+55plEgjQSCTLRUVa9rZZ8nOQclwqnLb9nt/3Y92lj2EDnSkmxeCGqhKcosLLpMM6Ee1DRdKx
	1leJuA540ztQ5cfQQN6EUNFj4XWgFQqJLf2qo=
X-Received: by 2002:a2e:a99e:0:b0:2fb:5a7e:504c with SMTP id 38308e7fff4ca-2fcbdfae76bmr201954851fa.13.1730885774854;
        Wed, 06 Nov 2024 01:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFkUXf1c0q1tYT6tGNkKpr6tyalOiSFB66rWomJUX6Z243+g0yItOwmfq/5SyzoRa4izFMf5x1gbO2hvSVEwo=
X-Received: by 2002:a2e:a99e:0:b0:2fb:5a7e:504c with SMTP id
 38308e7fff4ca-2fcbdfae76bmr201954771fa.13.1730885774382; Wed, 06 Nov 2024
 01:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-61uwDYDdMduh+UNp5er9x3=1snH6j78JGP7uWF2V5YA@mail.gmail.com>
 <CAFj5m9LZbNasB3+Ma1FzrLCFc-7C5mC3AREipvuXMnB+QLP7_w@mail.gmail.com>
In-Reply-To: <CAFj5m9LZbNasB3+Ma1FzrLCFc-7C5mC3AREipvuXMnB+QLP7_w@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Nov 2024 17:36:02 +0800
Message-ID: <CAHj4cs_d7EKUpAWUyv9fmdbcemCWg5_YR5iwEO_8ovjbXUQ6-Q@mail.gmail.com>
Subject: Re: [bug report] possible circular locking dependency detected with
 blktests block/002
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, Nov 6, 2024 at 4:29=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wro=
te:
> >
> > Hello
> > I found this circular locking with blktests block/002 on the latest
> > linux-block/for-next, please help check it, thanks.
>
> It should be fixed by the following patchset:
>

Verified the issue was fixed by the patch, thanks.

>  [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
>
> https://lore.kernel.org/linux-block/Zyq3N8VrrUcxoxrR@fedora/T/#t
>
> Thanks,
>


--=20
Best Regards,
  Yi Zhang

