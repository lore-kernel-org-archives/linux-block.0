Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B51134CA;
	Wed, 24 Jan 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100960; cv=none; b=NxxrinNcw3+vcya2PRwCSQL7ONvvQhm3AvCTgxRp3IMi1lzJsdw0U20b9ZCFk4TRQB1biB8FVpqzVlOr6RF0wmiEaZ4dbuvUVI8swCeox3KZj4Pfwis0a56hHE8HVTmdb0qBMV3WZbrw8Ua1/bdROiwn9mHT942P6syYgPgQdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100960; c=relaxed/simple;
	bh=RWSZasYkoovyiQ8B17HCViRlSoK288gtNrtExWQ9v00=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=iVqfwf4L2n1uLEuA0iwU6WvdESf75INvcPKm+o/zh06wdl6o68OKjkLl/lTLkJBN54N5gl5OiIhIrZI+IIVZLWW6+Jjf3T1FC6/Dl6lX43QufTm3Hve7NbGtjovZ7Gv/aPQ79Rk3GdeTnqhdBbUkQMCAyWQNDRW8kvzK75nISks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YbJU4eTk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owKuKaPn; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YbJU4eTk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owKuKaPn"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A22375C00EB;
	Wed, 24 Jan 2024 07:55:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 07:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706100957;
	 x=1706187357; bh=tik4YEQgVRO4jJCbEqRGniLocP3MT0dixBoy5Tn0QKs=; b=
	YbJU4eTkjTP/ThEPVM8rBS4YKhp7nKQNUmAepkrI993qD5RauetKXm8rLG/8Ldmp
	ZrUpUd5TXMyqIgM+FPhr9Tg10QKem1flnCAzqPCy9lj32Vr43cAP8FksjVTKZajV
	p6urmi4jURkXTcAnjj9FvAUVQAwc7JXA4X/9k13+RghrGYmlUSgD9nUCuFdVuWiG
	W2YjDBonzTRDRuRNakfB1Pv0hrQEke01EUCb7Y+x8rxfmbWsyEGRThWjTirzeTu7
	LKeI2XEDLKaftTbMJzmtUxANSIHgZT/yoPj3uOamEWsaNLHYUTzyCQ8gEYQjCe8h
	LMIdzW4uMdbmfM2K575XIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706100957; x=
	1706187357; bh=tik4YEQgVRO4jJCbEqRGniLocP3MT0dixBoy5Tn0QKs=; b=o
	wKuKaPnwuDW1XPVDzgXBSUiefdR9iM6RivBsIcK19Ti7LvnXb3opg03Vcp7a7T7V
	NDmh92mEKGPdaVYg6SOVsuzFBdnq0rmxsCj7g94XA+cz/irjAy5wCNEIJnpn2DMG
	YLBK5mtyZY3Yv+aJUKeaDQAYQ/KSv7YBsObb3AWQkm+Y3smNa9qs1YRJPvR/u2zU
	Vhg+3iFYdWWYL/NM2joxEXyiE7fgXiQ0Kycvvrcu0qWw8IIB/f6H1Je8fCjTp41t
	/rdJ2HPDAnv94tNkFwYIlt0HBgzteM4HLLjck4nNwV24DS1kqthNMs0u75wYbW5g
	J71tk7fTE0yYNJBR9Ip5Q==
X-ME-Sender: <xms:3QixZa5A7LcEdrY1OnhzXP2r3QbGwqa-cHoLQ37My-7UJodOg7KX9Q>
    <xme:3QixZT76EV6SSNhYcB6ZYvJpXRv_LU9SEBKaK5h1v4nABSNFzxch7vmLqE0WguczE
    21Hy1ufRbvMg03oKWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3QixZZeYA6H_NW7ZZdGbIVQG6ZobI5ki73bXkL37lye-tVTyQnS_Iw>
    <xmx:3QixZXIOt6vVW4w8dTdj_DIn5EZ2TU4xMFeRf7LTHLTiZVRGRNM8pg>
    <xmx:3QixZeJWR_2OvBJqftOP_6c5EIJhzLSllyVSbIMZUh3yPgXVoNexRQ>
    <xmx:3QixZfqPBp0Y0wmq0JAvNdE4aHK6SeuCiRVAJfdbxlVjsbpyMtEEkA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 414C2B6008D; Wed, 24 Jan 2024 07:55:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9650b123-5954-4d80-a909-a46ec08ef052@app.fastmail.com>
In-Reply-To: 
 <CACRpkdbw8mGBUOh9W_E=KZQsOpc3TefL3QWApB+t5Z6w6wNRdA@mail.gmail.com>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
 <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de>
 <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
 <20240123091132.GA32056@lst.de>
 <6f38c2db-3aae-42fe-ab97-dd027b90b690@app.fastmail.com>
 <CACRpkdbw8mGBUOh9W_E=KZQsOpc3TefL3QWApB+t5Z6w6wNRdA@mail.gmail.com>
Date: Wed, 24 Jan 2024 13:54:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Ming Lei" <ming.lei@redhat.com>,
 linux-block@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Andrew Lunn" <andrew@lunn.ch>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter
 reference is held when splitting bios
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024, at 13:33, Linus Walleij wrote:
> On Wed, Jan 24, 2024 at 12:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>
>> Let's use your initial suggestion then and use a Kconfig
>> dependency.
>
> I'm looking into this.
>
>> I still don't like how this may impact users that
>> currently enable highmem and use one of these drivers,
>
> I'm taking it on a machine-by-machine basis.
>
> For example it
> turns out all OMAP2 that use mmci-omap are Nokia n800, n810
> and the H4 reference design.
>
> So I am seeing if these can be excluded from the "most omap2plus
> systems" list.

Unfortunately excluding Nokia n8x0 would turn the omap2plus
defconfig into an omap3plus_defconfig effectively.

This is also something that has come up repeatedly in the
past though: omap24xx (and imx31 to a lesser degree) support
in multiplatform kernels is really annoying because it
requires a lot of special cases to also work on SMP enabled
machines, and it completely breaks on ARMv8-aarch32 machines.

     Arnd
