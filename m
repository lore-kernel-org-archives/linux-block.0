Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B221B9C8
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669132; cv=none; b=uyQvn5zx+PDSCe9Ea4fMYPuRP+fp+jQK4qzE/UkDbVml5h+rpsjyapv2eKTiw5f4jSOG7th8cdi33Me7HzX7M1d7CgkCyinbYP6VzoxqEZ+Mh4gMUbOW99IW8e2WHy1J9WJbID6G2SqWC9ehk49ecWXHtNkZyuQaQGbRAa7BYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669132; c=relaxed/simple;
	bh=tfOORXFWwM777CUxOYQHekIyJgtiUOFn6WAodQgU5Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcYPyHmXFzmXTMa8UFBPYCCCMxzzmKZU160dbBrrzMVIoWocpjNJUnSYqTqQDrUu9k8T0p/Z947uTzNDFrzMssPaEmiqoeJPxOrEV1ck4MhhSdV/N/xTDGovgQQq4EaUCt6Hy7OPUey7lub8btTkDttnY8R5/OtUe3Y8jAqGlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmswifYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmswifYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752669129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvwBLNC3JbC6Pz9XFD9XCRcacBd6zF6bLvRa6w4J4lE=;
	b=bmswifYefiInRVTRT+3hqIpwcfUgum+H7qbZehpJOB7jDG5212JonfK2+yZYRtNKJqZQT6
	ogONPFAAbB7CdbESf5MJ3QtHgiOXYJ/j3gL2//LNW+u943CVGvwj2qzcVgWFAySlbSxE0/
	+vmNrYunhGay7NyrqmSBjxFgizwP1ZI=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-XTe4BJDUOquxXdnuwRmF9A-1; Wed, 16 Jul 2025 08:32:08 -0400
X-MC-Unique: XTe4BJDUOquxXdnuwRmF9A-1
X-Mimecast-MFC-AGG-ID: XTe4BJDUOquxXdnuwRmF9A_1752669127
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5314dd44553so2154283e0c.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669127; x=1753273927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvwBLNC3JbC6Pz9XFD9XCRcacBd6zF6bLvRa6w4J4lE=;
        b=DpFZR9RG7854x9dQOf26UvGcRgyiiMF2BwP9GqoIszK6KFrdRmU+KPaNvrV93R1dSc
         4Ctl58tm3bl1jp7yQf0qsUeAIjNYWUEYfBeD5SqkwH1yhfv0uuY3h6Fh0pn4fWsmN/nN
         nLrvVSZlgxSkCUyNmim9g4nKM5uo9O9SApH5euH4tx4UaayX/NULw+X5P52ewAchzQUD
         YR9JOuhiQ6aCTTJlDpKEaYB+DwlQsD3i7BVflxko2coW9V7ipDrZOVpK//KQRVZLtXV1
         1ABjVcrFXWkjJ4jGZkzBQKmJsGCsmEdM4j982pM0w3QE2yvju8l9mhYake9uX+e1UN9m
         QNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQCD/7oCzTKmabtHN+XqBZRAF/GwzvI1+ZSG+hq6/T4lhasL5PyE6rAh+wp7MO5Hci7mmJ8r9e9xgwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCV4gfJbYrDGkXDEL49fasJEP87NEWmb2bBVTzd/S2UJjr/3QC
	5I+SfoLq5dVFfrxWDvLloETn8co9KzrY8+9Qhc7uidV0Q8zXbYTqiFcHKPeRcNVduryHBTRRV5c
	NrYsEJUNLx13FZo1p8nOn+dHZPjdpczqvVc5b3Fwx2SSjhRNxpn8C5rKaZO34GqafzDCgSrd4Ar
	+6mAVZWzJslcnfcLLNz4kx+jeodr0a8Bh5Y/qcQ5E=
X-Gm-Gg: ASbGncvzb4o+wfptScry8xG681Sskm4c8Vb4ucr/j1GusHD1ZOiPvo3I97SabcmSOku
	/dIjcv0mWBJ4ugK6dD6dvFoGAuT/Nfmge243E4jB3YnJ2ToUZg+0zNpjMzRCvIkHgX+iVR5+Osa
	MYcPtLfmAGFLbhN0n8//ohcQ==
X-Received: by 2002:a05:6122:2220:b0:534:7f57:8e30 with SMTP id 71dfb90a1353d-5373e328bafmr1355141e0c.10.1752669127560;
        Wed, 16 Jul 2025 05:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKkRQsVNcqsbLSU7Jv+TVsYPEWyR0rgGCufpE0krrXM8VHMTD1bKRkig4DeNPdgqU3MJcGKX5+HiFaWmZ6CB4=
X-Received: by 2002:a05:6122:2220:b0:534:7f57:8e30 with SMTP id
 71dfb90a1353d-5373e328bafmr1355137e0c.10.1752669127263; Wed, 16 Jul 2025
 05:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716114808.3159657-1-ming.lei@redhat.com> <aHeZA3sT_o2O5JWs@infradead.org>
In-Reply-To: <aHeZA3sT_o2O5JWs@infradead.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 16 Jul 2025 20:31:56 +0800
X-Gm-Features: Ac12FXya1q3LbbR4RHROh6uVNebk4SUNd_s4Hu34A68ClVerZjb4DqvBj0I1ItE
Message-ID: <CAFj5m9L=zOs4JkzMZMZ9S0rWJaH21Ntxk1d_0fR0SBu_QAAdAA@mail.gmail.com>
Subject: Re: [PATCH] loop: use kiocb helpers to fix lockdep warning
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 8:20=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Jul 16, 2025 at 07:48:08PM +0800, Ming Lei wrote:
> > This patch fixes the issue by using the AIO-specific helpers
> > `kiocb_start_write()` and `kiocb_end_write()`. These functions are
> > designed to be used with a `kiocb` and manage write sequencing
> > correctly for asynchronous I/O without introducing the problematic
> > lock dependency.
>
> Maybe explain what it actually does.  That is drop and reacquire the
> lockdep notion of a held lock, because the process is not holding it
> but instead handing it of to the one handling the completion of the
> asynchronous I/O.
>
> The change looks fine to me, but this commit log is rather confusing.

It is actually the typical use case for aio, please see use in fs/aio.c.

Thanks,
Ming

