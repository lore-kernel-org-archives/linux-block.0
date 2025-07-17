Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3135957
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752724705; cv=none; b=C12cWK9rWn/XhOiHl6wrPiy5cINcp4LY1Qsq8IzXinTKHq5FNkfWT1GcV7UTUCY5Ma0e2kdIA26yL8vbQ1fQ5tC+IknHPCItywL2054U59EED5vRZFdV60FPOC+WenwzUM/ByALgrW3OGoi6S7r0dfEwc8NSFO8+95Hp6/pJ9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752724705; c=relaxed/simple;
	bh=0ODvEofNjPirXpJpFbS2kphc81tnwsOiFi1FIKBBlSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVhFTMzz6InLOLQbw+O8oDcdjTprvZxEktKmvBKfwo9s9dblHBFh31TRI4voNaRxw7sbqapxgMZPcMV/xgyPktfMC+jQOW7iTCHFetIavIsdqCAE9rzGTjf9aCzYHgvY0PGFaNaLqiByZCVyErip4+Yg0FyrJ42OVqbMuaYS3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajMAnErr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajMAnErr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752724701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlcNNXIFdnY8n3UgCuqpxJFMgvzEKuIVDj9JI53FejY=;
	b=ajMAnErrC+0UvlK+OdpgwG933tAof2bDVp8iZ1Y+U4AhfKAaHSeSxEXwsGOqNxIfasn/PI
	aam25ioFVp7BvpOQLvAlcNsIp9C2J4jctHQwJcyinPd4uJJ1pgSo4bsQJ0ldE4f2n9D8b9
	p1ggvHfJLlPrehevyFbnX67cloKz9Yc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-F4poRNVwMvC-RMk8obmuxw-1; Wed, 16 Jul 2025 23:58:19 -0400
X-MC-Unique: F4poRNVwMvC-RMk8obmuxw-1
X-Mimecast-MFC-AGG-ID: F4poRNVwMvC-RMk8obmuxw_1752724698
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32b49f95c5eso1662741fa.0
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 20:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752724697; x=1753329497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlcNNXIFdnY8n3UgCuqpxJFMgvzEKuIVDj9JI53FejY=;
        b=JPIwytceOsihkg7CwbgSt7T7EwkwmA/H3Hp3JFWcm1pPCx1zpf5EjTpaI5xOox+rQ9
         /JDIoT0O3UZxUMRAK+PPnN0t4pLm/ShRFfY28LZLNzX9PfA/ZV+bdR1FyfUvTFx1br89
         FUwqA2UXeIgqgkfEAlKhW9swK4OO1jt8f4E5ubIgRB/loJWbf/g2NtfkH3rkfj7dK6x5
         d6V1N5jDFR56tAPZWz9BryIPr4VwdKQZpEp9xD287Ev7NuIfGjrWhbL+r5OMSF8iKjMK
         +CfqqoBcOP60SKP8gRYgP3WFci6r+aelhpg2m52qAU7ubSYv7Ki0bc9LoQhItGKsR3sy
         yslQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdgqwTXj64LD9EhOxwjNfw7jph0K54GBnEm1b9RssbKLA6SPVnYoyY9A8ob4wcjnHbGQKx1WdZORWvoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziIBY2qDEcpX3VcM0pXzzZCoWTXfbBI969MZuBsi6rKbQRCS3A
	xYFaGhVzhOQvwdR108enrYHSAV7mDe9FIDIltLuJwE9Pz9Wf7xn7VJV3+mQKMltiw5jaDcYkCT9
	8R+mPmS4AxrDrCT/+59Kh36piUaAmY1+x9XnQ/Y+Wuf2VBt9poiRycG2WNY19/j/KM8Ej9eDn64
	/WnuSQu/YVXUtdKqmMpx2NUCW2bkhSnBJJU4Jwx6w=
X-Gm-Gg: ASbGncuymZMAgl4Qr9WISPYmlfR1A3gB6o29NGqIO+T27YnBc0Il/TuJxHhfoy78Bur
	zDvkXEfrzqQpBtoKhP3QLZe1g9F+nvGx7eMi/kAP5R2fNLlPayBqk8nvtLt2LC2obSoTJw8AxZT
	b5YZF+Sodx4VkyCh7YviTlnA==
X-Received: by 2002:a2e:bc1c:0:b0:32b:541c:eae1 with SMTP id 38308e7fff4ca-3308e546e8cmr18844471fa.25.1752724697239;
        Wed, 16 Jul 2025 20:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3ssgDpHW5bRgIDb5obl6eTeH2PaNVb2gkH7f8pCKBavmMVSAJQ7SNrQCGnQ2byUDoCC/XUvloRs07S/p0pZo=
X-Received: by 2002:a2e:bc1c:0:b0:32b:541c:eae1 with SMTP id
 38308e7fff4ca-3308e546e8cmr18844381fa.25.1752724696785; Wed, 16 Jul 2025
 20:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk> <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
In-Reply-To: <aHeBiu9pHZwO95vW@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Jul 2025 11:58:04 +0800
X-Gm-Features: Ac12FXySRXb__GC6TCLHclXiXLR6xH7lnMepCirqSaYrmpVBwOhSYyVZ0FzYylQ
Message-ID: <CAHj4cs9bMqEKMBpdr6FvyNw1DBLevYgmygDZURVOn58Y_DLaCg@mail.gmail.com>
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>, 
	Nilay Shroff <nilay@linux.ibm.com>, linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:40=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2025/07/16 9:54, Jens Axboe =E5=86=99=E9=81=93:
> > > unreferenced object 0xffff8882e7fbb000 (size 2048):
> > >    comm "check", pid 10460, jiffies 4324980514
> > >    hex dump (first 32 bytes):
> > >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ...............=
.
> > >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ...............=
.
> > >    backtrace (crc c47e6a37):
> > >      __kvmalloc_node_noprof+0x55d/0x7a0
> > >      sbitmap_init_node+0x15a/0x6a0
> > >      kyber_init_hctx+0x316/0xb90
> > >      blk_mq_init_sched+0x416/0x580
> > >      elevator_switch+0x18b/0x630
> > >      elv_update_nr_hw_queues+0x219/0x2c0
> > >      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
> > >      blk_mq_update_nr_hw_queues+0x3a/0x60
> > >      find_fallback+0x510/0x540 [nbd]
> >
> > This is werid, and I check the code that it's impossible
> > blk_mq_update_nr_hw_queues() can be called from find_fallback().
>
> Yes.
>
> > Does kmemleak show wrong backtrace?
>

I think so, the kmemleak was observed when I was running all the
blktests which include the nbd test, that's why the backtrace have the
nbd info.
If I only run the test block/040, when the kmemleak occurred, the back
trace doesn't have the nbd info now.

> I tried to run blktests block/005 over nbd, but can't reproduce this
> kmemleak report after setting up the detector.
>
> Yi, can you share your reproducer?
>
>
> Thanks
> Ming
>


--=20
Best Regards,
  Yi Zhang

