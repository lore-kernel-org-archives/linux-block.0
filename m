Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26B22A4FC
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796700; cv=none; b=H9XGqEwcl0iRJeZxilk692vrBfN13OQlyo9kdhcUUCAOtLEp41mhbzdOJ0uLDBZDd/X8X0CfJzdifMJRgRnYmRCHbXiWLs1SviNSiIA7mcpORDJ4FCWdKVafy6684FXm6vW4/1wNfQggtl0BIpNredz8nMeF0yLy6+vbnDpipis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796700; c=relaxed/simple;
	bh=P/IAP9ppJ+wI+UW0/pPZVK00Gb1oA6dLumwXgWcZ47U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDtoFbVb52SwzsoR+9JXT2k5/8+pbC77GPhfC3bRMzUq3gxc2GKQM/C/wOEaL4trrrcQGCIjRk6SDjHZyYjUYcmlGU1SSlLUgtWAWRcpW0z6riOxvVA2SnFrFxuNhtCc/CXAi4EmnlW06Eu2c2nBhb9HRNI+1y7xg5Fmk0yE5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXhyy6Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXhyy6Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744796697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gskYLr/QaTBbTuNof8D0HyAgwjJAjf9jLJVV5gqwqdg=;
	b=cXhyy6GmTmAWxjbV91Y9kJdlDdxZbRXjzYLC1uRi1L/q24Mvnhk9qMtg2gk2Hn9H0z1xhB
	8BZlV7+HXZSQoOBGrTgjjv6uCOrSqz5KQRhvOyHp8Tt5NEbW6XBld4L+1P20vrWH6VACdm
	uB5aJqcXbww4cAIquQ5985TMH2nLM7o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-LlSQ8Wq9ONG6NAWFxAnrjw-1; Wed, 16 Apr 2025 05:44:56 -0400
X-MC-Unique: LlSQ8Wq9ONG6NAWFxAnrjw-1
X-Mimecast-MFC-AGG-ID: LlSQ8Wq9ONG6NAWFxAnrjw_1744796695
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54b0e3136ddso242207e87.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 02:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796694; x=1745401494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gskYLr/QaTBbTuNof8D0HyAgwjJAjf9jLJVV5gqwqdg=;
        b=pnEPNFi1LusRFhDkqeg15GXP304BCfOHGHl2TyLLAMloO+KDZzkPFFODcJ6PKSESBn
         GHf0OMq3xDReFzK44cSmGBq7HPExWT9op4ONARz3bjg/Ch7SzWGRVciwJ1DTlR9oDs82
         /K08jSGIReLZBCBlacMZNmE4vZAlcEjYZctXwB2oLH4zJCs5dGLHY9KD32naxFQcTkCJ
         TRrb8Rko8Ler03kJYoO0fz+ILRqGVOFUKveVFsvwVDfxxCN6AG3o742W83DA7iRDxAGT
         UbZWR8Dw7xaQWsqnwczCcpuJKXxwdA4kM4/iOLPcyEgeQguWAC0CiCwG6cmVh1oVSlQr
         pXxA==
X-Forwarded-Encrypted: i=1; AJvYcCW88yMWXJj48KZdxTf3meKWFNkUmJoX6N2IBVaU7o4ZkITFl0r+1RqZuOET7Mr135qCluEiwUV42R9uuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSKPDvkzw70C00iaXeykm4fdceZpR33Py/FndNjiREUNqLO4+
	u7np7XHQFQIAnN6ONeKnzTNtoCHKVv3HUa4WSgA4WvJAiHajXBR8yZtfS3yszQPAk4zkzPrMy+x
	fXHTKdvHjZhisJtGT68CjSw6VX3wAvf86yueCPGrg2EBSPkHMluNqPI/iuPKykj7VjrpTkzaI6S
	T3BdgtR9XxBw0cHPAcAFo7OWqig9IBd+55Ayc=
X-Gm-Gg: ASbGncvnDUjXfey/wsgoRWmoGK5/EMnR5rl2/53Y7M2ND1JL92vgCVpQEMnBLRPKLTi
	G40YBsbBr3TNFrJfYLhH8kH+gx+51RGRD2e8o2verYRBj/aig4gouPmNLZ4qvw6mcDsN+1g==
X-Received: by 2002:a05:6512:3d0d:b0:545:a70:74c5 with SMTP id 2adb3069b0e04-54d64bb5661mr314707e87.13.1744796694560;
        Wed, 16 Apr 2025 02:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iD3erof/D4AltR/ZJO+47LisYb8GczASHrURBKfRPlHZRbsc9oJ0j+AGICW9CuL2ndpu0r+X9rPI9KjPLks=
X-Received: by 2002:a05:6512:3d0d:b0:545:a70:74c5 with SMTP id
 2adb3069b0e04-54d64bb5661mr314699e87.13.1744796694088; Wed, 16 Apr 2025
 02:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412073202.3085138-1-yukuai1@huaweicloud.com>
 <20250412073202.3085138-4-yukuai1@huaweicloud.com> <c085664e-3a52-4a1c-b973-8d2ba6e5d509@redhat.com>
 <42cbe72e-1db5-1723-789d-a93b5dc95f8f@huaweicloud.com> <4358e07e-f78b-cd32-bbed-c597b8bb4c19@huaweicloud.com>
In-Reply-To: <4358e07e-f78b-cd32-bbed-c597b8bb4c19@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 16 Apr 2025 17:44:42 +0800
X-Gm-Features: ATxdqUGzrNLBpL-dz1zfHGEHz0hR9MOGiWoHxUZ54L4k63Bj0jKuOX2_xfQAo3o
Message-ID: <CALTww294r=ZFrmyK4=s8NMs4MZfdvZ-m6cLTQqXy+b+tW7gkBA@mail.gmail.com>
Subject: Re: [PATCH 3/4] md: fix is_mddev_idle()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:29=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/04/16 15:42, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2025/04/16 14:20, Xiao Ni =E5=86=99=E9=81=93:
> >>> +static bool is_rdev_idle(struct md_rdev *rdev, bool init)
> >>> +{
> >>> +    unsigned long last_events =3D rdev->last_events;
> >>> +
> >>> +    if (!bdev_is_partition(rdev->bdev))
> >>> +        return true;
> >>
> >>
> >> For md array, I think is_rdev_idle is not useful. Because
> >> mddev->last_events must be increased while upper ios come in and idle
> >> will be set to false. For dm array, mddev->last_events can't work. So
> >> is_rdev_idle is for dm array. If member disk is one partition,
> >> is_rdev_idle alwasy returns true, and is_mddev_idle always return
> >> true. It's a bug here. Do we need to check bdev_is_partition here?
> >
> > is_rdev_idle() is not used for current array, for example:
> >
> > sda1 is used for array md0, and user doesn't issue IO to md0, while
> > user issues IO to sda2. In this case, is_mddev_idle() still fail for
> > array md0 because is_rdev_idle() fail.

Thanks very much for the explanation. It makes sense :)

>
> Perhaps the name is_rdev_holder_idle() is better.

Your suggestion is better. And it's better to add some comments before
this function.

But how about dm-raid? Can this patch work for dm-raid?

Regards
Xiao

>
> Thanks,
> Kuai
>
> >
> > This is just inherited from the old behaviour.
> >
> > Thanks,
> > Kuai
> >
> >>
> >> Best Regards
> >>
> >> Xiao
> >
> > .
> >
>

