Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4F1EA7D9;
	Sat, 15 Feb 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739640603; cv=none; b=gU4D0cVrUj3ZengQvfkCl0MD8MGJUKbl2A9MSrcYaJy1zSiMO5gI/oow7Z74xGcWxOd4owhuwZuPQJVYZGau359UdSmpwdp+F2MjQ4KnRsDEGA/LYa/L4b8AZM0LJdubC22MvLrbYjSVgfXhgl9ZY5I6cEozKNBPs4U/goXpPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739640603; c=relaxed/simple;
	bh=L/0U9vwm/cm6dWuFvLAdLACDDXDljPFBk/iXIqJoFu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=me9CuFRmdZjJxhFH7KwQGS9O9MhYvyTU+pScJThvkhtNvH02emZpC2icFw7Cekny6RusAewwG4bD00GbWYygVoslTkZui3fI2le2xcK9Tb7Jb/0caPYR1zN0oAVDp3GHsJ/AP2PnPbl23BqYGhI/1bcxV4nbklt/t65QFS90Mb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=cfaRK2o9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rP6GG9lC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="cfaRK2o9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rP6GG9lC"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6DBD254018B;
	Sat, 15 Feb 2025 12:29:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Sat, 15 Feb 2025 12:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739640599; x=
	1739726999; bh=hbhfVtGnmRP+FHNE70Dvm+oPuq45bwTEpBGRMv0hqFE=; b=c
	faRK2o9SWalcefZxXPGoA7jexmGzBk0qxZYQIz6PdEIw3s73FcgDsKAR8JoIO8/D
	ngV/VAANem+/ItT9Nqn8Ch4Bl0oqIMFIGsa+CwAcg9L2h2WsXpO7eka7p3NYscoX
	tEZ1A+TZW8MbHz/g8SoJIZR8KUrkb0hW5Y7cChS4Hhf5viDoPdZ/J6zJJF6rIKhP
	JKctKgvBfFiAI11+xLBwd2CwHQRxWum9QWUPXv3wvazq0b3nCq4TBsIN2PhIu2JZ
	oDiF44c2JuDGcKrMejvu4rz0WSyx2chSHBR0xafU7jnJqhocqtODvZS9m2INtQEZ
	E1qSGzcINy41Ywm/YMXvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739640599; x=1739726999; bh=hbhfVtGnmRP+FHNE70Dvm+oPuq45bwTEpBG
	RMv0hqFE=; b=rP6GG9lCF2GHzP9UdYXQPKlwVPR1dFxwWL5BbidvDMHfBbDWGGF
	B6xVEj2JXCHuYisiLhj2TVRzeLdM8QG4X5sYMWpCVz+o6zQLSLgQfAlZMl+7KVAl
	603+WHTHzg7i4GOL/2zr9zcJhn437oZiPXzcvgehVUN+raLzSXHIZ5Il9MXt5RJr
	XR4o8BSVzIfUwG0J85EfgzHPFOuCWuylMHY/Hl9Jvyzd2ecTzjiLTS1sFYIaVXWI
	T1lJ2y6OCGT8jyfzeg0LR1EgsPsB5XJd7zPwpgO5n5J+aiPcHVQlk05iqOzJggTy
	/1gUn6Ca/FjmcGQa5LZaSSH3F3kJNA971eg==
X-ME-Sender: <xms:Fs-wZ8vbpRgLU1N8QpCtvoE6XhIg9SGQey9uE9TlCjowUiZeZuzotg>
    <xme:Fs-wZ5cTMXO0ktlc5yMwHpH3OGRzDlqRiRR7r5xY_ovN0QhujTXj1tW5YJYb-481c
    EjhuJGjq7XHjuPZw7o>
X-ME-Received: <xmr:Fs-wZ3xZExxOnx405lZssuw_B61TYArPgkVTgb2c3IuTSN41KFO4dc64W3TBHqvXXrb2tYRFi7OCohHf0kQOKXrrbA1n8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehfedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgs
    lhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqug
    hotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehkvghr
    nhgvlhdrughkpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehkohgtthel
    ihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Fs-wZ_Pt1aGehPoWqt05tFkta1B1K1EX958e_47WkOh3TKLWAVRp4Q>
    <xmx:Fs-wZ89mJm4-C0LrRY9GzuR4el6-0s3gw_IrQRbP-Mna-C-2CD1ljA>
    <xmx:Fs-wZ3VccjCHtkYytCtAlcmyNfcFdfm_gDAjWfSH9rfHjI1XxTJo1A>
    <xmx:Fs-wZ1cNPITYC436bNFXZ6dov__hb-jKt0b92EvGucohClgIq7vIIA>
    <xmx:F8-wZ5OxchQhSJeA8gpxbdhihNB_KDRSjMWxZIX3vXKylIpuZuC4F5qT>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Feb 2025 12:29:57 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,  Randy Dunlap <rdunlap@infradead.org>,
  Jens Axboe <axboe@kernel.dk>,  linux-doc@vger.kernel.org,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
In-Reply-To: <CALYGNiOA4K4PQcJTk_OwkHOamW-Am_gKSUZoog41v+Y_+qEQxg@mail.gmail.com>
	(Konstantin Khlebnikov's message of "Sat, 15 Feb 2025 18:18:20 +0100")
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
	<20250214051432.207630-1-me@davidreaver.com>
	<CALYGNiOU3vPAyvsNv4rt=qZRbZFVZ9iAe+kzPzGKkx6_L3wG5Q@mail.gmail.com>
	<864j0wxw74.fsf@davidreaver.com>
	<CALYGNiOA4K4PQcJTk_OwkHOamW-Am_gKSUZoog41v+Y_+qEQxg@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 15 Feb 2025 09:29:56 -0800
Message-ID: <86eczz3yln.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Khlebnikov <koct9i@gmail.com> writes:

> There is another case when counters back to zero:
> device reattachment or reinitialization.
> The device itself might be the same or completely different,
> but statistics sampling will see only restart from zero.
>
> So, maybe rephrase that counters sometimes restarts at zero.
> For example at boot, device attachment, or counter overflows.

That makes sense. How does this version of that paragraph sound?

  All fields are cumulative, monotonic counters, except for field 9, which
  resets to zero as I/Os complete. The remaining fields reset at boot, on
  device reattachment or reinitialization, or when the underlying counter
  overflows. Applications reading these counters should detect and handle
  resets when comparing stat snapshots.

Thanks for your feedback!

Thanks,
David Reaver
