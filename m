Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C330188CBB
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139620; cv=none; b=jReaPwEML3MbXRAJW5Pi2ZekEBi+4v9QLtKzvbSnWRr6yqsMnvHc33Bi+WxciIdgBQ4SNeo9fkEIQb3Ulg7aTEVNEplCsyLK5kcq6jplJu6BdDx6N2hn/gZAZ7ivYrynd7107bFSFFBwbGGCJB8JHD1THVrGj6RI1aydrZAdvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139620; c=relaxed/simple;
	bh=aYkN9CyGqEIYAw2LdxUgvvFJ/GqgBaxXltVMI7LxkmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNroB+mNl0waBuwFyJbb9P/L7V+asaskjQVl/bdbtDFVwbIdUihxk01f21cOo4Fe9WAqG/4ZF16qVY6yrw9hrT9WFVvSJvBTSyp60Iu/JSiLcgmk5KSZ1lkrKOnN4urYsx1SjRBh2tDleGlaFmECd2khOGYti0hb532UrQxB7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJta+Jvo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJta+Jvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724139617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI6kfa5oLV045Jmdu7a0CojUb3GQJzHs7H4OiymNEbE=;
	b=eJta+JvoAWDoq+TClca86nb1bs8xpBb+o5RHBqIDL2NFV2l3yaEvTzSxTrb7IuvYQv56o6
	QzM3HYFuNwLshv5bg817PpSVjUKuJq3S3C/WUtSLa8o0NPrg98ZWcQ1T3mBx2E72TvWBKq
	kD2JUPT7cJsgtQdSvVBw+Tu7sM+zyso=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-NMmwCt0MOMCDWXyWgZXccQ-1; Tue, 20 Aug 2024 03:40:14 -0400
X-MC-Unique: NMmwCt0MOMCDWXyWgZXccQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f01b609ac9so4173671fa.1
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 00:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139612; x=1724744412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI6kfa5oLV045Jmdu7a0CojUb3GQJzHs7H4OiymNEbE=;
        b=T7ApzKRrKx1mbobZKpmXF/HrMlH3mh8J8625sFd0FMJ9KdpyJpby7Rr202gtpCxyhL
         YlM37GGAcqofwSHXGkyD/siscQWgFgl4Rn1VHCKnCTSrukLLG5aZ6eSjFQ+qveh2mHmk
         D90ZWLhbx1c/EVT7ejWOpiNY7p1t/z8jBaKzWmFTcPGglYVQGN0oY66IrrlJuCsOeBoK
         3q3heA0Dgplsuvz/IUF2rGLFAiLtCuPTske8Bkf1e4jBx7uBPAHY7dFGVVxD8BBQEhFA
         7s187pwFsYmwFg1Smanc2l/4LolO5KD9/uDNlU8RFnVKoZ9SZiA5zTJq5zeH4M9msRde
         fqaA==
X-Forwarded-Encrypted: i=1; AJvYcCVhRKvnVEZC0uaotBuncXHvBOOqfVv/vxdmE4c09VfCxH9R77yohYnvS+8lnSQ9alz4anlJMJS+GZVcsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZPHOUpZpusUO35ZlMeu79gq0pe+l2u+30MvHu3plmq5gniwD
	PyQDlZqq6w/oHB+Q5EIvZ1CtYbgn1YD1ZfBUaaMnXRgF57G1H2XSymYJIQsCHfMsT7TV+cpWxN8
	MzEyaFEMB3utLMHzVnk9n/RiofziozXcXMIP4XFLY12OcGVLE8UXyXJHbZK6j
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778912e87.7.1724139612400;
        Tue, 20 Aug 2024 00:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuY9Bjt5iBWcm2YKpDyt42mNkBOnX16tyh4gc9tacJQihXtDb0AW33sxGPjl0kWgtMyZPzMQ==
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778883e87.7.1724139611750;
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm726051366b.100.2024.08.20.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Message-ID: <5d70794731198ec7bc59bd95e50a8aa81cf97c7b.camel@redhat.com>
Subject: Re: [PATCH 6/9] ethernet: cavium: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
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
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:40:09 +0200
In-Reply-To: <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-8-pstanner@redhat.com>
	 <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 21:23 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:46PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> cavium_ptp_probe()
>=20
> > -	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
> > +	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
> > =C2=A0
> > =C2=A0error_free:
> > =C2=A0	devm_kfree(dev, clock);
>=20
> Both are questionable. Why do we need either of them?

You seem to criticize my pcim_iounmap_region() etc. in other unwind
paths, too. I think your criticism is often justified. This driver
here, however, was the one which made me suspicious and hesitate and
removing those calls; because of the code below:


	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);

error_free:
	devm_kfree(dev, clock);

error:
	/* For `cavium_ptp_get()` we need to differentiate between the case
	 * when the core has not tried to probe this device and the case when
	 * the probe failed.  In the later case we pretend that the
	 * initialization was successful and keep the error in
	 * `dev->driver_data`.
	 */
	pci_set_drvdata(pdev, ERR_PTR(err));
	return 0;
}


So in case of an error they return 0 and do... stuff.

I don't want to touch that without someone who maintains (and, ideally,
understands) the code details what's going on here.


P.

