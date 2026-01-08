Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229ED329E7B
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854417; cv=none; b=Rr2wsnF8zwNWHng0VIOJAaidTycGsW1l3IRdAjv3V4Uc+tLadY69WVINyvVppcnQD5reA0hgwo1UOYxb+oYNWDHcDnF/Bud+wUgbVnBss3YibvdnNkc6s1ESDwYWJCfoOszd2JB/11ew90L0WRxVIR6ZJB+uL5LVWvJjpjwz2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854417; c=relaxed/simple;
	bh=EJ+H67tKI/qTqvflqqAtX9gYo+nlSZ4VQaDYOfznmK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAFZoqXFwE0T2LVN0vfexzIZacAoirQmPRK5fFROkIP9VVATwMAhsz3rUZ9fJjg3IDauwTyS6Y+McLl88PZFLLKszJzC+PuzIf8maRtmo1PmAjQRJjGpgAtCno96un9HMj0urUFbVNXNR2F8PK19o04i8ddkpiKjyvtoBSSmjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtHuTtCz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaLWTTiu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtHuTtCz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaLWTTiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767854408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8FlpwEGkeFU8Iy6w/RVyXEYLgyo3K7C8gAIqhRRnp8=;
	b=NtHuTtCz1ah7Rpou9oc2GXlWojr3BRksOaY6OdjUVnD69HBgMYv1uw+of4wHvXHPMnDVeS
	f8oq+4g0CyQVqRUeMHbBri/MsxRz6lvCDjqHzXTZyYxAa92sz1kmYjNL2m5V8WgIVWp52m
	dDeoarnPaSN+kzRQEAb9KOrIuesgfbQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-s6xKf-sEOImz9usMBjWVJw-1; Thu, 08 Jan 2026 01:40:04 -0500
X-MC-Unique: s6xKf-sEOImz9usMBjWVJw-1
X-Mimecast-MFC-AGG-ID: s6xKf-sEOImz9usMBjWVJw_1767854403
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-37fe06427afso15703201fa.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767854402; x=1768459202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8FlpwEGkeFU8Iy6w/RVyXEYLgyo3K7C8gAIqhRRnp8=;
        b=PaLWTTiu/eOQY4Fr5Keq8VdOVErxJPkqO1FNZD6kRAzzS1JVMAGmCUKOJWgxVj/LXO
         0biZxFBzbaWunOLtgmp7rJiGy2i4M3Hca+Uqbt8H7gDtFDnIFu2mUs1eJPNVhI4cUJ7x
         hkgrZx8xUnd5eaDnBypcIm1MCWBOZuT47qWkDctihbdGSZ+/MDMPUDBFIzZ7VZtxLi8s
         X2TLwZx4CV1l3D+ZCobYmII1RLHHBp7ERMp9Bp+1/jhsOU2Nkhhlwa4gxHCK68mtosru
         EDWWtNcrQfCcFEkLUJVv53+rfeTThwJVF7aXfdjg/kTpvcSFvKAqXceQH1gQVd2lH/fc
         RXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854402; x=1768459202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8FlpwEGkeFU8Iy6w/RVyXEYLgyo3K7C8gAIqhRRnp8=;
        b=VHc1NPW+BnLbZLNe6F/AfEpBBwbXnfJoM5+SYO/L4TkDsvsXKn8VCNh9r77dVPX+rL
         blMUjSV//qLQk1fY8R63GbjiKtJH4LIlpFwcxDeMVW9PYO4+vXjqipvQkj7wA66GaxVl
         XyO9cbcx7uMCDwGdT/Mk4fSExN9TBrUTHT36uznxciR9Y4KJ/gN8KvQ05rw8a9ctIsco
         FqFhrX7mzc8niZUo9j7Q12QIDW2HUi1POf2QgDQwqbTaZ1Uxq73drAWNj4E7Y+KFyk4H
         GtEIGrK+YDSz7jvaZunJ3AMvZ5h026penmua+CYX485NRMxD8IciTZUz/XGvV5goKTE+
         mk3w==
X-Gm-Message-State: AOJu0YwgSIQhehCmFnZu2/CgFmzgq/jjcAB1JfcN6O7giswrlxWMRV/h
	Uogv1X89huslCCRdCB0OYE4wjPazHT4TbgsAaItwW8nxZrkBrBbwMi4zpP1LTwvtZQgqg2CtF+J
	OYVnXhKCVCpWzI/nw9Ag4pEbaY4Ql9OGogVGNIXwtAekPw+fMxlJlH3F4cj0212y2Ubv0Rr5bgV
	Dd2OKzmW7L8x59aE+L3Szd8Ma6NQUiHcbp6QLGOp0JCCDfTEPlwzbsJYM=
X-Gm-Gg: AY/fxX6NAsuM2dCYT/T1oYWveEfrna6IEFQJB3thLRYvc4Q/K7TYAixnhUXdGb2k1/i
	D/S3Hadds5FwZYhptxrFTfyPysZAKi73DUz0CWnhOFVf469KC6w6VkKED0TUvY6ghm2LD4H/oQG
	RcWNTH7Vq0QIDa7Mpzv9gtfx7yOomk+7BMCicZIxQPJSCBk3FyLa4d3WYVhfBPbOyF4CQ=
X-Received: by 2002:a05:651c:19a4:b0:37a:2d23:9e81 with SMTP id 38308e7fff4ca-382ff6a6931mr12660981fa.16.1767854402448;
        Wed, 07 Jan 2026 22:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9rSHg+9zgRYaUicVy8a99tcznnepWS53BQ6RplNeNDC8IdND9yQ+H6m6GOyHzg15Qn+GpREkfrqjz+0G7uBQ=
X-Received: by 2002:a05:651c:19a4:b0:37a:2d23:9e81 with SMTP id
 38308e7fff4ca-382ff6a6931mr12660871fa.16.1767854401933; Wed, 07 Jan 2026
 22:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
In-Reply-To: <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 8 Jan 2026 14:39:45 +0800
X-Gm-Features: AQt7F2rQ7DC3St42s5j92iCaaVzhmPzARIBDmN4nq67AnjSQzYH9KzWE-ekkLt4
Message-ID: <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
Subject: Re: [bug report] kernel BUG at lib/list_debug.c:32! triggered by
 blktests nvme/049
To: Jens Axboe <axboe@kernel.dk>, fengnanchang@gmail.com
Cc: linux-block <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:48=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/7/26 9:39 AM, Yi Zhang wrote:
> > Hi
> > The following issue[2] was triggered by blktests nvme/059 and it's
>
> nvme/049 presumably?
>
Yes.

> > 100% reproduced with commit[1]. Please help check it and let me know
> > if you need any info/test for it.
> > Seems it's one regression, I will try to test with the latest
> > linux-block/for-next and also bisect it tomorrow.
>
> Doesn't reproduce for me on the current tree, but nothing since:
>
> > commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
> > Merge: 29cefd61e0c6 fcf463b92a08
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Tue Jan 6 05:48:07 2026 -0700
> >
> >     Merge branch 'for-7.0/blk-pvec' into for-next
>
> should have impacted that. So please do bisect.

Hi Jens
The issue seems was introduced from below commit.
and the issue cannot be reproduced after reverting this commit.

3c7d76d6128a io_uring: IOPOLL polling improvements

>
> --
> Jens Axboe
>


--=20
Best Regards,
  Yi Zhang

