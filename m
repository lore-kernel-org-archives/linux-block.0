Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD851F610;
	Sat, 27 Jan 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394212; cv=none; b=PSBENNcfibVSovP1yGlTyKwQO1D6UG3hAovaJtJp4dOP8Fmy29ATBe7QA6XZRoaweU0cjS9zEEO0VjbOnw6AMhVllJGabaDzlWZhJp7CI6SefD7WQIcbb1fHg82Bf0SUmzOfDbVl26P7kn/OAePbMoisyUR9+JZ7h28+UmM9uPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394212; c=relaxed/simple;
	bh=dXEKKJJKMssrfti5+IVKpGLfu0rUAaaK1AGmWF0f7FI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RnR42UPgucIPhqY1dOAvbD6gy/+e1H/60+Ijz0ZFQjikmAFYkC2NB5UE8xloOOmOquYREzxDr2ApZDIT7I638p4yXrS6Ql82pIteOabgAn4wK5HrZAi6EEhjB2e0DroTZCbh1cJ27YOhPo3kW5Ck3r3psoidBaEihQghWFfq7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LyciiXu4; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=xn5lipg3 reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LyciiXu4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="xn5lipg3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F761D4885;
	Sat, 27 Jan 2024 17:23:23 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=dXEKKJJKMssrfti5+IVKpGLfu0rUAaaK1AGmWF
	0f7FI=; b=LyciiXu4/sxWh71EiYf/n8K/olbEOJOTsJZLDi8UFC3tz6XR8OOac1
	0PIW825MHLObj+z/u3HgyqCryRJ3XJ/rgt12jCAN1HRr/eil4C18OnuK/ilS3L8x
	o8w4MIRS2S2YFDKmXNKt5HOS0W6TbAEIywXYOnlKSg08dW5ZDPPQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DF1A1D4884;
	Sat, 27 Jan 2024 17:23:23 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ZqdVXZMIxb6mKxSxxgHX9MkJMIE0Aldd2k6ZEOeFgR8=; b=xn5lipg36+IIpkr+wBabEfmZuYKGjocjBGVgYeVrtFBlNDU4dKrapObRVd9IsMLme9AAIKNwPKwyimnrwhdhAFWcjj8r42qpYHY9QoaUYxLMsuD6uvL/zUMpv+IAbwdG4cNyOlvVCSLpKBRkJ0nRD7Sd6XVIs/wfgNIeweaAxM4=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16B791D4883;
	Sat, 27 Jan 2024 17:23:23 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E6E7FB0948B;
	Sat, 27 Jan 2024 17:23:21 -0500 (EST)
Date: Sat, 27 Jan 2024 17:23:21 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 5/9] mmc: mvsdio: Use sg_miter for PIO
In-Reply-To: <CACRpkdaXc98RkxRp3tO3yXYdGU3psnRQ-ZW0-hmMO0wzbBt+dg@mail.gmail.com>
Message-ID: <o784r666-60o0-18n6-72pn-8sr4rs413543@syhkavp.arg>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org> <20240127-mmc-proper-kmap-v2-5-d8e732aa97d1@linaro.org> <qr2sr893-775p-9770-2441-4o02qqo105or@syhkavp.arg> <CACRpkdaXc98RkxRp3tO3yXYdGU3psnRQ-ZW0-hmMO0wzbBt+dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-595774222-1706394201=:37909"
X-Pobox-Relay-ID:
 AEBBF42C-BD62-11EE-AB95-78DCEB2EC81B-78420484!pb-smtp1.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-595774222-1706394201=:37909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024, Linus Walleij wrote:

> Hi Nico!
>=20
> nice to mail with you as always!
>=20
> On Sat, Jan 27, 2024 at 4:51=E2=80=AFAM Nicolas Pitre <nico@fluxnic.net=
> wrote:
> > On Sat, 27 Jan 2024, Linus Walleij wrote:
> >
> > > Use the scatterlist memory iterator instead of just
> > > dereferencing virtual memory using sg_virt().
> > > This make highmem references work properly.
> > >
> > > This driver also has a bug in the PIO sglist handling that
> > > is fixed as part of the patch: it does not travers the
> > > list of scatterbuffers: it will just process the first
> > > item in the list. This is fixed by augmenting the logic
> > > such that we do not process more than one sgitem
> > > per IRQ instead of counting down potentially the whole
> > > length of the request.
> > >
> > > We can suspect that the PIO path is quite untested.
> >
> > It was tested for sure ... at least by myself ... some 17 years ago !
>=20
> Hm, on the DMA path the code is taking struct mmc_data .sg_len
> into account but not on the polled I/O path.
>=20
> But I think sg_len is very often 1, as long as the memory isn't very
> fragmented so pieces of a file you read/write are all over the place.
>=20
> It needs to be tested under high memory pressure to provoke errors
> I think. I'm not sure, the block layer people may have some secret
> testing trick! (I actually have this hardware in a Kirkwood NAS.)

Oh, I don't mean to imply that the testing was thorough. Especially=20
given that, under normal circumstances, you're always using DMA with=20
nicely aligned and sized blocks.

But SDIO is different (smallish buffers). So the PIO support was added=20
only to work around hw bugs in that case.

Good you fixed it nevertheless.

> > >               if (!nodma)
> > > -                     dev_dbg(host->dev, "fallback to PIO for data =
at 0x%p size %d\n",
> > > -                             host->pio_ptr, host->pio_size);
> > > +                     dev_dbg(host->dev, "fallback to PIO for data\=
n");
> >
> > Given this message is about telling you why PIO is used despite not
> > having asked for it, I think it would be nicer to preserve the
> > equivalent info responsible for this infliction i.e. data->sg->offset
> > and data->blksz.
>=20
> OK I fix!
>=20
> Yours,
> Linus Walleij
>=20
---1463781375-595774222-1706394201=:37909--
