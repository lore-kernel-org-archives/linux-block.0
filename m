Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2135CBDF
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066441; cv=none; b=k0V5MibuXho3HzOH0dngPu9PAExUncviHdVSsqGe82izEm06wB1mad2WF9eZzE7UMjCTvJL0sB57YA8zuiyo5VUOEVeZL2Y9s+HtWDVosYDAvP2Dt+jSlfFha0IBHYIMKVq4QBN59P6yGpmP+LLaiQ+OwBqr9+kTKPXjViiMamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066441; c=relaxed/simple;
	bh=k9S0J4kOPP6rNUpj9hSQNdmH4J074CxuYrIkFj4FhWc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pAfCQlHJfFLjiqHKYEzYe7kWedKWxtp4uXkygcKihLW3o23AG63hD+0kf+4DSJ//lytahqiQNzEemTmj0vm9OG61yG5r1mGEIAS2IK+0dlVBc3KLeLXQ3REEJGozkPiImw77/rNGpbXzucDY3ZxhJGQxBTWyYFFvx300C6LcT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDv2zUrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDv2zUrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870E9C4AF09
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763066441;
	bh=k9S0J4kOPP6rNUpj9hSQNdmH4J074CxuYrIkFj4FhWc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vDv2zUrwUETRUlIW1qxCkExTUfDNbDLNhgWCd2O2gi/B9fEgNh3w3+bbnn8eRlLSA
	 32U/S0i0baBFDrtqns7Hm6ujWaFHg8JF0k4So3TNVuVAiqQnT0ceHmnHxJzZFjUT1k
	 AxGMcRthB3gXZalQADlxL0fmLKjesTsBdUO75YYmh9hsNJKGrEbVt3aQ4OE3zauMzM
	 U8kPkKQwwh1IwzoYBhW41fPvNl5GeJjK3q7x65EGhw6yrb1kJY2rT1r09rli5dy+Gw
	 j++lT9J/k6jEU8r9/ETn7IXddqwaYHF59ZMHaJSyJmHeBV/4IqWrQB0Mi45gKVDsEV
	 ++Kki53ERiMDw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 745A7F40068;
	Thu, 13 Nov 2025 15:40:40 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 15:40:40 -0500
X-ME-Sender: <xms:SEIWaZHBGuNK4pAd7wS-z9qKhDK2WSIAkAS0uZUqthMvntOGek2-cQ>
    <xme:SEIWaZKEh8eft2TGIofz9EdNBsKw-6bR8TttU5aBerOgo5G8yh-5w1rBvzkPghPZ4
    qDpl8MT-4PbFcmv0PkfZi5iqkLiLns15bruNhVK_pwU5bFdcHSLow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepgeduhfeugeeuueefveejtdefudekkeekhfeuiefhffejgfelleefleeh
    ueetgfefnecuffhomhgrihhnpehpvdhpughmrgdrmhgrphenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonh
    eppehkvghrnhgvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpd
    hrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehksghushgt
    hheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhr
    tghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SEIWaVpkIVp-Q33eeBu5nd4MrleaDwXX1iiI8k6XUvhOzFrGlx8EXg>
    <xmx:SEIWaWuRwX3NjvwomlZLy2JVfmeXtVd56kh8L0rHKf9aecUVRg31AA>
    <xmx:SEIWaYbKQeCtUuwhI8-ILt-gkkmz_lkwqUEQ_DxnMhm59qClZSpg5A>
    <xmx:SEIWada8aPSi91O1Vmq8-QcupFEo1NRj6cB7xShZjcalTqBIYC183g>
    <xmx:SEIWaZk5x_txG9Ph5fre0BN1is-Uk-PUcyWIf_DTYE9pewGZLFmynIi1>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3AB722CE0083; Thu, 13 Nov 2025 15:40:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaNBfhOYEQos
Date: Thu, 13 Nov 2025 22:40:19 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Message-Id: <ddc17de5-d5fe-4ebf-9d87-0d7bcf4bb7dd@app.fastmail.com>
In-Reply-To: <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal> <aRY5nCvNnQk4mMCT@kbusch-mbp>
 <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 13, 2025, at 22:13, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025, at 22:03, Keith Busch wrote:
>> On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
>>> Can you please squash this fixup instead?
>>
>> I think you should change pci_p2pdma_state() to always initialize the
>> map type instead of making the caller do it.
>
> Yes, i just was afraid to add another subsystem into the mix.

Another solution is to call to pci_p2pdma_state() again instead of checking iter.p2pdma.map in nvme.
Which option do you prefer?

Thanks
