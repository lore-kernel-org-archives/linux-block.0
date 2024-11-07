Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC0218D9E
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021708; cv=none; b=GdLd2nYXrWLjvZPGJ4EHLYCQi8SP0hPfUfWsT3OP0IHDA84/yGsHjthszFFMuGBPLfq85+5LkFcqoF0syuAnXUKPrw7ApjltuPEUT1CcJxHf3OcLsJdZXdbbiOtzXgvf3tIYhOOrkz7jXzE8o/ChZnPTU3yR9J5Q64tQFJ5RatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021708; c=relaxed/simple;
	bh=mYg8elYcvLlMYwxQNnrZBoalRTj/K60eaxGSmSRf0LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyXRM9KwytqfEUxWOQzQsJ7mBMXndOxlO15KfdqxanLnzLtQCAczCC6t8dfjDJF+l4S+9rdY+6WOALHuoqnvULGe4+HVozy63y0VIgsIriusa5GCksV7fcva8mdqTbmJ7ZGyQc+yKlFFbQ6MK5zdBHo5EhWakdWpWayBgOctBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4LXCljl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4LXCljl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731021705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VV7fL4dgaHSSNqE5Pa1vHN4hM7C5Vs+N0Cj75BdK/Q=;
	b=F4LXCljlfZ88l7V51X52k0eQz9WaZhbuac1WjKlSj1Nf7NXcEToHMI+HXFK2zWOtX6NE01
	NWzn5WJoKsUlDb77m/Mzzehjzog9EQnW6rG8ay0CCSI60lOsJ1GxVoJyae/q2YJLu7mosU
	iCRxazATQpWaqe36e8rKP+BHw47FaD8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-5nh8EXuiM7SpT2lNXNXYxQ-1; Thu, 07 Nov 2024 18:21:44 -0500
X-MC-Unique: 5nh8EXuiM7SpT2lNXNXYxQ-1
X-Mimecast-MFC-AGG-ID: 5nh8EXuiM7SpT2lNXNXYxQ
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50d6ace7217so630941e0c.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 15:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021703; x=1731626503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VV7fL4dgaHSSNqE5Pa1vHN4hM7C5Vs+N0Cj75BdK/Q=;
        b=cNElPuzFaKcQzitQ0j/pehPwLvSQK5y/zcHljf6BNCKejZ8n98Ur2hdzxCyyMFBICC
         NyF+Y5iVMzWv9yMOxaOjjQy7V5LA1H/6VVgCCj3nGdDSmvJyxOJ0po6oKmCbTk7wFC/j
         jc1T1PpisqNZTG63LjfBAFDpxw+Yah9YKqQj6Sgy4/RWPU1q8v9PqIKths++t8uCPk5A
         Bq/lvNHBgDGLCF6FhGm7+v6UCcu3fyvtgGzzGrcY4cOvWRKF5n8Ae54Oh6sPplOSz9FB
         cRVb1kxcT15yBcEx2TknyDG1h5nn9CVKEmc+XDnxTwaIEH3avi45fuFCpYjILHAhb+YD
         PO1w==
X-Forwarded-Encrypted: i=1; AJvYcCWXthg33b6Hob6Zo8ugiTHyLC2gf4kB34dCD9h78yhG2JsQWswUy4eFpOk40RUw5M+NFgv2mSfC6dB74g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYi+kcXx9aDmYDiqUAy6hh8sVAJkBAQQTrzOsEckWwpzhxbwD
	D5zT8tHoNyOrMxoD/KT6opC/0LD1gx27xstY150LsX5QZSEReCk6m+1paXmszoUuNAFuOASa6A1
	wCeSBg6XQzL/vRDqcUl48Y7e8FSBmUW604HvgHo+vDGKqiIkXyNHYBLfYgQM8arWg/+ajdj/tsC
	Lf2IQUTV3M5joP/PlakHhaThWsnGxNVwVxG2RJZK4zzmizlQ==
X-Received: by 2002:a05:6122:459c:b0:509:e80:3ed2 with SMTP id 71dfb90a1353d-51401e4a90cmr1163219e0c.7.1731021703163;
        Thu, 07 Nov 2024 15:21:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF06jMPtuh+LAHbv6/oVGg6sKryz1AdZ/n5/PI2qqLv2AEM8dT9Qq9/PbJJQ38wg9NC7DD1o7oHUVouHpAHrPM=
X-Received: by 2002:a05:6122:459c:b0:509:e80:3ed2 with SMTP id
 71dfb90a1353d-51401e4a90cmr1163209e0c.7.1731021702885; Thu, 07 Nov 2024
 15:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031133723.303835-1-ming.lei@redhat.com> <Zyq3N8VrrUcxoxrR@fedora>
In-Reply-To: <Zyq3N8VrrUcxoxrR@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 8 Nov 2024 07:21:32 +0800
Message-ID: <CAFj5m9KV0gnUr3jy-sU_5Msv86wQgqoHwAoyS_0h_inGybR1Rg@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] block: freeze/unfreeze lockdep fixes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Thu, Oct 31, 2024 at 09:37:16PM +0800, Ming Lei wrote:
> > Hello,
> >
> > The 1st patch removes blk_freeze_queue().
> >
> > The 2nd patch fixes freeze uses in rbd.
> >
> > The 3rd patches fixes potential unfreeze lock verification on non-owner
> > context.
> >
> > The 4th patch doesn't verify io lock in elevator_init_mq() for fixing
> > false lockdep warning.
> >
> > V2:
> >       - drop patch 1 and fix rbd by adding unfreeze (Christoph)
> >       - add reviewed-by
>
> Hi Jens,
>
> This patchset fixes several lockdep false positive warnings, can you
> merge them if you are fine?
>
> https://lore.kernel.org/linux-block/Zym_h_EYRVX18dSw@fedora/

Hi Jens,

There are lots of lockdep reports which need the fixes, so ping...

Thanks,

