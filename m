Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E42475D0
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787383604; cv=pass; b=Wji493jOE+VPtjx9XSReLUaXnQ2HJzD2EnLWNKOjHGbmsHPQSMjbfrNQB0OuvoBZ79gB5ewW/Hjyr8MI9NjXHhAB6fU4UQEmo7Wqz/i4awOIt9qP+xkRgzAe5u1MHWAblb18vakhbPsxdFRJSBn17EZ4XGTlizotJSkeEbqRd3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787383604; c=relaxed/simple;
	bh=wNT/6EeQEZ/T+Ej5F7Q+Xyo10e08KH8wEDY4kqBY12U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PK28UMwDpl6HBmTNh6fJ/VpA/y7BIEYGUbE01A9uGu/Bt2FaMN7CrcVT+nDS8SA7X8aVeh+fN7uqgn8ER7EXWsvbRfrgB7V5GJ3Cd0o9riojuiqghrIYd8NBkiciuq1BJN/DQISMV6rczBz3N63ElbdyAwlkGaxjcJEy/9oaIXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvMM3fTn; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvMM3fTn"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1459341a34.3
        for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 00:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787383601; cv=none;
        d=google.com; s=arc-20260327;
        b=GhH20MDFCFlbRPLT5aHSR7u/PwWjD9kNLD0WbpjJkFlgGgkxt/GpiXzmwPeubz92U7
         gZJJ52mP9yJStmslgxyl52Jl0v00a375+D9FcvPEKFJ2Y6ba0+EVcQXjsq/7uSIfFw6d
         kOFOIbL0ubaxCWswCHjdg34DPVGiSmW0oymnzqhZ4ZplD2lHpSpIKogBOM46rIszjmR6
         VP2MI9Pkz2ifQyTe1cmDm0vzrbTbvnqPPCwq1UdkPP0wmV+QTh9loRrcOgYwUqaMTkUO
         Q9dN+kK3Fh/HBKYWIvf3Y6cXc1+hoksDvof63ErOxidVcIFMJs8Lx+2PkruypUSUl1so
         NY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o29DDimxbOruOorQLa62cw+/lbJ1T35yKxTaaDvPjLc=;
        fh=WTPzBDSEzYEOm5UAP3L7S/0Wew0ZJx/+aDA7L8jZEY0=;
        b=N+rMKrEWR1CzHrGesDuraZNwrnPKN9FHIVxumky6VtQglOn1+RR/t3kTz4aurErnMl
         Nyi/zEri5wBSgYn8xO2zmecJiJerOXj7DDz602o/iYR6XXF943uTDYyU9BhCm1xMDw8R
         EUyDQYkPQ/ZHdb7By4G1KFjLaz1/6tDtXPHobDeZ6m1oHSlz+2g+NZQjZ/7jejsfnmTH
         5z2GTIOHS8NXxT/XMow/RIGAFmLjQvW/Wj8QsQoXR8TfPgejltPHa+WyFXQAyLTLs181
         wkP2sle8K0O0YJN0ADFu3g5/kaaTeIVShFSA1en4nzTXT11hFwIpecANjB1mKf/QgZfs
         nsfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787383601; x=1787988401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o29DDimxbOruOorQLa62cw+/lbJ1T35yKxTaaDvPjLc=;
        b=JvMM3fTns41l5gKInT3HlUvYl9cu7ohVKMf6DAZanARRXdrLBj92Ty/XvdCgfJRF4o
         lHXjeIH81+mIqtsn0Im0gtAD4yb0I3iX25UPnhzmy0Rh6x0bdd5XC2biZ7h2nJ3wD1HJ
         1GRiaiiBDgwa7gCopBlkY1T1Doy+yWPs25n5IiI4Oe6zWhnuM9YI2FuDsePoLrc5YdeS
         vc0nq9RRlUg+pBppU/n7MJvbdyzH7fMYAdnEKUOyFo3Ohh8/U/eP2UJoSTL0lKiGUQ02
         4kJJ1TzHcY0nTP/6cstc192ZQeo8lGmfoz5wWTcRjbw2iA0tQlUfwvDQYt/aODoOOPc2
         0VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787383601; x=1787988401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o29DDimxbOruOorQLa62cw+/lbJ1T35yKxTaaDvPjLc=;
        b=Wty6hFrbc+GVx1dENNQyZ2mTiNpetlNFy0fpVP9lOr3FPw6GHOiqRjpEKIKM6WZWVg
         +t2KeO4foOM8uEko4haS3GHNwTKeKmr3CcLh0WWizrILHrVnXMq+rlzr5HZV7Wu4nqIm
         HO2SfVovzW3MmfRclcRZRa8YG7FYylSid/y8huNnEc+2DkHJRYLvuKjp1QSsMV1Th4Bn
         bZ5VvTKsdIuminYRCHEcCCH4zMQM6j6Z6xdfq9itgKZPAQQ0pJVQ+b2BOs+jsHpZ6fIU
         QAStaPhVrEDDk1yiy3Ye4SDxg5XEQqJSz+/qq7t1wBxnWJPWySabrVKQzcglv9uLiSBD
         BDNQ==
