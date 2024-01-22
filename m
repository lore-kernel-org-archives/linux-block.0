Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAD4CDFB;
	Mon, 22 Jan 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935461; cv=none; b=hX2qQM2mbMlx77stKRzFwsfuV4EDZzAQGQ6YXKYRt11DbT6SVeH+V26JKLiN2YdxAzqpGetHe90A7sPcoaMwRRdS5brX852mZ/EoNMQ6h44KMAazZf6gv9l/UTAj3hVzuTvXFQYjMnPsq4APPGj0XVk1UHLEkQNLtiiL//NhCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935461; c=relaxed/simple;
	bh=pPhzL/ayVxzsEBW6rGJdJzE6Tt7pjXmG2h6mduOWEzs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TWb/w1/FyebdXs5g3msUAWnQVPhz9pPL5HA/wJkHAZ5CVDaBYlsbrht4el1QAtOkBfjm13hsPaDNARDEq19AUIcs1CoS8mIJp1hSBSwEoNhJpGe5Rf00jSQN1D4ojGd1FT4wvNVThNxM80B0R+LfRLg8Uvfw1KGXELQmhiUNHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DUPQGMNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPlo0sjL; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DUPQGMNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPlo0sjL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 649AF32004AE;
	Mon, 22 Jan 2024 09:57:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 09:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705935456; x=1706021856; bh=vJmTc0y1Bh
	ti+GplYvBYIWpcWWNiQQECwpgQSF8cB8M=; b=DUPQGMNdKSobkifu+Nk3M9HrXu
	2ubaVBQ+6b/gk2QR+UHPkZ5080LRUtVZVii+qSPwlPR43WG21STa0y77jgjC3Uf9
	YrffyS4I+8FGqv6t6I4IiJQIzSJ+J5dpY8PaUESC72uXJabGgvrowO0nhMaxExVj
	NuOGy7e9heAgukJRzDSVyKb41PCc2GzEhMDJ9C20aAjdFa/CL4iXMRHh85QJ2MWl
	p2oNOcF6N7cJ1amtTJ0A3obnCg2Aom5QqcdSfte6lOtF5v45jGLeP3onVAjlTr+L
	nodM3qCbArf/gRD23fPcE5/Tpi/3ZbPscVb53MozqRuUZ/tEBUbzy+cgxrdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705935456; x=1706021856; bh=vJmTc0y1Bhti+GplYvBYIWpcWWNi
	QQECwpgQSF8cB8M=; b=YPlo0sjLT2AK6FlFOVtry0J8mdhoQUje49UQ7wKKL58c
	0kqU4gFOqHF2p6rlI5ObU/02gGqGqSjs3RFnr40mRShkMY+HLFxif2aeLuBPvAsO
	6u2RwnGSyoudNG2vV0msVjzvR7+V8qfyEVH0MpU/wxjI2XLT4iDsa39YsABXL+iB
	/6FKJ3nW1LO/kVd8YIFb7YqoaqFFnxd3LeNEENHMmx10xoDXbnfwzLwcUQdGinfs
	yWlj6Z3l86eKqz4XeT++0E34TFehGY+zPqNjmBtzpTwcYYyn7JX8OOLfyrUNPGRS
	8deeZBZytAAZBKldZheOShfaxIKaNsibHUIsprmITg==
X-ME-Sender: <xms:YIKuZXHcYVYI7BNVkXMOHQbYr178Xyeep7pATj-QZg-QSPIxIZmtGw>
    <xme:YIKuZUV-2jFWpXwAoZoF9R3SaXFX8Cz1QXdjjaY9P2vZZb4RkcrfG2IwxTha0g3Xj
    IXSaSxbOvBP2XICjFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YIKuZZIZdrzid8sHZ83cK4b3cqb5QvcIr7CWQlFCH54XRbSnmkC7IQ>
    <xmx:YIKuZVF7vczMBdnkRK0Jxn6DtLx1i6jHEnzhsowaXZxc6drnCKCD8A>
    <xmx:YIKuZdULaJJb0I8UTwC5TJjYeCLrwT-EKuP30gGPHOWrWxLXjn_N9A>
    <xmx:YIKuZcEjJGedMrvJp-9HE0Kg10ZUie7VzRZeEZbMt3DErKGn641Rqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5F008B6008F; Mon, 22 Jan 2024 09:57:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
In-Reply-To: <20240122133932.GB20434@lst.de>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
 <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de>
Date: Mon, 22 Jan 2024 15:57:16 +0100
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

On Mon, Jan 22, 2024, at 14:39, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 10:26:30AM +0100, Arnd Bergmann wrote:
>> > A better indicator might be the use of page_address in the I/O path,
>> > which usually comes in the form of using the sg_virt() helper.
>> > For drivers/mmc/ that seems to be: davinci_mmc, moxart-mmc, mvsdio,
>> > mxcmmc, omap, sdhci-esdhc-mcf and sh_mmcif.
>> 
>> Out of these, I think only the mvsdio one is actually use
>> on boards with highmem: davinci, moxart, mxc (imx3) and omap2
>> are old enough to never have had more than 256MB or so of RAM,
>> and mcf (m68k) and sh can't even be built with CONFIG_HIGHMEM.
>
> It would be good to fix the one or two that could use highmem and add a
> depends on !HIGHMEM for the others

I would prefer a runtime check here, as one might still have a
multiplatform kernel where one machine can use highmem and
another machine can use one of these drivers, e.g. in
imx_v6_v7_defconfig.

> and then kill the bounce setup in
> mmc.  It turn out in addition to the one legacy ISA SCSI driver and the
> two parport SCSI driver usb-storage actually also sets this flag,
> which might be a road blocker, but at this point I'm getting ready
> to just pull the plug if it doesn't break using embedded platforms
> using mmc entirely.

Agreed. I've added the maintainers for the Marvell Armada
platform to Cc, maybe one of them can look into this, see
the thread at [1] for this. The problem in the mvsdio.c
is the sg_virt(data->sg) in mvsd_setup_data(), which will
stop working when the MMC layer stops using bounce buffers
for highmem pages.

     Arnd

[1] https://lore.kernel.org/all/20240122073423.GA25859@lst.de/
