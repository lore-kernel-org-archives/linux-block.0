Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BC33F361
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370310; cv=none; b=qzF4MC/W0f7jFYFKO1KQ0n7erSH2yX7y20PCYR9Ex1/TQIM/n5BW3cld8CVEsxz8fVAyYW7ir4KKFxt3wl01F/M+Hwkmcxd+j+OnYR8fBuPmZwNO1llPKaC/n9nSeNeYQl6kOziT9TuGiy+BRVTQbKBqcEyC5EOFEkvv/ZuhWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370310; c=relaxed/simple;
	bh=EQTTq3C3PpEZeZ9P6KqubrAmcSy2Zb9VRqOdtwwSBkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnZSVJa3No1lWfKR2kuS/gs8XhDbr/KLamh1OjwWqYerqzB5dUQzhC8DCruhLcdUUytsZ3oPGrWIIN/9G5rAD5wOyjGPzQe2i5W/7JDI3ys8BWmKh+cwnSz5NubuQg1ehr8N8yN7yrC9HXuXL5t/hNv5ZHuthyHJL3V373bv5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzxmZTPY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/XeOQP1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzxmZTPY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/XeOQP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768370299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etTeQSsRKnzSeWJ4DkOitPwqySAd6KzRagi4OvsHXbQ=;
	b=GzxmZTPYYKm3bPZ3tULaH2x6FQbz150TRzRdstMnc2u+ADY2llWnEWdAjtEMDSrOiHzvNT
	C/9Ig9qW+01h6GfoqqdyVDN7lvwzYWHlzu9lMYKqlXR1vR6CcoqCAd8EwwLLer4EHMr6+I
	er7RZi2eIjp96MOHMxazKnG9NWGzzGM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-lIrhBVTtMYGWOaZDftmc5w-1; Wed, 14 Jan 2026 00:58:18 -0500
X-MC-Unique: lIrhBVTtMYGWOaZDftmc5w-1
X-Mimecast-MFC-AGG-ID: lIrhBVTtMYGWOaZDftmc5w_1768370297
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59b6f3890e4so6521408e87.3
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 21:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768370296; x=1768975096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etTeQSsRKnzSeWJ4DkOitPwqySAd6KzRagi4OvsHXbQ=;
        b=I/XeOQP1pdzM88Tx9+xZcfsf4B9EMRDPdV9qRaUi2nIMLEJSI48hDtW90OPbHUdMCN
         z/2501W94BKVPbvNz1RAtDisxONkPKozEzMegA4M9EOXUVt5t4v9ED41vTu/R4jWRAqf
         XaPy68INbPwkhMlskglgz0CCk/tb7uKNiAJyNG7/jhHPnCR6wGSdGFFSgCaTEzMUNHO2
         oATk4RrPUih4sbVNrhjfy67fdIXDxYjrqKmqJWcKH8rozn9mE2E2io2aLIqPaJQkTXTa
         QHiPiWAufZWw6L4L71qtdNwyaEdgMdmZzeQOxJ2wnw4DRAF/2QMu+xT1WDi6eCUWEwzK
         zJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768370296; x=1768975096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etTeQSsRKnzSeWJ4DkOitPwqySAd6KzRagi4OvsHXbQ=;
        b=RhRZDqXjxZRWvDdtlELw+PEJeBscpzJsVHHPmzqe3ZkknEPLuwopkRQIQRbUnEL8I2
         1FiVY96XrqmTH+AznQasNkbF0q8y/Zg3lCZl6urhaBDEbQuAH1lc6qgGxZBagjc6VgSv
         ZYSIRtUxPlQyofe6lKo2PTCFV9p7Oc1A/4I/8DBpRemaFMyDyjpjoeU2OHFh04yHK5w+
         wV1xyrD5dM5WL9WLytQFAMtShgSD3glL4EXG4oEnnDaFBsecrg32FjQqYfyr7P1YDfTu
         IfXWUp/9E2gblEAPyHukgLuGfc/TRN9rhO35s/qgFjLCQVeUq1eRSJolzDomaeDnFbD6
         JegQ==
X-Gm-Message-State: AOJu0YxhUmzAlEDVnFPLHDo74aNfGX0EbNnYFrK1MdavSTYsFGONhyVZ
	hH/NhQJBERxFPM27TvVNvnkhOuURVczX/wP5vTo+samGUnHSEDn2TZANdJst60BkK6WkjGmOpZ+
	MZPxxYnqGbqALMHOD2vTraARFuQBTPhAHuyYjCVKcLxio8f5mz2jo9zhg3S9VxprZ+S9a4JuViN
	NdvxlYRldNdqHkCzBjPrx6gQAdSsUIJXhH0oqiZ7FPK5eU7UCW8fKo
X-Gm-Gg: AY/fxX69xOBr+xAKdP3/R6ZPBJ8Ffz6honrwpX6WL9aGgZWLGcnJWwwy+cew6yXqV/n
	qbSZuDeY/ouEk98FYCcXGFywLdCTGGLmgh0CS3dGEk+fSvSeU96fftNsI0UOPNbqiTUXrU99ZCk
	LgZtwnxOWj4MNiYBMyQm/SlSK4miumn/E1rB67jL7dlLCkvMF9Nps+ymumg2qrkcLyUQM=
X-Received: by 2002:a05:6512:61b1:b0:59b:9a9d:dc94 with SMTP id 2adb3069b0e04-59ba0f6517cmr417929e87.13.1768370296521;
        Tue, 13 Jan 2026 21:58:16 -0800 (PST)
X-Received: by 2002:a05:6512:61b1:b0:59b:9a9d:dc94 with SMTP id
 2adb3069b0e04-59ba0f6517cmr417921e87.13.1768370296045; Tue, 13 Jan 2026
 21:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk> <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
In-Reply-To: <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 14 Jan 2026 13:58:03 +0800
X-Gm-Features: AZwV_QjPoMkPEHaT9pV2ou9ANFJz4fdy1W_ExdZWa8tT7f7iRN8zml_kR8bvEYQ
Message-ID: <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
To: Jens Axboe <axboe@kernel.dk>, fengnanchang@gmail.com
Cc: linux-block <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:39=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> On Thu, Jan 8, 2026 at 12:48=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrot=
e:
> >
> > On 1/7/26 9:39 AM, Yi Zhang wrote:
> > > Hi
> > > The following issue[2] was triggered by blktests nvme/059 and it's
> >
> > nvme/049 presumably?
> >
> Yes.
>
> > > 100% reproduced with commit[1]. Please help check it and let me know
> > > if you need any info/test for it.
> > > Seems it's one regression, I will try to test with the latest
> > > linux-block/for-next and also bisect it tomorrow.
> >
> > Doesn't reproduce for me on the current tree, but nothing since:
> >
> > > commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
> > > Merge: 29cefd61e0c6 fcf463b92a08
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Tue Jan 6 05:48:07 2026 -0700
> > >
> > >     Merge branch 'for-7.0/blk-pvec' into for-next
> >
> > should have impacted that. So please do bisect.
>
> Hi Jens
> The issue seems was introduced from below commit.
> and the issue cannot be reproduced after reverting this commit.

The issue still can be reproduced on the latest linux-block/for-next

>
> 3c7d76d6128a io_uring: IOPOLL polling improvements
>
> >
> > --
> > Jens Axboe
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

