Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AD215713
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708263; cv=none; b=idL6kJntzjBCFl4h+otUX+jTOndqcQpCcrD/BnLOnNKwlN8TJwMfkvtlZJIyONfpVGgO/g/mdXo+kgn9JF4h3eG37VeD17B13oQRXb6epOmjL0SYwJZQ6nOOsBLE5iv6/h8ZUQQ9G9JhHCu6bg9PkpwmhyO3kFwaDT0CLddHw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708263; c=relaxed/simple;
	bh=qWEPipjVajktW8r42Yo8bmmUDElUtxU49YAxDG4mDAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f10H1J3s8zrP813Co+SZfE1AcMjZaR4U/22hvZS7AK3d7c77+SfmO3npBu+QPRdtXGh5rB11STQ7cZ78/KQdqCr/4BNLI4t6RBaFY6KySxK15uCVuNwd7FLJum66kF9TfJU6gnmlI5W73tuA1EIly4/W1mxS1EbyzWKQhgRLk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyJAR1iU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyJAR1iU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734708260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWEPipjVajktW8r42Yo8bmmUDElUtxU49YAxDG4mDAA=;
	b=dyJAR1iU7LHIj/R5KxtXRyqBeugZ0Dw1UAGSDIrx9L0HQXJ7wxfqTUViBZOflU0dCsRNTh
	3lY5qqN6f5+xiA/VfmYWxiA2fBOdEDpz7q0BWqIoDcTYwXTGwOS2mQhkyZLT0k78owwzHE
	UCabdxmqqwwFefWODBeDXapoY7ehU/E=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-fxw3i88LPjyJJLOGH3iq0w-1; Fri, 20 Dec 2024 10:24:19 -0500
X-MC-Unique: fxw3i88LPjyJJLOGH3iq0w-1
X-Mimecast-MFC-AGG-ID: fxw3i88LPjyJJLOGH3iq0w
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-516142d6740so409495e0c.2
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 07:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708258; x=1735313058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWEPipjVajktW8r42Yo8bmmUDElUtxU49YAxDG4mDAA=;
        b=bDUfftXInrvag6qekbZLrPa887L5oAQEDvxHI/8AjfFn0t5IQumpZapzAx7aII+taz
         4JMRnygrsyDTLMiHjgkI5QNVPNolxXdL1xMyZdfl3hlaiTEYngLOvtmVeSCRNZn6fPAt
         c1k+TY9Wz+gY+ljFdKu/zwEnC/Ua3V9jkHYICjY/7BmadtTJxp8tAKv7JaWlDlmKPlJQ
         FFpoInvAwFY5yI20jcxouJ+s+PZ/tfIKpWCTFmN/xKupbE6xwd0BIlYwAylS/8YajstC
         nItZoNAcJ/gjK7f84sGcYlWJbyGlVCtLJOJzfpWH1tGOVQKvwr2oNNjU1Eh13ViYrLUv
         dbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoJ22ciMPQRtcJT+d3OkkslppoyjKDNcaMatFnTJhKuCSrOlGQWm+chA/lLWVVrq2bryiuefoiD0fD8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjvskF2SOHNcuB8oBuzYxCN9fANOfvsLtJnGQtyou5+NT2VJe
	H0kP8/K3SQ0PlbIfv0w0PSlBhISy7M/Kd39Af8txNEPRAuay2B7kWrKn6uqJ18pPM3nEfqn916Y
	dvR+CBFK55hbmncgrWnO5zxjt7D9L1O7L/HKk0Od6nYB98/M3oZ8PUBhdZHMdyJYPd7pPY0de1o
	QUFlzDqRXHuKDRCVDnZCsWrHOhEM1QNOk5Yf8OFOc+bVyTuw==
X-Gm-Gg: ASbGnct3uwL8l0XFk0xNWWmgbJedHRCeUvz7s5Msnx7Zkm8Xs/J5RlLWeYM7nep0kKm
	F691laKKgPKt0Exmd4Sc5AepNbPDs6vQpq4M/wlE=
X-Received: by 2002:a05:6122:6607:b0:517:83d1:d438 with SMTP id 71dfb90a1353d-51b75c2df66mr3641153e0c.3.1734708258685;
        Fri, 20 Dec 2024 07:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0JAGdgP8Nt2auEUMKcrqk7v0MZV7Cb32v0uXfkyFR+XwnDEay7sYh6RSufa5AcEgDZA+4xr2rvW87whNkEBk=
X-Received: by 2002:a05:6122:6607:b0:517:83d1:d438 with SMTP id
 71dfb90a1353d-51b75c2df66mr3641121e0c.3.1734708258465; Fri, 20 Dec 2024
 07:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218101617.3275704-1-ming.lei@redhat.com> <20241218101617.3275704-2-ming.lei@redhat.com>
 <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com> <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
In-Reply-To: <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 20 Dec 2024 23:24:07 +0800
Message-ID: <CAFj5m9JKrNm75DzJGFaDDZp4Owq79EBnH5cXFETiz5pRKoGxBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: Revert "block: Fix potential deadlock while
 freezing queue and acquiring sysfs_lock"
To: Jens Axboe <axboe@kernel.dk>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 11:10=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 12/20/24 3:23 AM, Nilay Shroff wrote:
> > On 12/18/24 15:46, Ming Lei wrote:
> >> This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.
> >>
> >> Commit be26ba96421a ("block: Fix potential deadlock while freezing que=
ue and
> >> acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: m=
ove cpuhp
> >> callback registering out of q->sysfs_lock"), and causes the original r=
esctrl
> >> lockdep warning.
> >>
> >> So revert it and we need to fix the issue in another way.
> >>
> > Hi Ming,
> >
> > Can we wait here for some more time before we revert this as this is
> > currently being discussed[1] and we don't know yet how we may fix it?
> >
> > [1]https://lore.kernel.org/all/20241219061514.GA19575@lst.de/
>
> It's already queued up and will go out today. Doesn't exclude people
> working on solving this for real.

IMO, it is correct to cut the dependency between q->sysfs_lock and
global cpu hotplug lock, otherwise more subsystems can be involved,
so let's revert it first.

Christoph is also working on q->sysfs_lock warning, and we can try to
figure out other solutions given the involved(or most of) locks should be
from block layer internal.

https://lore.kernel.org/linux-block/20241219061514.GA19575@lst.de/

Thanks,
Ming

