Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A87A70A;
	Wed, 24 Jan 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105695; cv=none; b=UJN+z51FisOeJEMID7M9JbTh8o3KEOlQoMIvJm5vI2ZBn7oXGQabnaZph9SVVckeVgeJOkIdKyzum5jMbUcaQHKIF58dOze5+bO8ebEiTPaXrTPrSxQyiAfXLX+5036Smg3ERW7JT88+1qs5rUYAOkYsuSSODUL6r7iQM9ppHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105695; c=relaxed/simple;
	bh=QlgIGz26xqq1QCGnq0oXBfcZ6f42DD5S71PIws0pxXk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W90Ubk4Z9qH9w+pa+zsgDTqAQvLUcUJ9+NnEwgKN5ESptF2qy/FOO9x6Y3ZYgGGZDg6l24ctz+wh48v5kJNvxAy7e/FKiRHpmNS9KcItW1KNAHcKsxLMe+3IbAV6Xy56Bu8q7qP1jQzF3bBy9lXdXHoM3n5MzuYVV6ju/3chUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MK/DTaPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PU8yetdi; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MK/DTaPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PU8yetdi"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A0CFE5C0094;
	Wed, 24 Jan 2024 09:14:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 09:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706105692;
	 x=1706192092; bh=zFp+9fzAQjxj+vatrVmlqze46/6SfiUYsAn91Q5f1po=; b=
	MK/DTaPShgK40Na539ulXWXyYwWKIaMi9R+zGymB6bku6Y4B4n8/ZUfCI3Ec+t4p
	isFhNQTuJJsbb3brOhyQiylBZLHfozLI0X5RuZhkLQxc0vf8+N8iSnuAzQkyPuly
	wwy/2TZFRf2sHr8nPW4J4OFoRWYvGfFFyor1WejQlu4QtK6i9X2AriGJoB+Ar0Z5
	xmsi/AB0oXTUdNeqdSiyWQPVaZLKCL7IkT4lNbdshnpE2nBMRFdS6a/cHY2ZHXVz
	z1iFSKdU0PrnXOUBeWbFtgjY8IZUccPY2Sd9ZmR6WleHNXz3fI6x61Kdww6pPPnw
	2ZWa2dt4PjivjH3mKgt4EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706105692; x=
	1706192092; bh=zFp+9fzAQjxj+vatrVmlqze46/6SfiUYsAn91Q5f1po=; b=P
	U8yetdibI5IEbWWmIxNgc+vRLpN+5gs3AN5MkFsyvlh80l8NO2aIKfl2CCu3QKI7
	bl8+bP/KagdlgzwLmqpaXecKDUmbrQNEJYCnHcj9CGcEh1ybD6EyGsFt1gPca413
	Y0tiYpJ1OoMj521RTdLtEt5xpLtY7XdGfIgvW2IhczOqbjGz6oTZCvyZ/VagrUm7
	Jjfk+EDiK/1uRmweLTRSzq+0A9HgzaPXM92JKkDMSRI8TPdIo/E4Ac/bEB5xrd8b
	rOWvq43W+YDgluTq5X8l9o436nrEQeWsDo6INofvOqdYMi0vZ1D3Za5EepDIJkFb
	rQEsxbDSkU0BtL8zzOBZA==
X-ME-Sender: <xms:XBuxZS486J7S5dPddku8rcLSQ3RddfvanQGbdaYUQu6poePPQ0O9Gg>
    <xme:XBuxZb4PUfXBtUlz8M4SivYTptAboqFswAfZ3nI_v0YdEeHaoY4HaNZavMBsbGyy_
    JlhdIZQerI8wIRHWIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XBuxZRfAMIamAU2bRipflsZCbsqvdfmKufJuuh4bkwqc2l3CWYy3fg>
    <xmx:XBuxZfLfbTuRpzUjlC4HcdJ2EaipDrdQqn4qpt5gYGGP4AY_ScgbZA>
    <xmx:XBuxZWKKV5CXaE_ooRF1gWaVViuWLwFMS0BvH6E07MStB5ehEEp73g>
    <xmx:XBuxZXoFNkBUkY8Eoqjsoff6TjW8qq5qdZINF_Jgiy6wygXnfogx8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EF08EB60092; Wed, 24 Jan 2024 09:14:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8705302a-6127-4065-aad8-8033e5176411@app.fastmail.com>
In-Reply-To: 
 <CACRpkdYYtpk8fMe6Gjo5Fu9byS=PqA5GJGeJpKTaw9QxcLqY8A@mail.gmail.com>
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
 <9650b123-5954-4d80-a909-a46ec08ef052@app.fastmail.com>
 <CACRpkdYYtpk8fMe6Gjo5Fu9byS=PqA5GJGeJpKTaw9QxcLqY8A@mail.gmail.com>
Date: Wed, 24 Jan 2024 15:14:29 +0100
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

On Wed, Jan 24, 2024, at 14:16, Linus Walleij wrote:
> On Wed, Jan 24, 2024 at 1:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>
>> > So I am seeing if these can be excluded from the "most omap2plus
>> > systems" list.
>>
>> Unfortunately excluding Nokia n8x0 would turn the omap2plus
>> defconfig into an omap3plus_defconfig effectively.
>
> I did like this:
>
> @@ -135,7 +135,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>         bool "Typical OMAP configuration"
>         default y
>         select AEABI
> -       select HIGHMEM
> +       select HIGHMEM if !SOC_OMAP2420
>
> Effectively disabling HIGHMEM when using omap2plus_defconfig.
>
> If we want all systems supported, we just apply this at the expense
> of highmem for OMAP 2430, OMAP3 and OMAP4 and the

As far as I can tell, none of the above actually have more than
1GB of RAM, as OMAP4/AM4 maxes out at a single 8Gbit LPDDR2
RAM. For those machines, using CONFIG_VMSPLIT_3G_OPT is likely
going to be much better than CONFIG_HIGHMEM anyway.

Unfortunately, this does not work for OMAP5/AM5/DRA7, which
can have 2GB or possibly 4GB (as used in the Pyra) of DDR3,
so we'd still lose.

> We can then either
>
> - Disable SOC_OMAP2420 in omap2plus_defconfig (I made a
>   patch for this) turning it
>   into an omap3plus_defconfig as you say
>
> or
>
> - Actually add a new defconfig named omap3plus_defconfig
>   with highmem enabled but SOC_OMAP2420 disabled.
>
> I don't know which option is the lesser evil ... it's a bit hairy.
>
> (A third option would be to reexamine runtime restriction options...)

Or actually using kmap_local_page() in mmc_omap_xfer_data(),
as Christoph suggested.

      Arnd
