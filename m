Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDAD25B667
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186867; cv=none; b=pEP/ZmJx11tlBbPA4UQkzSO1uQzZk315vDjxI6le577YiGeuJTtokVRDk+FyCNNBmg156HKrBZ0ybwmwoXb3uRi4zFM6aysV9iCVyDeFpSmQzSl98KSpIB3wFRv5YH9Q+bgVmIirGwbh+Hmk1hnlnOxIX+BnWflMj0Ht0S1s0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186867; c=relaxed/simple;
	bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxGixnPFt6WDtkpQB8OokW/BpOWqHeFHjs8rkS+ete8ArzO8hAuFPysuU7fBhbDfkMmMB2DmkHpHOSh7xhvzLOrsu/H24vtPgdCY6JgFAvosKRfgEb5ZGik4dr03fdsllXaH0AvnmmA5pLncHZ8vt/R/ulIirJQG9BDqZFaqkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDDH68S3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDDH68S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744186864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
	b=JDDH68S3DQVBWm3y4MUO+NITGxD/kIpN2g5FhukBvEJL1T7jrfjFpt0WHaJb8ia263oOdF
	QwKKUbgRsaaW1DRUFL+f07wOwQuiGiS38FzwYjTp5Zey5Selu0Qvc18BfJTE0FrDCZZsRl
	z9Ojgg1Qo+9666coeQLQLzkjRIvpxRs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Hp9y4QxNN2arKPHOIRIyww-1; Wed, 09 Apr 2025 04:21:03 -0400
X-MC-Unique: Hp9y4QxNN2arKPHOIRIyww-1
X-Mimecast-MFC-AGG-ID: Hp9y4QxNN2arKPHOIRIyww_1744186862
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-739525d4d7bso5103731b3a.2
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744186862; x=1744791662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
        b=PZ84Z9zl4dE4oyX0yOqDOyL4xT5NJfvp+9uf11dONNGQtVqGidsI2mw8QE8PbX2sb3
         vY756Tn66SxPKFI53Bu0Qge8c1Dr7EDqRwgOjG4VqqEXsiGulTCgCzPuyIkDswciJ6yr
         UQtvo8U3O1mdN6oD5xuG2rULpRO5AOFyRhLo0DGLNRJsUt8Di4h06aHVFCQnOK2lRVzx
         8Xmv8RNYK4wGQBmtSJZ48sxX6GANQvEgEkHqgg7Rr8/3mm2FNxFVkXNpNYNh1TbqCDWt
         lVpXBMsqctQu9A9BwqXLXTLLRSDApL+HoL8DCU/bPXilqPGBe32ernK6Q7/0rXzNFVS1
         px6A==
X-Forwarded-Encrypted: i=1; AJvYcCUehFDMrI30PD6LE4jaDOp1PqhicLEdraVjcHYP9FZH+gtjaukvW8HRvG4+vqzAAP+3hxyK3QRD3R6SAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYlbZ777VSy3nni7/KlqLx84vY7Ecb72GrxL2/q6SEFLuIqkx
	/JTmr/wTqiiF50ocNbZJMw/Xhn0AAtAlmHU7JU8CJBknla//z+n5TJcGonsLADvUS6F7KObBmjM
	p2suyDzgQNA4Q2czBvGBuVQM8sNFklqA/Kgv0Aoh2unoOZM44CZlHhM1wk50x
X-Gm-Gg: ASbGncu88jM1oxLL+HL2DqeHuf0ESIvapq95L3wgaF/De0P+Odew3JBxSlkUE1QdnAq
	FIytn7el0kgeRiBXV+Y19Kij5/ykLRh5kI1YCWnpE/K5U3MJ4kC9RWmqFD4hlQO86DY94EOwe4R
	XWmTnpclV5mVRDkoRIa4YZy4X5/tkR7EgsEv6APM4LWHP84ooPFU+yAJrDhoCUL23wizwv7HDwI
	8ex0gUYlb0ZzZfmMg6GrW9B4NCw8wuAa1egzRg2DNUs1ozw+EZBAYkobUYsdLUprdb7lBpD86zI
	/mb9b5/dmV7DwuKIOFM/J+ycgpb8iwtEf0FXyg==
X-Received: by 2002:a05:6a20:9f4b:b0:201:4061:bd94 with SMTP id adf61e73a8af0-2015aec70dcmr2663681637.19.1744186862422;
        Wed, 09 Apr 2025 01:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAdC8ZOoLIsWMuTKkgVixwpNFmJg4t2tF+Bs6s3GQA8caDDKDF7hIvBuRiacHAa2qdet6aIQ==
X-Received: by 2002:a05:6a20:9f4b:b0:201:4061:bd94 with SMTP id adf61e73a8af0-2015aec70dcmr2663635637.19.1744186862052;
        Wed, 09 Apr 2025 01:21:02 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf2eb3sm660285a12.24.2025.04.09.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:21:01 -0700 (PDT)
Message-ID: <f2ec6ba36845c96e9fb9a2dc465d9066948bbe4f.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, Mark
 Brown <broonie@kernel.org>,  David Lechner <dlechner@baylibre.com>, Damien
 Le Moal <dlemoal@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Yang Yingliang
 <yangyingliang@huawei.com>,  Zijun Hu <quic_zijuhu@quicinc.com>, Hannes
 Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,  Li Zetao
 <lizetao1@huawei.com>, Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 09 Apr 2025 10:20:46 +0200
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>
References: <20250327110707.20025-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 12:07 +0100, Philipp Stanner wrote:
> The last remaining user of pcim_iounmap_regions() is mtip32 (in
> Linus's
> current master)
>=20
> So we could finally remove this deprecated API. I suggest that this
> gets
> merged through the PCI tree. (I also suggest we watch with an eagle's
> eyes for folks who want to re-add calls to that function before the
> next
> merge window opens).
>=20
> P.
>=20
> Philipp Stanner (2):
> =C2=A0 mtip32xx: Remove unnecessary PCI function calls
> =C2=A0 PCI: Remove pcim_iounmap_regions()

Can this go in for the next merge window, Bjorn?

P.

>=20
> =C2=A0.../driver-api/driver-model/devres.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0drivers/block/mtip32xx/mtip32xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 -----------------
> --
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A04 files changed, 2 insertions(+), 31 deletions(-)
>=20

