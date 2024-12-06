Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30B3D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473495; cv=none; b=E0qbeM8iDAh9Qop7U6hkCK1QFHQE+yLohI/5Rolsqiaf/2+hRH4iLyd/rmtvrijL18EYY+TB+k+x+doT2vPwxAP+Ac+rLOm0sra3ODhNErObCCWvvQxMiGY4W2m05p0xIFqvAqAI/Flr+dXiNZLI17z3bVxb53P4X/KaEa706OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473495; c=relaxed/simple;
	bh=ye8J5gMpyEgoziFk1k+Gop+xzKhy4Yw7NPhZRthC9cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ROfH1J4NOj9Q/3NOPCeGNpq98Ozv1wSKZOAJjGNy0hC/JJLFDI25oMfuFxpxz6Kvt/daz6E72MmYGsZdzn+uh1mnYLN60pGFYRIUAV+aUXX91nc7C2y6sJrAE22Q0pfiUKU3lYGaoxI7TKVOZnU5c1j0QbHOmDT6aM+hX0MQXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2Qri3HO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2Qri3HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS4aZvls3ix/DDflqOHJki+tFShMMQ2cafg5eO3cwRM=;
	b=a2Qri3HOEvdJ2QFFPdATE3oYtX2LgeQDwnDqeGSCbqmlI8ofST6gpo4aDx2/WyjI72/ObK
	AfaugpsZ+30jntLSF1BtfFIXY68jmtCSvko/3xu+wTjT9aeGbACZFTm/mHGJ4sLreTf3nM
	kWE5pz453rVDYmSLwMJ7pLth1EGV4Cg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yb8wMwJeMrun2SgZmoyiZg-1; Fri, 06 Dec 2024 03:24:50 -0500
X-MC-Unique: yb8wMwJeMrun2SgZmoyiZg-1
X-Mimecast-MFC-AGG-ID: yb8wMwJeMrun2SgZmoyiZg
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-85b8acec0d8so716935241.1
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 00:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473490; x=1734078290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS4aZvls3ix/DDflqOHJki+tFShMMQ2cafg5eO3cwRM=;
        b=lbKLuhWzfvSE08Phrck33kuKb8AtxZw9rYuw2XjUOqc8BDDoi33FRz8WUyM7+6o3I3
         JfCvzva0p+NSvgIWfiFMQ4SW70ZbkneHo9fN2ZUFbI9ZioL+xUw8p6V4Tuile6hxrncL
         temsV5ZSty+UXW46sJYHlVEEIV8Jui63K2/s8u/nPZwVMeEvddJPfTHDStEalY4CKBO3
         CWMHtEbBaBeTHNQQUf62awnDmF15rbNkkEbO4P2P4BoIwHkj08MqQkAm5ddorGh8GpwT
         R4bbNUeBoRCILwtTF9UKJZkbeswF2wUzHc9csk40EcUn8lxdPsVtkbrUYM9lCDJhtyCF
         94/w==
X-Forwarded-Encrypted: i=1; AJvYcCX8SiYwsWjAzaIP8IdL9A9u5zhLVKfS4LQV6IA85xffdp7wN4WVCQB/JYOueUNkcO95HWvjPyd3tcBOqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyWEFl7VNd7m01bht32Yry3UjZD8ugYxSDx2Zq/0NkKuQbhoy
	BTTayjc8FioCL1uijTec62JnQA62j2YFaFRTxaSlIzJY6ZaPtuuqvaykBZXhT6knl44lK2iENSS
	LrhkUmyP63YrE8nb0L4mC8zedvdGeNBiJ/9GduImspOULX4PKQGtuELDdWvQAYX7lazZbMa5FiU
	5zWSdbrp3hAc8uam1udn/sUMg+4kAYV9FI/wOVsPdlEbNJSg==
X-Gm-Gg: ASbGncsVrIk2PhXbHZGt6jkYzdr56ZcMSiBroJl9JjP7rVTz+oA1dy13/EexcW8Xw2b
	XoZO/wpaJxnM6bXmj4XbD3qBAi4fB51G8
X-Received: by 2002:a05:6102:374f:b0:4af:38f1:5127 with SMTP id ada2fe7eead31-4afcaaf3caamr3059576137.22.1733473490261;
        Fri, 06 Dec 2024 00:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh+tdWlzp1lbcwVot0Q+xGYh/E776emTlbGeUOspOcgTEaaKhONkTQj/e3iJ/02DvYXv0Hts/pNtPAQCOi2PY=
X-Received: by 2002:a05:6102:374f:b0:4af:38f1:5127 with SMTP id
 ada2fe7eead31-4afcaaf3caamr3059564137.22.1733473490010; Fri, 06 Dec 2024
 00:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206082202.949142-1-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 6 Dec 2024 16:24:38 +0800
Message-ID: <CAFj5m9+dkMBk8dZcOGPkry1A7UuDrK6oNfNToVbYTjbrKooY3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] blk-mq: fix lockdep warning between sysfs_lock and
 cpuhotplug lock
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:22=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Hello,
>
> The 1st patch is one prep patch.
>
> The 2nd one fixes lockdep warning triggered by dependency between
> q->sysfs_lock and cpuhotplug_lock.
>
>
> Ming Lei (2):
>   blk-mq: register cpuhp callback after hctx is added to xarray table
>   blk-mq: move cpuhp callback registering out of q->sysfs_lock
>
>  block/blk-mq.c | 108 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 14 deletions(-)

Please ignore the 2nd round mess, sorry for the noise again.

