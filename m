Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FF1C862F
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759065517; cv=none; b=I4hBZyyV5AZ5s/3mVYdLZO8nfG7txW0rQTzA0v731/PHpr5ey8DGn/e2HS2nozoPA9j2jXuyGpqpVR+XQFJU4jugvMopbz0eQAgNBTUadypH6m5j56FODUZpwqLToUXf7wDMh+Wmzc4L+nTMgt65qIN8+oB5EnTRkgAtei/WRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759065517; c=relaxed/simple;
	bh=XXj0QF+3/NXQQfnxR3B9aVBQN8uf65dx2ICtRuyzzrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgWFRmv3r9cl4tiTg9MaYkCx/4v/KWB44NYBa7Z186uG/U+kXGNJjIS3O6PlquL/juGk41lQHFvCrmncdHbxPefHdWXcKMk8OUSSp3Wfcvz6a/sApJQs7KIh9QdTIFNYOe9Oa+6Fs1lEXkUN7omg1IHClk5RCrZdTc7aHBvZiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ov4zjl3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov4zjl3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759065513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZrgw4gpKloeX9jAq8wMstO9M9cFrPaCA8nWHSUeCis=;
	b=Ov4zjl3DM7+arRlhDl2d42vTVNfCUPb2MUJ+5t9C4tpYFvq44/OspkXCFJz8RiMXSoGFdR
	yJw1pMFmrPTyOs1kgPPnteAHjQfcI5304Wda1nNQcC1K1H6KBuhXL8Xs5bvpexy31SrTQI
	KM2qHnRviZI05nVRYxCSHi7E62+JlWM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-kmu4edxHPeS44k7HXicCvg-1; Sun, 28 Sep 2025 09:18:32 -0400
X-MC-Unique: kmu4edxHPeS44k7HXicCvg-1
X-Mimecast-MFC-AGG-ID: kmu4edxHPeS44k7HXicCvg_1759065511
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-59e1b6766c9so5791676137.1
        for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759065511; x=1759670311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZrgw4gpKloeX9jAq8wMstO9M9cFrPaCA8nWHSUeCis=;
        b=Cj0/VXUebhuxZmchfDU7CzS3cQUFpZBQCaNB/aqySG8hFuVro17jzaLmBUC7JxJ+7G
         T/dqw/SzitMXyAuuOHve9W1vUQSpUWlF4qXn4OqL5cfx/DimS3NWvPwioD0ZTIn68NUJ
         wWuWMg7ccVqX+H2KumOi+UpTr0fD63DBQ3sv9eiJzMcDjJx50WtzITK8gZJDV7YjU/m+
         5Vmv7JSFNumi9My2PZbM7v08vbbwB4kBRx1nmCnPvpAWHH0Z/CjGgr1CgkII8BdXXtfR
         gkLr1RaP92ISiud+WzM7o8EgDBtqiKgn0QLlEEJiYwtfBuE8OParSnFWtqkVBWZuYs75
         fqKg==
X-Forwarded-Encrypted: i=1; AJvYcCWUHtOurFfANUs/Aq0LG3aSmcqVbKIW0jTYmZBGD4nKvRiWtKkJJEzq3aRT3GJH+ZwuGrurIyRxHha+LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEsrTcjrP17eGfT6Mz6POUL5RsvDrjPzbsDwqjtXC0/k1u15/
	Nr5HBSaNhdXrakg4utnV2Ib2onm7O1k1YUyUa04yK5dj14z8egbtRiXOAtjux1R5Ij+AODzmTRJ
	y3kWfaFLdHfKCjxD0DzSTzWritFLxlzftuh/RICYlZVlIDuJNpNR3/+B5nsfv8ioc1EqChZ9FnQ
	o6usqNmid9y3zOx+kky5IWjf5NoCdBhtRWY7ZdYt4qhi+mDANxEw==
X-Gm-Gg: ASbGncuI8m9/mi1MupTwzzXx7AUuemw8v48fOK99LOe0JM8Qux5Y88s6Umdn8IylCVi
	m5+wMVgYtjeFkGbPDorBWBtYuvw2lKEydLs/fHB1Slyj0/iwrxzeY0QtEc5K10AWEAnnteFLjOT
	iQCfgme9iY+yXRhibBDHDDpA==
X-Received: by 2002:a05:6102:3a12:b0:538:dc93:e3c4 with SMTP id ada2fe7eead31-5acd4636d52mr5613329137.16.1759065511355;
        Sun, 28 Sep 2025 06:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmHzfMI3Oe1YG7uKvPaPiSWpbJ7zP/EQGzITHlCvVsDPm2SGtMgLiLw/1bq/SDVd4FWH8fuf8RN3ofjSvjzK0=
X-Received: by 2002:a05:6102:3a12:b0:538:dc93:e3c4 with SMTP id
 ada2fe7eead31-5acd4636d52mr5613323137.16.1759065511056; Sun, 28 Sep 2025
 06:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de>
In-Reply-To: <37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de>
From: Ming Lei <ming.lei@redhat.com>
Date: Sun, 28 Sep 2025 21:18:19 +0800
X-Gm-Features: AS18NWDT6O8C5AwkRhe1aYAm1xR2Cn4j-NljwDjrlE4H2_PARSLlyFDDCraW_wY
Message-ID: <CAFj5m9K+ct=ioJUz8v78Wr_myC7pjVnB1SAKRXc-CLysHV_5ww@mail.gmail.com>
Subject: Re: [BUG] Double-free in blk_mq_free_sched_tags() after commit f5a6604f7a44
To: Niklas Fischer <niklas@niklasfi.de>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, vbabka@suse.cz, 
	akpm@linux-foundation.org, axboe@kernel.dk, nilay@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 8:18=E2=80=AFPM Niklas Fischer <niklas@niklasfi.de>=
 wrote:
>
> Hello,
>
> I'm reporting a kernel crash that occurs during boot on systems with
> multiple storage devices. The issue manifests as a double-free bug in
> the SLUB allocator, triggered by block layer elevator switching code.
>
> =3D=3D=3D Problem Summary =3D=3D=3D
>
> The system crashes during early boot when udev configures I/O schedulers
> on multiple storage devices. The crash occurs in mm/slub.c with a
> double-free detection, traced back to blk_mq_free_sched_tags().
>
> =3D=3D=3D Crash Details =3D=3D=3D
>
> Multiple crashes occur during boot, showing a severe race condition.
> Seven separate kernel oops/panics are observed:
>
> * Oops #1 (CPU 13, PID 928): General protection fault in
> kfree+0x69/0x3b0 - corrupted address 0x14b9d856a995288
> * Oops #2-4, #6-7 (multiple CPUs/PIDs): kernel BUG at mm/slub.c:546 in
> __slab_free+0x111/0x2a0 - SLUB double-free detection
> * Oops #5 (CPU 1, PID 952): General protection fault in kfree+0x69/0x3b0
>     - corrupted address 0x2480af562995288
>
> All crashes share the same call stack pattern:
>
> elv_iosched_store+0x149/0x180
> elevator_change+0xdb/0x180
> elevator_change_done+0x4a/0x1f0
> blk_mq_free_sched_tags+0x34/0x70
> blk_mq_free_tags+0x4b/0x60
> kfree+0x334/0x3b0  <-- crash here
>
> =3D=3D=3D Bisection Results =3D=3D=3D
>
> I bisected the issue to this commit:
>
> commit f5a6604f7a4405450e4a1f54e5430f47290c500f

It should be solved by the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-6.18/block&id=3Dba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Thanks,

