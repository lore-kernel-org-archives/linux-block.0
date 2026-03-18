Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4527467F;
	Wed, 18 Mar 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847914; cv=none; b=XdqvuTFFhS+64oTZY/aA1RYol0p5mwVI29kapIXrH56QHiCMO8IYZEEKCQnZ4bZ3Uw/lZjYLOs37STXd851/MuusAvG9P6qqbF+eTSZZmJHnLb+Tjo5M2UJYifB4X/E7PGjJ0qZ1K+l2qIp+YUlQwOmaqV1xkoywuMcTFMfj3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847914; c=relaxed/simple;
	bh=5dIHpEMD32L3Y4aBmGnf7pzbjxkbjCOH09VbDilVYaI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LWpdFsiD6zjGhoD136LH1W+XE9owRrAqFQtfzd4b5WyCUPmv6+8C402mY1DYLON1FH0vyTns+zDWng2g0YsKGdWsmjL5T1LiVndn3ZSQe8DrSedAvHSHjEd01M646lZx22ZlIXy0LJ8bi3+9qIvZ1heNV+XoApyZTBLM7Fi700U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fLWGErnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIMKriI1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fLWGErnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIMKriI1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E38DA1400207;
	Wed, 18 Mar 2026 11:31:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 11:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773847911;
	 x=1773934311; bh=VhTfRphbBnsJvwAd3yj8HVImQRdR9MPCJ5vawPXeXdg=; b=
	fLWGErnRy0MeynlyX8TS05DxZeARPqeIErZkyhB6OLTkGa5AFFq9ovwY1nwjUhIG
	uSsiS5YvQ/X3+GuTRXsywk5YUx4PFNWGWUyNaUOjLNLKtfMb0fhAQdukVRSt0e6j
	OrwZy3bKRDRtLnWmifL1nrWnldjswOGVyRPW2H2hafrwLZT84hd29PwxnXN3UtFT
	xSzJG4phTK1DKCeGZCQVb7Q6JjBXFGvD+OED5aJbh1vS2hhIKS35ywjw3RFSbPTr
	CggzeodE7aI7NjkNaylvLXZrAlUW1iMw8roWqrOw61KKmJowlcCMyT1CxmO4EBXw
	N7S1OYM7lmCZG94MAf9R6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773847911; x=
	1773934311; bh=VhTfRphbBnsJvwAd3yj8HVImQRdR9MPCJ5vawPXeXdg=; b=a
	IMKriI1zkArgnEptsJWgS2DSoaBwOY6WCzcy+KnUlJdL5FF9NdFUYrvegv2G0tYP
	b0k7zsRMHdWpQ/Ag5bmuqZQ/LWUodKFxPYjigUTcPdSuSc/m1YFyFGGbxhrTAbuA
	L8cfDhk8MSoETZfEqXUmH9blLCIlIw9Af1uhJBz8WnS+64W552FFAbOdHE0NMNLe
	Hs+UGbJs1sEpqEMY8Tl9bypD9gzZaiD8bBY6py/WlrI9ekdiHXytJaYh6ksLoLb9
	i3K33iyvXfoz9aKy7nmgDbX2/fS2JOF9H82XqD5xD6GJEKc7hrB54bOz/WUrfquf
	NPjcc+7XWwfgBfRT2nQlg==
X-ME-Sender: <xms:Z8W6aeCadJ6iY3actVlSfAvbj_K79wOqNRk9HF6v7WfcCVKVSV9h8Q>
    <xme:Z8W6aTUF2hxeidn1xZPL956lzrewmau3YstOESs6HxH9JCIYVJiW7QptWujNaCUZz
    FTHm7UzF5ug6ZD0n7Hlie3o-SU4UnOOK34Tza0MpK7KHB37Mzb_8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegvsghighhgvghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gthhhrihhsthhophhhrdgsohgvhhhmfigrlhguvghrsehlihhnsghithdrtghomhdprhgt
    phhtthhopehlrghrshdrvghllhgvnhgsvghrgheslhhinhgsihhtrdgtohhmpdhrtghpth
    htohepphhhihhlihhpphdrrhgvihhsnhgvrheslhhinhgsihhtrdgtohhmpdhrtghpthht
    ohepughrsgguqdguvghvsehlihhsthhsrdhlihhnsghithdrtghomhdprhgtphhtthhope
    hmrghrthhinhdrphgvthgvrhhsvghnsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:Z8W6aep7OlOF0hFruCvLZPe7QACtElAPm3ym0pYzGyDv8zKPfXn-9A>
    <xmx:Z8W6aYdpJOBB2-Brg9hjiB7dwPJBW94YFi9NWvrwrVIAYVW3vfobgQ>
    <xmx:Z8W6aelxFUmBkpzBYeCiR7RvU9tqmyPxrc_aK6Hp99FfDHvqqWg2sw>
    <xmx:Z8W6aXYT86Wwcp2yk-6pZhrZ4k-ClTlpRB7SEb8GXJfxcxCdslvA1A>
    <xmx:Z8W6aSuJIg-RYegGBM77cR8KQ7S7lkLWn3vPGsUz7hgGviXeIgLFjm6P>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 678A9700069; Wed, 18 Mar 2026 11:31:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A41OPxdFoFu7
Date: Wed, 18 Mar 2026 16:31:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Philipp Reisner" <philipp.reisner@linbit.com>,
 "Lars Ellenberg" <lars.ellenberg@linbit.com>, "Jens Axboe" <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Eric Biggers" <ebiggers@google.com>,
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <c3daa9b5-3741-4a18-9bbc-7bad1a2e0c1b@app.fastmail.com>
In-Reply-To: <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
References: <20260318104858.1868731-1-arnd@kernel.org>
 <eeb73048-d5ae-4fbd-9920-1395a3ca51eb@linbit.com>
Subject: Re: [PATCH 1/2] drbd: fix rdma dependency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026, at 16:24, Christoph B=C3=B6hmwalder wrote:
> Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
>
> Seems like we raced here, I already (supposedly?) fixed this on the
> drbd-next branch.

Ok, I assume that will be in linux-next

> My fix is this Kconfig:
>
> config BLK_DEV_DRBD_RDMA
> 	tristate "DRBD RDMA transport"
> 	depends on BLK_DEV_DRBD && INFINIBAND_ADDR_TRANS
> 	help
>
> 	  RDMA transport support for DRBD. This enables DRBD replication
> 	  over RDMA-capable networks for lower latency and higher throughput.
>
> 	  If unsure, say N.
>
> And then just this in the Makefile:
>
> obj-$(CONFIG_BLK_DEV_DRBD_RDMA) +=3D drbd_transport_rdma.o
>
> That should be equivalent, right?

It's close but not the same:=20

- INFINIBAND_ADDR_TRANS is a 'bool' symbol that can still be =3Dy
  when CONFIG_INFINIBAND=3Dm, so you'd still fail to build
  BLK_DEV_DRBD_RDMA. You still need a dependency on INFINIBAND
  (the tristate symbol) itself, though you probably also
  need the INFINIBAND_ADDR_TRANS one that I missed

- I incorrectly assumed from the earlier Makefile logic
  that the rdma transport exports symbols that are used
  by the common drbd code, but I now see that the opposite
  is the case. The difference is that for the case of
  BLK_DEV_DRBD=3Dy, CONFIG_INFINIBAND=3Dm, my version force-disabled
  the RDMA transport, while it should be in a loadable module.

It seems both versions are wrong then, but just adding
'depends on INFINIBAND' on top of yours should fix it.

        Arnd
