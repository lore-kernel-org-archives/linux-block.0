Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DE2E337F
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918610; cv=none; b=nRMZnrHGtloPpil9ZFtkaVZzElrvpwoB0qah5d+nrsOKuaWacm1O8z0kJ2AKyRigJMOBZ6TIKA/RWuLuiKHZwqpFjokQwMgxlcWNVEqyF4xJDVrimTthdStA4GW5pMdVdkCoRSPLLrZnVuPWOaqir0Cw6lq7pHp0zJeiAhO9JbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918610; c=relaxed/simple;
	bh=PMvS7i0wh7k9U+jdAT+Io28iXETdvuw7mkLtHXUFANQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkkQ08Fjn/nfwdPqSAhyXyHGJz/cMxt83t4rPFgyPnM/yMWGSKMcJUQTvPPYGPNVy+iJWxZzC9BSuN3HVyMnZzoFhRXCdoZ7LUrNSc3TSGoYHtL9vK2v8BiLm0LP664qcb7MYw3KN2isOvWvwUHi1RbbBe1kJH1hTdK1P19TR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gnw1Bqm4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnw1Bqm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741918608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxQodI+dJI6TdsXzaAAVG20w7s5CwmTRDEqwKu6qR9I=;
	b=Gnw1Bqm4Cn5Zo369u/9MKvg9+mtVE5RCCWcZlZkC4tfzhxFbetMS03XR+4+Nmit5QV9VBg
	Rb6Evq70ra+jqwflJ5lFC0jDrjDkMqCNGxR5Qe8AWpNNS6R5U72YiTmZX4SOvyGX2atXwz
	rLwRAvN4N0wFaOY09TNj8DEd6CCP8gw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-41FyB1X9PfCoWHOS8NH44g-1; Thu, 13 Mar 2025 22:16:46 -0400
X-MC-Unique: 41FyB1X9PfCoWHOS8NH44g-1
X-Mimecast-MFC-AGG-ID: 41FyB1X9PfCoWHOS8NH44g_1741918606
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-86b98748465so402772241.2
        for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 19:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741918606; x=1742523406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxQodI+dJI6TdsXzaAAVG20w7s5CwmTRDEqwKu6qR9I=;
        b=o8rC7zs73rTg4l7mRjHkH4wcPaBWnGARkhu54Cgn866aP0LfB7j2LnSJMRzzPAtDvG
         klfHZgBRj2RDWiLg5QX2GYutI4AdeyNmmh/CzkeoF5CjxsOFgFa9/i6eIn1gWFedmW/O
         mzwOI7EHuFGq2JwCMGRwDa9mCyB5RKBS+oBLVH0TxYhgB2XXVUhMcTTQ0Aw1CJ+H5GBD
         14sZF4Wy3vkkcRfBB3vZCEGDEiL1yzq+mWmptfTOOAM/hjSSTvyQAOLllIQ1eCIualPN
         Em5bPWqOSSMop5i2xYDj1GN3Q5o13vci95k6Voez4Vo/+cysJkrmwRK5MKujIUjK1E/m
         w34w==
X-Forwarded-Encrypted: i=1; AJvYcCXMuBQc0C/lhtv3p8qTcLUs2JCV63M0MvEG+FO9qc95yihaGEfwnNwrQ3p3hzDhq1/QShMnlcBYEEgcxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPd9d2E89MO2wPFFJg3rKldxp/uV7L0phMOpBPmDve9G3gZa9B
	zOo3FhKoEqJ5Se/s2R+KFyI2H3Z1aAjgKzompLhg0W1jSg8h6O2ACRWaBB6fGxyM0h8G0NY2Bgq
	Fxo/X5JTsBHtyqv8o98G/GeNtOg6/CS0vYhhrINW9erECvN3vsqpG8OSkLdszA5ZBs+rC3DHDiR
	tm/GQyimcOomsDhIazXv56DL/xpBvgUrk2kCo=
X-Gm-Gg: ASbGnctGsGP6ih9Yekgq/8bgewZ8aydDygbMPBEgyb80KoGePkdPh0d+wQtrgeB5tua
	gJ4o5NGK2MvFmAfHbBZPLHZhm2dn6H4J5ERhdoFf+WXmE/ewfdT1lURGQLAPwG4y8LVeossSPkw
	==
X-Received: by 2002:a05:6102:54a2:b0:4bb:e36f:6a30 with SMTP id ada2fe7eead31-4c383164f96mr419734137.15.1741918606217;
        Thu, 13 Mar 2025 19:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwqOe6J/BILwMYQ/BIWj5pe5+B8J4nDhpSGZnXcZbmryajNQaIADaLVmSSrT3A7kkx9zZ3ckEJ06Seje39PA=
X-Received: by 2002:a05:6102:54a2:b0:4bb:e36f:6a30 with SMTP id
 ada2fe7eead31-4c383164f96mr419724137.15.1741918605933; Thu, 13 Mar 2025
 19:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314021148.3081954-1-ming.lei@redhat.com>
In-Reply-To: <20250314021148.3081954-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 14 Mar 2025 10:16:35 +0800
X-Gm-Features: AQ5f1JoDwk7m7SqYHuXPwAIBP9q_aL8GAvUo9JDvDCPK8naIXF2YerzhWfnxXAg
Message-ID: <CAFj5m9+bS063tfCTqCA0ks00PNiTi=R0RZhg6M5t=bXVWDWctg@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] loop: improve loop aio perf by IOCB_NOWAIT
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jooyung Han <jooyung@google.com>, Mike Snitzer <snitzer@kernel.org>, 
	zkabelac@redhat.com, dm-devel@lists.linux.dev, 
	Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:12=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hello Jens,
>
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to=
 queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
>
> In my test VM, loop disk perf becomes very close to perf of the backing b=
lock
> device(nvme/mq virtio-scsi).
>
> And Mikulas verified that this way can improve 12jobs sequential rw io by
> ~5X, and basically solve the reported problem together with loop MQ chang=
e.
>
> https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@=
redhat.com/
>
> The loop MQ change will be posted as standalone patch, because it needs
> losetup change.
>
>
> Thanks,
> Ming
>
> V2:
>         - patch style fix & cleanup (Christoph)
>         - fix randwrite perf regression on sparse backing file
>         - drop MQ change

Hi Mikulas,

Just realized that you are missing in Cc list and loop you in, sorry for th=
at...

Thanks,

