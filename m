Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2F279DC9;
	Wed, 18 Mar 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868873; cv=none; b=jgzoY+KnnCdRRc+Vg5upG2ZaniO8UlI7q0PpnrLdcm5RRgDF3/5MMz7q0ahMPHFYPa3EjCLhc0LNiyoylnEJBRPfOH8IcH/InFhIOzeWztH1kLe3BgD593zXKDF4SiXq76j237dxo73FMhdsWLsKIvd+Bk299y7tCj1MFH2dF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868873; c=relaxed/simple;
	bh=uq6G0ZpM5sYvhp21VeatqbQocEipeAhbF53idP6HvbA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IBbCibsKug921VGY5Vho6chvdr3L123n4jhpNHMZNp8ouIarLyl9rml0nOgrUgpBfOunUcHltm1awuCWS7wCVJQbaK0R9C7aTVs3iiuyzH1oF82XM/ZBKcJn+NzBfh9F2EZqV22ZvTzVC7UStJUmRcloZAQhcBZCbm0KxmaDSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WGhmxX7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtmIJHtV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WGhmxX7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtmIJHtV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17EEA7A0064;
	Wed, 18 Mar 2026 17:21:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 17:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773868869;
	 x=1773955269; bh=ODM0+NlCmd227tQSIaLYBvFz9hHEuOY9El1401vnkJ4=; b=
	WGhmxX7RD9FvaVIKlEIcx3YUmzxqDTrdQ2HCPiHMsGakOgyv4+iovpx2VB6NJkTZ
	gFaMGYC9YofPst+CDXROqZV3ulKj6neOr+5TU1JAWJI6ejYSIiqdDgqGa9dCBbc1
	GOwyiWjQYbjC6F9NyUVwsuYEUUZfEx8ACAQQrNY+oxZ6IGMVJUZUtkVX/Y4HvaSg
	c1qOcaioOVU6GAY+kWAojzWQIwqrEN2Vor5Bel0J0rqoKv8kBVjwFsUC13EGGr6S
	aFJipFVambqyAi+pFslaS7u2qU3Ef1yPpAvs5xhu64C7EFwm7wEjsHj9JNpoJ+QY
	omvcTqZvZx1VjBLnYWTIrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773868869; x=
	1773955269; bh=ODM0+NlCmd227tQSIaLYBvFz9hHEuOY9El1401vnkJ4=; b=W
	tmIJHtVmfHplGg22RKeDjLKm+dZ18u/XvAMV2msJk6WBGmgODgGkQYDRUJAdOsCM
	iOlEpkfRPCFukB7lbyFqKFGDuPWvpUiZnIcKLElO/qBHVZUVK7dojqORVr1niigL
	A3ktAhFwhkCxCjFwKqcrFkCK0uolaeUDJREOhYAESXt4nTMv4nrtZKBcfwnktxsO
	HpA8pgPK7Ef6c6zsdsZQpBZNRoSpnTzrRc3+Wl3A5pJ8UY0JY3HqhzprMKIzF7yv
	WIEDjhrE9SkBZrvRh/n7Q9M0nArQxccavlj5UuQMV+mZuvxd3yQXoUoymVZ+vj90
	cIHOE2H0ghhF+ACZsxOKQ==
X-ME-Sender: <xms:RRe7abEG--WR-k1gpJhHjLg4ncccfRaj_Ct_TKMq4fQJLuv3I-FDSw>
    <xme:RRe7aTKzn_iEHPhy1_1vC1fXpxElqYkHbpTmlVb18JekV0PRX3HjpCggRBVqaTRaZ
    onnbeCSl3GJZcAFLswuaTyuzykLkONHgdDUcU7m8opSimIZGEUr453W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvggsihhgghgvrhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukh
    dprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhophhhrdgsohgvhhhmfigrlhguvghrsehlihhnsghi
    thdrtghomhdprhgtphhtthhopehlrghrshdrvghllhgvnhgsvghrgheslhhinhgsihhtrd
    gtohhm
X-ME-Proxy: <xmx:RRe7aX9dkAzfKFipLbIteNXrKPA6e6DDby9VWTh3epMv6QF5bWT2fw>
    <xmx:RRe7abS4Hbfk36L9FAskc9gAo1Ir7-gteJ4TdJfxuacdyTarnW9C9g>
    <xmx:RRe7aUpnNCRn1YGPSc5g6Lyq726c2Tb8PpPrWpquFgUksYUZTJ_hgg>
    <xmx:RRe7aQPWB5cOYDOZY0IKbkGeg76ABvxrb2r07FZ2kfQ5nnjJ8LMu4w>
    <xmx:RRe7aTM60KNALgXhuGbXnBvuNKqtnkW__RaGaPuGkV5W0NxYIVnSHVSl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62429700069; Wed, 18 Mar 2026 17:21:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaEtqGFuZtnN
Date: Wed, 18 Mar 2026 22:20:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Philipp Reisner" <philipp.reisner@linbit.com>,
 "Lars Ellenberg" <lars.ellenberg@linbit.com>, "Jens Axboe" <axboe@kernel.dk>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>, "Eric Biggers" <ebiggers@google.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Message-Id: <74946481-4eb7-4d8d-b10a-881ebd84ee33@app.fastmail.com>
In-Reply-To: <6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
References: <20260318104858.1868731-1-arnd@kernel.org>
 <20260318104858.1868731-2-arnd@kernel.org>
 <6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
Subject: Re: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026, at 22:16, Christoph B=C3=B6hmwalder wrote:
> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:

>>  config NET_HANDSHAKE_KUNIT_TEST
>>  	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT=
_ALL_TESTS
>
> Thanks for the fix, I applied it to our drbd-next tree (which should e=
nd
> up in linux-next).
>
> I would prefer to squash these kinds of fixups to keep the history in
> our patch series clean.
> Arnd, does that work for you? How do you prefer we handle attribution?
>
> Unfortunately I couldn't really find a clear precedence pattern for
> this, how is this usually handled?

Whichever way works best for you. Some people care a lot about=20
attribution for bugfixes, but I generally prefer a clean history
myself.

     Arnd
