Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611DB33D6CC
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884023; cv=none; b=Lx9x6sX+awzXH5O/T6HvSL9mpYBIeAxFnebk2pcKOgT5iziG3GuLAxJit3PTW7H+VyjqnNX7d2Qz3J/fuMLz06DSJ1qE5E19EsWfAvn3XvAv0iHu2G7KE0+stTwOtpgxL++cu0QMErMm8eIk2VG7sqnJoStl0NvSW0LUiI6n8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884023; c=relaxed/simple;
	bh=Ir34V/AA4/Kn53Xt2wU7m430i1aPoGLugyeX+Sg5NA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVIsSMeHKAc4HPjl9SFXsHo4QImpDbkS+8R7WaCVRyjFayIeMIrZX9pW3ZrYAAWn/SrQLp0KPkyGSEzp5ChGfg6Rr4y5CjF/TO8LuYMi5bhb9RGu7bMrvsvVfqXeJJECzZ2JmWnGwSxJiT8ewPGDeo8Cj/pfSZ1QI6MYhZw1tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/SUlIF3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdQ/gxxi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/SUlIF3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdQ/gxxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765884020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
	b=Y/SUlIF3xZtgfWnV+nd8PsBUXGzc1qvXwum9v4WxfmIlMV6UZyruB3Jcsx7u5ywHzRQfdl
	QL7sSlkJyF8GXpTYdTUhNLESg48fX5j9qmbUOAOd7UOHEn4waj4tWICfTonDme9RlYjPQN
	wEucxWW393E3DnzU4KBzthBrIJ1SPms=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hMBHyD8hO3eiCF37ewNLBw-1; Tue, 16 Dec 2025 06:20:19 -0500
X-MC-Unique: hMBHyD8hO3eiCF37ewNLBw-1
X-Mimecast-MFC-AGG-ID: hMBHyD8hO3eiCF37ewNLBw_1765884018
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78e668d6eecso36966687b3.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765884018; x=1766488818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
        b=DdQ/gxxiM4Q4+mxpMmDf0BNn0HUobvKwTPeLKuTLP3nIL2dVN9LPiwN9cttrOvM98R
         8FuQ/TEdOXvM866VsORzsMktkaFzRgijcmY+6fgUZscV8t/+E7+2D3j9s4K8JXdUI8tB
         rWc3opUwh659zS+Tmzld3uOYxsSFnoEvFXdurSYoJIhGNM66WRphPfHeee1Vm5xyGi+J
         lUt3gsO34maU2lsY+khRBqyljf82AsQMgLa4MjGQD9pUoQSlCyAtqTDHRqS6YM3ry++v
         ELq0i8kb7e69vPyMnWCzwjZa+SqIVuCrR+LV2KOuwIaP2n+dT3RGdv2SzXcQklQMNBTh
         msMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884018; x=1766488818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
        b=AW4Ma6vy6Fx8SoPwxRmZYOqPLCNBpV51qfSJcbNZnTBu5SPjhSnvInGC2315/EjNEs
         fgY8olG29LivscUW8eQLUTnmKPcDDJxIZERyimViBY86Djhsdm74k9EdjyoklBSeRWkP
         VnDSnOJ/j3bPCYiapTO1YkMyJI2A/OBIqL4k977wRs9spxk7sIlrQ23/CvJopdaiVtQQ
         wtd66op7zcuRkjNn4v1+VoaTNUlLJv+wH3JtAvHzZFji6caqkySfYoH6ID5TtULXA7Zn
         or7QdpXFyFxcYkwL+8p5d4g6jwETdF2lrcg2e67tmzdxY6QaxU8/jvEA3PbcR278XVjA
         w8CA==
X-Forwarded-Encrypted: i=1; AJvYcCXosiBkx+8ojdziY3RBa3L8KIiphmsSBeWbzqQRfw0TY+sRuPVJsmFbDqCwVS5rCaH98R+DH0to6lj4AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45nsUho8P0EK5L/J2N7fr1w/gpAwr+sMl1MMQHkhEmCHQPNOF
	/AvS0/QW7aspJ729LK1YalR1fvFtvi/UBMxamq3d6lvmHD/zW647CMoo+3qux5gENfyJ57hL6Dp
	2wfX2qTD1uIh8QbDn94RqhVCAu83CVglwYMLEBIVMl05dYLnQZTC6xIGpeLjYK49sayi3gH8ATG
	hm4LDfscnrrGFHk2KsGYYlJ0rRXzTHIuAGG35VgUg=
X-Gm-Gg: AY/fxX7PQ0oyx5eNxjJNbegBDsv/7G+XsPmRcN1zbvE06hwA5T1F6CSn96tADtpToGg
	t7+wauy76HY+fUInfQeKf68Dkl4hdyHpW3hQYSwyoMcBHy3nZ74TUSmeyqQTTb0LWm3Zg0Qu+fk
	Xl82PgXHY1JAxMrA7DLXsoGD30HaIKG3RXZJkzI4g7c6K7P5RjAo8MZ3NnRzZPYNyi
X-Received: by 2002:a05:690e:118a:b0:641:f5bc:695c with SMTP id 956f58d0204a3-64555661ec4mr12407308d50.72.1765884018377;
        Tue, 16 Dec 2025 03:20:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE1hRYagai5ZNpwc4wQBEIkmKE4t8Gn5ugUaYPF0w5F6afO5UP4qTUeJlKU6zAyLz8ccdYL4yR/SJoQvAZlXU=
X-Received: by 2002:a05:690e:118a:b0:641:f5bc:695c with SMTP id
 956f58d0204a3-64555661ec4mr12407292d50.72.1765884018076; Tue, 16 Dec 2025
 03:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208121020.1780402-1-agruenba@redhat.com> <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org> <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
 <aUE3_ubz172iThdl@infradead.org>
In-Reply-To: <aUE3_ubz172iThdl@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Dec 2025 12:20:07 +0100
X-Gm-Features: AQt7F2q5uYepYK7esYO29pN2NRPzWpk3ITk8uPFpAWNLoGj4HZrc4JFHmQEXPKs
Message-ID: <CAHc6FU4OeAYgvXGE+QZrAJPqERLS3v7q64uSoVtxJjG0AdZvCA@mail.gmail.com>
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:44=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Tue, Dec 16, 2025 at 09:41:49AM +0100, Andreas Gruenbacher wrote:
> > On Tue, Dec 16, 2025 at 8:59=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > > On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> > > > In a few places, target->bi_status is set to source->bi_status only=
 if
> > > > source->bi_status is not 0 and target->bi_status is (still) 0.  Her=
e,
> > > > checking the value of target->bi_status before setting it is an
> > > > unnecessary micro optimization because we are already on an error p=
ath.
> > >
> > > What is source and target here?  I have a hard time trying to follow
> > > what this is trying to do.
> >
> > Not sure, what would you suggest instead?
>
> I still don't understand what you're saying here at all, or what this is
> trying to fix or optimize.

When we have this construct in the code and we know that status is not 0:

  if (!bio->bi_status)
    bio->bi_status =3D status;

we can just do this instead:

  bio>bi_status =3D status;

Andreas

