Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55877652;
	Wed, 24 Jan 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114177; cv=none; b=CjGFkmgcpHyqiKkRSHqbXnTDopVgzrTehlUK6XjSecppBj+JoNKFzT9MryJ35x/fD5RYcaKR0ZMtWQ2SVgq39v81X/YV9oywuz9iWkiAATwryLY+HtCyd/XtmuFr3XYdG5yIWxCInOPwEkAOUHTx9CSOutNcLMRndicgi+fQjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114177; c=relaxed/simple;
	bh=QW2noZyRPGuHNKDAj2HXtvl9nLGVFak+RwCFUtNxUEs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UXqB/y0Aq1w69zv+7M1zIaYguWXbGJ23jAWODWoNi+eo75ocZRIs3khCg+lYfNX6sVFue9eF/NybaDuuV569+3hovmyL1BSvRFqqReJLdx9AOdmFSWC3C8EzL/0gJQIMvnj9ikrBKvnQmSP2z4kKFfsPRjftZi6Vhs2MNIUa2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cTKUY4g8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImKIn6If; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cTKUY4g8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImKIn6If"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A7BE05C012E;
	Wed, 24 Jan 2024 11:36:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 11:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706114172;
	 x=1706200572; bh=2CXLns6hzjly6ZZt1NQ2rlZOa4H0ebqQSTs2jpivDoo=; b=
	cTKUY4g82k3Q9SJVkuoagMaqHATeCWdXskvL9fR7ZBUW/vYsDDUU4CeO4SPBaKE8
	EDiHBTg9Qj19Ze1LqsXYGZLOC+3OEd769eUzNrM8HM6fKeVvtgr1qfvrpzQ1uFCI
	Ol1CCuhOAlQRVYRCRIo9ZZFx8SdY5SnhipwWtzJYtjnysT5vW8sZvZaGr4ZLCmVF
	i5LeMhmRJpGDRwXgMMeYDJ+3iMQ8QYc2w9gOL+PpiLGEpIBV9j7tNLQNUSO9UPig
	b0NucnY3EdH9XFGAavzY2FlQDNuVMr3ObNFYTLkMv/O0FUva5P3T6PNFZK8Ja8xY
	H5koiAnugjOm+LiH7GTARw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706114172; x=
	1706200572; bh=2CXLns6hzjly6ZZt1NQ2rlZOa4H0ebqQSTs2jpivDoo=; b=I
	mKIn6IfxShIJ7nBr2FJPFgiyWLqPeAg13Y3chqwORUcTts6IYRjzEIcE4wHJ5jdL
	v69CUgeVS70RCzDp+8LpocPrzGoi9maVoEMzIy3DhcxrWJKJ6D5MeBh51HuKCNO2
	GnQTtbzTG5biDzGcOPAcJrrWSMmfIV5UKFb4EW4LUnx3rP7kXdVsS42IEMRKsDDJ
	jDNxhHtR8reukP4VIBS+oU0tc3QgKYoMnzNqb00GlX4sFuSzvI0ovXJPTKsYWtul
	NF54kvFBdZFqrqLjuGfoIFk45wNh2G/0zkF/v7QZ9I5eo6L4nnsa4tYjiCH1S9J5
	rZ29t6x2aIQqSNjkO4Glg==
X-ME-Sender: <xms:ezyxZcAx9ORWf7rzhjCR74VLZqrFXzWle_4bocyoOc11TKVXw3Tilw>
    <xme:ezyxZejKoYUwAQ6mseR38i_2q8eX2mPdhFj_ba-x1tBPdAkWbQfwTkp2Sgnk0RR0B
    R8CYa-Qjfy61m3uxlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ezyxZfkscHdhVp7cCgkX6jd_HZ4TUK74u8RFkNOL5lGtfkf_Dt6VvA>
    <xmx:ezyxZSxImkvkzX8_E1jPLPTdqNSTc1yKxucjgfEiXkKJ_pzcb-APfg>
    <xmx:ezyxZRQHXLoEplbO1667pRKbwXy6jidlfN0bpMb1emxH45_99L1lIQ>
    <xmx:fDyxZfNafSd0lpgsQImCrvSu7q3mm2RQK576kbv22GCaRsCpIYh3Cw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D7867B6008D; Wed, 24 Jan 2024 11:36:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <215c8e8e-8aee-411b-9f72-6ae40814c73d@app.fastmail.com>
