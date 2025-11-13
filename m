Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEF2C2357
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064818; cv=none; b=tIuXhFHYsWXQdstVTjPc1Bd/j4dqVzUe21mNVD3+TyOOnIDWiaJqm0GF6QVw9ksfUSIRgHGCfGANosoh562NnGwRbGeM70rOtg5Ncl8ePQKzvrQz/l/b5g725c1aCW6XMSvsjB1GZs9pWUJsu7lwtJI6Ln/6fKqMOXmXJ9o7Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064818; c=relaxed/simple;
	bh=R3yi+cLMsc/L6sR5rN3U9sVi/JaSUtT0gxwfSLY7z+8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ssRh8eT0sfYDqIVGuSHEmEeInCU5Xm8xqWjEdFzsr7Tb4cC13w//5sSsIItD/fq0MYcsL+AkguJJOtGv90qH8WQbOe3VGu4MxOxS9TzsuTW7prIWlUTI4Sl1iLzDgwAk43RTU57eWaT7W4Sa4sBkHgiOb5tSEgbjBJp1tI5uRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM9a8K+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM9a8K+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78977C4CEF8;
	Thu, 13 Nov 2025 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064817;
	bh=R3yi+cLMsc/L6sR5rN3U9sVi/JaSUtT0gxwfSLY7z+8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MM9a8K+C2agMp+gYd55xxl0uRpc/VDT53ay/Ie4CGKDi3pLKYGnZ4pOyu+HyWLf7e
	 /qNVLeF4SIowLXNMdHILC140sSygao38VmaQh1HWFNJhrdd87eT+ZO6Rl6jcT/YUa9
	 iYOiHr4ZPWXwd5kMmt/DowCDjevoF4hsWclCVRa58jO7dhWRS/PSYqmKRMWg0tqJQN
	 Qv3mH7VTUH8phRmBXeMmv1aW6Pltrorb9r4PeV16vpAwLtO36+lcvEgPvG8cO7IqOK
	 lDbGUzn6Y4VEzpWRLljjlB4XvYeUvg36Bc2k8Syism+MKlvE4V8sffXSKhZfAGXa8k
	 Wb9tDmK79LcbQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B937F40078;
	Thu, 13 Nov 2025 15:13:36 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 15:13:36 -0500
X-ME-Sender: <xms:8DsWabLpHErX5_FxkX26uPnf_E4VqNMGjHBXt23VH6JmN9Rf6CQqMQ>
    <xme:8DsWaZ9A7C8g4QT56wYvRZ_dHN9HnPDTd-0aSze-YUqhE6_56QlEQMM-AW8rXsMxe
    AS207WZ9EOL2dG7c2zxW_6AAvykADk3smAjLKaWHO5gikrYH4Xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfnfgvohhn
    ucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepjeevffelgfelvdfgvedvteelhefhvdffheegffekveelieevfeejteei
    leeuuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeel
    keegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnh
    hupdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    rghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlh
    drughkpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqdgslhhotghksehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8DsWaYCitHph3b6ZiMTFx3ZcBcEe49wdStjLVOZ-GSMxVIyCgJODEw>
    <xmx:8DsWaXfudOpE5Z5fKbcvMDAO96mfLGejjqQRgPYmhzKFGrHYFsbrBQ>
    <xmx:8DsWaXOQpV52RhRmcpBDxzFURalbL1PeEkiC_sA76UerqHCAjuaqug>
    <xmx:8DsWaXJhiBiYJXEapqMynX2DwPEI7mL7_GWe5RBNKD2WYcV4Per5Pw>
    <xmx:8DsWaXLnbYtNaBAmi3Dwrs77dzp0Hw8oMhalS_098UsWnTXB-NAzwEol>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67D4C2CE0067; Thu, 13 Nov 2025 15:13:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaNBfhOYEQos
Date: Thu, 13 Nov 2025 22:13:16 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Message-Id: <c745d717-fcd5-48a5-b640-af5697be6049@app.fastmail.com>
In-Reply-To: <aRY5nCvNnQk4mMCT@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal> <aRY5nCvNnQk4mMCT@kbusch-mbp>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 13, 2025, at 22:03, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
>> Can you please squash this fixup instead?
>
> I think you should change pci_p2pdma_state() to always initialize the
> map type instead of making the caller do it.

Yes, i just was afraid to add another subsystem into the mix.