X-Gm-Message-State: AFuF++kUGG5Diw3ik4k+n8LRvjtfMq5/yw5a4JBGcyxg91KCyTjvVTVH
	9WcijoSO2RxA7oB374wUoI2JjuE8StU+IWrOikSVZdQ3J6gIzeDQhiWDwU7oFDuM17QzXDx8pKo
	3zzojy+q+Y9ODW3SQrzBTPiic575RQpg=
X-Gm-Gg: AR+sD12EOcTORsNuKMskyfP/60k6qpXexceo7CJ9WiIbD5KUowRJxyMrj3x3JtGYJzn
	NNC4apBBl4D5FVYnbYpObxYDnjjmJTJzeQc4CUnz/rsE+SLgIFKbdwBE59kbKM9Lavkr0vOKrFn
	/6lQA7jv5aSiCX9pBBl6+SaxoedO3sCta1rYUQ03ygPJG4YGrWEdAfBLc5sFKBgEMkBaKus7N7v
	6+nV5MyON4z6Y2zGYRKUzxJEOHZPm3MX4PL9PRjDlbXomiCHb9f+EHzgZor/P0PgEL1DZKqbaaW
	TDSFbxhSRpoKNK2x1nQhY7Gprv0uW1bsNOskknWDx71ditIrZviPkPO9JSYRknmi3JTcold94y0
	46d2i/OrvLKfFxsFLe6ZQs+venZIyis8SrB6y0IQwHHpy
X-Received: by 2002:a05:6820:4de8:b0:6aa:f920:6b1a with SMTP id
 006d021491bc7-6b159287077mr13866400eaf.16.1787383601634; Sat, 22 Aug 2026
 00:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <akyeX0hlcrnOC0nT@shinmob> <ama1svBbdVfyEKz1@shinmob> <aogtVw9T8D91mTdw@shinhome>
In-Reply-To: <aogtVw9T8D91mTdw@shinhome>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 22 Aug 2026 02:26:30 -0500
X-Gm-Features: AcwNN1WrPJk4dxl1BlNp-8sy2dB1wdnx7kU4IWooQvnYbaDorgXxVsfvQbWD8gE
Message-ID: <CACVXFVMWCbvZHte0MpfHo06jWKqd-nhQ91-Hf=pCxNnpxW+x+g@mail.gmail.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, John Pittman <jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 5:52=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jul 27, 2026 / 13:10, Shin'ichiro Kawasaki wrote:
> [...]
> > Bart, Ming and Keith,
> >
> >   May I ask you to create and post a patch to change the license of the=
 files
> >   you authored from GPL-2.0 to GPL-3.0+?
> >
> >   - Bart: block/029,030,031
> >     Contributors: Christoph Hellwig <hch@lst.de>
> >                 Li Zhijian <lizhijian@fujitsu.com>
> >                 Akinobu Mita <akinobu.mita@gmail.com>
> >                 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >   - Ming: block/040
> >   - Keith: block/042,043, src/dio-offsets.c
> >     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >                 John Pittman <jpittman@redhat.com>
> >                 Bart Van Assche <bvanassche@acm.org>
> >
> >   If you are too busy, please let me know. I can create the patch on yo=
ur
> >   behalf, but since this is a license change, it's better if you author=
 it
> >   yourselves.
>
> I rethought and decided to take my liberty to create the patches for the
> relicensing on behalf of the authors. I will send out the patches soon.
>
> Authors, and contributors,
>
> May I ask your responses to the patches with you Acked-by tags?
> Thanks in advance.

Acked-by: Ming Lei <tom.leiming@gmail.com>


thanks,
Ming Lei
