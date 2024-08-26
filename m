Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1C189506
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683874; cv=none; b=ASvSTrt3/xmcomQHmJH3w78DA9CQBxD5r2BmDgc4ZoLCgrvQcEb6U18xgxBrI5OBWuXaswLCRlW34tuGOgGV1YvQqrabyvLGOtlfN0JradNKaILXUZn3qbRlZbhxdZjIKjGdm+MBGyQ2RSOHJyeHyuHHulnq6JQ0HkH9jEMWZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683874; c=relaxed/simple;
	bh=gejqF3lxPDzVKaKWaPqTWU5CZhdrvtg8FR6CXRKXq10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZTOhFM6niFVUb8gndkySFQ7mHAdTH8acRsKHwb1fdwPlVkfu4bYbwzw8s29dt21sX55rv4w1ZoM13as8GsQj1sjR0fnYhV2Xi79wuNu2CrA86l3jsKi+nibbOx7SQ7IOQBkdkIMnWpXsOtXelRiiAnC9UtXNUT0frBi5Qe4Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA4lXiLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA4lXiLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
	b=bA4lXiLwLbxXH+chWnqogx2r3zeNyU2BAG7EXKp0TAbr+VgsMWZrBFK2X/vjyQYNAordpb
	CTrrECbjWibCTvnGfb9rOHN71bKIAo0heafCSIVLe3Rv8fGO0xWQ0+w+7D28s7wqXVj62g
	mQeEYjSsXNqTmBUSuwenOPOEb5sO+zE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-pmlBD0vfN2WSstqmuPoOsg-1; Mon, 26 Aug 2024 10:51:11 -0400
X-MC-Unique: pmlBD0vfN2WSstqmuPoOsg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so3683069f8f.3
        for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 07:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683870; x=1725288670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
        b=LaGzfXm0dtaJo2uSEgbTowSy/jZw6VN8Gr3z+RYMyLbpa+gjPBlkUr3iF+lU89PLBB
         gz7Kuwq/4EkiTawVZd44/gBfOt5mju0Va4Gdg30EQ2ryO51svlBlKYObr2nEcIUjuX+a
         lCNG4lu88n9X4E/WyFZ5fzHwLCeGB02MF85pXOXOvLOAOLD/O4mHCXckBblcwKdeCWLE
         X1OnORlwcY0qh7/4uBKxaRQkCV3SRYQ62j3FIREh7gQD44sp8/4dBmwVknFHYQOj64AF
         JQruDU3PLpLbvTc9hl571csquQDFUF7a8GBay/ROPByjSP7rJkChgdx6tzrRYr5UAP0R
         hnuA==
X-Forwarded-Encrypted: i=1; AJvYcCX5pfwxm5xSkusk546FnEV1+7GKPbaOGxB9k2spK9Lb/HoEPfRBy3losglcsNf/wUp1fUjdf+kzCDCB7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8VdqXs2YFUP+3aTcK4Y9WaxpvDLJCIoXmcXypaDkvbMEx+3H
	JpHb8mrJVlft3WEkkV+bnhYxJHSAJwb3uI5gUDkPC3Wki2y7o8hcsrlp5B4OETLzMyw4NNGG8+X
	R+/UaDZ6vIBuudEvwRlefJqvVFXdODbhsYgfgEICvPCjp2WWM1mdugJrfVT2g
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315247f8f.41.1724683869834;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzcbeZGAiG9pR7gwgPFjZ9tQkwyQH6hKqQkC/ZviQjFl3Zuqsn+yKqro2WkBtRVRH4FkIJWQ==
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315196f8f.41.1724683869319;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082096bbsm10889215f8f.89.2024.08.26.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:51:08 -0700 (PDT)
Message-ID: <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Mon, 26 Aug 2024 16:51:07 +0200
In-Reply-To: <ZsdO2q8uD829hP-X@smile.fi.intel.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-6-pstanner@redhat.com>
	 <ZsdO2q8uD829hP-X@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> > -	err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > -	if (err)
> > +	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > +	if (IS_ERR(clock->reg_base)) {
> > +		err =3D PTR_ERR(clock->reg_base);
> > =C2=A0		goto error_free;
> > -
> > -	clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> > +	}
>=20
> Perhaps
>=20
> 	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> pci_name(pdev));
> 	err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> 	if (err)
> 		goto error_free;
>=20
> This will make your patch smaller and neater.
>=20
> P.S. Do you use --histogram diff algo when preparing patches?

So far not.
Should one do that?

P.


>=20

