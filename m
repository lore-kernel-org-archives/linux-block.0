Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6715188CA4
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138530; cv=none; b=rEJh5UVulHrQ7OhI6QgJgN+RqCAC2XQkq5f5/tkcXIPeGiF9HI8P2/yesGSXSXHGwfJL/ip5OZzRvJedstiUXbD8KFnOUffJ1aMHTbj/Cu9E8rILzKVTt2h8AdZd4cdiyFll1xKs7PV+YxQkoj/ym3WmniMJcgUuiBQmxWr1UtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138530; c=relaxed/simple;
	bh=CwAJcF6bJ+g48Ud2pzdceQkOvdF0s36dJmUP+WwsYDg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8xtk5LhhARy/t9aotzHOWhpzwSu7omO57uOK4IYUhByd7qmK9sxbmEys1E0oreQnBczlaAKIrircheEFV+4SXdaZMtD1+3xhoDbiF1Upd4hFl2PX4lTEgfBlXPhdMIeld6PYVXIKr02VLBDvbL5Fr+6Ix2Ryh9bU7nTswkEVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmoTNaD6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmoTNaD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724138526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
	b=WmoTNaD6nf8DilMTLUEdSPmpZwcIuK/QYbOK/Qi6VNhhmcyfmfNc2e3JJL19iXO4hvyMWP
	NcGks+osBWcHSw5Mfy435lvB7fUPatbdGJcoaPSb76e9YiETpq/qQX/OQXq+eHcDegBbSQ
	ab0Iy0aPHGncelIAY+ng7LtHxBJVLC8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Bj-svBJdMEeOQg0SL5kN2A-1; Tue, 20 Aug 2024 03:22:04 -0400
X-MC-Unique: Bj-svBJdMEeOQg0SL5kN2A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso9509575e9.2
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138523; x=1724743323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASIEWrzHXogS2+yni6jFmR1o/WYm2ANcxSxU4DhoyQc=;
        b=aWjHk7difnOBOIYWFZpKy6oPmveSvreAbhrn23aPMcqZCqGV+S211l5T//sBdrVh6M
         kY9trdBcCFg3LY8exmS/9bIGuQhASCBc/sz5ASZGADxeiwykclgGrbw2tLjpG46DU5Rg
         fTEOwPg3ESdUC9o0i1F/qaL0LQSbvuZfcbiU9s01hNTiI5Zl8B5Ty+me3ggwREc2isoD
         dL7DJYuk7haTRUDVq7zKxr9M33/QA2QFAmv6lIU8/pucxkufGB/sxLInWPxTKr3juE4+
         8yekS6/z9Va8wMTwTXDMAXjIT2onB8FxYNHzLprghkcEXQ+HW9yiU0BgXS+zrqO7tIcu
         YnIA==
X-Forwarded-Encrypted: i=1; AJvYcCU1hscyAyPBspbkZo2YmcxSEyrbY/Ski45V20m42ZQpZmk+0af3JdKGP6zucegXyISgw+MUefLpES87+KoqfZvkoHIg7k3dLdhHGvQ=
X-Gm-Message-State: AOJu0YwrAXY3OeGfK9MKaCyu/K/WOcrPOkA+wOY6Tcz3gKKqhDC8fzrb
	eOIYOw+P7FnujuPMZ9FpoAB6p2HTQytQEN26YtwMYhyHYgJNLvcb1e7dz0WWGYD4LxkX2ofLt7O
	F5dbzbyQJ7cELyP8RiwWJtC13e8hRdB1TBFDqiNdPh8BBEM27PfFyw+0MmAsR
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55367855e9.0.1724138522940;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtu6sXluOG26PWy70qwsbDcaM81TTK+UTUTvyjs1U84scjqTgJELEGk3SrTeSIfdGLnjJpqA==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr55367605e9.0.1724138522431;
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429eeadfafbsm130634445e9.47.2024.08.20.00.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:22:02 -0700 (PDT)
Message-ID: <267a021781f59d6efe798dbca63f29dd25359f2d.camel@redhat.com>
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>, Damien Le
 Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:22:00 +0200
In-Reply-To: <20240819165148.58201-6-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-6-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 18:51 +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>=20
> In mtip32xx, these functions can easily be replaced by their
> respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's call to pcim_iounmap_regions() is not necessary, because
> it's
> invoked in the remove() function. Cleanup can, hence, be performed by
> PCI devres automatically.
>=20
> Replace pcim_iomap_regions() and pcim_iomap_table().
>=20
> Remove the call to pcim_iounmap_regions().
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c
> b/drivers/block/mtip32xx/mtip32xx.c
> index c6ef0546ffc9..c7da6090954e 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
> =C2=A0	int rv;
> =C2=A0	unsigned long timeout, timetaken;
> =C2=A0
> -	dd->mmio =3D pcim_iomap_table(dd->pdev)[MTIP_ABAR];
> +	dd->mmio =3D pcim_iomap(dd->pdev, MTIP_ABAR, 0);
> +	if (!dd->mmio)
> +		return -ENOMEM;
> =C2=A0
> =C2=A0	mtip_detect_product(dd);
> =C2=A0	if (dd->product_type =3D=3D MTIP_PRODUCT_UNKNOWN) {
> @@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Map BAR5 to memory. */
> -	rv =3D pcim_iomap_regions(pdev, 1 << MTIP_ABAR,
> MTIP_DRV_NAME);
> +	rv =3D pcim_request_region(pdev, 1, MTIP_DRV_NAME);

That's a bug here, btw.
Should be MTIP_ABAR instead of 1.

Will fix in v2.

P.

> =C2=A0	if (rv < 0) {
> -		dev_err(&pdev->dev, "Unable to map regions\n");
> +		dev_err(&pdev->dev, "Unable to request regions\n");
> =C2=A0		goto iomap_err;
> =C2=A0	}
> =C2=A0
> @@ -3849,7 +3851,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0		drop_cpu(dd->work[2].cpu_binding);
> =C2=A0	}
> =C2=A0setmask_err:
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> +	pcim_release_region(pdev, MTIP_ABAR);
> =C2=A0
> =C2=A0iomap_err:
> =C2=A0	kfree(dd);
> @@ -3925,7 +3927,6 @@ static void mtip_pci_remove(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0	pci_disable_msi(pdev);
> =C2=A0
> -	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> =C2=A0	pci_set_drvdata(pdev, NULL);
> =C2=A0
> =C2=A0	put_disk(dd->disk);

