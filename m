Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DD39AD6;
	Mon, 22 Jan 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915616; cv=none; b=bd1TAQDot8+gsKrvKWLEuyGecGNnlg7tM4MnG6O1xdJxolBntmlekyK0J+qbjh/apwZpyNuOZnn4uNvg8RBayYH0z7As4a7T6bd4T42EzEYqiTiqZbaQX4FaNFc+mAQO69sSx6Gueuk/JPhbYttpYvpUJ42etojEzvHi2ADyuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915616; c=relaxed/simple;
	bh=k1zZzncBUoKWEp6Hq6ankKSI+ROrVsXUBhhBlBqFMhE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=L++cd6FA4yFu7ul9G78aEKTxKEH3SHcjrlbh0InFsJRy2+HibXuEKxl+wXP6tb4JZJaI8hFl5/Z0d3ihlDQwvELRxlddLmbl2/RH6AwK4OVK5FQQi9OEZgT1m6tIjn6iPeyyZPHPMH99yvaun3SEKOANwY1NgRLr5xNNcC+3KIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JpyHYXBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9tDyYpL; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JpyHYXBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9tDyYpL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2705A5C0183;
	Mon, 22 Jan 2024 04:26:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 04:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705915613; x=1706002013; bh=1HIVLf5Qfb
	Vvbl8bZq3qsVK2FWnMeIsjIuRSzgJe1oI=; b=JpyHYXBXe03uRFYjE7BD4gY9t1
	2RVuDyRcQBym2PJQmmRTUzNRW32PtY9fOGT/WA6rWnxprGwxrzUjlJYMDUTPd5ZC
	lywjw06+2uJ8JwMBPzUuZvfbNnMg7ImOEPAmZfFQkOudELjgKOxjSZWmX8v86ZlX
	joTIVblymcrst0GZuDJwcyxYxUJHF19JV1158ndJ/6qhn38Xn+rZorQRszUHmjOw
	QxTmA7DrYKJbMTn1+GbW1CNLlP8IvJe9HsUR1Q5jVTR2HlmKhE+66sGbG+540hk+
	fl9Zjb9aILGIZzGPgU+R0GM7DWRtaOvIkwjfXy4/oCGj+JCGOZTdOvJpKCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705915613; x=1706002013; bh=1HIVLf5QfbVvbl8bZq3qsVK2FWnM
	eIsjIuRSzgJe1oI=; b=W9tDyYpL5DnKMvCE0v3kUQ75LmP4377HG/vsiLDO7Oh1
	c6mHmV9cJPkGkUpgIzvsuWTdPJ3t9vrwiwArdRGemEjmtV4XcrU8XHr6Y65AWnut
	TYYm7jVO9MPqqIRezdo6v+V9JiCS8rmLLt/jqOy53/iXt76ystMKGtdRAWxmP4FS
	ZgFYyuygC4TX80KhO3PSictwkUytYv0Iuwx1Wr0BoCy8xEQB4aV4mMuaX4dY2BEL
	gIZnuznPTR3lyAtW+rDBJWEXWR0RvKPUKGaEdwxZJ6pp1a5QswRTrmN6MZnRaVSy
	6+Ja9RzBA9dzWIHy3u2azHjWQ/EscsJMlewmw6kQtQ==
X-ME-Sender: <xms:3DSuZTbSORsgopnkt0cCXZpm3nM0qvoBL3EgcwqfcPRVPEH99irG9Q>
    <xme:3DSuZSYhOXCs-ICfHZJK_R0oqQMr0yB5381gAjaI4TmRMtshYBbO16WiaDh-JIIgB
    G_omcdwBBRkBlwE8oY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3DSuZV-Zg5YOktqgrhOjZofKXuQVguhC5hIuq-_Q207gcYhSqaYw1Q>
    <xmx:3DSuZZoTS1w4pI9xXEGvpUDJV2lqdxYOBeZdeMa-o1pxB41H386lZQ>
    <xmx:3DSuZep4z5m1q89vL3Phufc7txl_guCKLeKFcWHzSsmMWCTvNrrmLw>
    <xmx:3TSuZXn6l-j4ThBQJUaPjArxxTv7OSqnrItfHv4D20bCrwNma9Zfcg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9F1DCB6008D; Mon, 22 Jan 2024 04:26:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
In-Reply-To: <20240122073423.GA25859@lst.de>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
Date: Mon, 22 Jan 2024 10:26:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Ming Lei" <ming.lei@redhat.com>,
 linux-block@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter
 reference is held when splitting bios
Content-Type: text/plain

On Mon, Jan 22, 2024, at 08:34, Christoph Hellwig wrote:
> On Mon, Jan 15, 2024 at 12:20:50PM +0100, Ulf Hansson wrote:
>> Not sure exactly what problem you are trying to solve here, but I am
>> certainly happy to help, if I can.
>> 
>> Can you perhaps point me to a couple of drivers that need to be converted?
>
> Sure.
>
> mmc_alloc_disk sets BLK_BOUNCE_HIGH for any mmc host that doesn't have a
> DMA mask set, which is a bit odd as all proper devices should have a
> valid DMA mask.  I suspect platform devices might sometimes not have
> one, which historically was the wild west.

I found five drivers that have a legacy platform device
definition without a DMA mask:

arch/m68k/coldfire/device.c: "sdhci-esdhc-mcf"
arch/arm/mach-omap1/devices.c: "mmci-omap" (slave DMA)
arch/sh/boards/board-sh7757lcr.c: "sh_mmcif" (slave DMA)
arch/sh/boards/mach-ecovec24/setup.c: sh_mmcif" (slave DMA)
arch/sh/boards/mach-*/setup.c: "sh_mobile_sdhi" (slave DMA)
drivers/misc/cb710/core.c: "cb710-mmc" (pio-only)

None of these embedded platforms actually have highmem,
though the omap1 machine may run a kernel that has highmem
support enabled.

Most of the others only support DT based probing after we
removed a lot of old board files a year ago, so they will
always have a 32-bit mask set at probe time.

The slave DMA case is interesting, 

> A better indicator might be the use of page_address in the I/O path,
> which usually comes in the form of using the sg_virt() helper.
> For drivers/mmc/ that seems to be: davinci_mmc, moxart-mmc, mvsdio,
> mxcmmc, omap, sdhci-esdhc-mcf and sh_mmcif.

Out of these, I think only the mvsdio one is actually use
on boards with highmem: davinci, moxart, mcx (imx3) and omap2
are old enough to never have had more than 256MB or so of RAM,
and mcf (m68k) and sh can't even be built with CONFIG_HIGHMEM.

       Arnd