In-Reply-To: 
 <CACRpkdZKwHdPsR8KoyrhDjihLKiP5GdEgtYi_p-7L8b4_Ty_gg@mail.gmail.com>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
 <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <CACRpkdZKwHdPsR8KoyrhDjihLKiP5GdEgtYi_p-7L8b4_Ty_gg@mail.gmail.com>
Date: Wed, 24 Jan 2024 17:35:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Ming Lei" <ming.lei@redhat.com>,
 linux-block@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter
 reference is held when splitting bios
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024, at 14:49, Linus Walleij wrote:
> On Mon, Jan 22, 2024 at 10:26=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>
>> I found five drivers that have a legacy platform device
>> definition without a DMA mask:
>>
>> arch/m68k/coldfire/device.c: "sdhci-esdhc-mcf"
>> arch/arm/mach-omap1/devices.c: "mmci-omap" (slave DMA)
>> arch/sh/boards/board-sh7757lcr.c: "sh_mmcif" (slave DMA)
>> arch/sh/boards/mach-ecovec24/setup.c: sh_mmcif" (slave DMA)
>> arch/sh/boards/mach-*/setup.c: "sh_mobile_sdhi" (slave DMA)
>> drivers/misc/cb710/core.c: "cb710-mmc" (pio-only)
>>
>> None of these embedded platforms actually have highmem,
>> though the omap1 machine may run a kernel that has highmem
>> support enabled.
>>
>> Most of the others only support DT based probing after we
>> removed a lot of old board files a year ago, so they will
>> always have a 32-bit mask set at probe time.
>
> For sh_mmcif I just added dma_mask and coherent_dma_mask
> as DMA_BIT_MASK(32) in the boardfile

I think technically it's wrong to set the DMA mask
for the sh_mmcif device. The mask is set correctly
for the dmaengine driver, which is used correctly in

        ret =3D dma_map_sg(chan->device->dev, sg, data->sg_len,
                         DMA_FROM_DEVICE);

Since SH never has highmem, I don't think there is
anything that needs to be done for these.

Also for cb710, there is no DMA, and highmem gets
handled correctly through using sg_miter_next() etc.

> and I consider doing it
> for pretty much all of them: If they
> - Run without HIGHMEM enabled and
> - With highmem are bouncing buffers around to PKMAP (right?) when
>   BLK_BOUNCE_HIGH is set

> That kind of indicates that they are
> probably 32bit DMA capable, pretty much as the device trees
> assumes in most cases.

> This avoids doing Kconfig trickery, make it runtime handled
> and we can delete BLK_BOUNCE_HIGH as that branch is
> never taken and just refuse to probe if dma_mask =3D=3D 0.

We can probably treat this as two different issues now:

a) drivers that don't set a DMA mask get the block layer
   bounce buffers, and as far as I can tell none of these
   actually need the bounce buffers, so we can already
   remove the BLK_BOUNCE_HIGH setting without causing
   a chance in behavior. cb710 is likely to see a
   small performance improvement when used on highmem
   systems without BLK_BOUNCE_HIGH but it's a very slow
   and old device, so nobody will notice

b) drivers that use sg_virt() instead of kmap_local_page()
   or sg_iter are currently broken if they run on on
   systems using highmem, as there is no bounce buffer
   when the DMA mask is set. Some of these may have
   used BLK_BOUNCE_HIGH in the past before the conversion
   to DT probing.

It's the second point that requires the Kconfig dependency.

      Arnd
