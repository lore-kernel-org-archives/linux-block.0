Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007B168B1
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761988; cv=none; b=iqsfpuUncbaXPXJqGNUO9wgmNedhVSoBaNQA3VXtFm2nH68YOoaJ0AbZNRuzTolQ1jlgX9EAKlIolI9fo4HkW14IYCEv+z0yxxhcCGX9dy2qJrZsDsuZdeMDRZb8xPFEDsyUrRB+Tuga/ntO0QcoyAsVcSXWzRxom7eAfYCK0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761988; c=relaxed/simple;
	bh=R+evDg63IzUd5zapaBryco9bCuVG/AOU6w5P3KAG978=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkLVbYlcx/bo5HV8HDHqeBgml/Kn42vWXbG3+vuyRaxJHP/RPVZhkhCVCxLUp94CvIWenfUJLYLCTSzdCHuE6mPF8AqctOlImqcIOkRWK+moAK6DeWV6ImyuY/g/nK/GdeElNJd7FOH10yjg5Usp7AtZ2zzo/3h8GnqYwEK+9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxQjVsv3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxQjVsv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713761985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3feHkqgPPy1+RGpuKoIZf5c3ACEkn4+zXOf51zMJUpk=;
	b=QxQjVsv3TbcLYIT1VoftYFAZBn+OK7VqhIF+wPhSjPAbnrMQrYMTJkIgKJi+HwUY5L8nl+
	6rjQNZHx2sFLbXXDT5jTJFuZUWQQs1hohqxZYHOGUA8e4X1kuVJfyiVe07hTiEEZ+y21O2
	fVPkGjKsVUN+FfLe0aWbxizjnylbQM4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-H36YRleTNqWH1s5aQOMFqw-1; Mon, 22 Apr 2024 00:59:44 -0400
X-MC-Unique: H36YRleTNqWH1s5aQOMFqw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so5400516a91.2
        for <linux-block@vger.kernel.org>; Sun, 21 Apr 2024 21:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713761982; x=1714366782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3feHkqgPPy1+RGpuKoIZf5c3ACEkn4+zXOf51zMJUpk=;
        b=WC6b01QPELHJTbx+nOjIeGmXMueAGNukjroJppDvYcCf7X1hh3ahTQGqlc+acZsBHQ
         iF0Ic/NLkN4372TiLHIVTc4AydJWr1mKLX7lagRFXSv0G3tyBP+271uUNwqkDSgw8tQO
         n/CTigKaWAhw4kEJUD5a60qLW431+TnQsrMYzfvRrkzCOPM44MmUYwyc5BVnRX+TXO8C
         ftFUCZfEgJ8GqWbCLewMauIYwx3KFWvc93fGWcFcGNeAjpZ9LnoDw62jkRyjz3NkpnfR
         zuF10Bz9FNoynkD+j5RH0EfxivhJWjdjWGBp0KIfqbdtYFfM2dU3u3vPWpZO11fvNWoc
         5GnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4BZGsz26kzt75eiGDkjiCc9L8rJzw/7vey67vDROvjAWTwTncN4Uz5/J2uG92ao5OyE/k7D8+a7eyLjL8uG0cYwQZRPPFJ+EKxwU=
X-Gm-Message-State: AOJu0Yy6FvKS5lqhMSSWyqThfuPanpIfHTNhrGO5h5od+ELi8VWYKlp9
	UfFi0hVBuz4ubSUCoH8eOTyXFCixL4ilgmW7WN0LQXOBYkPEafOa41fNtC3JSQjyQOlmfZG8CVk
	t5L6fcB45S0p/iUjWZ50G1fsWosCZuRc9gzkzOdLVvuV0p0Ml31DHQ4svQKHa3288SsotbFi/3q
	UisfQMq7VDYn4DUi1wUxWvZ+7bfzgcDgJlSjI+79zzDlc=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id f9-20020a17090a638900b002aba53a6e52mr7841411pjj.37.1713761981960;
        Sun, 21 Apr 2024 21:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkCI65P6txzqz3iyqhbrRVGRMUVMFKgnJxfVOLFXvSKUenWM2+xiSOzJD+8Wc3loMYC1QTZqgf4Pk1IRrkds=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id
 f9-20020a17090a638900b002aba53a6e52mr7841400pjj.37.1713761981617; Sun, 21 Apr
 2024 21:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com> <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
In-Reply-To: <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 22 Apr 2024 12:59:29 +0800
Message-ID: <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 6:31=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
> > +linux-nvme list for awareness ...
> >
> > -ck
> >
> >
> > On 4/6/24 17:38, Yi Zhang wrote:
> >> Hello
> >>
> >> I found the kmemleak issue after blktests nvme/tcp tests on the latest
> >> linux-block/for-next, please help check it and let me know if you need
> >> any info/testing for it, thanks.
> > it will help others to specify which testcase you are using ...
> >
> >> # dmesg | grep kmemleak
> >> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
> >> /sys/kernel/debug/kmemleak)
> >>
> >> # cat kmemleak.log
> >> unreferenced object 0xffff8885a1abe740 (size 32):
> >>     comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>     hex dump (first 32 bytes):
> >>       c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ............=
.
> >>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ...............=
.
> >>     backtrace (crc 6328eade):
> >>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>       [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
> >>       [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
> >>       [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>       [<ffffffffc262a881>] 0xffffffffc262a881
> >>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> >> unreferenced object 0xffff88a8b03647c0 (size 16):
> >>     comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>     hex dump (first 16 bytes):
> >>       c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ............=
.
> >>     backtrace (crc 860ce62b):
> >>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>       [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
> >>       [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>       [<ffffffffc262a881>] 0xffffffffc262a881
> >>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>
> kmemleak suggest that the leakage is coming from lo_read_simple() Is
> this a regression that can be bisected?
>

It's not one regression issue, I tried 6.7 and it also can be reproduced.


--
Best Regards,
  Yi Zhang

