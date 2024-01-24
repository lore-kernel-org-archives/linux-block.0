Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB42134CA;
	Wed, 24 Jan 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100385; cv=none; b=QYh0voqizCq33raBnN9YmRpctOj7E3JMY8zkTBCBOD/dxptIQvH9tzRQF2a6e3Cl+j8FkV9tROqqTdJZf5LWyJz2k7qNp1AkLuM412asv4mfPLEn0OkvLglW8gXRmZkui2bxSBkrSbvKy4dl0if/Xi7fWMVIuNcZ8LMIDOx4kjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100385; c=relaxed/simple;
	bh=BqeAZs4BcTKaDPo/CsowHPQ4hNhu0+T0mDkA+AM8rcA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IwrFSH64sXow6R9g2Jd+6gP4iMxrsQzMd0JHapvREzWcLmFgt6ANpLfiwmuR9beYjzh2oK2Oo7nz7jbe0vhVdD8f7TuRZ+oZHO0vFLI0tNXd0WVBF0j07RFhoYxUbJaG/H3gQYZ34DxDWExbhQqzOujrbTK668N0qtWAENnMKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Sqxq0+gA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAz4Z685; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Sqxq0+gA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAz4Z685"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C58F75C008D;
	Wed, 24 Jan 2024 07:46:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 07:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706100381; x=1706186781; bh=XgryKKh/+t
	DmZsL3UGkJJ3QGVpHjXi/yQsYf+WIC59E=; b=Sqxq0+gA1irey2rAqkEbd0FfHg
	HFikJs6w47zvAfxezO1+KkBA92GuI7wXaKycAPeDVpP1v9ESGb/1FMQhn9WcItNG
	47Zt0l3xZSaztpY7IjgHCM+N8mVqMQDOdqtIBOqvfc3Uew3gc/5x9MwCHa8KqxeE
	w1CE8HmdovGT2fqvaPTW2zm1GTJsUTGDScYTHjo5ODNYn15KtHcqLfmo9WKj7BNG
	ftxAVhOH/2O04zUV4+WPmL9/A/pUCKRlwiNe6MCd68QTIGk7tnYopiSLncvh9TAk
	eHrviRUIaR7C1fv1QFH4ZUEJDb02pOv04osphoT42hqAVqdH7OyCKkLNB5rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706100381; x=1706186781; bh=XgryKKh/+tDmZsL3UGkJJ3QGVpHj
	Xi/yQsYf+WIC59E=; b=TAz4Z685i09J6lFBqyCoTCz7FOriTKs7S8Nw+4SDEZgd
	i/Lg2EDxyC1aON/c6s8HW9AnHGCxifn/QbCw6J53QgJAgofVkSGe1RPqeCJ4HkV9
	DwwdbNNYg26151JUhfuSzOM5Q/NW/c0eMU2Zr5QsdjGGljVkP+G3E7/urlq54SU9
	2s+wvuMigL4GeF/3dK26YTtWPTh/TisHUOZQvIpAEaDj2WI1Rv8L0PkU8A2n282G
	qifQ2Tr6ksjvsAeOxiqSm0zFgsVksub7CJDTEF4lxoW082p4Q7RgUX7Xu8CqtydQ
	gHYP8xjHp/KUyawxHrmYMHRr/df3NcP7EUTVCGIYxg==
X-ME-Sender: <xms:nQaxZTJpfHIbCDcrvDCBfDRwTZvZW6fAVeYYMiVd89ZZb78vnWY0Pg>
    <xme:nQaxZXLSiSMzu99-Y3a0KkEjhMN4Vl2YIsFY5UZQoxd1YNX6Xz_8chc8UP_XuoIwn
    82w4hOEWe7DVV2zADs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nQaxZbteOckp9usu9L2pgM-AFQsjhHIRqjTCt-DdBSqDzgOeno5j-g>
    <xmx:nQaxZcbD0PvqYRlk-F-62wcb0tL_zYvoSGCsykgtThgKzKqhkfI2fQ>
    <xmx:nQaxZaYDkzJFcjMTv_xvoIgAZPcu-_RMm9qsa8lFee6kKIHE23x0pQ>
    <xmx:nQaxZS7dtCePj9BTfKmuLDEutud1DpodmZQPrVuWFbOw1gEmUg_Ffw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 56F9FB6008D; Wed, 24 Jan 2024 07:46:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6720022a-0ddb-4ed9-9b60-6c994c8c8cea@app.fastmail.com>
In-Reply-To: <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
 <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de>
 <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
Date: Wed, 24 Jan 2024 13:45:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Ming Lei" <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter
 reference is held when splitting bios
Content-Type: text/plain

On Mon, Jan 22, 2024, at 15:57, Arnd Bergmann wrote:
> On Mon, Jan 22, 2024, at 14:39, Christoph Hellwig wrote:
>> On Mon, Jan 22, 2024 at 10:26:30AM +0100, Arnd Bergmann wrote:
>
>> and then kill the bounce setup in
>> mmc.  It turn out in addition to the one legacy ISA SCSI driver and the
>> two parport SCSI driver usb-storage actually also sets this flag,
>> which might be a road blocker, but at this point I'm getting ready
>> to just pull the plug if it doesn't break using embedded platforms
>> using mmc entirely.
>
> Agreed. I've added the maintainers for the Marvell Armada
> platform to Cc, maybe one of them can look into this, see
> the thread at [1] for this. The problem in the mvsdio.c
> is the sg_virt(data->sg) in mvsd_setup_data(), which will
> stop working when the MMC layer stops using bounce buffers
> for highmem pages.

I talked to Linus Walleij about this driver, as he's already
looking at highmem related issues in Arm kernels. Here is
some updated information about what I think is going on:

- The driver is used on kirkwood, dove, armadaxp/370, and
  armada375, but not on armada380 and later, as those use
  sdhci instead.

- Most of the boards with those chips have the sdio controller
  disabled. In particular for the later chips it is only
  enabled in the reference design but not in products like the
  Armada XP based NAS boxes.

- Products that actually use it and have at least 1GB of RAM
  are the Globalscale Mirabox/D3Plug and  Solidrun Cubox.

- All of the machines using this driver have a valid DMA mask
  set, so the BLK_BOUNCE_HIGH hack is never actually active
  here.

- The reason I think the driver still works is that the
  PIO mode using the broken sg_virt() call is only used
  for unaligned data, and all data sent to the controller is
  either fully aligned (mmc block data) or in lowmem (sdio
  data structures filled in the kernel).

- The hack for non-caheline-aligned DMA in commit 3c583f70a8e2
  ("mmc: mvsdio: Work around broken TX DMA") specifically
  mentions small data structures. I wonder if this is instead
  a bug with dma_mapping stack variables or similar instead of
  an actual hardware bug. The only sdio_writesb() I see in the
  mwifiex driver mentioned here is for network data buffers,
  which I think don't ever share cache lines though.

      Arnd
